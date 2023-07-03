window.addEventListener('load',function(){
  const zannen = document.querySelector('.zannen h3')
  const score = document.getElementById('score');
  const title1 = document.querySelector('.ome-title');
  const title2 = document.querySelector('.zannen-title');
  
  if (score.innerHTML === "合計得点: 5") {
    title1.style.display = 'block';
    title1.classList.add('congrats');
  } else {
    title2.style.display = 'block';
    zannen.classList.add('sad');
  }
});