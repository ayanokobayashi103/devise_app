class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :active_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :passive_relationships, foreign_key: 'followed_id', class_name: 'Relationship', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :confirmable

         #指定のユーザをフォローする
       def follow!(other_user)
         active_relationships.create!(followed_id: other_user.id)
       end
       #フォローしているかどうかを確認する
       def following?(other_user)
         active_relationships.find_by(followed_id: other_user.id)
       end
       #指定のユーザのフォローを解除する
       def unfollow!(other_user)
         active_relationships.find_by(followed_id: other_user.id).destroy
       end
end
