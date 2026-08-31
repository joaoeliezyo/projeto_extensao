// middleware/authMiddleware.js

// Verifica se o usuario está autenticado
const authMiddleware = (req, res, next) => {
  if (!req.session || !req.session.usuario) {
    return res.redirect('/login');
  }
  next();
};

const projeto_extensaoModel = require('../models/projeto_extensaoModel');

// Verifica se o usuario tem um dos perfis permitidos
// Uso: authorize('admin', 'coordenador')
function authorize(...perfisPermitidos) {
  return (req, res, next) => {
    console.log('[authDebug] req.session.usuario:', req.session ? req.session.usuario : 'undefined', 'req.session.tipo:', req.session ? req.session.tipo : 'undefined');
    if (!req.session || !req.session.usuario) {
      return res.redirect('/login');
    }
    const tipoPerfil = (req.session.tipo || '').toLowerCase();
    if (perfisPermitidos.length > 0 && !perfisPermitidos.includes(tipoPerfil)) {
      return res.status(403).render('error', {
        message: 'Acesso negado. Você não tem permissão para acessar esta funcionalidade.',
        returnLink: '/logo'
      });
    }
    next();
  };
}

async function checkProjectAccess(req, res, next) {
  try {
    const id_projeto = req.params.id || req.params.id_projeto || req.body.id_projeto || req.query.id_projeto;
    if (!id_projeto || isNaN(id_projeto)) {
      return next();
    }

    const sessionUser = {
      tipo: req.session.tipo,
      id_pessoa: req.session.id_pessoa,
      cpf: req.session.cpf || ''
    };

    const allowed = await projeto_extensaoModel.hasAccess(id_projeto, sessionUser);
    if (!allowed) {
      return res.status(403).render('error', {
        message: 'Acesso negado. Você não tem permissão para visualizar ou gerenciar este projeto.',
        returnLink: '/projeto_extensao'
      });
    }
    next();
  } catch (error) {
    console.error('Erro na validação de acesso ao projeto:', error);
    res.status(500).render('error', {
      message: 'Erro interno ao processar a validação de acesso.',
      returnLink: '/logo'
    });
  }
}

module.exports = { authMiddleware, authorize, checkProjectAccess };
