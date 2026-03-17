require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    driven_by(:rack_test)
  end

# 2.userのテストケース
# 2.1.ﾛｸﾞｲﾝ前
# 2.1.1.ユーザ新規登録
  it 'フォームの入力値が正常なら登録成功' do
    user = build(:user)
    visit new_user_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    expect { click_button 'SignUp' }.to change(User, :count).by(1)
  end

  it 'メールアドレスが未入力なら登録失敗' do
    visit new_user_path
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    expect { click_button 'SignUp' }.to change(User, :count).by(0)
  end

  it '登録済みのメールアドレスを入力するなら登録失敗' do
    user = create(:user)
    visit new_user_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    expect { click_button 'SignUp' }.to change(User, :count).by(0)
  end

# 2.1.2. マイページ遷移
  it 'ログイン前ならアクセス失敗' do
    user = create(:user)
    visit edit_user_path(user)
    expect(current_path).to eq login_path
  end

# 2.2.ﾛｸﾞｲﾝ後
# 2.2.1.ユーザ編集
  it 'フォームの入力値が正常なら編集成功' do
    user = create(:user)
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Login'
    visit edit_user_path(user)
    fill_in 'Email', with: 'user1@example.com'
    click_button 'Update'
    expect(user.reload.email).to eq 'user1@example.com'
  end

  it 'メールアドレスが未入力なら編集失敗' do
    user = create(:user)
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Login'
    visit edit_user_path(user)
    fill_in 'Email', with: ''
    click_button 'Update'
    expect(user.reload.email).to eq user.email
  end

  it '登録済みのメールアドレスを入力するなら編集失敗' do
    create(:user, email: 'user1@example.com', password: 'password1', password_confirmation: 'password1')
    user = create(:user, email: 'user2@example.com', password: 'password2', password_confirmation: 'password2')
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password2'
    click_button 'Login'
    visit edit_user_path(user)
    fill_in 'Email', with: 'user1@example.com'
    click_button 'Update'
    expect(user.reload.email).to eq 'user2@example.com'
  end

  it '自分以外のユーザー編集ページに遷移するならアクセス失敗' do
    user2 = create(:user, email: 'user1@example.com', password: 'password1', password_confirmation: 'password1')
    user  = create(:user, email: 'user2@example.com', password: 'password2', password_confirmation: 'password2')
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password2'
    click_button 'Login'
    visit edit_user_path(user2)
    expect(current_path).to eq user_path(user)
  end

# 2.2.2. マイページ遷移
  it 'タスクを作成後、作成したタスクが表示される' do
    user = create(:user)
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Login'
    visit new_task_path
    fill_in 'Title', with: 'テストタスク'
    expect { click_button 'Create Task' }.to change(Task, :count).by(1)
    visit tasks_path
    click_link 'Show'
    expect(current_path).to eq task_path(Task.last)
    expect(page).to have_content 'テストタスク'
  end

end