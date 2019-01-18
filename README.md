# vim-dictionary
Easily add dictionary files to the [dictionary](http://vimdoc.sourceforge.net/htmldoc/options.html#'dictionary') setting by creating the file within your `.vim` directory.

# Usage
Every time a buffer is opened, the [runtimepath](http://vimdoc.sourceforge.net/htmldoc/options.html#'runtimepath') will be scanned for files that have a `.dictionary` suffix and included.

Invoke this manually with:
```
:call LoadDictionary()
```

## License

Copyright (c) Jonathan Brink.  Distributed under the same terms as Vim itself.
See `:help license`.
