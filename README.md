w_nfs Cookbook
==================

[![Build Status](https://travis-ci.org/haapp/w_nfs.svg?branch=master)](https://travis-ci.org/haapp/w_nfs)

Chef cookbook to instal and configure nfs. Expects multiple high availability apache virtual machine to share their data.

Requirements
------------
Cookbook Dependency:

* nfs

Supported Platform:
Ubuntu 14.04, Ubuntu 12.04

Usage
-----
#### w_nfs::default

Include with `w_common` in your node/role's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[w_common]",
    "recipe[w_nfs]"
  ]
}
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Install reqired gems
```
bundle install
```
4. Write your change
5. Write tests for your change (if applicable)
6. Run the tests, ensuring they all pass
```
bundle exec rspec
bundle exec kithen test
```
7. Submit a Pull Request using Github

License and Authors
-------------------
Authors: 
* Joel Handwell @joelhandwell 
* Full Of Lilies @fulloflilies
