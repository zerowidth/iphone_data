iphone_data
    by Nathan Witmer
    http://github.com/aniero

== DESCRIPTION:

Script to dump data from an iPhone's synced data

Thanks to masque /at/ pobox.com for his unravel.perl script, http://calmstorm.net/iphone/unravel.perl

== FEATURES/PROBLEMS:

* Dump SMS message logs as a log file or an mbox file
* Dump all of the iPhone backup files into a specified directory
* Assumes only a single iPhone right now

== SYNOPSIS:

iphone_data <command> [options]

Commands include:

  help - show help
  sms - show sms messages
  dump - dump the iphone backup data

== REQUIREMENTS:

* plist >= 3.0.0
* sqlite3-ruby >= 1.2.1
* main >= 2.8.0

== INSTALL:

* sudo gem install aniero-iphone_data --source=http://gems.github.com/

== LICENSE:

(The MIT License)

Copyright (c) 2008 Nathan Witmer

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
