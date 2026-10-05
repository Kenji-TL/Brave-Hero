# Configurações da campanha — Brave Hero - Search Ilha

## Resumo

| Item | Valor |
|---|---|
| Tipo | Rede de Pesquisa (só Google Search) |
| Parceiros de pesquisa e Rede de Display | **desligados** |
| Orçamento | **R$ 32,90 por dia** (o Google limita o mês a ~30,4 × o diário → ~R$ 1.000/mês) |
| Estratégia de lance | **Maximizar conversões** (depois de 30+ conversões, testar "CPA desejado") |
| Idioma | Português |
| Status inicial | **Pausada** — só ativar depois do checklist lá embaixo |

> Se as conversões ainda não estiverem funcionando no dia de ativar, comece com **"Maximizar cliques"** por 1–2 semanas e troque pra "Maximizar conversões" assim que as conversões começarem a aparecer. Sem conversão, o Google não tem o que otimizar.

## Segmentação geográfica (configurar à mão no Editor ou no painel)

- **Raio de 6 km** a partir da Brave Hero: Estrada da Cacuia, 1259 — Cocotá (latitude -22.8080479, longitude -43.1826057). Cobre praticamente a Ilha do Governador inteira.
- Opção de local: **"Presença: pessoas que estão ou costumam estar nos locais segmentados"** (não usar "interesse", senão aparece pra quem está longe).

## Programação (dias e horários)

- **Terça a domingo, das 14h às 23h** (pega quem planeja a janta e o pedido antes de abrir às 17h)
- **Segunda: desligado** (a casa fecha)
- Depois de 2–3 semanas, olhar no relatório os horários que mais geram clique no WhatsApp/cardápio e concentrar a verba neles.

## Dispositivos

- Celular: +0% · Computador: +0% · Tablet: −20%
- Obs.: com "Maximizar conversões" o Google ignora ajustes de dispositivo (só respeita −100%). Os ajustes valem se começar com lance manual/cliques.

## Grupos de anúncio

| Grupo | Leva pra | Foco |
|---|---|---|
| Hamburgueria na Ilha | topo do site | quem procura hamburgueria na região |
| Delivery de Hambúrguer | `?s=delivery` | quem quer pedir em casa |
| Festas e Aniversários | `?s=festas` | reservas de aniversário (10 a 60 pessoas) |
| Espaço Kids e Família | `?s=espaco` | pais procurando lugar com área kids |
| Marca Brave Hero | topo do site | quem já procura pelo nome (clique barato, protege a marca) |

Cada grupo tem negativas cruzadas pra busca cair no grupo certo (ex.: "delivery" é negativa no grupo "Hamburgueria na Ilha", então quem busca delivery vê o anúncio de delivery).

## Extensões (recursos)

- **Sitelinks (6):** Cardápio, Festas, Espaço Kids, Delivery, Avaliações, Como Chegar — cada um abre a seção certa do site (`?s=...`)
- **Chamada:** (21) 98074-0586
- **Frases de destaque (8):** Espaço Kids, Chope Gelado, Nota 4,9 no Google…
- **Snippets:** Tipos (burgers, smash, petiscos, combos kids, açaí) e Comodidades (espaço kids, salão temático…)
- **Promoção:** 10% off no 1º pedido online com o cupom BRAVE10
- **Local:** vincular o **Perfil da Empresa no Google** (mostra endereço, nota e botão de rota) — isso é feito no painel, não por CSV
- **Preço:** não incluído — o site não mostra preços, e o Google exige que os preços do anúncio estejam na página de destino

## Conversões a configurar (antes de ativar)

No Google Ads → Metas → Conversões → Nova ação de conversão → Site:

1. **Clique no WhatsApp** (links `wa.me`) — principal
2. **Clique em "Pedir agora" / cardápio online** (links `app.cardapioweb.com`) — principal
3. **Clique no iFood ou 99Food** — secundária
4. **Clique em "Como chegar" / Google Maps** — secundária
5. **Ligações pelo anúncio** (vêm da extensão de chamada) — principal

O Google vai te dar um código tipo `AW-XXXXXXXXX` e um "rótulo" pra cada conversão. Mande pro Claude que ele instala no site e marca cada clique.

## Checklist antes de ativar

- [ ] Site publicado e endereço trocado no `gerar.ps1` (CSVs gerados de novo)
- [ ] Conta criada, cartão da Brave Hero cadastrado, verificação do anunciante ok
- [ ] Perfil da Empresa no Google vinculado (extensão de local)
- [ ] Conversões criadas e código instalado no site
- [ ] Raio de 6 km e programação terça–domingo configurados
- [ ] Cupom BRAVE10, horário e regras de festa (10 a 60 pessoas) confirmados com o cliente
- [ ] Revisar os anúncios no Editor e publicar
- [ ] Ativar a campanha
