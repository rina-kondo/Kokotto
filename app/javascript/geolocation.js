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
      formData.append('image', inputImage.files[0]);
      formData.append('latitude', lat);
      formData.append('longitude', lng);

      const response = await fetch('/posts',{
        method: 'POST',
        headers: {
          'X-CSRF-Token': document.querySelector("meta[name=csrf-token]").content
        },
        body: formData
      });

      if (!response.ok) throw new Error('Network response was not ok');

      const data = await response.json();
      console.log(data.message);
      window.location.href = '/posts';

    } catch (error) {
      alert('失敗しました。');
      console.error('Error:', error);
    }
  };
};

function getCurrentPosition(options = {}) {
  return new Promise((resolve, reject) => {
    navigator.geolocation.getCurrentPosition(resolve, reject, options);
  });
}