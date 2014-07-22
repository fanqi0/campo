require 'carrierwave/processing/mini_magick'
IMAGE_UPLOADER_ALLOW_IMAGE_VERSION_NAMES = %(normal bigger)
class AvatarUploader < CarrierWave::Uploader::Base
  def store_dir
    "#{model.class.to_s.underscore}/#{mounted_as}"
  end

  def url(version_name = "")
    @url ||= super({})
    version_name = version_name.to_s
    return @url if version_name.blank?
    if not version_name.in?(IMAGE_UPLOADER_ALLOW_IMAGE_VERSION_NAMES)
      # 故意在调用了一个没有定义的“缩略图版本名称”的时候抛出异常，以便开发的时候能及时看到调错了
      raise "AvatarUploader version_name:#{version_name} not allow."
    end
    [@url,version_name].join("!") # 我这里在图片空间里面选用 ! 作为“间隔标志符”
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end

