(() => {
  const eventName = 'outbound-link-click';

  const isTrackableOutboundLink = (link) => {
    if (!link || !link.href) return false;
    if (link.dataset.umamiEvent) return false;

    try {
      const url = new URL(link.href, window.location.href);
      const isHttp = url.protocol === 'http:' || url.protocol === 'https:';
      return isHttp && url.host !== window.location.host;
    } catch {
      return false;
    }
  };

  document.querySelectorAll('a').forEach((link) => {
    if (!isTrackableOutboundLink(link)) return;

    link.dataset.umamiEvent = eventName;
    link.dataset.umamiEventUrl = link.href;
  });
})();
