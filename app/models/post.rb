class Post < ApplicationRecord
  belongs_to :category, :optional => true
  validates_presence_of :content
  belongs_to :user

  has_many :likes, :dependent => :destroy
  has_many :liked_users, :through => :likes, :source => :user

  def find_like(user)
    self.likes.where( :user_id => user.id ).first
  end

  has_many :collections, :dependent => :destroy
  has_many :collectiond_users, :through => :collections, :source => :user

  def find_collection(user)
    self.collections.where( :user_id => user.id).first
  end

  has_many :scores, :class_name => "PostScore"

  def find_score(user)
    user && self.scores.where( :user_id => user.id ).first
  end

  def average_score
    self.scores.average(:score)
  end
end
