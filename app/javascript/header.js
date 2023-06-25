window.addEventListener('load', function() {
  const navBar = document.querySelector('nav');
  const myTitle = document.querySelector('nav div.site-title');

  function handleScroll() {
    if (window.scrollY >= 170) {
      navBar.classList.add('fixed-header');
      myTitle.classList.add('visible-title');
    } else {
      navBar.classList.remove('fixed-header');
      myTitle.classList.remove('visible-title');
    }
  }

  window.addEventListener('scroll', handleScroll);
  handleScroll(); // 初回実行も追加
});