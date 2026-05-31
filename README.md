# 📘 Sistema de Gerenciamento de Projetos de Extensão (UNI•CET)

[![Node.js Version](https://img.shields.io/badge/node-%3E%3D14.0.0-brightgreen)](https://nodejs.org/)
[![MySQL](https://img.shields.io/badge/mysql-8.0-blue)](https://www.mysql.com/)
[![License](https://img.shields.io/badge/license-ISC-green)](https://opensource.org/licenses/ISC)

Sistema web robusto para a gestão completa do ciclo de vida de projetos de extensão acadêmica, desde a concepção e avaliação até a execução e relatório final.

---

## 📂 Documentação Detalhada

Para informações técnicas aprofundadas, consulte os novos guias na pasta `docs/`:
- [📘 **Guia do Projeto**](docs/GUIA_PROJETO.md) - Arquitetura, fluxo de dados e estrutura detalhada.
- [📄 **Guia Rápido**](docs/GUIA_RAPIDO.txt) - Comandos e acessos rápidos para o dia a dia.

---

## 🚀 Como Iniciar

### 📋 Pré-requisitos
- **Node.js**: Versão 14 ou superior.
- **MySQL**: Versão 8.0.
- **Ferramentas**: npm ou yarn.

### 🛠️ Instalação e Configuração

1. **Clonar e instalar dependências:**
   ```bash
   npm install
   ```

2. **Configurar Variáveis de Ambiente (.env):**
   Crie um arquivo `.env` na raiz com as seguintes chaves:
   ```env
   DB_HOST=127.0.0.1
   DB_USER=seu_usuario
   DB_PASSWORD=sua_senha
   DB_NAME=projetos_extensao
   DB_PORT=3306
   NODE_ENV=development
   PORT=3000
   ```

3. **Configurar o Banco de Dados:**
   Execute o script de setup para criar a estrutura inicial:
   ```bash
   npm run setup
   ```

4. **Iniciar o Servidor:**
   ```bash
   npm start
   ```

5. **Acesso Inicial:**
   - **URL**: `http://localhost:3000/login`
   - **Usuário**: `admin`
   - **Senha**: `admin123`

---

## 🌟 Principais Funcionalidades

### 🔄 Fluxo de Trabalho (Workflow)
O sistema gerencia o status dos projetos com permissões baseadas em perfis (Professor, Coordenador, Admin):
- **Rascunho** ➡️ **Em Avaliação** ➡️ **Aprovado** ➡️ **Em Execução** ➡️ **Concluído**.

### 📊 Dashboard e KPIs
Visualização em tempo real do status dos projetos, número de participantes e métricas de impacto acadêmico.

### 📑 Relatórios e PDFs
- Geração automática de **Plano de Extensão** e **Relatório Final**.
- Layouts otimizados para **assinatura digital**.
- Gestão de anexos e evidências do projeto.

### 🧩 Módulos CRUD (16+)
Gestão completa de Pessoas, Cursos, Instituições, Públicos-Alvo, Cronogramas, Custos e mais.

---

## 🏗️ Arquitetura do Projeto

```text
projeto_extensao/
├── controllers/    # Lógica de negócio e controle de fluxo
├── models/         # Camada de dados e queries MySQL
├── routes/         # Definições de rotas Express
├── views/          # Templates EJS (Interface)
├── public/         # Arquivos estáticos (CSS, JS, Imagens)
├── middleware/     # Filtros de segurança e autenticação
├── docs/           # Documentação técnica (Guia do Projeto)
└── db.js           # Configuração central do banco de dados
```

---

## 🛠️ Scripts Disponíveis

| Comando | Descrição |
| :--- | :--- |
| `npm start` | Inicia o servidor e aplica migrações automáticas de banco. |
| `npm run dev` | Inicia em modo de desenvolvimento com `nodemon`. |
| `npm run setup` | Executa o script de criação inicial do banco e tabelas. |

---

## 📄 Licença e Créditos

Desenvolvido para **UNI•CET 2025** como projeto educacional de extensão.

**Status:** ✅ Projeto 100% Funcional e Documentado
**Última atualização:** Maio de 2026

## As implementações

Foram adicionadas as melhoras: adição da api do correios que busca o enderenços pelo cep, a padronizção dos botõe de editar e exclusão e a implemntação da assinatura digital no pdf.

