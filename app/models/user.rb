class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  scope :all_except, ->(user){where.not(id:user)}
  validates :username, presence: true
  has_one_attached :avatar


  after_create_commit {broadcast_append_to "users", target: "users",partial: "users/user", locals: { user: self } }
  after_update_commit do
    broadcast_replace_to  "user_status", partial: "users/status", user: self
    broadcast_replace_to  "sidebar_user_status", partial: "users/sidebar_status", user: self
  end
end
