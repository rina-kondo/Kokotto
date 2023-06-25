p '==================== admin create ===================='
Admin.create!(
  name: "admin123456789",
  email: "admin123456789@kokotto.com",
  password: "123456"
)

p '==================== Official user create ===================='
User.create!(
  name: "Official",
  email: "Official123456@kokotto.com",
  password: "awds123456"
)

p '==================== bot tweet create ===================='
Post.create!(
  user_id: 1,
  text: "Kokottoでお出かけをより楽しい体験にしましょう☺️",
  tag_name: "life/celebration",
  latitude: "35.6359322",
  longitude: "139.8786311"
)

Post.create!(
  user_id: 1,
  text: "みなさまの安全を確保するために、自宅などプライバシーのある場所での投稿はお控え下さい",
  tag_name: "feeling/sad",
  latitude: "35.6359322",
  longitude: "139.8786311"
)

Post.create!(
  user_id: 1,
  text: "もちろん道端での出来事をシェアするのも楽しいですね",
  tag_name: "animal/kneadingdog",
  latitude: "35.6359322",
  longitude: "139.8786311"
)

Post.create!(
  user_id: 1,
  text: "観光地、カフェ、学校、スポーツ観戦場など、目的が明確な場所で投稿すると、同じ目的を持つ人々によって投稿が共有されやすくなります",
  tag_name: "hobby/baseball",
  latitude: "35.6359322",
  longitude: "139.8786311"
)

Post.create!(
  user_id: 1,
  text: "あなたのつぶやきは、つぶやいた場所にいる人たちだけが見ることができます！",
  tag_name: "feeling/love",
  latitude: "35.6359322",
  longitude: "139.8786311"
)

Post.create!(
  user_id: 1,
  text: "Kokottoへようこそ！お出かけ先の出来事をつぶやいてシェアしましょう！",
  tag_name: "feeling/heart",
  latitude: "35.6359322",
  longitude: "139.8786311"
)
