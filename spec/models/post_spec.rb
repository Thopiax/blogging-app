RSpec.describe Post, type: :model do
  it do
    should validate_presence_of(:message) # test if it is not empty
    should validate_length_of(:message) # and less than 150 characters
      .is_at_most(150)
  end
end
