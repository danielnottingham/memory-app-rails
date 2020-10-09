
  Given('I visit the new item page') do
    visit '/items/new'
  end

  Given('I fill in {string} with {string}') do |key, value|
    find('input[id=item_key]').set key
    find('#item_value').set value
    sleep 1
  end

  Given('click on the {string} button') do |add|
    #page.find('input[value=Add]').click
    click_button 'Add'
    sleep 1
  end

  Then('the number of existent items should be increased by one') do
    
  end

  Then('I should be sent to the page {items}') do |string|
    redirect_to '/items'
  end