require 'yaml'

def repos
  @repos ||= YAML.load_file 'src/repos.yml'
end

def tags
  @tags ||= YAML.load_file 'src/tags.yml'
end

def tag_title(tag)
  tags[tag] || tag
end

def repos_by_tag
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

class String
  def tag_to_link
    "[#{self}](##{self})"
  end
end