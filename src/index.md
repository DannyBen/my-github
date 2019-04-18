<%- repos_by_tag.each do |tag, repo_keys| -%>

### <%= tag_title tag %>

| Repository  | Description | Tags |
|-------------|-------------|------|
<%- repo_keys.each do |repo_key| -%>
<%- repo = repos[repo_key] -%>
| [<%= repo['name'] %>](https://github.com/DannyBen/<%= repo_key %>) | <%= repo['summary'] -%> | <%= repo['tags'].map(&:tag_to_link).join ' &nbsp;&nbsp;&nbsp; ' -%> |
<%- end -%>

<%- end -%>
