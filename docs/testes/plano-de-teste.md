# 🧪✅ Plano de Teste

### 🆔📖 Identificação e contexto

| Campo                                       | Preencher ✍️ |
| ------------------------------------------- | ------------ |
| 🧩 Nome do projeto                          |Agendamento App|
| 📝 Objetivo do sistema (resumo)             |Permitir que alunos da faculdade visualizem, agendem e gerenciem sua participação em programas, eventos e serviços oferecidos pela instituição|
| 🎯 Público-alvo                             |Alunos da Instituição, Administradores, Coordenadores, Prestadores dos Serviços Oferecido e Comunidade Externa|
| 💻 Plataforma/Tipo (console/web/mobile/API) |Mobile|
| 🔗 Repositório                              |https://github.com/P3dr0EM/Agendamento_App/tree/main|
| 👥 Time/Grupo                               |Pedro Gabriel Evangelista Marques; Leonardo Ferreira Tomaz; Lucas Gabriel Abade Oliveira; Mariana de Souza Porto|

***

### 🎯🧪 Objetivo do teste

| Item                                 | Descrição 🗒️ |
| ------------------------------------ | ------------- |
| ✅ Objetivo geral                     |Este Plano de Testes tem como objetivo definir a estratégia, o escopo e os critérios para validação do sistema do aplicativo, visando garantir que o sistema atenda aos requisitos funcionais e não-funcionais, proporcionando segurança, confiabilidade e uma boa experiência de uso aos usuários|
| 📊 Metas de cobertura (se aplicável) |N / A|

***

### 📦📌 Escopo

| Categoria                               | ✅ Em escopo | 🚫 Fora de escopo |
| --------------------------------------- | ----------- | ----------------- |
| 🧩 Funcionalidades                      |Login, visualização de serviços, agendamento e gerenciamento de consultas|Funcionalidades futuras ainda não implementadas|
| 🧠 Regras de negócio                    |Validação de datas, disponibilidade de horários e permissões de acesso|Regras ainda não definidas pela equipe|
| 🔌 Integrações                          |Google Calendar API|Integrações externas não implementadas|
| 🗃️ Dados                               |Dados utilizados durante os testes unitários e manuais|Persistência em banco de dados (não utilizada)|
| 🧑‍💻 Não-funcionais (usabilidade etc.) |Usabilidade, navegabilidade e responsividade básica|Testes avançados de carga, estresse e segurança|

***

### 🧰🖥️ Ambiente e ferramentas

| Item                            | Especificação ⚙️ |
| ------------------------------- | ---------------- |
| 🖥️ SO                          |Windows / Android|
| ☕ Linguagem/Runtime             |Dart Programming Language|
| 🧑‍💻 IDE                       |Visual Studio Code|
| 🧱 Build                        |Gradle|
| ✅ Framework de testes unitários |Flutter (flutter_test package)|
| 🥒 BDD (se houver)              |N / A|
| 🤖 CI (se houver)               |N / A|
| 🗄️ Banco/Dados (se houver)     | N / A |

***

### 🧪🧱 Estratégia de testes (por tipo)

| Tipo de teste         | 🎯 Objetivo | 📌 Escopo | 🛠️ Ferramenta | 👤 Responsável | 📎 Saída/Evidência |
| --------------------- | ----------- | --------- | -------------- | -------------- | ------------------ |
| ✅ Unitário            |Validar métodos, controladores e regras de negócio individualmente|Controllers, validações e lógica de negócio|flutter_test|Lucas Gabriel Abade Oliveira; Pedro Gabriel Evangelista Marques|Relatório de execução dos testes|
| 🌐 Sistema/End-to-End |Verificar funcionamento dos fluxos principais da aplicação|Fluxos de login, agendamento e gerenciamento|Testes manuais|Lucas Gabriel Abade Oliveira; Pedro Gabriel Evangelista Marques|N/A|
| 🥒 BDD                |N/A|N/A|N/A|N/A|N/A|
| 🧑‍💻 Usabilidade     |Avaliar facilidade de uso e identificar dificuldades dos usuários|Interface, navegação e compreensão das funcionalidades|Observação direta e questionário|Lucas Gabriel Abade Oliveira|As evidências consistem em observações diretas e anotações feitas durante a execução da aplicação|

***

### 🧷🧭 Rastreabilidade (Requisitos x Testes)

| ID Req | Requisito/Funcionalidade | ⭐ Prioridade     | 🔗 Fonte (Issue/PR) | 🧪 IDs de testes (UT/BDD/RT) | 📌 Status                   |
| ------ | ------------------------ | ---------------- | ------------------- | ---------------------------- | --------------------------- |
| RF-01  |Realizar agendamento| Alta |UT-01 / RT-01|Backlog|🟢 Executado|
| RF-02  |Realizar login| Alta |UT-02 / RT-02|Backlog|🟢 Executado|
| RF-03  |Impedir o login se o E-mail for inválido| Média |UT-03 / RT-03|Backlog|🟢 Executado|
| RF-04  |Impedir o login se a senha for inválida| Média |UT-04 / RT-04|Backlog|🟢 Executado|
| RF-05  |Validar o dia selecionado para o agendamento| Média |UT-05 / RT-05|Backlog|🟢 Executado|

***

### 🧾🧪 Casos de teste planejados (resumo)

| ID     | 🧪 Tipo    | 🏷️ Título | 🔐 Pré-condição | 📥 Entrada | ✅ Resultado esperado | ⭐ Prioridade | 🤖 Automatizado? |
| ------ | ---------- | ---------- | --------------- | ---------- | -------------------- | ------------ | ---------------- |
| UT-01  | ✅ Unitário |            |                 |            |                      | Alta         | Sim              |
| BDD-01 | 🥒 BDD     |            |                 |            |                      | Alta         | Sim              |
| RT-01  | 📝 Manual  |            |                 |            |                      | Média        | Não              |

***

### 🗃️🧪 Dados de teste

| ID    | 🧺 Conjunto | 📝 Descrição | 🧪 Como criar | 📍 Onde armazenar | 💡 Observações |
| ----- | ----------- | ------------ | ------------- | ----------------- | -------------- |
| DT-01 |             |              |               |                   |                |
| DT-02 |             |              |               |                   |                |

***
