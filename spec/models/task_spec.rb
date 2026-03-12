require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'バリデーションチェック' do
    it '設定したすべてのバリデーションが機能しているか（titleとstatusがあること、titleが被ってないこと）' do end
  
  # 残りのテストパターンを書いていく
    it 'titleが被らない場合にバリデーションエラーが起きないか' do end
    it 'titleがない場合にバリデーションが機能してinvalidになるか' do end
    it 'statusがない場合にバリデーションが機能してinvalidになるか' do end
    it 'titleが被った場合にuniqueのバリデーションが機能してinvalidになるか' do end

  end
end