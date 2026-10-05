# Publicar o site da Brave Hero no Netlify

A pasta **`brave-hero-site/`** é o site pronto pra ir ao ar. Não mexa nela direto: faça as mudanças em `../site/` e gere a pasta de novo (peça pro Claude "atualizar a pasta de deploy").

## Primeira publicação (arrastar e soltar)

1. Entre em **https://app.netlify.com** e **faça login** (dá pra entrar com Google ou GitHub).
   Importante: faça login *antes* de subir. Site enviado sem conta é apagado depois de 1 hora.
2. Vá em **Sites → Add new site → Deploy manually** (ou acesse https://app.netlify.com/drop).
3. **Arraste a pasta `brave-hero-site` inteira** pra área pontilhada.
4. Em alguns segundos o site estará no ar num endereço tipo `https://nome-aleatorio.netlify.app`.

## Deixar com cara profissional

- **Nome do endereço:** Site configuration → *Change site name* → ex.: `braveheroburguer` → vira `https://braveheroburguer.netlify.app`.
- **Domínio próprio (opcional):** registre em https://registro.br (ex.: `braveheroburguer.com.br`) e depois, no Netlify, *Domain management → Add a domain* e siga as instruções de DNS. O HTTPS (cadeado) é gratuito e automático.

## Atualizar o site depois

Netlify → seu site → aba **Deploys** → arraste a pasta `brave-hero-site` atualizada na área "Drag and drop your site output folder here".

## Depois que estiver no ar

- [ ] Mandar o endereço pro Claude trocar o `og:image` pela URL completa — assim a prévia com foto aparece quando o link é compartilhado no WhatsApp/Instagram.
- [ ] Colocar o link no **Perfil da Empresa no Google** (hoje aparece "Adicionar website"), na bio do Instagram e no Linktree.
- [ ] Medir a velocidade em **https://pagespeed.web.dev** (colar o endereço do site).

## O que já vem preparado nessa pasta

- Fotos do cardápio reduzidas pro tamanho em que aparecem na tela (mais leve no celular)
- Arquivos que o site não usa ficaram de fora (LEIA-ME, foto do combo, miniatura `espaço-kids.jpg`)
- `_headers`: regras de segurança e de cache do Netlify
- `404.html`: página "não encontrada" com a identidade da Brave Hero
- `robots.txt`: libera o Google pra indexar o site
