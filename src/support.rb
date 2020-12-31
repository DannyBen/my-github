require 'yaml'
require 'slim'
require 'byebug'
require "fileutils"

class File
  def self.deep_write(file, content)
    dir = File.dirname file
    FileUtils.mkdir_p dir unless Dir.exist? dir
    File.write file, content
  end
end

def slim(name, context = {}, &block)
  Slim::Template.new("src/views/#{name}.slim", pretty: true).render(OpenStruct.new(context), &block)
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

# def toc
#   @toc ||= toc!
# end

# def toc!
#   result = repos_by_tag.map do |tag, repos|
#     link = tag_to_link(tag)
#     { key: tag, link: link,  count: repos.count }
#   end

#   result.sort_by { |a| a[:link] }
# end

# def user_content_prefix
#   ENV['DEV'] ? 'user-content-' : ''
# end

def repos_by_tag
  @repos_by_tag ||= repos_by_tag!
end

def repos_by_tag!
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

# def tag_to_link(tag)
#   "[#{tag_title(tag)}](##{user_content_prefix}#{slug(tag)})"
# end

# def slug(tag)
#   tag_title(tag).downcase.gsub(' ', '-').gsub(/[^\w\-]/, '')
# end

# def tag_title(tag)
#   if tags[tag]
#     tags[tag]
#   else
#     $stderr.puts "Warning: no title for #{tag}"
#     tag
#   end
# end
