// Seed: Criar usuário admin padrão se não existir
// Roda automaticamente no boot do servidor
require('dotenv').config();

async function seedAdmin(pool) {
  try {
    // 1. Garantir que as pessoas de admin e coordenador existam na tabela pessoa
    const [adminPessoaRows] = await pool.query("SELECT id_pessoa FROM pessoa WHERE nome = ? LIMIT 1", ['Administrador']);
    let adminPessoaId;
    if (adminPessoaRows.length === 0) {
      const [insertRes] = await pool.query("INSERT INTO pessoa (nome, id_tipo_pessoa) VALUES (?, ?)", ['Administrador', 3]); // 3 = Técnico
      adminPessoaId = insertRes.insertId;
      console.log('[seed] Pessoa "Administrador" criada com id:', adminPessoaId);
    } else {
      adminPessoaId = adminPessoaRows[0].id_pessoa;
    }

    const [coordPessoaRows] = await pool.query("SELECT id_pessoa FROM pessoa WHERE nome = ? LIMIT 1", ['Coordenador Geral']);
    let coordPessoaId;
    if (coordPessoaRows.length === 0) {
      const [insertRes] = await pool.query("INSERT INTO pessoa (nome, id_tipo_pessoa) VALUES (?, ?)", ['Coordenador Geral', 1]); // 1 = Coordenador
      coordPessoaId = insertRes.insertId;
      console.log('[seed] Pessoa "Coordenador Geral" criada com id:', coordPessoaId);
    } else {
      coordPessoaId = coordPessoaRows[0].id_pessoa;
    }

    // 2. Verificar/Criar usuário admin padrão
    const [admins] = await pool.query("SELECT id_usuario, id_pessoa FROM usuario WHERE usuario = ? LIMIT 1", ['admin']);
    if (admins.length === 0) {
      await pool.query(
        "INSERT INTO usuario (usuario, senha, tipo, id_pessoa) VALUES (?, ?, ?, ?)",
        ['admin', 'admin123', 'admin', adminPessoaId]
      );
      console.log('[seed] Usuário admin criado (login: admin / senha: admin123)');
    } else if (admins[0].id_pessoa === null) {
      await pool.query("UPDATE usuario SET id_pessoa = ? WHERE usuario = ?", [adminPessoaId, 'admin']);
      console.log('[seed] Usuário admin vinculado à pessoa Administrador');
    }

    // 3. Verificar/Criar usuário coordenador de exemplo
    const [coords] = await pool.query("SELECT id_usuario, id_pessoa FROM usuario WHERE usuario = ? LIMIT 1", ['coordenador']);
    if (coords.length === 0) {
      await pool.query(
        "INSERT INTO usuario (usuario, senha, tipo, id_pessoa) VALUES (?, ?, ?, ?)",
        ['coordenador', 'coord123', 'coordenador', coordPessoaId]
      );
      console.log('[seed] Usuário coordenador criado (login: coordenador / senha: coord123)');
    } else if (coords[0].id_pessoa === null) {
      await pool.query("UPDATE usuario SET id_pessoa = ? WHERE usuario = ?", [coordPessoaId, 'coordenador']);
      console.log('[seed] Usuário coordenador vinculado à pessoa Coordenador Geral');
    }

    // 4. Garantir que usuários existentes tenham tipo 'professor' se estiver null
    await pool.query("UPDATE usuario SET tipo = 'professor' WHERE tipo IS NULL OR tipo = ''");

  } catch (err) {
    // Silenciar erro se tabela não existe ainda
    if (err.code !== 'ER_NO_SUCH_TABLE') {
      console.warn('[seed] Aviso:', err.message);
    }
  }
}

// Se executado diretamente
if (require.main === module) {
  const mysql = require('mysql2/promise');
  (async () => {
    const conn = await mysql.createConnection({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_NAME,
      port: process.env.DB_PORT
    });
    await seedAdmin(conn);
    await conn.end();
    console.log('[seed] Concluído.');
  })().catch(console.error);
}

module.exports = seedAdmin;
