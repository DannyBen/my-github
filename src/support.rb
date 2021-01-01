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

def render(name, context = {})
  context[:content] = slim name, context
  slim "layout", context
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
