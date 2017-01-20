feature 'User creates a post' do
  # SUCCESSFUL TESTS
  scenario 'they see a flash message and see the post appear.' do
    should_create_a_post
    should_see_flash_message 'Success! Your post has been created.'
  end

  # UNSUCCESSFUL TESTS
  scenario 'the post is too long, so they get an error.' do
    when_a_user_tries_to_submit 'Mr. and Mrs. Dursley, of number four,
      Privet Drive, were proud to say that they were perfectly normal,
      thank you very much. They were the last people you\'d expect to
      be involved in anything strange or mysterious, because they just
      didn\'t hold with such nonsense.'
    should_see_message 'Message is too long
                                    (maximum is 150 characters)'
  end

  scenario 'the post is empty, so they get an error.' do
    when_a_user_tries_to_submit ''
    should_see_message 'Message can\'t be blank'
  end
end

feature 'The list of posts' do
  # SUCCESSFUL TESTS
  scenario 'should be ordered in descresing chronological order' do
    snd_post = 'Msg 2'
    should_create_a_post 'Msg 1'
    should_create_a_post snd_post
    post_should_be_on_top snd_post
  end

  # UNSUCCESSFUL TESTS
  scenario 'should show a message when that list is empty' do
    visit '/'
    should_show_empty_list_message
  end
end

feature 'User deletes a post' do
  # SUCCESSFUL TESTS
  scenario 'the deletion should show a message upon success' do
    should_create_a_post
    should_delete_first_post
    should_see_flash_message 'Success! You\'ll never see that post again.'
    should_show_empty_list_message
  end
end

private

# Helper method below to reduce code duplication
def when_a_user_tries_to_submit(msg)
  visit '/'
  find('#form_post_text > textarea').set msg
  click_button 'Post!'
end

def should_create_a_post(msg = 'Hello World.')
  when_a_user_tries_to_submit msg
  should_see_message msg
  should_see_message 'posted less than a minute ago.'
end

def should_see_message(msg)
  expect(page).to have_content msg
end

def should_see_flash_message(msg)
  expect(find('.notifications')).to have_content msg
end

def should_show_empty_list_message
  should_see_message 'Your timeline seems to be empty!
                                Write something in the form above.'
end

def post_should_be_on_top(msg)
  post = (page.all '.post_message')[0]
  expect(post).to have_content msg
end

def should_delete_first_post
  assert_same(1, (page.all '.post_message').length)
  # since there is only one element, there should only be one delete button
  click_button 'Delete'
end
