const pool = require('../db');

function getAccessFilter(sessionUser) {
  const user = sessionUser || { tipo: 'admin' };
  const tipo = (user.tipo || 'admin').toLowerCase();
  const id_pessoa = user.id_pessoa ? Number(user.id_pessoa) : null;
  const cpfClean = user.cpf ? user.cpf.replace(/\D/g, '') : '';

  if (tipo === 'admin' || tipo === 'propec') {
    return { sql: '1=1', params: [] };
  }

  if (tipo === 'professor') {
    return {
      sql: `(pe.coordenador_id = ? OR pe.id_projeto IN (
        SELECT DISTINCT pp.id_projeto
        FROM projeto_pessoa pp
        JOIN pla_curso_disciplina pcd ON pp.id_pessoa = pcd.ID
        WHERE REPLACE(REPLACE(pcd.CPF, '.', ''), '-', '') = ?
      ))`,
      params: [id_pessoa, cpfClean]
    };
  }

  if (tipo === 'coordenador') {
    return {
      sql: `(pe.coordenador_id = ? OR pe.id_projeto IN (
        SELECT DISTINCT pc.id_projeto
        FROM projeto_curso pc
        JOIN curso c ON pc.id_curso = c.id_curso
        WHERE c.coordenador_id = ?
      ))`,
      params: [id_pessoa, id_pessoa]
    };
  }

  // Padrão: bloqueia tudo se não for reconhecido
  return { sql: '1=0', params: [] };
}

async function hasAccess(id_projeto, sessionUser) {
  const user = sessionUser || {};
  const tipo = (user.tipo || '').toLowerCase();
  if (tipo === 'admin' || tipo === 'propec') return true;

  const id_pessoa = user.id_pessoa ? Number(user.id_pessoa) : null;
  const cpfClean = user.cpf ? user.cpf.replace(/\D/g, '') : '';

  if (tipo === 'professor') {
    const [rows] = await pool.query(
      `SELECT 1 FROM projeto_extensao pe
       WHERE pe.id_projeto = ? AND (pe.coordenador_id = ? OR pe.id_projeto IN (
         SELECT DISTINCT pp.id_projeto
         FROM projeto_pessoa pp
         JOIN pla_curso_disciplina pcd ON pp.id_pessoa = pcd.ID
         WHERE REPLACE(REPLACE(pcd.CPF, '.', ''), '-', '') = ?
       ))`,
      [id_projeto, id_pessoa, cpfClean]
    );
    return rows.length > 0;
  }

  if (tipo === 'coordenador') {
    const [rows] = await pool.query(
      `SELECT 1 FROM projeto_extensao pe
       WHERE pe.id_projeto = ? AND (pe.coordenador_id = ? OR pe.id_projeto IN (
         SELECT DISTINCT pc.id_projeto
         FROM projeto_curso pc
         JOIN curso c ON pc.id_curso = c.id_curso
         WHERE c.coordenador_id = ?
       ))`,
      [id_projeto, id_pessoa, id_pessoa]
    );
    return rows.length > 0;
  }

  return false;
}

async function getAllprojeto_extensaos(sessionUser, page = 1, limit = 10) {
  const offset = (page - 1) * limit;
  const access = getAccessFilter(sessionUser || {});

  const [countResult] = await pool.query(
    `SELECT COUNT(*) as total FROM projeto_extensao pe WHERE ${access.sql}`,
    access.params
  );
  const total = countResult[0].total;

  const [rows] = await pool.query(`
    SELECT
      pe.id_projeto,
      pe.titulo,
      pe.id_tipo_plano,
      pe.coordenador_id,
      pe.periodo_inicio,
      pe.periodo_fim,
      pe.carga_horaria_total,
      pe.id_publico_alvo,
      pe.objetivo,
      pe.metodologia,
      pe.status,
      p.nome AS coordenador_nome,
      (
        SELECT GROUP_CONCAT(c.nome_curso SEPARATOR ', ')
        FROM projeto_curso pc
        JOIN curso c ON pc.id_curso = c.id_curso
        WHERE pc.id_projeto = pe.id_projeto
      ) AS cursos
    FROM projeto_extensao pe
    LEFT JOIN pessoa p ON pe.coordenador_id = p.id_pessoa
    WHERE ${access.sql}
    ORDER BY pe.id_projeto DESC
    LIMIT ${limit} OFFSET ${offset}
  `, [...access.params]);
  return { rows, total, page, limit, totalPages: Math.ceil(total / limit) };
}

async function getprojeto_extensaosByNome(sessionUser, nome) {
  const access = getAccessFilter(sessionUser || {});
  const [rows] = await pool.query(
    `SELECT pe.* FROM projeto_extensao pe 
     WHERE pe.titulo LIKE ? AND ${access.sql} 
     ORDER BY pe.id_projeto DESC`,
    [`%${nome}%`, ...access.params]
  );
  return rows;
}

async function getprojeto_extensaosById(id) {
  const [rows] = await pool.query(
    'SELECT * FROM projeto_extensao WHERE id_projeto = ?',
    [id]
  );
  return rows[0];
}

async function insertprojeto_extensaos(registro) {
  const [result] = await pool.query(
    `INSERT INTO projeto_extensao
      (titulo, id_tipo_plano, coordenador_id, periodo_inicio, periodo_fim, carga_horaria_total, id_publico_alvo, objetivo, metodologia)
     VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
    [
      registro.titulo ?? null,
      registro.id_tipo_plano ?? null,
      registro.coordenador_id ?? null, // pode ficar null
      registro.periodo_inicio ?? null,
      registro.periodo_fim ?? null,
      registro.carga_horaria_total ?? null,
      registro.id_publico_alvo ?? null,
      registro.objetivo ?? null,
      registro.metodologia ?? null
    ]
  );

  return result.insertId;
}

async function updateprojeto_extensaos(id, registro) {
  await pool.query(
    `UPDATE projeto_extensao
     SET
       titulo = ?,
       id_tipo_plano = ?,
       coordenador_id = ?,
       periodo_inicio = ?,
       periodo_fim = ?,
       carga_horaria_total = ?,
       id_publico_alvo = ?,
       objetivo = ?,
       metodologia = ?
     WHERE id_projeto = ?`,
    [
      registro.titulo ?? null,
      registro.id_tipo_plano ?? null,
      registro.coordenador_id ?? null, // pode ficar null
      registro.periodo_inicio ?? null,
      registro.periodo_fim ?? null,
      registro.carga_horaria_total ?? null,
      registro.id_publico_alvo ?? null,
      registro.objetivo ?? null,
      registro.metodologia ?? null,
      id
    ]
  );

  return getprojeto_extensaosById(id);
}

async function deleteprojeto_extensaos(id) {
  const connection = await pool.getConnection();
  try {
    await connection.beginTransaction();

    await connection.query('DELETE FROM avaliacao_institucional WHERE id_projeto = ?', [id]);
    await connection.query('DELETE FROM avaliacao_participante WHERE id_projeto = ?', [id]);
    await connection.query('DELETE FROM projeto_curso WHERE id_projeto = ?', [id]);
    await connection.query('DELETE FROM projeto_custo WHERE id_projeto = ?', [id]);
    await connection.query('DELETE FROM projeto_instituicao WHERE id_projeto = ?', [id]);
    await connection.query('DELETE FROM projeto_linhaprogramatica WHERE id_projeto = ?', [id]);
    await connection.query('DELETE FROM projeto_local WHERE id_projeto = ?', [id]);
    await connection.query('DELETE FROM projeto_pessoa WHERE id_projeto = ?', [id]);
    await connection.query('DELETE FROM projeto_tipoacao WHERE id_projeto = ?', [id]);
    await connection.query('DELETE FROM anexo_projeto WHERE id_projeto = ?', [id]);

    await connection.query('DELETE FROM projeto_extensao WHERE id_projeto = ?', [id]);

    await connection.commit();
  } catch (error) {
    await connection.rollback();
    throw error;
  } finally {
    connection.release();
  }
}

/* ===== Relacionamentos de Tipo de Ação ===== */

async function getTipoAcaoByProjeto(id_projeto) {
  const [rows] = await pool.query(
    'SELECT * FROM projeto_tipoacao WHERE id_projeto = ?',
    [id_projeto]
  );
  return rows;
}

async function updateTipoAcaoProjeto(id_projeto, itens) {
  const connection = await pool.getConnection();
  try {
    await connection.beginTransaction();

    await connection.query(
      'DELETE FROM projeto_tipoacao WHERE id_projeto = ?',
      [id_projeto]
    );

    if (itens?.length) {
      for (const item of itens) {
        await connection.query(
          'INSERT INTO projeto_tipoacao (id_projeto, id_acao) VALUES (?, ?)',
          [id_projeto, item.id_acao]
        );
      }
    }

    await connection.commit();
  } catch (error) {
    await connection.rollback();
    throw error;
  } finally {
    connection.release();
  }
}

/* ===== Relacionamentos de Linha Programática ===== */

async function getLinhaProgramaticaByProjeto(id_projeto) {
  const [rows] = await pool.query(
    'SELECT * FROM projeto_linhaprogramatica WHERE id_projeto = ?',
    [id_projeto]
  );
  return rows;
}

async function updateLinhaProgramaticaProjeto(id_projeto, itens) {
  const connection = await pool.getConnection();
  try {
    await connection.beginTransaction();

    await connection.query(
      'DELETE FROM projeto_linhaprogramatica WHERE id_projeto = ?',
      [id_projeto]
    );

    if (itens?.length) {
      for (const item of itens) {
        await connection.query(
          'INSERT INTO projeto_linhaprogramatica (id_projeto, id_linha) VALUES (?, ?)',
          [id_projeto, item.id_linha]
        );
      }
    }

    await connection.commit();
  } catch (error) {
    await connection.rollback();
    throw error;
  } finally {
    connection.release();
  }
}

/* ===== Cursos do projeto ===== */

async function getCursosByProjeto(id_projeto) {
  const [rows] = await pool.query(
    'SELECT * FROM projeto_curso WHERE id_projeto = ?',
    [id_projeto]
  );
  return rows;
}

async function updateCursosProjeto(id_projeto, cursos) {
  const connection = await pool.getConnection();
  try {
    await connection.beginTransaction();

    await connection.query(
      'DELETE FROM projeto_curso WHERE id_projeto = ?',
      [id_projeto]
    );

    if (cursos?.length) {
      for (const item of cursos) {
        await connection.query(
          'INSERT INTO projeto_curso (id_projeto, id_curso) VALUES (?, ?)',
          [id_projeto, item.cursoId]
        );
      }
    }

    await connection.commit();
  } catch (error) {
    await connection.rollback();
    throw error;
  } finally {
    connection.release();
  }
}

async function getPessoasByProjeto(id_projeto) {
  const [rows] = await pool.query(
    'SELECT * FROM projeto_pessoa WHERE id_projeto = ?',
    [id_projeto]
  );
  return rows;
}

async function updatePessoasProjeto(id_projeto, cursos, idPapelProfessor) {
  const connection = await pool.getConnection();
  try {
    await connection.beginTransaction();

    await connection.query(
      'DELETE FROM projeto_pessoa WHERE id_projeto = ? AND id_papel = ?',
      [id_projeto, idPapelProfessor]
    );

    let somaCH = 0;

    if (cursos?.length) {
      const pessoasJaInseridas = new Set();

      for (const item of cursos) {
        if (item.professores?.length) {
          for (const prof of item.professores) {
            const id_pessoa = typeof prof === 'object' && prof !== null ? prof.id_pessoa : prof;
            const disciplina = typeof prof === 'object' && prof !== null ? prof.disciplina : null;
            const cargahoraria = typeof prof === 'object' && prof !== null ? prof.cargahoraria : null;
            const chave = `${id_projeto}-${id_pessoa}-${idPapelProfessor}`;

            if (!pessoasJaInseridas.has(chave)) {
              await connection.query(
                'INSERT INTO projeto_pessoa (id_projeto, id_pessoa, id_papel, Disciplina, cargahoraria) VALUES (?, ?, ?, ?, ?)',
                [id_projeto, id_pessoa, idPapelProfessor, disciplina || null, cargahoraria || 0]
              );
              pessoasJaInseridas.add(chave);
              somaCH += parseInt(cargahoraria) || 0;
            }
          }
        }
      }
    }

    // Toda modificação da carga horária de professor deve alterar a carga horária do projeto
    await connection.query(
      'UPDATE projeto_extensao SET carga_horaria_total = ? WHERE id_projeto = ?',
      [somaCH, id_projeto]
    );

    await connection.commit();
  } catch (error) {
    await connection.rollback();
    throw error;
  } finally {
    connection.release();
  }
}

async function filterprojeto_extensao(sessionUser, filters, page = 1, limit = 10) {
  const offset = (page - 1) * limit;
  const access = getAccessFilter(sessionUser || {});

  const conditions = [access.sql];
  const params = [...access.params];

  if (filters.titulo) { conditions.push('pe.titulo LIKE ?'); params.push('%' + filters.titulo + '%'); }
  if (filters.curso) {
    conditions.push(`pe.id_projeto IN (
      SELECT DISTINCT pc.id_projeto
      FROM projeto_curso pc
      JOIN curso c ON pc.id_curso = c.id_curso
      WHERE c.nome_curso LIKE ?
    )`);
    params.push('%' + filters.curso + '%');
  }
  if (filters.id_tipo_plano) { conditions.push('pe.id_tipo_plano = ?'); params.push(filters.id_tipo_plano); }
  if (filters.status) { conditions.push('pe.status = ?'); params.push(filters.status); }
  if (filters.periodo_inicio_de) { conditions.push('pe.periodo_inicio >= ?'); params.push(filters.periodo_inicio_de); }
  if (filters.periodo_inicio_ate) { conditions.push('pe.periodo_inicio <= ?'); params.push(filters.periodo_inicio_ate); }

  const whereSql = ' WHERE ' + conditions.join(' AND ');

  const [countResult] = await pool.query(`SELECT COUNT(*) as total FROM projeto_extensao pe${whereSql}`, params);
  const total = countResult[0].total;

  let sql = `SELECT pe.id_projeto, pe.titulo, pe.id_tipo_plano, pe.coordenador_id, pe.periodo_inicio, pe.periodo_fim, pe.carga_horaria_total, pe.id_publico_alvo, pe.objetivo, pe.metodologia, pe.status, p.nome AS coordenador_nome,
             (
               SELECT GROUP_CONCAT(c.nome_curso SEPARATOR ', ')
               FROM projeto_curso pc
               JOIN curso c ON pc.id_curso = c.id_curso
               WHERE pc.id_projeto = pe.id_projeto
             ) AS cursos
             FROM projeto_extensao pe LEFT JOIN pessoa p ON pe.coordenador_id = p.id_pessoa${whereSql} ORDER BY pe.id_projeto DESC LIMIT ${limit} OFFSET ${offset}`;
  const [rows] = await pool.query(sql, params);
  return { rows, total, page, limit, totalPages: Math.ceil(total / limit) };
}

async function updateStatus(id, status) {
  await pool.query('UPDATE projeto_extensao SET status = ? WHERE id_projeto = ?', [status, id]);
}

async function getDashboardStats() {
  const [statusCounts] = await pool.query(`
    SELECT status, COUNT(*) AS total FROM projeto_extensao GROUP BY status
  `);
  const [totalProjetos] = await pool.query('SELECT COUNT(*) AS total FROM projeto_extensao');
  const [totalPessoas] = await pool.query('SELECT COUNT(*) AS total FROM pessoa');
  const [totalCursos] = await pool.query('SELECT COUNT(*) AS total FROM curso');
  const [projetosPorCurso] = await pool.query(`
    SELECT c.nome_curso, COUNT(pc.id_projeto) AS total
    FROM projeto_curso pc
    JOIN curso c ON pc.id_curso = c.id_curso
    GROUP BY c.nome_curso
    ORDER BY total DESC
    LIMIT 5
  `);
  return {
    statusCounts: statusCounts.reduce((acc, r) => { acc[r.status] = r.total; return acc; }, {}),
    totalProjetos: totalProjetos[0].total,
    totalPessoas: totalPessoas[0].total,
    totalCursos: totalCursos[0].total,
    projetosPorCurso
  };
}

async function getProjetoCompletoById(id) {
  const [projeto] = await pool.query(`
    SELECT pe.*, tp.descricao AS tipo_plano_nome, pa.descricao AS publico_alvo_nome,
           p.nome AS coordenador_nome
    FROM projeto_extensao pe
    LEFT JOIN tipo_plano tp ON pe.id_tipo_plano = tp.id_tipo_plano
    LEFT JOIN publico_alvo pa ON pe.id_publico_alvo = pa.id_publico_alvo
    LEFT JOIN pessoa p ON pe.coordenador_id = p.id_pessoa
    WHERE pe.id_projeto = ?
  `, [id]);
  if (!projeto[0]) return null;
  const proj = projeto[0];

  const [tiposAcao] = await pool.query('SELECT ta.nome FROM projeto_tipoacao pt JOIN tipo_acao ta ON pt.id_acao = ta.id_acao WHERE pt.id_projeto = ?', [id]);
  const [linhas] = await pool.query('SELECT lp.nome FROM projeto_linhaprogramatica pl JOIN linha_programatica lp ON pl.id_linha = lp.id_linha WHERE pl.id_projeto = ?', [id]);
  const [cursos] = await pool.query('SELECT c.nome_curso FROM projeto_curso pc JOIN curso c ON pc.id_curso = c.id_curso WHERE pc.id_projeto = ?', [id]);
  const [pessoas] = await pool.query(`
    SELECT
      pcd.NOMEPROFESSOR AS nome,
      pp.Disciplina AS disciplina,
      pp.cargahoraria AS cargahoraria,
      pp2.descricao AS papel
    FROM projeto_pessoa pp
    LEFT JOIN pla_curso_disciplina pcd ON pp.id_pessoa = pcd.ID
    LEFT JOIN papel_projeto pp2 ON pp.id_papel = pp2.id_papel
    WHERE pp.id_projeto = ?
  `, [id]);
  const [custos] = await pool.query('SELECT * FROM projeto_custo WHERE id_projeto = ?', [id]);
  const [cronograma] = await pool.query('SELECT * FROM cronograma_atividades WHERE id_projeto = ? ORDER BY numero', [id]);
  const [locais] = await pool.query('SELECT le.* FROM projeto_local pl JOIN local_execucao le ON pl.id_local = le.id_local WHERE pl.id_projeto = ?', [id]);
  const [instituicoes] = await pool.query('SELECT i.id_instituicao, i.nome, i.sigla, ti.descricao AS tipo FROM projeto_instituicao pi JOIN instituicao i ON pi.id_instituicao = i.id_instituicao LEFT JOIN tipo_instituicao ti ON i.id_tipo_instituicao = ti.id_tipo_instituicao WHERE pi.id_projeto = ?', [id]);
  const [anexos] = await pool.query(
    'SELECT * FROM anexo_projeto WHERE id_projeto = ? ORDER BY data_upload DESC',
    [id]
  );

  proj.tiposAcao = tiposAcao;
  proj.linhas = linhas;
  proj.cursos = cursos;
  proj.pessoas = pessoas;
  proj.custos = custos;
  proj.cronograma = cronograma;
  proj.locais = locais;
  proj.instituicoes = instituicoes;
  proj.arquivos_anexos = anexos;

  const [assinaturas] = await pool.query(`
    SELECT pa.id, pa.ordem, pa.data_hora, pa.Assinatura, pa.tipo_assinatura, pa.id_pessoa, p.nome, p.cpf
    FROM projeto_assinatura pa
    INNER JOIN pessoa p ON pa.id_pessoa = p.id_pessoa
    WHERE pa.id_projeto = ?
    ORDER BY pa.data_hora ASC
  `, [id]);
  proj.assinaturas = assinaturas;

  // Carregar professores cadastrados do projeto
  const [registeredProfsRows] = await pool.query(`
    SELECT DISTINCT pcd.CPF, pcd.NOMEPROFESSOR
    FROM projeto_pessoa pp
    JOIN pla_curso_disciplina pcd ON pp.id_pessoa = pcd.ID
    WHERE pp.id_projeto = ? AND pp.id_papel = 1
  `, [id]);

  const profCPFs = new Set(registeredProfsRows.map(row => {
    return row.CPF ? row.CPF.replace(/\D/g, '') : '';
  }).filter(Boolean));

  // Carregar coordenadores dos cursos vinculados ao projeto
  const [coordinatorsRows] = await pool.query(`
    SELECT DISTINCT c.coordenador_id, p.cpf, p.nome
    FROM projeto_curso pc
    JOIN curso c ON pc.id_curso = c.id_curso
    LEFT JOIN pessoa p ON c.coordenador_id = p.id_pessoa
    WHERE pc.id_projeto = ? AND c.coordenador_id IS NOT NULL
  `, [id]);

  const coordIds = new Set(coordinatorsRows.map(row => Number(row.coordenador_id)));

  // Classificar assinaturas existentes
  const assinaturasProfessoresPlano = [];
  const assinaturasCoordenadoresPlano = [];
  const assinaturasProfessoresRelatorio = [];
  const assinaturasCoordenadoresRelatorio = [];

  const signedProfCPFsPlano = new Set();
  const signedCoordIdsPlano = new Set();
  const signedProfCPFsRelatorio = new Set();
  const signedCoordIdsRelatorio = new Set();

  for (const ass of assinaturas) {
    const cleanCpf = ass.cpf ? ass.cpf.replace(/\D/g, '') : '';
    const id_pessoa = Number(ass.id_pessoa);
    const tipo = ass.tipo_assinatura === 2 ? 2 : 1;

    if (tipo === 1) {
      if (profCPFs.has(cleanCpf) && !signedProfCPFsPlano.has(cleanCpf)) {
        assinaturasProfessoresPlano.push(ass);
        signedProfCPFsPlano.add(cleanCpf);
      } else if (coordIds.has(id_pessoa) && !signedCoordIdsPlano.has(id_pessoa)) {
        assinaturasCoordenadoresPlano.push(ass);
        signedCoordIdsPlano.add(id_pessoa);
      } else {
        if (coordIds.has(id_pessoa)) {
          assinaturasCoordenadoresPlano.push(ass);
          signedCoordIdsPlano.add(id_pessoa);
        } else {
          assinaturasProfessoresPlano.push(ass);
        }
      }
    } else {
      if (profCPFs.has(cleanCpf) && !signedProfCPFsRelatorio.has(cleanCpf)) {
        assinaturasProfessoresRelatorio.push(ass);
        signedProfCPFsRelatorio.add(cleanCpf);
      } else if (coordIds.has(id_pessoa) && !signedCoordIdsRelatorio.has(id_pessoa)) {
        assinaturasCoordenadoresRelatorio.push(ass);
        signedCoordIdsRelatorio.add(id_pessoa);
      } else {
        if (coordIds.has(id_pessoa)) {
          assinaturasCoordenadoresRelatorio.push(ass);
          signedCoordIdsRelatorio.add(id_pessoa);
        } else {
          assinaturasProfessoresRelatorio.push(ass);
        }
      }
    }
  }

  proj.assinaturasProfessores = assinaturasProfessoresPlano;
  proj.assinaturasCoordenadores = assinaturasCoordenadoresPlano;
  
  proj.assinaturasProfessoresPlano = assinaturasProfessoresPlano;
  proj.assinaturasCoordenadoresPlano = assinaturasCoordenadoresPlano;
  proj.assinaturasProfessoresRelatorio = assinaturasProfessoresRelatorio;
  proj.assinaturasCoordenadoresRelatorio = assinaturasCoordenadoresRelatorio;
  
  proj.professoresCadastrados = registeredProfsRows;
  proj.coordenadoresCursos = coordinatorsRows;

  return proj;
}

async function updatePlano(id, campos) {
  await pool.query(`UPDATE projeto_extensao SET resultados_esperados = ?, avaliacao_descricao = ?, referencias = ? WHERE id_projeto = ?`,
    [campos.resultados_esperados || null, campos.avaliacao_descricao || null, campos.referencias || null, id]);
}

async function updateRelatorio(id, campos) {
  await pool.query(`UPDATE projeto_extensao SET justificativa = ?, resultados_alcancados = ?, avaliacao_comunidade = ?, avaliacao_equipe = ?, produtos_gerados = ?, ods = ?, observacao_final = ?, anexos = ? WHERE id_projeto = ?`,
    [campos.justificativa || null, campos.resultados_alcancados || null, campos.avaliacao_comunidade || null, campos.avaliacao_equipe || null, campos.produtos_gerados || null, campos.ods || null, campos.observacao_final || null, campos.anexos || null, id]);
}

// ===== HELPERS: LOCAIS vinculados ao projeto =====
async function addLocalProjeto(id_projeto, localData) {
  const [result] = await pool.query(
    'INSERT INTO local_execucao (endereco, bairro, cidade, cep) VALUES (?, ?, ?, ?)',
    [localData.endereco || null, localData.bairro || null, localData.cidade || null, localData.cep || null]
  );
  const id_local = result.insertId;
  await pool.query('INSERT INTO projeto_local (id_projeto, id_local) VALUES (?, ?)', [id_projeto, id_local]);
  return id_local;
}

async function removeLocalProjeto(id_projeto, id_local) {
  await pool.query('DELETE FROM projeto_local WHERE id_projeto = ? AND id_local = ?', [id_projeto, id_local]);
}

// ===== HELPERS: INSTITUICOES vinculadas ao projeto =====
async function addInstituicaoProjeto(id_projeto, id_instituicao) {
  await pool.query('INSERT INTO projeto_instituicao (id_projeto, id_instituicao) VALUES (?, ?)', [id_projeto, id_instituicao]);
}

async function removeInstituicaoProjeto(id_projeto, id_instituicao) {
  await pool.query('DELETE FROM projeto_instituicao WHERE id_projeto = ? AND id_instituicao = ?', [id_projeto, id_instituicao]);
}

async function updateLocalProjeto(id_local, localData) {
  await pool.query(
    'UPDATE local_execucao SET endereco = ?, bairro = ?, cidade = ?, cep = ? WHERE id_local = ?',
    [localData.endereco || null, localData.bairro || null, localData.cidade || null, localData.cep || null, id_local]
  );
}

async function updateInstituicaoProjeto(old_id_instituicao, id_projeto, new_id_instituicao) {
  await pool.query(
    'UPDATE projeto_instituicao SET id_instituicao = ? WHERE id_projeto = ? AND id_instituicao = ?',
    [new_id_instituicao, id_projeto, old_id_instituicao]
  );
}

async function insertAnexosProjeto(id_projeto, arquivos) {
  if (!arquivos || arquivos.length === 0) return;

  const sql = `
    INSERT INTO anexo_projeto
    (id_projeto, nome_original, nome_arquivo, caminho_arquivo, tipo_arquivo, tamanho_bytes)
    VALUES (?, ?, ?, ?, ?, ?)
  `;

  for (const arquivo of arquivos) {
    await pool.query(sql, [
      id_projeto,
      arquivo.originalname,
      arquivo.filename,
      `/uploads/anexos/${arquivo.filename}`,
      arquivo.mimetype || null,
      arquivo.size || null
    ]);
  }
}

async function getAnexosByProjeto(id_projeto) {
  const [rows] = await pool.query(
    'SELECT * FROM anexo_projeto WHERE id_projeto = ? ORDER BY data_upload DESC, id_anexo DESC',
    [id_projeto]
  );
  return rows;
}

async function getAnexoById(id_anexo) {
  const [rows] = await pool.query(
    'SELECT * FROM anexo_projeto WHERE id_anexo = ?',
    [id_anexo]
  );
  return rows[0];
}

async function deleteAnexoById(id_anexo) {
  await pool.query(
    'DELETE FROM anexo_projeto WHERE id_anexo = ?',
    [id_anexo]
  );
}

module.exports = {
  getAllprojeto_extensaos,
  getprojeto_extensaosByNome,
  getprojeto_extensaosById,
  insertprojeto_extensaos,
  updateprojeto_extensaos,
  deleteprojeto_extensaos,
  getTipoAcaoByProjeto,
  updateTipoAcaoProjeto,
  getLinhaProgramaticaByProjeto,
  updateLinhaProgramaticaProjeto,
  getCursosByProjeto,
  updateCursosProjeto,
  getPessoasByProjeto,
  updatePessoasProjeto,
  filterprojeto_extensao,
  getProjetoCompletoById,
  updatePlano,
  updateRelatorio,
  addLocalProjeto,
  updateLocalProjeto,
  removeLocalProjeto,
  addInstituicaoProjeto,
  updateInstituicaoProjeto,
  removeInstituicaoProjeto,
  updateStatus,
  getDashboardStats,
  insertAnexosProjeto,
  getAnexosByProjeto,
  getAnexoById,
  deleteAnexoById,
  hasAccess
};