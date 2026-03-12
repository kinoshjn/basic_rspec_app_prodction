require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'バリデーションチェック' do
    it '設定したすべてのバリデーションが機能しているか（titleとstatusがあること、titleが被ってないこと）' do
      user = create(:user)
      task = build(:task, user: user, title: "bbb")   # ← build（保存しない）
      expect(task).to be_valid
      expect(task.errors).to be_empty
     end

    it 'titleが被らない場合にバリデーションエラーが起きないか' do
      user = create(:user)
      task = create(:task, user: user, title: "aaa")  # ← create（DBに保存）
      task = build(:task, user: user, title: "bbb")   # ← build（保存しない）
      expect(task).to be_valid
      expect(task.errors).to be_empty
    end

    it 'titleがない場合にバリデーションが機能してinvalidになるか' do
      user = create(:user)
      task = build(:task, user: user, title: nil)   # ← build（保存しない）
      expect(task).to be_invalid
    end

    it 'statusがない場合にバリデーションが機能してinvalidになるか' do
      user = create(:user)
      task = build(:task, user: user, title: "bbb", status: nil)   # ← build（保存しない）
      expect(task).to be_invalid
    end

    it 'titleが被った場合にuniqueのバリデーションが機能してinvalidになるか' do
      user = create(:user)
      task = create(:task, user: user, title: "aaa")  # ← create（DBに保存）
      task = build(:task, user: user, title: "aaa")   # ← build（保存しない）
      expect(task).to be_invalid
    end

  end
end