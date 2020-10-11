
  Given('I visit the url {string}') do |path|
    visit path
  end

  Given('I fill in field {string} with {string}') do |element_id, value|
    find(element_id).set value
  end

  Given('click on the {string} button') do |add|
    click_button add
  end

  Then('the item with key {string} exists') do |key|
    item = Item.find_by(key: key)
    expect(item).to_not be_nil
  end

  Then('The current url should be {string}') do |path|
    expect(page).to have_current_path(path)
  end