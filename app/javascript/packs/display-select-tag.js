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

async function handleCategoryClick(category) {
  const imagePaths = await fetchImagePaths(category);
  displayImages(imagePaths);
  setupTagSelection();
}

async function fetchImagePaths(category) {
  const response = await fetch(`/posts/image_paths?category=${encodeURIComponent(category)}`);
  if (!response.ok) {
    throw new Error('Network response was not ok');
  }
  return await response.json();
}

function displayImages(imagePaths) {
  const imageContainer = document.getElementById('imageContainer');
  imageContainer.innerHTML = '';

  imagePaths.forEach(imagePath => {
    const img = createImageElement(`/assets/${imagePath}`, 100, 100);
    img.classList.add(getBaseName(imagePath), 'tag');
    imageContainer.appendChild(img);
  });
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