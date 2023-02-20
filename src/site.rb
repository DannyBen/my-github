require 'byebug'
require 'colsole'
require 'digest/md5'
require 'lp'
require 'slim'
require 'yaml'

require_relative 'extensions'

class Site
  include Colsole

  # Main interface

  def reset
    say 'rb`initializing site`'
    system 'rm -rf site'
    system 'mkdir -p site/assets/img'
    system 'mkdir -p site/assets/css'
    copy_assets
  end

  def copy_assets
    say 'b`copying assets`'
    system 'cp -r src/assets/img/*.png site/assets/img/'
    system "cp -r src/assets/css/main.css site/assets/css/main-#{css_fingerprint}.css"
    system 'cp -r src/assets/css/bonsai.min.css site/assets/css/'
    system 'cp src/files/* site/'
  end

  def generate_pages
    repos_by_tag.each do |tag, repos|
      tag_name = tags[tag]
      abort "No title for #{tag}" unless tag_name

      filename = "site/#{tag}/index.html"
      say "g`#{filename.ljust 42}` m`#{tag_name}` (#{repos.count})"

      @tag = tag
      @tag_name = tag_name
      @repos = repos
      output = slim 'page', layout: true
      File.deep_write filename, output
    end
  end

  def generate_index
    say 'g`site/index.html`'
    @tag_name = nil
    File.deep_write 'site/index.html', slim('index', layout: true)
  end

  # Internal

  def slim(name, layout: false)
    result = Slim::Template.new("src/views/#{name}.slim", pretty: true).render(self)
    return result unless layout

    layout_template.render(self) { result }
  end

  def repos
    @repos ||= YAML.load_file 'src/config/repos.yml'
  end

  def tags
    @tags ||= YAML.load_file 'src/config/tags.yml'
  end

  def featured
    @featured ||= YAML.load_file 'src/config/featured.yml'
  end

  def repos_by_tag
    @repos_by_tag ||= begin
      result = {}

      repos.each do |key, data|
        next unless data['tags']

        data['tags'].each do |tag|
          result[tag] ||= []
          payload = { 'key' => key }.merge repos[key]
          result[tag] << payload
        end
      end

      result.sort_by { |k, v| [-v.count, k] }.to_h
    end
  end

  def index_data
    @index_data ||= repos_by_tag.transform_values(&:count)
  end

  def layout_template
    @layout_template ||= Slim::Template.new('src/views/layout.slim', pretty: true)
  end

  def css_fingerprint
    @css_fingerprint ||= Digest::MD5.hexdigest(File.read('src/assets/css/main.css'))
  end
end
