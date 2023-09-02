namespace :myturn do
  desc "Export all B and C items to CSV format"
  task export_items: :environment do
    now = Time.current.rfc3339
    path = Rails.root + "exports" + "myturn-items-#{now}.csv"
    puts "writing items to #{path}"
    headers = [
      "Item ID",
      "Item Type",
      "Status(es)",
      "Name",
      "Additional Image",
      "Agreement that must be signed to checkout the item",
      "Amount / Fee",
      "Attachment",
      "Author",
      "Between Buffer Days",
      # 10
      "Categories",
      "Color",
      "Condition",
      "Daily Late Fee",
      "Date Purchased",
      "Default Loan Length",
      "Default Scheduled Maintenance Plan",
      "Description",
      "Dimensions (WxHxD)",
      "Eco Rating",
      # 20
      "Embodied Carbon",
      "Emission Factor",
      "Featured",
      "Floating",
      "Goes Home",
      "Grace period on late fees (in days)",
      "Historical Cost",
      "Image",
      "Keywords",
      "Location Code",
      # 30
      "Maintenance",
      "Maintenance Plan After Each Checkin",
      "Manufacturer",
      "Max Frequency",
      "Max Frequency Units",
      "Max Output",
      "Maximum number of renewals",
      "Maximum number that may be reserved",
      "Maximum percentage of inventory that may be reserved",
      "Maximum Reservation Length",
      # 40
      "Min Frequency",
      "Min Frequency Units",
      "Model",
      "Now Buffer Days",
      "Post-Description Text",
      "Pre-Description Text",
      "Price to Purchase",
      "Product Code / UPC",
      "Publisher",
      "Purchased",
      # 50
      "Replacement Cost",
      "Serial Number",
      "Size",
      "Source / Supplier",
      "Tax(es)",
      "Transfer Buffer Days",
      "Weight",
      "Date Created",
      "Date Last Edited",
      "Date Last Updated"
    ]

    CSV.open(path, "wb", headers: headers, write_headers: true) do |csv|
      Item
        .joins(:borrow_policy)
        .includes(:category_nodes)
        .where("borrow_policies.code = 'B' OR borrow_policies.code = 'C'")
        .limit(100)
        # .in_batches(of: 100) do |items|
        # items.each do |item|
        .each do |item|
          row = CSV::Row.new(headers, [])
          row["Item ID"] = item.number
          row["Item Type"] = item.myturn_item_type
          row["Name"] = item.name

          # strip html
          row["Description"] = item.description

          if item.image
            row["Image"] = "https://ik.imagekit.io/sac4wk7wt3/#{item.image.blob.key}"
          end

          row["Manufacturer"] = item.brand
          row["Model"] = item.model
          # Not sure the difference between these
          row["Replacement Cost"] = item.purchase_price&.format
          row["Price to Purchase"] = item.purchase_price&.format

          row["Size"] = item.size
          row["Serial Number"] = item.serial
          row["Replacement Cost"] = item.purchase_price&.format

          csv << row
        end
    end
  end
end

desc "Export members for import into MyTurn"
task export_members: :environment do
  now = Time.current.rfc3339
  path = Rails.root + "exports" + "myturn-members-#{now}.csv"
  puts "writing memberss to #{path}"
  headers = [
    "Customer ID",
    "First Name",
    "Last Name",
    "Email",
    "Confirmed?",
    "Unconfirmed Email",
    "Username",
    "Title",
    "Organization",
    "Address",
    "Address2",
    "City",
    "State/Province",
    "Postal Code",
    "Country",
    "Phone",
    "Alt. Phone",
    "Address Notes",
    "Sex",
    "Age",
    "Secondary First Name",
    "Secondary Last Name",
    "Secondary Email",
    "Secondary Title",
    "Secondary Organization",
    "Secondary Address",
    "Secondary Address2",
    "Secondary City",
    "Secondary State/Province",
    "Secondary Postal Code",
    "Secondary Country",
    "Secondary Phone",
    "Secondary Alt. Phone",
    "Secondary Address Notes",
    "Member Created (M/D/YYYY)",
    "Start of first full membership (M/D/YYYY)",
    "Current Membership Type",
    "Latest Membership Change (request, upgrade, renewal, cancellation...) (M/D/YYYY)",
    "Current Membership Expiration (M/D/YYYY)",
    "Renews Automatically",
    "Automatically Pay Statements",
    "User Note",
    "User Warning",
    "Opening Balance",
    "Opening Balance Date (M/D/YYYY)",
    "Pronouns",
    "Custom Pronoun", "
      Name Pronunciation",
    "Preferred Name"
  ]

  Member
    # .where()
    .limit(100)
    # .in_batches(of: 100) do |items|
    # items.each do |item|
    .each do |m|
    row = CSV::Row.new(headers, [])
    row["Customer ID"] = m.id

    row["First Name"] = m.full_name.split[0]
    row["Last Name"] = m.full_name.split[1..].join(" ")
    row["Email"] = m.email
    row["Confirmed?"] = m.
      # row["Unconfirmed Email"] = m.
      row["Username"] = m.number
    # row["Title"] = m.
    # row["Organization"] = m.
    row["Address"] = m.address1
    row["Address2"] = m.address2
    row["City"] = m.city
    row["State/Province"] = m.region
    row["Postal Code"] = m.postal_code
    row["Country"] = "United States"
    row["Phone"] = m.phone_number
    # row["Alt. Phone"] = m.
    # row["Address Notes"] = m.
    # row["Sex"] = m.
    # row["Age"] = m.
    # row["Secondary First Name"] = m.
    # row["Secondary Last Name"] = m.
    # row["Secondary Email"] = m.
    # row["Secondary Title"] = m.
    # row["Secondary Organization"] = m.
    # row["Secondary Address"] = m.
    # row["Secondary Address2"] = m.
    # row["Secondary City"] = m.
    # row["Secondary State/Province"] = m.
    # row["Secondary Postal Code"] = m.
    # row["Secondary Country"] = m.
    # row["Secondary Phone"] = m.
    # row["Secondary Alt. Phone"] = m.
    # row["Secondary Address Notes"] = m.
    row["Member Created (M/D/YYYY)"] = m.created_at.to_s(:short)
    row["Start of first full membership (M/D/YYYY)"] = m
      .row["Current Membership Type"] = m
        .row["Latest Membership Change (request, upgrade, renewal, cancellation...) (M/D/YYYY)"] = m
          .row["Current Membership Expiration (M/D/YYYY)"] = m
            .row["Renews Automatically"] = m
              .row["Automatically Pay Statements"] = m
                .row["User Note"] = m
                  .row["User Warning"] = m.
                    # row["Opening Balance"] = m.
                    # row["Opening Balance Date (M/D/YYYY)"] = m.
                    row["Pronouns"] = m.pronouns
    row["Custom Pronoun"] = m
      .row["Name Pronunciation"] = m.pronun
    row["Preferred Name"] = m.preferred_name
  end

  def update_myturn_item_type(row)
    id = row["id"]
    item = Item.find(id)

    myturn_item_type = row["myturn_item_type"]&.strip

    unless myturn_item_type.blank?
      item.myturn_item_type = myturn_item_type
      item.save!
    end

    puts "updated item #{id}"
  rescue ActiveRecord::RecordNotFound => e
    puts e.inspect
  end

  desc "Import item types into database"
  task import_item_types: :environment do
    path = ENV["CSV_FILE"]
    user = User.find_by(email: ENV["AUTHOR"])

    raise "author not found!" unless user

    library = Library.find(ENV["LIBRARY_ID"])

    CSV.foreach(path, headers: true) do |row|
      Audited.audit_model.as_user(user) do
        ActsAsTenant.with_tenant(library) do
          update_myturn_item_type(row)
        end
      end
    end
  end
end
