require 'rails_helper'
RSpec.describe "UserSessions", type: :system do
  before do
    driven_by(:rack_test)
  end

# 1.1. ログイン前  ページ遷移確認
  it 'ログイン前はタスク新規登録ページにアクセスできない' do
    visit new_task_path
    expect(current_path).to eq login_path
  end
  it 'タスクの編集ページにアクセス => アクセス失敗' do
    task = create(:task)
    visit edit_task_path(task)
    expect(current_path).to eq login_path
  end
  it 'タスクの詳細ページにアクセスならタスク詳細情報が表示される' do
    task = create(:task)
    visit task_path(task)
    expect(current_path).to eq task_path(task)
    expect(page).to have_content task.title
  end
  it 'タスク一覧ページにアクセスならタスク一覧が表示される' do
    task = create(:task)
    visit tasks_path
    expect(current_path).to eq tasks_path
  end

# 1.2. ログイン後  
# 1.2.1. タスクの新規登録 
  it 'フォームの入力値が正常なら登録成功' do
    user = create(:user)
    task = create(:task, user: user)
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Login'
    visit new_task_path
    fill_in 'Title', with: 'テストタスク'
    expect { click_button 'Create Task' }.to change(Task, :count).by(1)
  end
  it 'タイトルが未入力なら登録失敗' do
    user = create(:user)
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Login'
    visit new_task_path  # 追加
    expect { click_button 'Create Task' }.to change(Task, :count).by(0)
  end
  it '登録済のタイトルを入力値するなら登録失敗' do
    user = create(:user)
    task = create(:task, user: user)
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Login'
    visit new_task_path
    fill_in 'Title', with: 'テストタスク'
    click_button 'Create Task'
    visit new_task_path
    fill_in 'Title', with: 'テストタスク'
    expect { click_button 'Create Task' }.to change(Task, :count).by(0)
  end

  # 1.2.2. タスクの編集 
  it 'フォームの入力値が正常なら編集成功' do
    user = create(:user)
    task = create(:task, user: user)  # 修正
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Login'
    visit edit_task_path(task)
    fill_in 'Title', with: '編集タイトル'
    click_button 'Update Task'
    expect(page).to have_content '編集タイトル'
  end
  it 'タイトルが未入力なら編集失敗' do
    user = create(:user)
    task = create(:task, user: user)  # 修正
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Login'
    visit edit_task_path(task)
    click_button 'Update Task'
    expect(task.reload.title).not_to eq ''  # 修正
  end
  it '登録済みのタイトルを入力するなら編集失敗' do
    user = create(:user)
    create(:task, title: '既存タスク', user: user)  # 修正
    task = create(:task, title: 'テストタスク', user: user)  # 修正
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Login'
    visit edit_task_path(task)
    fill_in 'Title', with: '既存タスク'
    click_button 'Update Task'
    expect(task.reload.title).to eq 'テストタスク'
  end

  # 1.3. タスクの削除 
  # it 'タスク削除するなら削除成功', js: true do
  #   user = create(:user)
  #   create(:task, title: '既存タスク', user: user)
  #   visit login_path
  #   fill_in 'Email', with: user.email
  #   fill_in 'Password', with: 'password'
  #   click_button 'Login'
  #   visit tasks_path
  #   expect { page.accept_confirm { click_link 'Destroy' } }.to change(Task, :count).by(-1)
  # end

  it 'タスク削除するなら削除成功' do
    user = create(:user)
    create(:task, title: '既存タスク', user: user)
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Login'
    visit tasks_path
    expect { click_link 'Destroy' }.to change(Task, :count).by(-1)
  end

end