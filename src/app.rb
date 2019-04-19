require 'yaml'
require 'byebug'

def repos
  @repos ||= YAML.load_file 'src/repos.yml'
end

def tags
  @tags ||= YAML.load_file 'src/tags.yml'
end

def toc
  @toc ||= toc!
end

def toc!
  result = repos_by_tag.map do |tag, repos|
    link = tag_to_link(tag)
    { key: tag, link: link,  count: repos.count }
  end

  result.sort_by { |a| a[:link] }
end

def user_content_prefix
  ENV['DEV'] ? 'user-content-' : ''
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
      result[tag] << key
    end
  end

  result.sort_by { |k, v| [-v.count, k] }.to_h
end

def tag_to_link(tag)
  "[#{tag_title(tag)}](##{user_content_prefix}#{slug(tag)})"
end

def slug(tag)
  tag_title(tag).downcase.gsub(' ', '-').gsub(/[^\w]/, '')
end

def tag_title(tag)
  if tags[tag]
    tags[tag]
  else
    $stderr.puts "Warning: no title for #{tag}"
    tag
  end
end
