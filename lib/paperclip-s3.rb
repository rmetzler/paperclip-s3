require 'paperclip'
require 'paperclip-s3/version'
require 'paperclip-s3/railtie'


module Paperclip
  module S3
    
    # Use Paperclip::S3::Glue to keep the original gems style
    module Glue
      def self.included base
        base.extend ClassMethods
      end
    end
        
    module ClassMethods
      # Extends the paperclips has_attached_file method
      # It will use S3 Storage. The credentials will be read from the environment
      def has_attached_file(name, options = {})
        options[:storage] = :s3
        options[:path]    ||= "/:class-:attachment/:id/:style-:basename.:extension"
        options[:bucket]  ||= ENV["S3_BUCKET"]
        options[:url]     ||= ENV["S3_URL"]
        options[:s3_credentials] ||= {
                                        :access_key_id => ENV['S3_KEY'],
                                        :secret_access_key => ENV['S3_SECRET']
                                    }
        super(name, options)
      end
    end
  end
end