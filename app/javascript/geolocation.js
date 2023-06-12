window.onload = function () {
  const btn = document.getElementById("btn");
  const inputText = document.getElementById('input_text');
  const inputImage = document.getElementById('input_image');

  btn.onclick = async function() {
    try {
      const pos = await getCurrentPosition();
      const lat = pos.coords.latitude;
      const lng = pos.coords.longitude;

      console.log(inputText.value, lat, lng);

      const formData = new FormData();
      formData.append('text', inputText.value);
      if (inputImage.files.length > 0) {
        formData.append('image', inputImage.files[0]);
      }
      formData.append('latitude', lat);
      formData.append('longitude', lng);

      const response = await fetch('/posts',{
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
        console.error(data.message);

        const flash = document.querySelector('div.flash')

        flash.innerHTML = ''

        const message = document.createElement('div')
        message.classList.add('flash-message')
        message.innerText = data.message

        flash.appendChild(message)
      }
    } catch (error) {
      console.error('Error:', error);
    }
  };
};

function getCurrentPosition() {
  return new Promise((resolve, reject) => {
    navigator.geolocation.getCurrentPosition(resolve);
  });
}