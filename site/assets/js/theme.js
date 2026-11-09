(() => {
  const storageKey = 'my-github-theme';
  const systemTheme = matchMedia('(prefers-color-scheme: dark)');
  let theme = 'system';

  try {
    const saved = localStorage.getItem(storageKey);
    if (saved === 'light' || saved === 'dark') theme = saved;
  } catch {}

  const apply = () => {
    const current = theme === 'system' ? (systemTheme.matches ? 'dark' : 'light') : theme;
    document.documentElement.dataset.theme = current;
    document.querySelectorAll('source[data-theme-image]').forEach(source => {
      source.media = current === 'dark' ? 'all' : 'not all';
    });
    document.querySelectorAll('.theme-selector button').forEach(button => {
      button.setAttribute('aria-pressed', String(button.dataset.theme === theme));
    });
  };

  const select = value => {
    theme = value;
    apply();
    try {
      if (theme === 'system') localStorage.removeItem(storageKey);
      else localStorage.setItem(storageKey, theme);
    } catch {}
  };

  apply();
  systemTheme.addEventListener('change', apply);
  document.addEventListener('DOMContentLoaded', () => {
    apply();
    const control = document.querySelector('.theme-selector');
    control.hidden = false;
    control.addEventListener('click', event => {
      const button = event.target.closest('button');
      if (button) select(button.dataset.theme);
    });
    document.addEventListener('keydown', event => {
      if (event.key.toLowerCase() !== 't' || !event.altKey || event.ctrlKey || event.metaKey || event.shiftKey) return;
      event.preventDefault();
      if (!event.repeat) select(document.documentElement.dataset.theme === 'dark' ? 'light' : 'dark');
    });
  });
})();
