# == Schema Information
#
# Table name: microposts
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Micropost < ActiveRecord::Base
  attr_accessible :content

  validates :content, :length => { :minimum => 1, :maximum => 140 }
  validates :user_id, :presence => true

  belongs_to :user

  default_scope :order => 'microposts.created_at desc'
 
  def self.from_users_followed_by(user)
    followed_user_ids=user.followed_user_ids;
    where("user_id in (:followed_user_ids) or user_id = :user_id",
          :followed_user_ids =>  followed_user_ids, 
          :user_id => user)
  end
end
