document.addEventListener("DOMContentLoaded", async () => {
  const buttons = document.querySelectorAll('.category');
  console.log(buttons);

  const displayCategory = async category => {
    console.log("onclicked");
    const displayDiv = document.getElementById('display');
    displayDiv.innerText = category;

    const response = await fetch(`/posts/image_paths?category=${encodeURIComponent(category)}`);
    const imagePaths = await response.json();
    console.log(imagePaths);

    const imageContainer = document.getElementById('imageContainer');

    imageContainer.innerHTML = '';

    imagePaths.forEach(imagePath => {
      const img = document.createElement('img');
      img.src = "/assets/" + imagePath;
      img.alt = imagePath.split('/').pop().split('.')[0];
      img.width = 100;
      img.height = 100;

      imageContainer.appendChild(img);
    });
  };

  buttons.forEach(button => {
    button.addEventListener('click', () => displayCategory(button.innerText));
  });
});



// document.addEventListener("DOMContentLoaded", () => {
//   const buttons = document.querySelectorAll('.category');
//   console.log(buttons);

//   const displayCategory = category => {
//     console.log("onclicked");
//     const displayDiv = document.getElementById('display');
//     displayDiv.innerText = category;
//   };

//   buttons.forEach(button => {
//     button.addEventListener('click', () => displayCategory(button.innerText));
//   });
// });