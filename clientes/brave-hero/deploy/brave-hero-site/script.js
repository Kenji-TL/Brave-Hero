// Menu mobile
const toggle = document.querySelector('.nav-toggle');
const nav = document.getElementById('menu');

toggle.addEventListener('click', () => {
  const open = toggle.getAttribute('aria-expanded') === 'true';
  toggle.setAttribute('aria-expanded', String(!open));
  toggle.setAttribute('aria-label', open ? 'Abrir menu' : 'Fechar menu');
  nav.classList.toggle('is-open', !open);
});

nav.querySelectorAll('a').forEach((link) => {
  link.addEventListener('click', () => {
    toggle.setAttribute('aria-expanded', 'false');
    toggle.setAttribute('aria-label', 'Abrir menu');
    nav.classList.remove('is-open');
  });
});

// Aberto agora? Terça a domingo, 17h às 23h (horário do Rio)
const OPEN_HOUR = 17;
const CLOSE_HOUR = 23;
const CLOSED_DAY = 1; // segunda-feira
const DAYS = ['domingo', 'segunda', 'terça', 'quarta', 'quinta', 'sexta', 'sábado'];

function nowInRio() {
  const parts = new Intl.DateTimeFormat('en-US', {
    timeZone: 'America/Sao_Paulo',
    weekday: 'short',
    hour: 'numeric',
    hourCycle: 'h23',
  }).formatToParts(new Date());
  const weekday = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
    .indexOf(parts.find((p) => p.type === 'weekday').value);
  const hour = Number(parts.find((p) => p.type === 'hour').value);
  return { weekday, hour };
}

function updateStatus() {
  const status = document.getElementById('status');
  if (!status) return;
  const text = status.querySelector('.status__text');
  const { weekday, hour } = nowInRio();
  const openToday = weekday !== CLOSED_DAY;

  if (openToday && hour >= OPEN_HOUR && hour < CLOSE_HOUR) {
    status.classList.add('is-open');
    status.classList.remove('is-closed');
    text.textContent = `Aberto agora · fecha às ${CLOSE_HOUR}h`;
    return;
  }

  status.classList.add('is-closed');
  status.classList.remove('is-open');
  if (openToday && hour < OPEN_HOUR) {
    text.textContent = `Fechado · abre hoje às ${OPEN_HOUR}h`;
  } else {
    let next = (weekday + 1) % 7;
    if (next === CLOSED_DAY) next = (next + 1) % 7;
    const label = next === (weekday + 1) % 7 ? 'amanhã' : DAYS[next];
    text.textContent = `Fechado · abre ${label} às ${OPEN_HOUR}h`;
  }
}

updateStatus();
setInterval(updateStatus, 60 * 1000);

// Fotos do espaço kids e das festas: só aparecem quando o arquivo existe; senão fica o quadrinho.
document.querySelectorAll('[data-media]').forEach((figure) => {
  const img = figure.querySelector('.media__img');
  if (!img) return;
  const show = () => {
    if (img.naturalWidth > 0) figure.classList.add('has-media');
  };
  if (img.complete) show();
  else img.addEventListener('load', show);
});

// Fotos do local passando no fundo do topo. Pra trocar ou adicionar, é só editar a lista.
const FOTOS_FUNDO = [
  'assets/fundo/local-1.jpg',
  'assets/fundo/local-2.jpg',
  'assets/fundo/local-3.jpg',
  'assets/fundo/local-4.jpg',
  'assets/fundo/local-9.jpg',
  'assets/fundo/local-5.jpg',
  'assets/fundo/local-7.jpg',
  'assets/fundo/local-6.jpg',
  'assets/fundo/local-8.jpg',
];

function montarFundo() {
  const bg = document.querySelector('.hero__bg');
  if (!bg || !FOTOS_FUNDO.length) return;
  const metade = Math.ceil(FOTOS_FUNDO.length / 2);
  [FOTOS_FUNDO.slice(0, metade), FOTOS_FUNDO.slice(metade)].forEach((fotos, i) => {
    if (!fotos.length) return;
    const row = document.createElement('div');
    row.className = i ? 'hero__row hero__row--reverse' : 'hero__row';
    // dois grupos iguais pra emendar sem fim; cada um repete as fotos pra cobrir telas largas
    for (let g = 0; g < 2; g++) {
      const group = document.createElement('div');
      group.className = 'hero__group';
      [...fotos, ...fotos].forEach((src) => {
        const img = new Image();
        img.src = src;
        img.alt = '';
        img.decoding = 'async';
        img.addEventListener('error', () => img.remove());
        group.appendChild(img);
      });
      row.appendChild(group);
    }
    bg.appendChild(row);
  });
}

// monta o fundo só depois que a página carregou, pra não atrasar a primeira tela
if (document.readyState === 'complete') montarFundo();
else window.addEventListener('load', montarFundo);

// Galeria "Por dentro do QG": clicar numa foto abre ela grande, com setas pra passar
const lightbox = document.querySelector('.lightbox');
const fotosQG = [...document.querySelectorAll('.qg__item')];

if (lightbox && fotosQG.length) {
  const lbImg = lightbox.querySelector('.lightbox__img');
  const lbCaption = lightbox.querySelector('.lightbox__caption');
  let atual = 0;

  const abrir = (i) => {
    atual = (i + fotosQG.length) % fotosQG.length;
    const img = fotosQG[atual].querySelector('img');
    lbImg.src = img.currentSrc || img.src;
    lbImg.alt = img.alt;
    lbCaption.textContent = fotosQG[atual].querySelector('figcaption').textContent;
    if (!lightbox.open) lightbox.showModal();
  };

  fotosQG.forEach((item, i) => {
    item.tabIndex = 0;
    item.setAttribute('role', 'button');
    item.setAttribute('aria-label', `Ampliar foto: ${item.querySelector('figcaption').textContent}`);
    item.addEventListener('click', () => abrir(i));
    item.addEventListener('keydown', (e) => {
      if (e.key === 'Enter' || e.key === ' ') {
        e.preventDefault();
        abrir(i);
      }
    });
  });

  lightbox.querySelector('.lightbox__close').addEventListener('click', () => lightbox.close());
  lightbox.querySelector('.lightbox__nav--prev').addEventListener('click', () => abrir(atual - 1));
  lightbox.querySelector('.lightbox__nav--next').addEventListener('click', () => abrir(atual + 1));

  // clicar fora da foto fecha
  lightbox.addEventListener('click', (e) => {
    if (e.target === lightbox) lightbox.close();
  });

  lightbox.addEventListener('keydown', (e) => {
    if (e.key === 'ArrowLeft') abrir(atual - 1);
    if (e.key === 'ArrowRight') abrir(atual + 1);
  });

  // arrastar pro lado no celular
  let toqueX = null;
  lightbox.addEventListener('touchstart', (e) => { toqueX = e.touches[0].clientX; }, { passive: true });
  lightbox.addEventListener('touchend', (e) => {
    if (toqueX === null) return;
    const dx = e.changedTouches[0].clientX - toqueX;
    if (Math.abs(dx) > 40) abrir(dx < 0 ? atual + 1 : atual - 1);
    toqueX = null;
  });
}

// Links dos anúncios (?s=festas, ?s=cardapio…): abre o site já na seção certa
const secaoPedida = new URLSearchParams(window.location.search).get('s');
if (secaoPedida) {
  const alvo = document.getElementById(secaoPedida);
  if (alvo) window.addEventListener('load', () => alvo.scrollIntoView());
}

document.getElementById('ano').textContent = new Date().getFullYear();
