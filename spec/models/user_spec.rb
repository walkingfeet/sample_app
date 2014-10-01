require 'spec_helper'

describe User do

  before { @user = User.new(name:"Example User", email:"user@example.com",
                           password: "foobar", password_confirmation: "foobar") }

  subject{ @user}

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it {should be_valid}

  describe "When name is not present" do
    before { @user.name = " "}
    it { should_not be_valid }
  end

  describe "When email is not present" do
    before { @user.email = " "}
    it { should_not be_valid }
  end

  describe "When name.lenght more then 50" do
    before {@user.name="a" * 51}
    it { should_not be_valid }
  end

  describe "When email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_roo.org example.user@foo.foo@bar_baz.com foo@bar+bas.com .@. foo@bar..com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "When email is valid" do
    it "should be valid" do
      addresses = %w[user@foo.com user_at_roo@s.org example.user@foo.foo foo@bar.com edu@edu.hse.ru]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "When email is not unique" do
    before do
      user_with_same_parameters = @user.dup
      user_with_same_parameters.email = @user.email.upcase
      user_with_same_parameters.save
    end
    it { should_not be_valid}
  end

  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

end
