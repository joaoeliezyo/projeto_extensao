# Sistema de Gerenciamento de Projetos de Extensão

## 📋 Descrição
Sistema web completo para gerenciar projetos de extensão acadêmica, desenvolvido com Node.js, Express, MySQL e Bootstrap.

## 🚀 Como Iniciar

### Pré-requisitos
- Node.js v14+
- MySQL 8.0
- npm ou yarn

### Instalação

1. **Instalar dependências:**
```bash
npm install
```

2. **Configurar variáveis de ambiente (.env):**
```
DB_HOST=127.0.0.1
DB_USER=*******
DB_PASSWORD=***************
DB_NAME=projetos_extensao
DB_PORT=3306
NODE_ENV=development
PORT=3000
```

3. **Iniciar servidor:**
```bash
npm start
```

4. **Acessar:**
- URL: http://localhost:3000/login
- Usuário: `admin`
- Senha: `admin123`

## 📱 Funcionalidades

### ✅ 16 Módulos CRUD Completos

#### Módulos Principais:
- **Pessoas** - Gerenciar pessoas do sistema
- **Projetos de Extensão** - Criar e gerenciar projetos
- **Avaliações Institucionais** - Registrar avaliações
- **Cursos** - Gerenciar cursos
- **Tipos de Pessoa** - Categorias de pessoas
- **Faixas Etárias** - Faixas etárias disponíveis
- **Escolaridades** - Níveis de escolaridade

#### Módulos de Configuração:
- **Tipos de Instituição** - Tipos/categorias de instituições
- **Instituições** - Cadastro de instituições
- **Tipos de Plano** - Categorias de planos
- **Públicos-Alvo** - Públicos-alvo dos projetos
- **Tipos de Ação** - Tipos de ação executada
- **Linhas Programáticas** - Linhas programáticas
- **Papéis do Projeto** - Papéis/funções no projeto
- **Locais de Execução** - Endereços de execução

## 🏗️ Arquitetura

```
projeto_extensao/
├── controllers/         # Controladores (Lógica de negócio)
├── docs/                # Documentação do projeto (CONCLUSAO, GUIA_RAPIDO)
├── middleware/          # Middlewares (Autenticação, etc)
├── models/              # Modelos de banco de dados (MySQL)
├── public/              # Arquivos estáticos (CSS, Imagens)
├── routes/              # Definição de rotas/endpoints
├── trash/               # Arquivos e scripts obsoletos/temporários
├── views/               # Templates EJS (Interface do usuário)
├── .env                 # Variáveis de ambiente
├── .gitignore           # Arquivos ignorados pelo Git
├── db.js                # Configuração de conexão com o banco
├── package.json         # Dependências e scripts npm
├── projeto_extensao.sql # Script SQL inicial do banco
├── run_migration_status.js # Script de migração automática
├── seed_admin.js        # Script de criação de usuário admin
├── server.js            # Arquivo principal do servidor
└── setup_db.js          # Script de configuração inicial do banco
```

## 🔐 Autenticação

- Sistema de login com session-based authentication
- Expiração de sessão: 24 horas
- Cookies HttpOnly para segurança
- Rota `/logout` para sair do sistema
- Rota `/logo` para acessar o Dashboard

## 🎨 Interface

- Bootstrap 5.3.3 para layout responsivo
- Bootstrap Icons para ícones temáticos
- Design moderno e intuitivo
- Dashboard com menu lateral navegável
- Tabelas responsivas com busca/filtro
- Formulários validados e geração de PDF

## 📊 Banco de Dados

- MySQL 8.0
- Database: `projetos_extensao` (ajustável no .env)
- 20+ tabelas relacionadas
- Suporte a múltiplos relacionamentos e migração automática de colunas

## 🔌 Endpoints Disponíveis

### Autenticação
- `GET /login` - Página de login
- `POST /login` - Processar login
- `GET /logout` - Fazer logout
- `GET /logo` - Dashboard

### Para cada módulo (exemplo: `/pessoa`):
- `GET /pessoa` - Listar todos
- `POST /pessoa/filtro` - Buscar
- `GET /pessoa/forms/pessoa` - Formulário novo
- `POST /pessoa/cadastrar` - Criar novo
- `GET /pessoa/:id/edit` - Formulário editar
- `POST /pessoa/:id/edit` - Atualizar
- `POST /pessoa/:id/delete` - Excluir

## 🛠️ Scripts npm

```bash
npm start          # Iniciar servidor (executa migrações automáticas)
npm run dev        # Iniciar com nodemon (desenvolvimento)
npm run setup      # Configurar banco de dados inicial
```

## 🎯 Como Usar

1. **Configurar o Banco:**
   - Execute `node setup_db.js` ou `npm run setup` para criar o banco inicial.
2. **Iniciar o Sistema:**
   - Execute `npm start`. O sistema aplicará migrações automáticas se houver mudanças no esquema.
3. **Fazer Login:**
   - Credenciais padrão: admin / admin123
4. **Gerenciar Projetos:**
   - Use o dashboard para navegar entre os módulos.
   - Gere relatórios em PDF com seções de Parecer Técnico otimizadas para assinatura digital.

## 📄 Licença

Projeto educacional - UNI•CET 2025

---

**Status:** ✅ Projeto 100% Funcional e Organizado
**Última atualização:** Maio/2026
