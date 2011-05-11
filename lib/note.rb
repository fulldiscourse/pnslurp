require 'active_resource'

class Note < ActiveResource::Base

    
  def self.yaml
    YAML.load_file('slurper_config.yml')
  end

  def self.config
    @@config = yaml
    scheme =  if !!@@config['ssl']
                self.ssl_options = {  :verify_mode => OpenSSL::SSL::VERIFY_PEER,
                                      :ca_file => File.join(File.dirname(__FILE__), "cacert.pem") }
                "https"
              else
                "http"
              end
    host = @@config['host'] || "www.projectnotifier.com"
    self.site = "#{scheme}://#{host}/accounts/#{@@config['account']}/projects/#{@@config['project']}"
    self.user = @@config["token"]
    Note.format = :json
    @@config
  end


  def prepare
    scrub_description
    default_tags
  end

  protected

  def scrub_description
    if respond_to?(:description)
      self.description = description.gsub("  ", "").gsub(" \n", "\n")
    end
    if respond_to?(:description) && description == ""
      self.attributes["description"] = nil
    end
  end

  def default_tags
    if (!respond_to?(:tag_list) || tag_list == "") && Note.config["default_tags"]
      self.attributes["tag_list"] = Note.config["default_tags"]
    end
  end

end
