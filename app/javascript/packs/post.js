import { Loader } from "@googlemaps/js-api-loader"

document.addEventListener("DOMContentLoaded", setup);

async function setup() {
  // Maps JavaScript APIの読み込み
  const loader = new Loader({
    apiKey: process.env.GOOGLE_MAP_API_KEY,
    version: "quarterly",
  });
  await loader.load();

  const btn = document.getElementById("btn");
  btn.addEventListener('click', onButtonClick);
}

async function onButtonClick(event) {
  toggleLoading(true);
  const btn = event.target;
  try {
    btn.disabled = true;
    const pos = await getCurrentPosition();
    const { lat, lng } = pos;
    const prefectureAndCity = await geocodeLatLng(lat, lng);

    const formData = createFormData({
      text: document.getElementById('input-text').value,
      tag: document.querySelector('.select-tag').alt,
      image: document.getElementById('input-image').files[0],
      lat,
      lng,
      prefectureAndCity
    });

    const data = await sendRequest('/posts', 'POST', formData);
    console.log(data);

    if (data.status === "success") {
      window.location.href = '/posts';
      displayFlashMessage(data.message);
    } else {
      displayFlashMessage(data.message);
    }
  } catch (error) {
    console.error('Error:', error);
    displayFlashMessage("通信に失敗しました");
  } finally {
    btn.disabled = false;
    toggleLoading(false);
  }
}

function toggleLoading(is_inview){
  const loadingScreen = document.querySelector('.loading');
  if (is_inview === true){
    loadingScreen.classList.add('inview');
  }else{
    loadingScreen.classList.remove('inview');
  }
}

function outviewLoading(){
  const loadingScreen = document.querySelector('.loading');
  loadingScreen.classList.add('inview');
}

function createFormData({ text, tag, image, lat, lng, prefectureAndCity }) {
  const formData = new FormData();
  formData.append('text', text);
  formData.append('tag_name', tag);
  formData.append('latitude', lat);
  formData.append('longitude', lng);
  formData.append('prefecture_city', prefectureAndCity);
  if (image) {
    formData.append('image', image);
  }
  return formData;
}

async function sendRequest(url, method, formData) {
  const response = await fetch(url, {
    method,
    headers: {
      'X-CSRF-Token': document.querySelector("meta[name=csrf-token]").content
    },
    body: formData
  });
  return response.json();
}

function displayFlashMessage(message) {
  const flash = document.querySelector('div.flash');
  flash.innerHTML = '';

  const messageDiv = document.createElement('div');
  messageDiv.classList.add('flash-message');
  messageDiv.innerText = message;

  flash.appendChild(messageDiv);
}

function handleError(message) {
  displayFlashMessage(message);
  throw new Error(message);
}

// 緯度経度の取得
function getCurrentPosition() {
  return new Promise((resolve, reject) => {
    // 位置情報を取得可否
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(
        (position) => {
          const pos = {
            lat: position.coords.latitude,
            lng: position.coords.longitude,
          };
          resolve(pos);
        },
        () => handleError("通信に失敗しました")
      );
    } else {
      handleError("お使いのデバイスで位置情報が取得できません");
    }
  });
}

// 緯度経度から住所("都道府県"+"大字・町")を取得
async function geocodeLatLng(lat, lng) {
  const geocoder = new google.maps.Geocoder();
  const latlng = { lat, lng };

  return geocoder.geocode({ location: latlng }).then((response) => {
    if (response.results[0]) {
      const addressComponents = response.results[0].address_components;
      let prefecture = "";
      let city = "";

      for (let i = 0; i < addressComponents.length; i++) {
        if (addressComponents[i].types.includes("administrative_area_level_1")) {
          prefecture = addressComponents[i].long_name;
        }
        if (addressComponents[i].types.includes("locality")) {
          city = addressComponents[i].long_name;
        }
      }

      if (prefecture || city) {
        return prefecture + " " + city;
      } else {
        displayFlashMessage("現在地の取得ができません");
      }
    } else {
      displayFlashMessage("通信に失敗しました");
    }
  })
  .catch((e) => {
    console.log("Geocoder failed due to: " + e);
  });
}