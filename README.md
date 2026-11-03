# JIDOK Studio — Central de Organização

**Acessar:** https://dimivigia-dev.github.io/Jidok-2027/

O JIDOK Studio é um painel visual e responsivo para gerenciar o campeonato JIDOK, **sem editar arquivos, código ou planilhas**.

## O que dá para fazer

- **Pontuação:** selecionar uma equipe e lançar pontos com botões rápidos (+10, +25, +50, +100, +200), inserir qualquer valor personalizado, adicionar justificativa opcional, conferir ranking automático e histórico, estornar resultados antigos sem apagar registros e exportar CSV.
- **Equipes:** personalizar os três times com nome, cores principal/complementar, ícone, líder e lema.
- **Ideias:** criar anotações e classificá-las em novas, planejamento, aprovadas e concluídas. Filtrar por assunto, prioridade e buscar por texto.
- **Agenda:** visualizar calendário mensal; criar, editar ou excluir cultos, gincanas, ensaios, reuniões e outros eventos, com datas, horários e observações.
- **Visão geral:** visualizar ranking, movimentações, ideias e próximos eventos.
- **Modo telão:** exibir o ranking em tela cheia durante uma reunião ou evento.
- **Backups:** exportar/importar cópia completa em JSON e exportar o histórico de pontos em CSV.
- **iPhone e Android:** interface responsiva com menu inferior.

Nenhum cronograma ou atividade de versões anteriores é imposto como dado oficial. O painel começa com **três equipes genéricas, zero pontos e ideias/agenda vazias**.

## Como salvar dados

**Importante:** esta versão roda no GitHub Pages, que é hospedagem estática. Os dados são guardados automaticamente no **localStorage do navegador utilizado**.

Isso significa:

- Os dados são salvos no aparelho/navegador de origem, não num banco compartilhado.
- Abrir o endereço em outro celular **não exibirá** os mesmos lançamentos ou edições.
- Limpar os dados do navegador pode apagar a informação.
- Use **Configurações > Exportar backup** após as reuniões ou lançamentos importantes, mantendo cópia em local seguro.
- É possível levar o backup a outro aparelho via **Configurações > Importar backup**, substituindo os dados daquele aparelho.
- Ainda não existe login administrativo ou sincronização em tempo real. Para isso, é necessário configurar autenticação e banco de dados, em outra etapa.

## Arquivos da versão Studio

| Arquivo | Descrição |
|---|---|
| \`index.html\` | Página principal |
| \`studio.css\` | Design e responsividade |
| \`studio.js\` | Equipes, pontuação, ideias, agenda e armazenamento |

Arquivos antigos (\`app.js\`, \`painel.js\`, \`programacao.json\`, etc.) permanecem no repositório por histórico, mas **não são utilizados** pelo Studio.

## Segurança e transparência

- O valor dos pontos é livre, sem limite máximo por equipe ou atividade; o sistema usa inteiros decimais com \`BigInt\`.
- O histórico não exclui lançamentos de pontuação. Para corrigir erros, use **Estornar**, que adiciona um lançamento inverso rastreável.
- O modo local não impede que alguém com acesso ao mesmo navegador modifique os dados; não o use como banco oficial de vários organizadores.
- Evite guardar dados pessoais de adolescentes ou convidados nas notas, ideias ou agenda do site estático.
- Os resultados não devem ser apresentados como uma classificação única e compartilhada entre todos os participantes até a implementação de um backend com controle de acesso.

## Publicação

O site principal está na branch \`main\` e pasta raiz do repositório, publicada pelo GitHub Pages. Toda alteração no código será publicada automaticamente após o GitHub concluir a implantação. As informações cadastradas no painel **não são enviadas ao GitHub**; permanecem neste navegador.
