document.addEventListener("DOMContentLoaded", function(){
  const btn = document.querySelector('.notification-button');
  btn.addEventListener('click', fetchNotificationData);
});

async function fetchNotificationData() {
  try {
    const response = await fetch('/notifications/modal');
    const data = await response.json();
    createModal(data);
  } catch (error) {
    console.error("Error fetching notifications:", error);
  }
}

function createModal(data) {
  const main = document.querySelector('.main');
  const fragment = document.createDocumentFragment();

  const modalBackground = document.createElement('div');
  modalBackground.classList.add('modal-background');
  modalBackground.id = 'modal-background';
  modalBackground.addEventListener('click', deleteModal);

  const notificationModal = document.createElement('div');
  notificationModal.classList.add('notification__modal');
  const title = document.createElement('h3');
  title.innerText = "お知らせ";
  notificationModal.appendChild(title);

  if (data.length === 0) {
    const noNotificationsText = document.createElement('p');
    noNotificationsText.innerText = "通知はありません";
    notificationModal.appendChild(noNotificationsText);
  } else {

    data.forEach(item => {
      const link = document.createElement('a');
      link.href = `/posts/${item.post_id}`;
      const notificationCard = document.createElement('div');
      notificationCard.classList.add('notification__card');

      const text = document.createElement('div');
      text.innerText = `あなたの投稿が${item.action}されました!`;

      const time = document.createElement('div');
      const timeText = document.createElement('span');
      timeText.innerText = item.date;

      const timeIcon = document.createElement('i');
      timeIcon.classList.add("fa-regular", "fa-clock");

      time.appendChild(timeIcon);
      time.appendChild(timeText);
      notificationCard.appendChild(text);
      notificationCard.appendChild(time);
      link.appendChild(notificationCard);
      notificationModal.appendChild(link);
    });
  }

  const notificationLink = document.createElement('a');
  notificationLink.innerText = "通知一覧をみる";
  notificationLink.href = "/notifications";
  notificationLink.classList.add("notification__index-link");
  notificationModal.appendChild(notificationLink);

  fragment.appendChild(modalBackground);
  fragment.appendChild(notificationModal);
  main.appendChild(fragment);
}

function deleteModal() {
  const modalBackground = document.getElementById("modal-background");
  modalBackground?.remove();

  const notificationModal = document.querySelector(".notification__modal");
  notificationModal?.remove();
}