My GitHub
==================================================

This is the repository for building <https://github.dannyben.com/>.


Developer Notes
--------------------------------------------------

- [index.html](index.html) is edited manually
- All other HTML pages are generated automatically based on data in the
  [_src](_src) folder and the
  [repo-template.html](_src/repo-template.html) file.
- Data in the [_data](_data) folder is used by the Jekyll templates. It is
  mostly generated automatically from the YAML files in the [_src](_src) folder.
- The [_data/featured.yml](_data/featured.yml) file is edited manually.
- Generate everything by running `run generate`
- Start the local server with `run server`.
