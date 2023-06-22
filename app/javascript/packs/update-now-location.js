document.addEventListener("DOMContentLoaded", onPageLoad);

async function onPageLoad() {
  if (window.name === "reloaded") {
    console.log(window.name);
    return;
  }

  try {
    const pos = await getCurrentPosition();
    const { latitude: lat, longitude: lng } = pos.coords;

    const formData = new FormData();
    formData.append('user[now_latitude]', lat);
    formData.append('user[now_longitude]', lng);

    const response = await fetch(' /user/now_location', {
      method: 'PATCH',
      headers: {
        'X-CSRF-Token': document.querySelector("meta[name=csrf-token]").content
      },
      body: formData
    });

    const data = await response.json();

    if (response.ok) {
      window.location.reload();
      window.name = "reloaded";
    } else {
      displayFlashMessage(data.message);
    }
  } catch (error) {
    console.error('Error:', error);
    displayFlashMessage("通信に失敗しました");
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

function getCurrentPosition() {
  return new Promise((resolve) => {
    navigator.geolocation.getCurrentPosition(resolve);
  });
}