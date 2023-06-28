document.addEventListener('DOMContentLoaded', () => {

  const toggleElement = document.getElementById('toggle');
  const overlayElement = document.getElementById('overlay');

  toggleElement.addEventListener('click', () => {
    toggleElement.classList.toggle('active');
    overlayElement.classList.toggle('open');
  });
});