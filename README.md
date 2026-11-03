# JIDOK 2027 — Operação Legado

**Site público:** https://dimivigia-dev.github.io/Jidok-2027/

**Painel de gestão:** https://dimivigia-dev.github.io/Jidok-2027/painel.html

## Atualização v4

- Pontuação livre, **sem teto de pontos por prova, equipe ou semana**.
- Lançamento individual ou de vários times ao mesmo tempo, com motivo, categoria, data e histórico de ajustes.
- Cadastro de três equipes (nomes, cores, líderes e lemas).
- Editores visuais para programação geral de sexta/sábado, cronograma do acampamento, datas, cultos, jogos e ministérios.
- Ranking público com cores, nomes e histórico; layout adaptado ao celular.
- 48 jogos regulares e quatro finais, sem enigmas ou quebra-cabeças como provas.
- Acampamento de três dias, com três jogos + Mega Final Dominação 27 no **sábado à tarde**, seguido de premiação.
- Flare Up e Intercessão toda semana; missões especiais de GAD, SOS, IMS, New Breed, Vivacidade e GOE nas datas propostas.
- Tema oficial ainda não informado, sujeito à decisão da liderança.

## Arquivos

| Arquivo | Função |
|---|---|
| `index.html` | Entrada do site público |
| `styles.css` | Aparência do site público |
| `app.js` | Agenda, provas, ranking e informações do público |
| `programacao.json` | Programação inicial e regras das gincanas |
| `painel.html` | Entrada do painel da organização |
| `painel.css` | Layout administrativo |
| `painel.js` | Formulários de equipes, pontos, cronogramas e jogos |
| `sync.js` | Leitura e gravação local ou via Supabase |
| `backend-config.js` | URL e chave **pública** do Supabase (vazias inicialmente) |
| `supabase_schema.sql` | Modelo do banco e políticas de acesso (RLS) |

## MUITO IMPORTANTE — modos de armazenamento

### 1. Modo local (padrão, já funciona)

Sem configurar um banco, o painel funciona no navegador: permite editar a programação, cadastrar os nomes e as cores, lançar pontos e exportar/importar backup. **Mas nenhuma edição é compartilhada com outros celulares ou visitantes.** O botão diz *Salvar neste aparelho*. Não use essa modalidade como placar oficial compartilhado.

Os pontos e alterações ficam no `localStorage` do dispositivo. Use *Publicação e backup* para exportar os dados.

### 2. Modo online seguro com Supabase (configuração necessária)

A publicação do GitHub Pages é estática, por isso não recebe nem grava alterações em servidor sozinha.

Para ativar a sincronização:

1. Crie um projeto Supabase de sua propriedade.
2. No SQL Editor do projeto, execute todo o conteúdo do arquivo `supabase_schema.sql`.
3. Em **Authentication > Users**, cadastre um usuário de login da liderança.
4. Copie o UUID do usuário e execute no SQL Editor:
   ```sql
   insert into public.jidok_roles(user_id,is_admin)
   values ('UUID_DO_USUARIO_CRIADO', true)
   on conflict (user_id) do update set is_admin=true;
   ```
5. Obtenha a URL HTTPS do projeto e a chave **anon/publicável** em *Settings > API Keys*.
6. Preencha esses dois valores no `backend-config.js` do repositório (somente esses dois). **NUNCA salve a senha de usuário, secret key, service_role ou outros segredos em arquivos do GitHub Pages.**
7. Após o Pages concluir a implantação, abra `/painel.html` e entre com o usuário autorizado.
8. Entre em *Publicação e backup*, confira a programação inicial e clique em **Publicar alterações** para gravar o primeiro `jidok_site_config`.
9. A partir daí, os usuários do site público recebem a programação do banco e os pontos lançados pelos administradores.

**Proteção:** o SQL ativa Row Level Security (RLS). A tabela de pontos permite leitura pública e *inserção por administradores*; não permite apagar ou editar pontuações antigas. Correções são novos lançamentos (inclusive negativos). A configuração do site aceita escrita apenas de administradores. Não há senha padrão no site.

**Nota:** se você fez alterações em modo local e depois configurar o Supabase, salve um backup JSON antes de mudar. A migração dos pontos locais para a nuvem exige conferência dos líderes e lançamento autorizado (não é automática).

## Como usar no dia a dia

1. Abrir o painel.
2. Na aba **Equipes**, alterar nome, líder e cores das três equipes e salvar.
3. Em **Cronogramas**, editar horário e ordem das atividades das sextas, sábados e acampamento.
4. Em **Cultos e eventos**, editar o conceito de cada noite, temas, locais e datas.
5. Em **Jogos**, editar regras, materiais, participantes e ordem, ou adicionar uma prova.
6. Em **Pontuação e histórico**, lançar pontos sem teto, em lote ou individualmente. Ao corrigir um erro, informar valor negativo e motivo, sem apagar o registro original.
7. Em **Publicação e backup**, exportar JSON/CSV e verificar se está em modo local ou online.

## Cuidados

- A liderança deve aprovar datas, regras, pontuação e premiação antes da temporada.
- O culto de sexta começa às 20h e o discipulado às 19h; horários finais podem ser ajustados.
- Atividades esportivas precisam de supervisão, hidratação e alternativas inclusivas.
- O horário da sala de oração às 05h exige atenção ao descanso, transporte e segurança dos menores; não se avalia qualidade da fé.
- Os resultados de domingo devem contabilizar convidados com respeito à privacidade, sem publicação de nomes.
- Sem coleta ou publicação de imagens de menores sem autorização.
- A interface de edição não é uma forma de armazenamento seguro por si só: o modo online depende das RLS do Supabase.
