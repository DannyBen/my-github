---
title: Open Source Projects by @DannyBen
---

## Index

<%- toc.each do |item| -%>
- <%= item[:link] %> - <%= item[:count] > 1 ? "#{item[:count]} repositories" : "1 repository" %> 
<%- end -%>

---

<%- repos_by_tag.each do |tag, repo_keys| -%>

## <%= tag_title tag %>
<%- if repo_keys.count > 1 -%>
<%= repo_keys.count -%> repositories
<%- end -%>

| Repository  | Tags |
|-------------|------|
<%- repo_keys.each do |repo_key| -%>
<%- repo = repos[repo_key] -%>
| [<%= repo['name'] %>](https://github.com/DannyBen/<%= repo_key %>) <br> <%= repo['summary'] -%> | <%= repo['tags'].sort.map { |tag| tag_to_link(tag) }.join ' &nbsp;&nbsp;&nbsp; ' -%> |
<%- end -%>

<%- end -%>
