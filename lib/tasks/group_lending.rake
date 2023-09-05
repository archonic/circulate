namespace :group_lending do
  desc "create some dev data for group lending"
  task :devdata => :environment do
    user = User.find(1)

    reservation = Reservation.create!(
      started_at: 1.week.since, 
      ended_at: 2.weeks.since,
      reserver: user,
    )

    pool = ItemPool.create!(name: "Shovels")
    5.times do |n|
      item = Item.create!(name: "Shovel #{n}", number: Item.next_number, item_pool: pool, borrow_policy: BorrowPolicy.default, library_id: 1)
      reservation.line_items.create!(reservable: item, creator: user)
    end

  end
end