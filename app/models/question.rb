class Question < ActiveRecord::Base
  attr_accessor :tag_string
  attr_protected :user_id
  validates_presence_of :content, :message => " of question should not be blank."
  validates :content, :length => { :maximum => 5000 }
  has_many :answers, :dependent => :destroy
  has_and_belongs_to_many :tags
  belongs_to :user
  
  def tag_string=(string)
    tag_names = string.split(',').compact.collect{|x| x.gsub(/\s+/, " ").strip.downcase unless x.strip.empty? }
    tags.clear
    for tag_name in tag_names.compact[0..9]
      self.tags << Tag.find_or_create_by_name(tag_name)
    end
  end
  
  def tag_string
    (tags.collect{ |t| t.name }).join ', '
  end
end
