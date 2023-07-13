document.addEventListener("DOMContentLoaded", setup);

function setup() {
  setupCategoryDisplay();
  setupTagSelection();
}

function setupCategoryDisplay() {
  const buttons = document.querySelectorAll('.category');
  buttons.forEach(button => {
    button.addEventListener('click', () => handleCategoryClick(button.innerText));
  });
}

function handleCategoryClick(category) {
  const activetagList = document.querySelector('.tag-list--active')
  activetagList.classList.remove('tag-list--active');
  activetagList.classList.add('tag-list--inactive');
  const targetTagList = document.querySelector(`.${category}`);
  targetTagList.classList.remove('tag-list--inactive');
  targetTagList.classList.add('tag-list--active');
}

function setupTagSelection() {
  const images = document.querySelectorAll('.tag');
  images.forEach(image => {
    image.addEventListener('click', handleTagClick);
  });
}

function handleTagClick() {
  displaySelectTag(this.src);
}

function displaySelectTag(tagUrl) {
  const tagContainer = document.querySelector('#input-tag');
  tagContainer.innerHTML = '';

  const img = createImageElement(tagUrl, 100, 100);
  img.classList.add('select-tag');
  tagContainer.appendChild(img);
}

function createImageElement(src, width, height) {
  const img = document.createElement('img');
  img.src = src;
  img.alt = getBaseName(src);
  img.width = width;
  img.height = height;
  return img;
}

function getBaseName(path) {
  // "asset/image/category/filename.jpg"の"category/filename"を取り出す
  const segments = path.split('/');
  const assetsIndex = segments.indexOf('assets');
  const pathSegment = `${segments[assetsIndex + 2]}/${segments[assetsIndex + 3]}`;
  return pathSegment.split('-')[0].split('.')[0];
}