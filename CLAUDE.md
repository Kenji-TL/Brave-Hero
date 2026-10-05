# Vertex Web Studio — workspace Brave Hero

> As regras gerais do MazyOS (ler contexto, aprender com correções, manter
> memória, criar skills) estão no `~/.claude/CLAUDE.md` global. Aqui fica só o
> que é específico desta operação.

## O que é esse workspace

Operação da Vertex Web Studio voltada ao cliente **Brave Hero Burguer**
(hamburgueria temática na Ilha do Governador, RJ). Aqui ficam o site, a prévia,
a proposta e a campanha de Google Ads desse cliente.

O workspace da própria Vertex (site institucional, marca, prospecção) fica em
`../VERTEXWEBSTUDIO/`.

**Estrutura de pastas:**
- `_memoria/` — quem somos, como falamos, foco atual
- `identidade/` — marca da Vertex (a do cliente fica no briefing dele)
- `clientes/brave-hero/` — briefing, site, deploy, prévia, proposta, marketing
- `marketing/` — conteúdo próprio da Vertex
- `saidas/` — emails e documentos pontuais
- `dados/` — arquivos a analisar
- `scripts/` — automações
- `templates/` — moldes do MazyOS

## Quem somos

Gustavo Kenji Norimatsu e Lucas Santos Garcia, sócios da Vertex Web Studio.
Os dois fazem tudo e se ajudam. Trabalhamos com negócios locais e pequenas
empresas entregando presença digital.

WhatsApp do Kenji: (81) 99599-6640 · https://wa.me/5581995996640

## Nosso serviço

- Desenvolvimento de sites
- Posts e carrosséis para Instagram
- Anúncios no Google Ads

Preços de referência: site R$ 1.500 à vista / R$ 2.000 no cartão (2 rodadas de
ajustes inclusas) · manutenção R$ 150/mês · hospedagem e domínio contratados
pelo próprio cliente (Hostinger Premium). Não vendemos criação de emails.

## Cliente ativo

**Brave Hero Burguer** — `clientes/brave-hero/`
Site pronto, prévia e proposta geradas, campanha de Google Ads montada e
pausada. Aguardando fechamento. Detalhes em `clientes/brave-hero/briefing.md`.

## Como trabalhamos

Encontramos o negócio, entramos em contato por mensagem escrita e enviamos uma
prévia do site pensada pra ele (PDF ou link temporário não indexado). Preço só
depois do interesse. Sem vídeo e sem chamada na abordagem.

## Tom de voz

Cordial, pessoal e direto, chamando o cliente pelo nome:

> "Olá, Marta, tudo bem? Meu nome é Gustavo Kenji, trabalho com criação de
> sites. Preparei uma prévia pensada especialmente para o seu negócio e estou
> te enviando em PDF."

Evitar: emoji em excesso, tom de guru, vídeo e chamada na abordagem.

## Regras do sistema

- Cliente novo → criar pasta `clientes/<Nome>/` com `briefing.md`
- Prévia e proposta → dentro da pasta do cliente (`previa/`, `proposta/`)
- Site: editar sempre em `clientes/<Nome>/site/`; a pasta `deploy/` é gerada a
  partir dela, nunca editada à mão
- Campanhas de Ads → `clientes/<Nome>/marketing/campanhas/google-ads-<data>/`,
  sempre pausadas até o cliente ativar
- Peça visual da Vertex → `identidade/design-guide.md`
- Peça visual do cliente → identidade que está no `briefing.md` dele

## Ferramentas conectadas

- [ ] Notion
- [ ] Gmail
- [ ] Google Calendar
- [ ] Stripe / cobrança

*(Marcar conforme for instalando os MCPs)*
