How to Use
----------

1. Close this repository (and any submodules) to a directory, e.g. ~/Home
2. Run link.sh, this will symbol link all the profiles in your home directory, but you have to change the commonds to represent your cloned path
3. Open Vim
4. Run :PluginInstall, till all the plugins have been cloned, restart Vim
5. OK, all done

How to Compile Command-T Ext
----------------------------

```bash
cd ~/.vim/bundle/command-t/ruby/command-t
make clean
ruby -e 'puts "#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"' # make sure it says 2.0.0
ruby extconf.rb
make
```
