feature 'Post' do
  scenario 'Post is empty' do
    when_a_user_tries_to_submit_an_empty_post
    they_cant_post_the_messaage
  end

  def when_a_user_tries_to_submit_an_empty_post
    visit '/'
    click_button 'Create Post'
  end

  def they_cant_post_the_messaage
    expect(page).to have_content 'Message can\'t be blank'
  end
end
