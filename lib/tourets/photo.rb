module TouRETS
  class Photo

    class << self

      # Find the photo
      # Use find("1234", :id => 1) to find the photo with ID 1 in the 1234 group
      # Default it to return all of the photos.
      def find(matrix_unique_id, opts={})
        photo_id = opts[:id] || "*"
        resource = opts[:resource] || :Property
        [].tap do |photos|
          TouRETS.current_connection.get_object(:resource => resource, :type => :Photo, :id => "#{matrix_unique_id}:#{photo_id}") do |headers, content|
            photos << new(headers, content)
          end
        end
      end

    end

    attr_accessor :id, :resource_id, :content_type, :content

    # id is the ID of the photo
    # resource_id is the ID of the resource it belongs to. Properties will probably be sysid everytime
    # content_type is the Image content_type
    # content is the Binary string that can be written to a file to display the image.
    def initialize(headers, content)
      self.id = headers["object-id"]
      self.resource_id = headers["content-id"]
      self.content_type = headers["content-type"]
      self.content = content
    end

    # Use this method to get the binary string to write to a file.
    # Sometimes the string will contin ASCII-8BIT characters.
    # Forcing to UTF-8 will make it write to a file easier.
    def image
      @image ||= content.to_s.force_encoding("UTF-8")
    end

    # Returns the Base64 string used for images on the web.
    def to_base64
      "data:image/#{extension};base64,#{Base64.encode64(image)}"
    end

    # Returns a filename based on the resource_id and id of the photo
    # should have proper extension on it.
    def filename
      "#{resource_id}-#{id}.#{extension}"
    end

    def extension
      @extension ||= case content_type
      when /jpeg$/, /jpg$/ then "jpg"
      when /png$/ then "png"
      when /gif$/ then "gif"
      else "jpg"
      end
      @extension
    end

  end
end
