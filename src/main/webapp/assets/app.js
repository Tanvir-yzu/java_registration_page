(() => {
  const prefersReducedMotion = window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches;

  const onReady = (fn) => {
    if (document.readyState === 'loading') {
      document.addEventListener('DOMContentLoaded', fn, { once: true });
    } else {
      fn();
    }
  };

  onReady(() => {
    document.documentElement.classList.add('js');

    const forms = document.querySelectorAll('form');
    forms.forEach((form) => {
      form.addEventListener('submit', (e) => {
        const actionInput = form.querySelector('input[name="action"]');
        if (actionInput && actionInput.value === 'delete') {
          const ok = window.confirm('Are you sure you want to delete this user?');
          if (!ok) {
            e.preventDefault();
            return;
          }
        }

        const btn = form.querySelector('button[type="submit"], input[type="submit"]');
        if (btn && !prefersReducedMotion) {
          btn.disabled = true;
          const originalText = btn.tagName === 'BUTTON' ? btn.textContent : btn.value;
          if (btn.tagName === 'BUTTON') {
            btn.textContent = 'Please wait...';
          } else {
            btn.value = 'Please wait...';
          }
          window.setTimeout(() => {
            btn.disabled = false;
            if (btn.tagName === 'BUTTON') {
              btn.textContent = originalText;
            } else {
              btn.value = originalText;
            }
          }, 1400);
        }
      });
    });
  });
})();
