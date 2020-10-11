
  Given('I visit the new item page') do
    visit '/items/new'
  end

  Given('I fill in Key with {string}') do |value|
    find("#item_key").set value
    #find('#item_value').set value
  end

  Given('I fill in Value with {string}') do |value|
    find("#item_value").set value
    #find('#item_value').set value
  end

  Given('click on the {string} button') do |add|
    #page.find('input[value=Add]').click
    click_button 'Add'
  end

  Then('the item with key {string} exists') do |key|
    item = Item.find_by(key: key)
    binding.pry
    expect(item).to_not be_nil
  end

  Then('I should be sent to the page {string}') do |string|
    visit '/items'
  end