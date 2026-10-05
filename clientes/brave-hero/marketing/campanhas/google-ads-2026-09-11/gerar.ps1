# Gera os CSVs da campanha Google Ads da Brave Hero (pra importar no Google Ads Editor).
# Pra trocar o endereço do site: mude $FinalUrl e rode de novo (ou peça pro Claude).
$ErrorActionPreference = 'Stop'

$FinalUrl  = 'https://SEU-SITE.netlify.app/'   # TROCAR pelo endereço real quando o site estiver no ar
$Campanha  = 'Brave Hero - Search Ilha'
$Orcamento = '32.90'                          # R$ por dia (~R$ 1.000 por mês)
$Pasta     = 'C:\Users\Kenji\Desktop\Brave hero\clientes\brave-hero\marketing\campanhas\google-ads-2026-09-11'

function Url($secao) { if ($secao) { "$($FinalUrl.TrimEnd('/'))/?s=$secao" } else { $FinalUrl } }
function Q($v) { '"' + ([string]$v).Replace('"', '""') + '"' }
function Salvar($nome, $colunas, $linhas) {
  $sb = New-Object System.Text.StringBuilder
  [void]$sb.AppendLine((($colunas | ForEach-Object { Q $_ }) -join ','))
  foreach ($l in $linhas) { [void]$sb.AppendLine((($colunas | ForEach-Object { Q $l[$_] }) -join ',')) }
  [IO.File]::WriteAllText((Join-Path $Pasta $nome), $sb.ToString(), (New-Object Text.UTF8Encoding $true))
}
$erros = New-Object System.Collections.ArrayList
function Checa($texto, $max, $onde) {
  if ($texto.Length -gt $max) { [void]$erros.Add("${onde}: '$texto' tem $($texto.Length) caracteres (máx $max)") }
}

# ---------- títulos em comum (até 30 caracteres, sem "!") ----------
$Comuns = @{
  A = @('Brave Hero Burguer', 'Hamburgueria Temática', 'Nota 4,9 no Google', 'Mais de 160 Avaliações',
        'Burgers com Nome de Herói', 'Pão Colorido de Herói', 'Chope Gelado e Petiscos',
        'Aberto de Terça a Domingo', 'Das 17h às 23h no Cocotá', 'Veja o Cardápio Completo',
        'Todo Herói Tem Fome', 'Reserve sua Mesa')
  B = @('Cupom BRAVE10: 10% Off', '10% Off no 1º Pedido Online', 'Peça pelo Cardápio Online',
        'Peça pelo WhatsApp', 'Também no iFood e 99Food', 'Brave Hero Burguer', 'Nota 4,9 no Google',
        'Todo Herói Tem Fome', 'Aberto de Terça a Domingo', 'Faça Seu Pedido Agora',
        'Burgers com Nome de Herói', 'Mais de 160 Avaliações')
  C = @('Espaço Kids Exclusivo', 'Salão Temático de Heróis', 'Pais Comem, Crianças Brincam',
        'Burger, Chope e Espaço Kids', 'Mesas para Grupos Grandes', 'Nota 4,9 no Google',
        'Brave Hero Burguer', 'Estrada da Cacuia, 1259', 'No Cocotá, Ilha do Governador',
        'Reserve sua Mesa', 'Mais de 160 Avaliações', 'Chope Gelado e Petiscos')
  D = @('Salão Temático de Heróis', 'Espaço Kids Exclusivo', 'Mesas para Grupos Grandes',
        'Chope Gelado e Petiscos', 'Nota 4,9 no Google', 'Brave Hero Burguer', 'Aberto de Terça a Domingo',
        'Das 17h às 23h no Cocotá', 'Reserve sua Mesa', 'Burger, Chope e Espaço Kids',
        'Mais de 160 Avaliações', 'Todo Herói Tem Fome')
}

# ---------- descrições (até 90 caracteres) ----------
$Desc = @{
  inst     = 'Hamburgueria temática no Cocotá com burger artesanal, chope gelado e espaço kids.'
  nota     = 'Nota 4,9 no Google com mais de 160 avaliações. Veja o cardápio e faça seu pedido.'
  cupom    = 'Use o cupom BRAVE10 e ganhe 10% de desconto no primeiro pedido pelo cardápio online.'
  horario  = 'Aberto de terça a domingo, das 17h às 23h. Estrada da Cacuia, 1259, Ilha do Governador.'
  delivery = 'Peça pelo cardápio online, iFood, 99Food ou WhatsApp e receba seu burger em casa.'
  festa    = 'Festas de aniversário para grupos de 10 a 60 pessoas, com espaço kids. Reserve já.'
  festa2   = 'Salão temático de heróis, burger caprichado e chope gelado. Chame no WhatsApp.'
  kids     = 'Enquanto você curte seu burger, a criançada se diverte no espaço kids. Venha conhecer.'
  marca    = 'Site oficial da Brave Hero: cardápio, delivery, festas e como chegar em um só lugar.'
}

# ---------- grupos de anúncio ----------
$Grupos = @(
  @{ Nome = 'Hamburgueria na Ilha'; Secao = ''; Path1 = 'hamburgueria'; Path2 = 'ilha'; Sets = @('A', 'B', 'C')
     Descs = @(@('inst', 'nota', 'horario', 'cupom'), @('cupom', 'delivery', 'nota', 'horario'), @('kids', 'inst', 'nota', 'horario'))
     Espec = @('Hamburgueria na Ilha', 'Hamburgueria no Cocotá', 'Hamburgueria Artesanal', 'Hambúrguer Artesanal na Ilha',
               'Burger na Ilha do Governador', 'Smash e Artesanal na Chapa', 'Hamburgueria Perto de Você', 'Aberta Hoje até as 23h')
     KW = @(@('hamburgueria ilha do governador', 'Exact'), @('hamburgueria ilha do governador', 'Phrase'),
            @('hamburgueria na ilha do governador', 'Phrase'), @('hamburgueria cocota', 'Phrase'),
            @('hamburgueria artesanal ilha do governador', 'Phrase'), @('hamburguer ilha do governador', 'Phrase'),
            @('hamburgueria jardim guanabara', 'Phrase'), @('hamburgueria freguesia ilha', 'Phrase'),
            @('hamburgueria perto de mim', 'Phrase'), @('hamburgueria aberta agora', 'Phrase'),
            @('onde comer hamburguer na ilha', 'Phrase'), @('hamburgueria tematica', 'Phrase'),
            @('smash burger ilha do governador', 'Phrase'), @('lanchonete ilha do governador', 'Phrase'))
     Neg = @('delivery', 'entrega', 'ifood', 'aniversario', 'aniversário', 'festa', 'espaco kids', 'espaço kids', 'area kids', 'crianca', 'criança', 'infantil', 'brave hero') },

  @{ Nome = 'Delivery de Hambúrguer'; Secao = 'delivery'; Path1 = 'delivery'; Path2 = 'ilha'; Sets = @('A', 'B', 'B')
     Descs = @(@('delivery', 'cupom', 'nota', 'horario'), @('cupom', 'delivery', 'inst', 'nota'), @('delivery', 'nota', 'inst', 'horario'))
     Espec = @('Delivery na Ilha do Governador', 'Hambúrguer Delivery na Ilha', 'Delivery de Hambúrguer', 'Burger Quentinho em Casa',
               'Peça e Receba em Casa', 'Delivery de Terça a Domingo', 'Smash e Artesanal no Delivery', 'Combos para Toda a Família')
     KW = @(@('hamburguer delivery ilha do governador', 'Exact'), @('delivery hamburguer ilha do governador', 'Phrase'),
            @('hamburguer delivery ilha do governador', 'Phrase'), @('delivery de hamburguer perto de mim', 'Phrase'),
            @('hamburguer delivery perto de mim', 'Phrase'), @('delivery ilha do governador', 'Phrase'),
            @('lanche delivery ilha do governador', 'Phrase'), @('hamburguer delivery cocota', 'Phrase'),
            @('smash burger delivery', 'Phrase'), @('pedir hamburguer', 'Phrase'), @('delivery hamburgueria aberta agora', 'Phrase'))
     Neg = @('aniversario', 'aniversário', 'festa', 'espaco kids', 'espaço kids', 'brave hero') },

  @{ Nome = 'Festas e Aniversários'; Secao = 'festas'; Path1 = 'festas'; Path2 = 'aniversario'; Sets = @('A', 'D', 'C')
     Descs = @(@('festa', 'festa2', 'nota', 'horario'), @('festa', 'kids', 'nota', 'horario'), @('festa2', 'festa', 'inst', 'horario'))
     Espec = @('Festa de Aniversário na Ilha', 'Aniversário na Brave Hero', 'Comemore no QG dos Heróis', 'Grupos de 10 a 60 Pessoas',
               'Aniversário com Espaço Kids', 'Reserve pelo WhatsApp', 'Festa Infantil com Burger', 'Reservas para Aniversário')
     KW = @(@('lugar para aniversario ilha do governador', 'Exact'), @('lugar para aniversario ilha do governador', 'Phrase'),
            @('aniversario ilha do governador', 'Phrase'), @('festa de aniversario ilha do governador', 'Phrase'),
            @('restaurante para aniversario ilha do governador', 'Phrase'), @('comemorar aniversario ilha do governador', 'Phrase'),
            @('aniversario infantil ilha do governador', 'Phrase'), @('festa infantil ilha do governador', 'Phrase'),
            @('espaco para festa ilha do governador', 'Phrase'), @('onde comemorar aniversario', 'Phrase'),
            @('restaurante para festa de aniversario', 'Phrase'), @('aniversario em restaurante', 'Phrase'))
     Neg = @('delivery', 'ifood', 'buffet', 'decoracao', 'decoração', 'convite', 'bolo', 'salgados', 'kit festa', 'aluguel', 'brave hero') },

  @{ Nome = 'Espaço Kids e Família'; Secao = 'espaco'; Path1 = 'espaco-kids'; Path2 = 'ilha'; Sets = @('C', 'D', 'A')
     Descs = @(@('kids', 'inst', 'nota', 'horario'), @('kids', 'festa', 'nota', 'horario'), @('inst', 'kids', 'festa2', 'horario'))
     Espec = @('Restaurante com Espaço Kids', 'Hamburgueria com Espaço Kids', 'Diversão pros Pequenos Heróis', 'Espaço Kids na Ilha',
               'Família Inteira Bem-Vinda', 'Área Kids no Cocotá', 'Brinquedão para as Crianças', 'Lugar para Levar as Crianças')
     KW = @(@('restaurante com espaco kids ilha do governador', 'Exact'), @('restaurante com espaco kids ilha do governador', 'Phrase'),
            @('restaurante com espaco kids', 'Phrase'), @('hamburgueria com espaco kids', 'Phrase'),
            @('restaurante com brinquedoteca', 'Phrase'), @('restaurante com area kids', 'Phrase'),
            @('lugar para levar crianca ilha do governador', 'Phrase'), @('restaurante infantil ilha do governador', 'Phrase'),
            @('restaurante para familia ilha do governador', 'Phrase'), @('restaurante com parquinho', 'Phrase'))
     Neg = @('festa', 'aniversario', 'aniversário', 'delivery', 'brave hero') },

  @{ Nome = 'Marca Brave Hero'; Secao = ''; Path1 = 'brave-hero'; Path2 = 'cardapio'; Sets = @('A', 'B', 'C')
     Descs = @(@('marca', 'nota', 'cupom', 'horario'), @('marca', 'delivery', 'festa', 'horario'), @('marca', 'inst', 'nota', 'cupom'))
     Espec = @('Site Oficial Brave Hero', 'Brave Hero Hamburgueria', 'Cardápio Brave Hero', 'Brave Hero no Cocotá',
               'Delivery Brave Hero', 'Festas na Brave Hero', 'Brave Hero: Pedido Online', 'Brave Hero Ilha do Governador')
     KW = @(@('brave hero burguer', 'Exact'), @('brave hero burguer', 'Phrase'), @('brave hero hamburgueria', 'Phrase'),
            @('brave hero ilha', 'Phrase'), @('brave hero cocota', 'Phrase'), @('brave hero burger', 'Phrase'),
            @('brave hero delivery', 'Phrase'))
     Neg = @() }
)

# ---------- negativas da campanha inteira ----------
$NegGlobais = @('receita', 'receitas', 'como fazer', 'caseiro', 'caseira', 'vaga', 'vagas', 'emprego', 'empregos',
  'trabalhe conosco', 'curso', 'franquia', 'atacado', 'congelado', 'supermercado', 'pao de hamburguer', 'carne moida',
  'prensa', 'maquina', 'gratis', 'grátis', 'download', 'png', 'desenho', 'calorias', 'dieta', 'significado',
  'mcdonalds', 'mc donalds', 'burger king', 'bobs', 'madero', 'habibs',
  'original burguer', 'o burgues', 'o burguês', 'notorious burguer', 'social burguer', 'trindade burger',
  'point do leao', 'point do leão', 'hamburgueria do rafa', 'mocellin', 'gruta da ilha', 'simsalabim', 'a favorita')

# ---------- montagem ----------
$slices = @(@(0, 1, 2, 3, 4), @(3, 4, 5, 6, 7), @(0, 1, 5, 6, 7))
$linCamp = @(@{ 'Campaign' = $Campanha; 'Campaign Type' = 'Search'; 'Networks' = 'Google search'; 'Budget' = $Orcamento;
                'Budget type' = 'Daily'; 'Bid Strategy Type' = 'Maximize conversions'; 'Languages' = 'pt'; 'Campaign Status' = 'Paused' })
$linGrupos = @(); $linKW = @(); $linNeg = @(); $linAds = @()

foreach ($n in $NegGlobais) { $linNeg += @{ 'Campaign' = $Campanha; 'Ad Group' = ''; 'Keyword' = $n; 'Criterion Type' = 'Campaign Negative Phrase' } }

foreach ($g in $Grupos) {
  $linGrupos += @{ 'Campaign' = $Campanha; 'Ad Group' = $g.Nome; 'Ad Group Status' = 'Enabled' }
  foreach ($k in $g.KW) { $linKW += @{ 'Campaign' = $Campanha; 'Ad Group' = $g.Nome; 'Keyword' = $k[0]; 'Criterion Type' = $k[1]; 'Status' = 'Enabled' } }
  foreach ($n in $g.Neg) { $linNeg += @{ 'Campaign' = $Campanha; 'Ad Group' = $g.Nome; 'Keyword' = $n; 'Criterion Type' = 'Negative Phrase' } }
  foreach ($e in $g.Espec) { Checa $e 30 "Título ($($g.Nome))" }
  Checa $g.Path1 15 "Caminho 1 ($($g.Nome))"; Checa $g.Path2 15 "Caminho 2 ($($g.Nome))"
  for ($i = 0; $i -lt 3; $i++) {
    $titulos = New-Object System.Collections.ArrayList
    $candidatos = @($slices[$i] | ForEach-Object { $g.Espec[$_] }) + $Comuns[$g.Sets[$i]]
    foreach ($h in $candidatos) { if ($titulos.Count -lt 15 -and -not $titulos.Contains($h)) { [void]$titulos.Add($h) } }
    if ($titulos.Count -ne 15) { [void]$erros.Add("Anúncio $($i+1) de '$($g.Nome)' ficou com $($titulos.Count) títulos") }
    $ad = @{ 'Campaign' = $Campanha; 'Ad Group' = $g.Nome; 'Ad type' = 'Responsive search ad'; 'Path 1' = $g.Path1; 'Path 2' = $g.Path2;
             'Final URL' = (Url $g.Secao); 'Status' = 'Enabled' }
    for ($t = 0; $t -lt 15; $t++) {
      $ad["Headline $($t+1)"] = $titulos[$t]; Checa $titulos[$t] 30 "Título"
      if ($titulos[$t] -match '!') { [void]$erros.Add("Título com '!': $($titulos[$t])") }
    }
    for ($d = 0; $d -lt 4; $d++) { $txt = $Desc[$g.Descs[$i][$d]]; $ad["Description $($d+1)"] = $txt; Checa $txt 90 "Descrição" }
    $linAds += $ad
  }
}

# ---------- extensões ----------
$sitelinks = @(
  @('Cardápio com Fotos', 'Burgers, petiscos, chope e açaí', 'Peça online com 10% no 1º pedido', 'cardapio'),
  @('Festas de Aniversário', 'Grupos de 10 a 60 pessoas', 'Reserve pelo WhatsApp', 'festas'),
  @('Espaço Kids', 'Brinquedão para a criançada', 'Diversão enquanto você come', 'espaco'),
  @('Delivery', 'Cardápio online, iFood e 99Food', 'Ou peça pelo WhatsApp', 'delivery'),
  @('Avaliações 4,9 no Google', 'Mais de 160 avaliações', 'Veja o que dizem os clientes', 'avaliacoes'),
  @('Como Chegar', 'Estrada da Cacuia, 1259', 'Cocotá, Ilha do Governador', 'visite'))
$linSL = @()
foreach ($s in $sitelinks) {
  Checa $s[0] 25 'Sitelink'; Checa $s[1] 35 'Sitelink (linha 1)'; Checa $s[2] 35 'Sitelink (linha 2)'
  $linSL += @{ 'Campaign' = $Campanha; 'Link text' = $s[0]; 'Description line 1' = $s[1]; 'Description line 2' = $s[2]; 'Final URL' = (Url $s[3]) }
}
$callouts = @('Espaço Kids', 'Chope Gelado', 'Nota 4,9 no Google', 'Salão Temático de Heróis', 'Festas de Aniversário',
              'Delivery Próprio', 'Cupom 10% no 1º Pedido', 'Terça a Domingo 17h-23h')
$linCO = @(); foreach ($c in $callouts) { Checa $c 25 'Frase de destaque'; $linCO += @{ 'Campaign' = $Campanha; 'Callout text' = $c } }
$snippets = @(@('Types', @('Burgers artesanais', 'Smash burgers', 'Petiscos', 'Combos kids', 'Açaí')),
              @('Amenities', @('Espaço kids', 'Salão temático', 'Chope gelado', 'Mesas para grupos', 'Delivery')))
$linSN = @()
foreach ($s in $snippets) { foreach ($v in $s[1]) { Checa $v 25 'Snippet' }; $linSN += @{ 'Campaign' = $Campanha; 'Structured snippet header' = $s[0]; 'Structured snippet values' = ($s[1] -join ';') } }
$linCall = @(@{ 'Campaign' = $Campanha; 'Phone number' = '(21) 98074-0586'; 'Country code' = 'BR' })
$promo = '1º pedido online'; Checa $promo 20 'Promoção'
$linPromo = @(@{ 'Campaign' = $Campanha; 'Promotion target' = $promo; 'Percent off' = '10'; 'Promo code' = 'BRAVE10'; 'Language' = 'pt'; 'Final URL' = (Url 'cardapio') })

if ($erros.Count -gt 0) { "PROBLEMAS ENCONTRADOS:"; $erros; throw "Corrija os textos acima antes de gerar." }

$hd = @(1..15 | ForEach-Object { "Headline $_" }); $dd = @(1..4 | ForEach-Object { "Description $_" })
Salvar 'campanhas.csv' @('Campaign', 'Campaign Type', 'Networks', 'Budget', 'Budget type', 'Bid Strategy Type', 'Languages', 'Campaign Status') $linCamp
Salvar 'grupos.csv' @('Campaign', 'Ad Group', 'Ad Group Status') $linGrupos
Salvar 'keywords.csv' @('Campaign', 'Ad Group', 'Keyword', 'Criterion Type', 'Status') $linKW
Salvar 'keywords-negativas.csv' @('Campaign', 'Ad Group', 'Keyword', 'Criterion Type') $linNeg
Salvar 'anuncios.csv' (@('Campaign', 'Ad Group', 'Ad type') + $hd + $dd + @('Path 1', 'Path 2', 'Final URL', 'Status')) $linAds
Salvar 'extensoes-sitelinks.csv' @('Campaign', 'Link text', 'Description line 1', 'Description line 2', 'Final URL') $linSL
Salvar 'extensoes-chamadas.csv' @('Campaign', 'Phone number', 'Country code') $linCall
Salvar 'extensoes-frases.csv' @('Campaign', 'Callout text') $linCO
Salvar 'extensoes-snippets.csv' @('Campaign', 'Structured snippet header', 'Structured snippet values') $linSN
Salvar 'extensoes-promocao.csv' @('Campaign', 'Promotion target', 'Percent off', 'Promo code', 'Language', 'Final URL') $linPromo

"OK: 1 campanha | $($linGrupos.Count) grupos | $($linKW.Count) palavras-chave | $($linNeg.Count) negativas | $($linAds.Count) anúncios | $($linSL.Count) sitelinks | $($linCO.Count) frases | $($linSN.Count) snippets"
"Endereço usado: $FinalUrl"
