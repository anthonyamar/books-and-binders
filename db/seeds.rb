5.times do |u|
  user = User.create!(
    email: "user_#{u + 1}@mylibrary.co",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    username: Faker::Artist.name,
    password: "password")
  puts "Create user n°#{u}"
  puts "=================="
  rand(100..200).times do |b|
    puts "Create book n°#{b}"
    Book.create!(
      title: Faker::Book.title,
      author: Faker::Book.author,
      editor: Faker::Book.publisher,
      price: rand(1.1..450.0).round(2),
      release_date: Faker::Date.between(from: 400.years.ago, to: Date.today),
      buyed_at: Faker::Date.between(from: 5.years.ago, to: 3.years.ago),
      started_at: Faker::Date.between(from: 2.years.ago, to: 1.years.ago),
      finished_at: Faker::Date.between(from: 1.years.ago, to: 6.months.ago),
      read: [true, true, false, false, false].sample,
      page_count: rand(50..700),
      buying_condition: rand(0...Book.buying_conditions.size),
      buyed_from: Faker::Restaurant.name,
      actual_condition: rand(0...Book.actual_conditions.size),
      book_type: rand(0...Book.book_types.size),
      binding: rand(0...Book.bindings.size),
      language: I18n.t("languages").sample,
      category: I18n.t("categories").sample,
      summary: Faker::Hipster.paragraph(sentence_count: rand(2..8)),
      user_id: user.id)
  end
  
end