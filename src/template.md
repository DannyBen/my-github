<%- repos_by_tag.each do |tag, repo_keys| -%>

## <%= tag_title tag %>
<%- if repo_keys.count > 1 -%>
<%= repo_keys.count -%> repositories
<%- end -%>

| Repository  | Tags |
|-------------|------|
<%- repo_keys.each do |repo_key| -%>
<%- repo = repos[repo_key] -%>
| [<%= repo['name'] %>](https://github.com/DannyBen/<%= repo_key %>) <br> <%= repo['summary'] -%> | <%= repo['tags'].sort.map(&:tag_to_link).join ' &nbsp;&nbsp;&nbsp; ' -%> |
<%- end -%>

<%- end -%>

