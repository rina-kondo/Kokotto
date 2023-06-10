
window.onload = function () {
  document.getElementById("btn").onclick = function(){
    navigator.geolocation.getCurrentPosition(success,fail);
  };
}

function success(pos){
  const input_text = document.getElementById('input_text').value;
  const input_image = document.getElementById('input_image').files[0];
  const lat = pos.coords.latitude;
  const lng = pos.coords.longitude;
  console.log(input_text);
  console.log(lat);
  console.log(lng);

  let form_data = new FormData();
  form_data.append('text', input_text);
  form_data.append('image', input_image);
  form_data.append('latitude', lat);
  form_data.append('longitude', lng);

  const body = form_data;

  fetch('/posts',{
      method: 'POST',
      headers: {
        'X-CSRF-Token': document.querySelector("meta[name=csrf-token]").content
      },
      body: body
    }
  ).then((res) => res.json())
  .then((data) => {
    console.log(data.message);
  }).catch((error) =>{
    alert('失敗しました。');
  })
}

function fail(pos){
 alert('位置情報の取得に失敗しました。');
}