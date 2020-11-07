feature 'Viewing home page' do
  scenario 'visiting the homepage redirect' do
    visit('/')
    fill_in :content, with: "hello"
    fill_in :author, with: "@obama"
    click_button('Send Chirp')
    expect(page).to have_content "Chitter"
    expect(page).to have_content "obama"
    expect(page).to have_content "hello"
  end
end
