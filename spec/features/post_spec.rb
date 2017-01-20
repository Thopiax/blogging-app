feature 'Post' do
  scenario 'Post is empty' do
    when_a_user_tries_to_submit_an_empty_post
    they_can_sign_up_to_the_acme_newsletter
  end

  def when_a_user_tries_to_submit_an_empty_post
    visit '/'
    click_button 'Post'
  end

  def they_cant_post_the_messaage
    expect(page).to have_content 'Your Message can\'t be empty!'
  end
end
