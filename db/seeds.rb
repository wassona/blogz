alex = User.create username: "alex", email: "alex@alex.alex"
margaret = User.create username: "margaret", email: "margaret@cat.wood"

alex.posts.create(title: "The more posts I make...", body: "the more colors I see!")
alex.posts.create(title: "I like colors!", body: "That is all.")
alex.posts.create(title: "Colors!", body: "Posts come in so many colors!")
alex.posts.create(title: "Front page!", body: "I made it on the front page today!")
alex.posts.create(title: "Title!", body: "Post!")

margaret.posts.create(title: "Today", body: "Today I napped under the Christmas tree")
margaret.posts.create(title: "Cold", body: "It is very cold outside, but I don't know that because I am a cat and never leave the apartment.")
margaret.posts.create(title: "Sleeping", body: "I like it. I don't care for others doing it, though.")
margaret.posts.create(title: "Mice", body: "I love mice. I think. I love mice in concept. Also, I hate them.")
margaret.posts.create(title: "Last night", body: "Last night I did a lot of fighting. There were many enemies I had to fight. Many of them were on the bed. Today I shall sleep well.")

Profile.create(user: alex, body: "This is my profile now, dog.")
Profile.create(user: margaret, body: "~MEOW~!")

alex.leaders.push(margaret)



