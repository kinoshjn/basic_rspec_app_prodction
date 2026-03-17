require 'rails_helper'

RSpec.describe "UserSessions", type: :system do
  before do
    driven_by(:rack_test)
  end

# 3.userのテストケース
# 3.1.ﾛｸﾞｲﾝ前
  it 'フォームの入力値が正常ならログイン処理が成功する' do
    user = create(:user)
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Login'
    expect(current_path).to eq root_path  # ログイン後のリダイレクト先を確認
  end
  it 'フォームの値が未入力ならログイン失敗' do
    user = create(:user)
    visit login_path
    click_button 'Login'
    expect(current_path).to eq login_path
  end

# 3.2.ﾛｸﾞｲﾝ後
  it 'ログアウトボタンクリックするならログアウトされる' do
    user = create(:user)
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Login'
    click_link 'Logout'
    expect(current_path).to eq root_path
  end

end
