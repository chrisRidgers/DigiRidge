---
layout: post
title: "Bashing Around"
date: 2014-12-07 13:33:14 +0000
comments: true
categories: Bash Linux Wordpress MySQL Git Flow Zend
---

Working over at [Studio Mashbo][] has been an enjoyable experience so far.  The
team have been great to work with, and the pace is much quicker then that
expected of undergrads in university.  There's been new frameworks to learn,
real working code to read and adapt, new work flow practices to adopt and build
into my personal routine, deadlines and standards to meet; if you think you
have it hard in uni with your 9AM's and your (none dissertation) coursework
don't worry; it gets harder.

<!-- more -->

Recently a lot of my focus areas have been coming together in the form of a
Bash script to help automate our project setups, leaving us more time to focus
on the actual work for the clients.  Better time spent, better quality product
as a result.

You may have recently heard about Bash in connection with the recent
[Shellshock][] bug.  One of the reasons the bug was so loudly reported on in
the media was because of how widespread/ standard the Bash software is in the
computer world; you would be hard pressed to find a none Windows computer
released after 1989 that doesn't have some iteration of Bash installed on it.
And those Windows computers: if they're running Cygwin, they're running Bash.

So just to get the sucking eggs out of the way, this is Bash:

``` Bash ./hello-world.sh
#!/bin/Bash
        
echo 'Hello World!'
```

Which when run produces:

``` console hello-world.sh
$ ./hello-world.sh
Hello World!
```

So that's eggs. A more real world example might be something like:

{% include_code [lang:console ] output.sh-session %}

Which is a standard omelette.  Bash isn't just another language for you to
write 'Hello World'! in and than put away to maybe pick up again later.  It's a
full interactive shell capable of directory navigation, file reading and
writing, execution, user input and through extension of that working with
scripts.

Take any application you have in a visual desktop environment (for example
Firefox) and whatever you click on will be running a very simple Bash command
along the lines of: ``/usr/bin/firefox``. Your pretty windows are themselves no
more than (most likely) part of the X Window system which was itself launched
by Bash either as your computer booted up or soon after login.

Bash isn't an optional fling for you as a developer.  She's already moved in
and she's brought her toothbrush.  You should probably learn to get on.

A lot of what I do is within a Bash terminal, right the way down to my file
coding/ editing and system management.  Updates, new software, system monitor,
hell I've even had Twitter/Facebook feed set up through a Bitlbee server to an
IRC client; it all goes through the terminal.  There may be a smidge of
elitism in there somewhere, but 90% of the time it makes me a better developer
because of it.  You learn exactly what your system is doing and how to work
with it &mdash; although in work I've recently discovered a wonderful text
editor called [Sublime Text][].  It's not going to completely replace my terminal
based editor, but it's pretty slick.

One of the frameworks we use in Mashbo is Wordpress, which if you don't already
know is very popular.  It has large array of features, is relatively simple to
use thanks to it's content managment system (CMS), has a large plugin set and
developer community, and markets itself very successfully as a low fuss product
suitable for a wide array of applications. Personally, I would argue the point
on this last one, but that's for another time.

One of the features touted by Wordpress is its 'Famous Five Minute Install'.
You download the files to your directory, make sure your server is pointing at
it, create your database table and user, add that database information to your
config file, and then run the install script by accessing it in your browser.
This is of course assuming you already have a web server up and running with
an SQL database.

Which means in order to get Wordpress up and running, you'll actually need:

- A browser to locate and download the Wordpress files.

- An SQL Database manager (such as Workbench) to create your database table and
  user.

- A text editor (graphical or terminal) to edit the config file.

- The browser (again) to run the install script.

- Your time to go through the process.  Plus that of any plugins you want to
  install.

Or we can do this:

**NOTE NOT THE ACTUAL SCRIPT IM USING IN WORK.  TREAT AS PSEUDO CODE**

``` console wp-install
#!/bin/Bash

curl -sS http://getcomposer.org/installer | php
mv composer.phar to/wherever/you/want/it

composer create-project wp-cli/wp-cli your/cli/install
ln -s your/cli/install/bin/wp-cli /usr/local/bin/wp

wp core download --path=path/to/project/home

wp core config --path=path/to/project/home --db_name=database_name
--db_user=database_user --db_password=database_password

wp db create --path=path/to/project/home

wp core install --path=path/to/project/home --url=site_url --title=site_title --admin_user=admin_name --admin_email=admin@email.com --admin_password=admin_password
```

Which translates as download composer, install the Wordpress CLI, download the
core files for Wordpress, generate a configuration file with this database
information, create that database table and user within my database, run the
Wordpress install script.

And you can use that script for different projects dropping in different
variables as necessary.  Depending on your database setup you'll probably need
to initially pass Wordpress your root login details in order for it to create
the new table and user, and then script it to replace the root login details in
the config file with those of the user that it creates.  Doddle right?  Course
it is, with [sed][].

And there in lies the power of Bash.  You can extend any sequence of commands
or 'user input' with any other; Bash has built in tools for piping one
command's output to another, as demonstrated above on line 2, and has a number
of built in commands which all but guarantee a minimum amount of functionality
from system to system allowing you to have confidence that your script will
work in all places &mdash; throw in distribution specific calls like apt-get in
there and you'll start struggling to move that script somewhere else. I'll talk
about that, and the built-ins later.

In fact, one of my recent site updates includes a small sidebar that currently
displays what I'm reading.  At the minute, it's providing a link to Richard
Stevens' [Advanced Programming in the UNIX environment][] which is a very
highly regarded book in the computer science community.  I'll no doubt learn
lots about Bash as a result from reading it so I'll have plenty more to talk
about.

[Studio Mashbo]: http://www.studiomashbo.com 
[Shellshock]: http://readwrite.com/2014/10/02/shellshock-Bash-bug-faq-explainer 
[Sublime Text]: http://www.sublimetext.com
[sed]: http://www.grymoire.com/Unix/Sed.html
[Advanced Programming in the UNIX environment]: http://www.amazon.co.uk/gp/product/0321637739/ref=s9_simh_gw_p14_d0_i2?pf_rd_m=A3P5ROKL5A1OLE&pf_rd_s=center-2&pf_rd_r=1EN7HX7V6R6RXKFYW9A4&pf_rd_t=101&pf_rd_p=455344027&pf_rd_i=468294
