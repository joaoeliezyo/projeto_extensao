// projeto_assinaturaController.js
const projeto_assinaturaModel = require('../models/projeto_assinaturaModel');
const projeto_extensaoModel = require('../models/projeto_extensaoModel');

async function listprojeto_assinatura(req, res) {
  try {
    const projeto_assinatura = await projeto_assinaturaModel.getAllProjeto_assinatura();
    res.render('consultas/projeto_assinatura', { dados: projeto_assinatura });
  } catch (error) {
    console.error('Erro ao buscar assinaturas:', error);
    res.render('error', { message: 'Erro ao buscar assinaturas', returnLink: '/welcome' });
  }
}

async function filterprojeto_assinatura(req, res) {
  const { nome } = req.body;
  try {
    const projeto_assinatura = await projeto_assinaturaModel.getProjeto_assinaturaByNome(nome || '');
    if (!projeto_assinatura || projeto_assinatura.length === 0) {
      res.render('consultas/projeto_assinatura', { dados: [] });
      return;
    }
    res.render('consultas/projeto_assinatura', { dados: projeto_assinatura });
  } catch (error) {
    console.error('Erro ao filtrar assinaturas:', error);
    res.render('error', { message: 'Erro ao filtrar assinaturas', returnLink: '/welcome' });
  }
}

async function addprojeto_assinatura(req, res) {
  const id_pessoa = req.id_pessoa ?? req.session?.id_pessoa ?? req.body.id_pessoa ?? null;
  try {
    await projeto_assinaturaModel.insertProjeto_assinatura(
      req.body,
      { id_pessoa }
    );
    res.redirect('/projeto_assinatura');
  } catch (error) {
    console.error('Erro ao inserir assinatura:', error);
    res.render('error', { message: 'Erro ao inserir assinatura', returnLink: '/logo' });
  }
}

async function showprojeto_assinatura(req, res) {
  const id = req.params.id;
  try {
    const projeto_assinatura = await projeto_assinaturaModel.getProjeto_assinaturaById(id);
    if (!projeto_assinatura) {
      res.status(404).send('projeto_assinatura nao encontrado');
      return;
    }
    res.render('consultas/projeto_assinatura', { dados: [projeto_assinatura] });
  } catch (error) {
    console.error('Erro ao buscar projeto_assinatura:', error);
    res.render('error', { message: 'Erro ao buscar projeto_assinatura', returnLink: '/welcome' });
  }
}

async function showEditForm(req, res) {
  const id = req.params.id;
  try {
    const projeto_assinatura = await projeto_assinaturaModel.getProjeto_assinaturaById(id);
    if (!projeto_assinatura) {
      res.status(404).send('projeto_assinatura nao encontrado');
      return;
    }
    res.render('forms/projeto_assinatura', { projeto_assinatura, isEdit: true });
  } catch (error) {
    console.error('Erro ao carregar assinatura para edicao:', error);
    res.render('error', { message: 'Erro ao carregar assinatura para edicao', returnLink: '/projeto_assinatura' });
  }
}

async function editprojeto_assinatura(req, res) {
  const id = req.params.id;
  try {
    await projeto_assinaturaModel.updateProjeto_assinatura(id, req.body);
    res.redirect('/projeto_assinatura');
  } catch (error) {
    console.error('Erro ao editar assinatura:', error);
    res.render('error', { message: 'Erro ao editar assinatura', returnLink: '/projeto_assinatura' });
  }
}

async function showConfirmDeleteFormprojeto_assinatura(req, res) {
  const id = req.params.id;
  try {
    const projeto_assinatura = await projeto_assinaturaModel.getProjeto_assinaturaById(id);
    if (!projeto_assinatura) {
      res.status(404).send('projeto_assinatura nao encontrado');
      return;
    }
    res.render('confirmDelete', { curso: projeto_assinatura });
  } catch (error) {
    console.error('Erro ao carregar confirmacao de exclusao:', error);
    res.render('error', { message: 'Erro ao carregar confirmacao de exclusao', returnLink: '/projeto_assinatura' });
  }
}

async function deleteprojeto_assinatura(req, res) {
  const id = req.params.id;
  try {
    const ass = await projeto_assinaturaModel.getProjeto_assinaturaById(id);
    if (!ass) {
      req.session.flash = { type: 'error', message: 'Assinatura não encontrada.' };
      return res.redirect('/projeto_extensao');
    }

    const id_projeto = ass.id_projeto;
    const proj = await projeto_extensaoModel.getProjetoCompletoById(id_projeto);

    // Regra 4: Uma vez o coordenador assinado na mesma etapa, o professor não pode excluir a assinatura existente
    const tipo = ass.tipo_assinatura === 2 ? 2 : 1;
    const hasCoordinatorSignedEtapa = (tipo === 1 ? proj.assinaturasCoordenadoresPlano : proj.assinaturasCoordenadoresRelatorio).length > 0;
    
    const cleanAssCpf = ass.cpf ? ass.cpf.replace(/\D/g, '') : '';
    const isProfSig = proj.professoresCadastrados.some(p => p.CPF && p.CPF.replace(/\D/g, '') === cleanAssCpf);

    if (isProfSig && hasCoordinatorSignedEtapa) {
      req.session.flash = {
        type: 'error',
        message: `Não é possível remover a assinatura do professor pois um coordenador já assinou esta etapa do projeto.`
      };
      return res.redirect(`/projeto_assinatura/${id_projeto}/assinar`);
    }

    await projeto_assinaturaModel.deleteProjeto_assinatura(id);

    req.session.flash = {
      type: 'success',
      message: 'Assinatura removida com sucesso!'
    };
    res.redirect(`/projeto_assinatura/${id_projeto}/assinar`);
  } catch (error) {
    console.error('Erro ao excluir assinatura:', error);
    req.session.flash = { type: 'error', message: 'Erro ao remover assinatura.' };
    res.redirect('/projeto_extensao');
  }
}

async function showAssinar(req, res) {
  const id_projeto = req.params.id_projeto;
  let id_pessoa = req.id_pessoa ?? req.session?.id_pessoa ?? null;

  try {
    const pool = require('../db');
    let userCpf = '';
    if (id_pessoa) {
      const [pessoaRows] = await pool.query('SELECT cpf FROM pessoa WHERE id_pessoa = ?', [id_pessoa]);
      if (pessoaRows.length > 0) {
        userCpf = pessoaRows[0].cpf || '';
      }
    }

    const [projeto, resumoAssinaturas] = await Promise.all([
      projeto_extensaoModel.getProjetoCompletoById(id_projeto),
      projeto_assinaturaModel.getResumoAssinaturasByProjeto(id_projeto)
    ]);

    if (!projeto) {
      res.status(404).send('Projeto não encontrado');
      return;
    }

    res.render('consultas/projeto_assinatura', {
      dados: projeto.assinaturas,
      id_projeto,
      resumoAssinaturas,
      projeto,
      userCpf
    });
  } catch (error) {
    console.error('Erro ao carregar assinaturas do projeto:', error);
    res.render('error', { message: 'Erro ao carregar assinaturas do projeto', returnLink: '/projeto_extensao' });
  }
}

async function assinarProjeto(req, res) {
  const id_projeto = req.params.id_projeto;
  let id_pessoa = req.id_pessoa ?? req.session?.id_pessoa ?? null;
  const tipo_assinatura = Number(req.body.tipo_assinatura || 1);

  // Fallback: se estiver autenticado mas a session não tiver id_pessoa, buscar no banco
  if (!id_pessoa && req.session?.usuario) {
    try {
      const pool = require('../db');
      const [userRows] = await pool.query('SELECT id_pessoa FROM usuario WHERE usuario = ?', [req.session.usuario]);
      if (userRows.length > 0 && userRows[0].id_pessoa) {
        id_pessoa = userRows[0].id_pessoa;
        req.session.id_pessoa = id_pessoa;
      }
    } catch (e) {
      console.warn('Erro ao recuperar id_pessoa do banco:', e);
    }
  }

  try {
    if (!id_pessoa) {
      req.session.flash = {
        type: 'error',
        message: 'Acesso inválido: Seu usuário não está vinculado a nenhuma Pessoa cadastrada. Por favor, vincule seu usuário nas configurações.'
      };
      return res.redirect(`/projeto_assinatura/${id_projeto}/assinar`);
    }

    // Carregar informações do CPF e nome da pessoa da sessão
    const pool = require('../db');
    const [pessoaRows] = await pool.query('SELECT cpf, nome FROM pessoa WHERE id_pessoa = ?', [id_pessoa]);
    if (pessoaRows.length === 0) {
      req.session.flash = { type: 'error', message: 'Dados pessoais não encontrados.' };
      return res.redirect(`/projeto_assinatura/${id_projeto}/assinar`);
    }
    const userCpfClean = pessoaRows[0].cpf ? pessoaRows[0].cpf.replace(/\D/g, '') : '';

    // Carregar projeto completo para avaliar as regras
    const proj = await projeto_extensaoModel.getProjetoCompletoById(id_projeto);
    if (!proj) {
      req.session.flash = { type: 'error', message: 'Projeto não encontrado.' };
      return res.redirect('/projeto_extensao');
    }

    // Identificar os papéis da pessoa no projeto
    const isProf = proj.professoresCadastrados.some(p => p.CPF && p.CPF.replace(/\D/g, '') === userCpfClean);
    const isCoord = proj.coordenadoresCursos.some(c => Number(c.coordenador_id) === Number(id_pessoa));

    if (!isProf && !isCoord) {
      req.session.flash = {
        type: 'error',
        message: 'Acesso negado: Você não é professor cadastrado ou coordenador do curso deste projeto.'
      };
      return res.redirect(`/projeto_assinatura/${id_projeto}/assinar`);
    }

    // Validação específica para o Relatório Final (tipo_assinatura = 2)
    if (tipo_assinatura === 2) {
      const allPlanSigned = (proj.assinaturasProfessoresPlano.length >= proj.professoresCadastrados.length) &&
                            (proj.assinaturasCoordenadoresPlano.length >= proj.coordenadoresCursos.length);
      
      if (proj.status !== 'concluido') {
        req.session.flash = {
          type: 'error',
          message: 'Não é possível assinar o relatório: o projeto ainda não foi marcado como "Concluído" pela coordenação.'
        };
        return res.redirect(`/projeto_assinatura/${id_projeto}/assinar`);
      }
      
      if (!allPlanSigned) {
        req.session.flash = {
          type: 'error',
          message: 'Não é possível assinar o relatório: todas as assinaturas do plano de trabalho devem estar assinadas.'
        };
        return res.redirect(`/projeto_assinatura/${id_projeto}/assinar`);
      }
    }

    // Verificar assinaturas já existentes para a etapa selecionada (tipo_assinatura)
    const assinaturasProfsEtapa = tipo_assinatura === 1 ? proj.assinaturasProfessoresPlano : proj.assinaturasProfessoresRelatorio;
    const assinaturasCoordsEtapa = tipo_assinatura === 1 ? proj.assinaturasCoordenadoresPlano : proj.assinaturasCoordenadoresRelatorio;

    const alreadySignedAsProf = assinaturasProfsEtapa.some(ass => ass.cpf && ass.cpf.replace(/\D/g, '') === userCpfClean);
    const alreadySignedAsCoord = assinaturasCoordsEtapa.some(ass => Number(ass.id_pessoa) === Number(id_pessoa));

    let papelParaAssinar = null;

    if (isProf && !alreadySignedAsProf) {
      papelParaAssinar = 'professor';
    } else if (isCoord && !alreadySignedAsCoord) {
      // Regra 1: Coordenadores só assinam após todos os professores daquela etapa assinarem
      if (assinaturasProfsEtapa.length < proj.professoresCadastrados.length) {
        req.session.flash = {
          type: 'error',
          message: `Não é possível assinar como coordenador: ainda existem professores cadastrados pendentes de assinatura para esta etapa (${tipo_assinatura === 1 ? 'Plano' : 'Relatório'}).`
        };
        return res.redirect(`/projeto_assinatura/${id_projeto}/assinar`);
      }

      // Regra: Coordenador só assina a etapa 1 (Plano) se o status do projeto for 'aprovado' (ou posterior)
      if (tipo_assinatura === 1 && !['aprovado', 'em_execucao', 'concluido'].includes(proj.status)) {
        req.session.flash = {
          type: 'error',
          message: 'Não é possível assinar como coordenador: o status do projeto deve ser "Aprovado" para assinar o Plano de Trabalho.'
        };
        return res.redirect(`/projeto_assinatura/${id_projeto}/assinar`);
      }
      
      papelParaAssinar = 'coordenador';
    } else {
      // Já assinou em todas as capacidades
      let msg = `Você já assinou esta etapa (${tipo_assinatura === 1 ? 'Plano' : 'Relatório'}) deste projeto.`;
      if (isProf && isCoord) {
        msg = `Você já assinou esta etapa (${tipo_assinatura === 1 ? 'Plano' : 'Relatório'}) deste projeto como Professor e como Coordenador.`;
      } else if (isProf) {
        msg = `Você já assinou esta etapa (${tipo_assinatura === 1 ? 'Plano' : 'Relatório'}) deste projeto como Professor.`;
      } else if (isCoord) {
        msg = `Você já assinou esta etapa (${tipo_assinatura === 1 ? 'Plano' : 'Relatório'}) deste projeto como Coordenador.`;
      }
      req.session.flash = { type: 'error', message: msg };
      return res.redirect(`/projeto_assinatura/${id_projeto}/assinar`);
    }

    await projeto_assinaturaModel.insertProjeto_assinatura(
      { id_projeto, ordem: papelParaAssinar === 'coordenador' ? 2 : 1, tipo_assinatura },
      { id_pessoa }
    );

    req.session.flash = {
      type: 'success',
      message: `Projeto assinado com sucesso como ${papelParaAssinar === 'coordenador' ? 'Coordenador' : 'Professor'} para o ${tipo_assinatura === 1 ? 'Plano de Trabalho' : 'Relatório Final'}!`
    };
    res.redirect(`/projeto_assinatura/${id_projeto}/assinar`);
  } catch (error) {
    console.error('Erro ao assinar projeto:', error);
    req.session.flash = {
      type: 'error',
      message: 'Erro ao assinar projeto. Tente novamente.'
    };
    res.redirect(`/projeto_assinatura/${id_projeto}/assinar`);
  }
}

async function validarAssinatura(req, res) {
  const { codigo } = req.query;
  try {
    if (!codigo) {
      return res.render('validacao', { success: false, message: 'Código de validação não fornecido.' });
    }
    const assinatura = await projeto_assinaturaModel.getProjeto_assinaturaByCodigo(codigo);
    if (!assinatura) {
      return res.render('validacao', { success: false, message: 'Assinatura não encontrada ou código de validação inválido.' });
    }

    // Tentar carregar detalhes do projeto para refinar o papel da assinatura
    const proj = await projeto_extensaoModel.getProjetoCompletoById(assinatura.id_projeto);
    let papel = 'Assinante';
    if (proj) {
      const cleanCpf = assinatura.pessoa_cpf ? assinatura.pessoa_cpf.replace(/\D/g, '') : '';
      const isProf = proj.professoresCadastrados.some(p => p.CPF && p.CPF.replace(/\D/g, '') === cleanCpf);
      const isCoord = proj.coordenadoresCursos.some(c => Number(c.coordenador_id) === Number(assinatura.id_pessoa));
      
      if (assinatura.ordem === 1 || (isProf && assinatura.ordem !== 2)) {
        papel = 'Professor(a)';
      } else if (assinatura.ordem === 2 || isCoord) {
        papel = 'Coordenador(a)';
      }
    }

    let etapa = 'Plano de Trabalho';
    if (assinatura.tipo_assinatura === 2) {
      etapa = 'Relatório Final';
    }

    res.render('validacao', {
      success: true,
      assinatura,
      papel,
      etapa
    });
  } catch (error) {
    console.error('Erro ao validar assinatura:', error);
    res.render('validacao', { success: false, message: 'Erro interno ao processar a validação.' });
  }
}

module.exports = {
  listprojeto_assinatura,
  filterprojeto_assinatura,
  addprojeto_assinatura,
  showprojeto_assinatura,
  showEditForm,
  editprojeto_assinatura,
  showConfirmDeleteFormprojeto_assinatura,
  deleteprojeto_assinatura,
  showAssinar,
  assinarProjeto,
  validarAssinatura
};