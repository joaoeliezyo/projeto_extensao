# 📘 Guia do Sistema de Gerenciamento de Projetos de Extensão

Este documento serve como um guia técnico e operacional para o sistema de gerenciamento de projetos de extensão da **UNI•CET**. Aqui você encontrará a explicação da arquitetura, estrutura de pastas e funcionamento dos principais componentes.

---

## 🏗️ Estrutura de Pastas

A organização do projeto segue o padrão **MVC (Model-View-Controller)**, o que facilita a manutenção e a escalabilidade.

| Pasta | Descrição | Importância |
| :--- | :--- | :--- |
| `controllers/` | Contém a lógica de negócio do sistema. | Processa as requisições, interage com os modelos e decide qual visão (view) exibir. |
| `models/` | Gerencia a interação direta com o banco de dados MySQL. | Define as consultas SQL e garante a integridade dos dados que entram e saem do banco. |
| `routes/` | Define as URLs (endpoints) do sistema. | Mapeia cada endereço acessado pelo navegador para um controlador específico. |
| `views/` | Contém os templates EJS (HTML dinâmico). | É a interface do usuário. Aqui fica o que o usuário vê e interage no navegador. |
| `public/` | Arquivos estáticos acessíveis publicamente. | Armazena arquivos CSS, imagens e scripts JavaScript do lado do cliente (frontend). |
| `middleware/` | Filtros que rodam antes de chegar aos controladores. | Essencial para segurança, como verificar se o usuário está logado antes de permitir o acesso. |
| `docs/` | Documentação técnica e manuais. | Centraliza guias como este para auxiliar novos desenvolvedores ou usuários. |
| `trash/` | Arquivo de componentes obsoletos ou temporários. | Mantém o projeto limpo, isolando arquivos que não são mais usados mas que ainda podem ser consultados. |

---

## 📄 Arquivos Principais

### ⚙️ Núcleo do Sistema
- **`server.js`**: O ponto de entrada da aplicação. Configura o Express, as sessões, os middlewares e inicia o servidor na porta definida.
- **`db.js`**: Centraliza a conexão com o banco de dados MySQL utilizando o pacote `mysql2`. É exportado para ser usado por todos os modelos.
- **`.env`**: Armazena variáveis de ambiente sensíveis (como senhas de banco), garantindo que não fiquem expostas no código principal.

### 🗄️ Banco de Dados e Migrações
- **`projeto_extensao.sql`**: O script SQL mestre que contém toda a estrutura inicial das tabelas e relacionamentos.
- **`setup_db.js`**: Script utilitário para criar o banco de dados do zero.
- **`run_migration_status.js`**: Script inteligente que verifica a estrutura atual do banco e aplica alterações (como novas colunas) automaticamente sem perder dados.
- **`seed_admin.js`**: Cria o usuário administrador inicial para o primeiro acesso.

---

## 🚀 Fluxo de Funcionamento

Quando um usuário acessa uma página (ex: `/pessoa`):
1. O arquivo **`server.js`** recebe a requisição.
2. O **`routes/pessoa.js`** identifica a rota e chama o **`pessoaController.js`**.
3. O controlador solicita os dados ao **`pessoaModel.js`**.
4. O modelo executa a query no MySQL via **`db.js`** e retorna os dados.
5. O controlador envia esses dados para a pasta **`views/`**, que renderiza o HTML final.
6. O navegador exibe a página utilizando os estilos CSS da pasta **`public/`**.

---

## 💡 Informações Importantes

### 🔐 Segurança e Sessão
O sistema utiliza **express-session** para manter o usuário logado. As sessões expiram em 24 horas por padrão e os cookies são configurados como `HttpOnly` para prevenir ataques de scripts maliciosos.

### 📑 Geração de Relatórios
O sistema possui integração para gerar relatórios em **PDF**. Esses relatórios são otimizados com seções de "Parecer Técnico" desenhadas especificamente para aceitar assinaturas digitais, facilitando a burocracia acadêmica.

### 🔄 Evolução do Banco de Dados
Sempre que uma nova funcionalidade exigir uma nova coluna no banco de dados, você não precisa apagar o banco. O sistema de migrações automáticas (`run_migration_status.js`) cuida disso ao iniciar o servidor com `npm start`.

---

## 🔄 Fluxo de Aprovação (Workflow)

O sistema implementa um controle de estados para os projetos, garantindo que passem pelas etapas corretas de avaliação e execução:

1.  **Rascunho**: Estado inicial onde o professor edita as informações.
2.  **Em Avaliação**: O projeto é enviado para a coordenação para análise técnica.
3.  **Aprovado / Rejeitado**: O coordenador decide se o projeto segue para execução ou precisa de ajustes (retorno ao rascunho).
4.  **Em Execução**: Projetos aprovados que estão com atividades em andamento.
5.  **Concluído**: Finalização do ciclo de vida do projeto e entrega do relatório final.

### Transições por Perfil:
- **Professor**: Pode mover de `Rascunho` para `Em Avaliação`.
- **Coordenador**: Pode mover de `Em Avaliação` para `Aprovado/Rejeitado` e de `Aprovado` para `Em Execução`.
- **Admin**: Possui controle total sobre todas as transições de status.

---

## 📈 Dashboard e Relatórios Digitais

### 📊 Painel de Controle (KPIs)
O Dashboard (`/logo`) exibe estatísticas vitais para a gestão institucional:
- Total de projetos ativos e concluídos.
- Contagem de pessoas (professores, alunos e externos) vinculadas aos projetos.
- Métricas de impacto e alcance por público-alvo.

### 📄 Documentos com Assinatura Digital
O sistema gera dois documentos fundamentais em formato PDF:
- **Plano de Extensão**: Gerado durante a fase de planejamento.
- **Relatório Final**: Consolidado após a conclusão das atividades.

**Importante:** Ambos os documentos são renderizados com um layout que inclui blocos de assinatura padronizados, compatíveis com softwares de assinatura digital (como o Verificador do ITI), facilitando a tramitação digital sem necessidade de impressão.

---

**Última Atualização:** Maio de 2026
**Status do Projeto:** ✅ Estável e Documentado
