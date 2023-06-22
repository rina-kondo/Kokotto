document.addEventListener("DOMContentLoaded", setup);

async function onButtonClick(event) {
  try {
    event.target.disabled = true;
    const pos = await getCurrentPosition();
    const { latitude: lat, longitude: lng } = pos.coords;

    const inputText = document.getElementById('input-text');
    const inputTag = document.querySelector('.select-tag');
    const inputImage = document.getElementById('input-image');

    const formData = new FormData();
    formData.append('text', inputText.value);
    formData.append('tag_name', inputTag.alt);
    formData.append('latitude', lat);
    formData.append('longitude', lng);

    if (inputImage.files.length > 0) {
      formData.append('image', inputImage.files[0]);
    }

    const response = await fetch('/posts', {
      method: 'POST',
      headers: {
        'X-CSRF-Token': document.querySelector("meta[name=csrf-token]").content
      },
      body: formData
    });

    const data = await response.json();

    if (response.ok) {
      console.log(data.message);
      window.location.href = '/posts';
    } else {
      displayFlashMessage(data.message);
    }
  } catch (error) {
    console.error('Error:', error);
  }
}

function displayFlashMessage(message) {
  const flash = document.querySelector('div.flash');
  flash.innerHTML = '';

  const messageDiv = document.createElement('div');
  messageDiv.classList.add('flash-message');
  messageDiv.innerText = message;

  flash.appendChild(messageDiv);
}

function setup() {
  const btn = document.getElementById("btn");
  btn.addEventListener('click', onButtonClick);
}

function getCurrentPosition() {
  return new Promise((resolve) => {
    navigator.geolocation.getCurrentPosition(resolve);
  });
}