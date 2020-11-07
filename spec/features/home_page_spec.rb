feature 'Viewing home page' do
  scenario 'visiting the homepage redirect' do
    visit('/')
    expect(page).to have_content "Chitter"
  end
end
