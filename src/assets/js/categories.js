(() => {
  const input = document.querySelector('#category-filter');
  if (!input) return;

  const cards = [...document.querySelectorAll('[data-category]')];
  const results = document.querySelector('#category-results');
  const empty = document.querySelector('.categories .empty-state');

  const filter = () => {
    const query = input.value.trim().toLocaleLowerCase();
    let visible = 0;
    for (const card of cards) {
      card.hidden = !card.dataset.category.toLocaleLowerCase().includes(query);
      if (!card.hidden) visible++;
    }
    results.textContent = query ? `${visible} of ${cards.length} categories` : `${cards.length} categories`;
    empty.hidden = visible !== 0;
  };

  input.closest('.category-filter').hidden = false;
  input.addEventListener('input', filter);
  document.addEventListener('keydown', event => {
    if (event.defaultPrevented || event.isComposing || event.ctrlKey || event.altKey || event.metaKey) return;
    if (event.key === '/' && !event.target.closest('input, textarea, select, [contenteditable]')) {
      event.preventDefault();
      input.focus();
    }
    if (event.key === 'Escape' && document.activeElement === input && input.value) {
      event.preventDefault();
      input.value = '';
      filter();
    }
  });
  filter();
})();
