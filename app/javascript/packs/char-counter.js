document.addEventListener("DOMContentLoaded", setup);

function setup(){
  const textArea = document.querySelector('.form__contentTextform');
  countCharacters(textArea); //コメント失敗時(render時)に文字数を再度カウント
  textArea.addEventListener('input', function() {
    countCharacters(textArea);
  });
}

function countCharacters(textArea) {
  const charCount = document.getElementById('charCount');
  const currentLength = textArea.value.length;
  console.log(currentLength);
  const maxLength = 100;
  charCount.innerText = `${currentLength}/${maxLength} 文字`
  if(maxLength - currentLength < 0){
    charCount.style.color = '#f68084';
  }else{
    charCount.style.color = '#CEA0C1';
  }
}
