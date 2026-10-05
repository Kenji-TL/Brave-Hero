# Google Ads — Brave Hero (passo a passo pra subir)

Campanha pronta nos CSVs desta pasta. Tudo entra **pausado**: nada gasta dinheiro até você ativar.

## Arquivos

| Arquivo | O que tem |
|---|---|
| `campanhas.csv` | a campanha (orçamento, lance, idioma, pausada) |
| `grupos.csv` | os 5 grupos de anúncio |
| `keywords.csv` | palavras-chave de cada grupo |
| `keywords-negativas.csv` | negativas da campanha + de cada grupo |
| `anuncios.csv` | 15 anúncios responsivos (3 por grupo, 15 títulos + 4 descrições cada) |
| `extensoes-*.csv` | sitelinks, chamada, frases de destaque, snippets e promoção |
| `configuracoes.md` | raio, horários, conversões e checklist antes de ativar |
| `gerar.ps1` | gerador dos CSVs (o Claude roda de novo quando o endereço do site mudar) |

## Antes de tudo (uma vez só)

1. **Conta de administrador (MCC):** https://ads.google.com/intl/pt-BR_br/home/tools/manager-accounts/ — no teu nome, pra gerenciar esse e os próximos clientes.
2. Dentro dela, **criar a conta da Brave Hero** e cadastrar o **cartão da Brave Hero** na cobrança.
3. Se o Google pedir **verificação do anunciante**, usar os dados/CNPJ da Brave Hero.
4. Pedir pro dono te adicionar como **gerente no Perfil da Empresa no Google** e vincular o perfil na conta de anúncios (Recursos → Local).
5. **Site no ar:** mandar o endereço pro Claude trocar nos CSVs (hoje está `https://SEU-SITE.netlify.app/`).

## Importar no Google Ads Editor

1. Baixar e instalar o **Google Ads Editor** (grátis): https://ads.google.com/intl/pt-BR_br/home/tools/ads-editor/
2. Abrir, fazer login e baixar a conta da Brave Hero.
3. **Conta → Importar → Do arquivo** e subir **nesta ordem**:
   1. `campanhas.csv`
   2. `grupos.csv`
   3. `keywords.csv`
   4. `keywords-negativas.csv`
   5. `anuncios.csv`
   6. os `extensoes-*.csv`
4. Em cada importação, o Editor mostra uma prévia. Se alguma coluna aparecer como "não reconhecida", é só escolher o campo certo na lista (os nomes estão em inglês, igual ao Editor).
5. Configurar à mão o que não vai por CSV (está em `configuracoes.md`): **raio de 6 km**, **programação terça a domingo 14h–23h**.
6. Clicar em **Publicar** (a campanha continua pausada).

## Antes de ativar

- Criar as **conversões** (lista em `configuracoes.md`) e mandar o código `AW-...` pro Claude instalar no site.
- Conferir o checklist do `configuracoes.md`.
- Ativar a campanha. O Google revisa os anúncios, geralmente em até 1 dia útil.

## Depois de ativar

- Toda semana: no Google Ads, **Relatórios → baixar CSV** (campanha, palavras-chave e termos de pesquisa) e mandar pro Claude com `/relatorio-ads`.
- Primeiros 15 dias: não mexer muito. O Google está aprendendo.
- Verba sugerida pra avaliar: **R$ 32,90/dia por 30 dias** antes de decidir aumentar, cortar grupo ou mudar a estratégia.
