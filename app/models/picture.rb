class Picture < ActiveRecord::Base

	belongs_to :imageable, :polymorphic => true

	has_attached_file :image,
                  :url  => "/assets/products/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/products/:id/:style/:basename.:extension"

	validates_attachment_presence :image	
	validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif']

end
