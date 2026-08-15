import{_ as e,d as t,s as n,t as r,u as i}from"./supabase.DlwssEfo.js";var a=document.getElementById(`menu-toggle`),o=document.getElementById(`mobile-menu`);a?.addEventListener(`click`,()=>{o?.classList.toggle(`hidden`)});var s=document.getElementById(`user-area-desktop`),c=document.getElementById(`user-area-mobile`),l=`rounded-full px-4 py-2 text-sm font-semibold transition-colors`,u=`${l} border border-line text-text-dim hover:border-violet-glow/60 hover:text-violet-glow`,d=`${l} bg-violet-yola text-white hover:bg-violet-glow`;function f(e){return`<div class="w-8 h-8 rounded-full bg-violet-yola/20 border border-violet-yola/40 flex items-center justify-center text-sm font-bold text-violet-glow">${(e?.[0]||`?`).toUpperCase()}</div>`}function p(t){if(!t?.user){s.innerHTML=`
        <a href="/auth" class="${d}">Entrar</a>
      `,c.innerHTML=`
        <a href="/auth" class="px-3 py-2.5 rounded-lg text-sm font-medium text-violet-glow">Entrar / Crear cuenta</a>
      `;return}let n=t.user.email||`usuario`,i=r(n),a=n.length>24?n.slice(0,22)+`…`:n;s.innerHTML=`
      <a href="/panel" title="${i}" class="flex items-center gap-2 rounded-full border border-line/60 pl-1 pr-4 py-1 text-sm font-medium text-text-main hover:border-violet-glow/60 transition-colors">
        ${f(n)}
        <span class="max-w-[10rem] truncate">${r(a)}</span>
      </a>
      <button id="nav-logout" class="${u}">Salir</button>
    `,c.innerHTML=`
      <a href="/panel" class="flex items-center gap-2 px-3 py-2 rounded-lg text-sm font-medium text-text-main">
        ${f(n)} <span class="truncate">${i}</span>
      </a>
      <button id="nav-logout-mobile" class="px-3 py-2.5 rounded-lg text-sm font-medium text-red-400 text-left">Salir de la cuenta</button>
    `,document.getElementById(`nav-logout`)?.addEventListener(`click`,async()=>{await e(),window.location.href=`/`}),document.getElementById(`nav-logout-mobile`)?.addEventListener(`click`,async()=>{await e(),window.location.href=`/`})}i(),t(p),p(n());