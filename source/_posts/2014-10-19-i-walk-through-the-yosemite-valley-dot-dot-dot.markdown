---
layout: post
title: "I walk through the Yosemite Valley..."
date: 2014-10-19 18:35:12 +0100
comments: true
categories: OS X Yosemite Updates Developer Tools XCode
---

... of Death, I will fear no evil.

As a user updating your computer is a minor nuisance that often gets postponed 
either to laziness, or simply a desire not to upgrade.  As a developer however
there comes with every update notification a sense of trepidation, dread and,
even on occasion, panic (just this week I inadvertently ran a ``sudo apt-get
upgrade`` command on my employers web development server).

<!-- more -->

This weekend has consisted entirely of me going through upgrade procedures.
Even this blog you're currently reading is the result of some fairly fiddly
fiddling from this side of the keyboard.  It's as poor timing would have it that
just as it was coming together OS X would announce a system update: *Woo Hoo* I
thought.  *Fan Tastic*.  

OS X is a bit of an oddball when it comes to updating its software, particularly
for Unix-like systems. For starters, the process often includes the removal of
command line developer tools and revoking of privileges required to use them.
It's not a particularly developer friendly policy, and it serves as a very swift
kick to remind you that your choice of platform is heavily embedded within
Apple's upgrade cycle.  Not an issue for OS X/iOS developers I'm sure, but for
those of us with a less platform specific career pathway it's some extra hoops
and edge cases that never quite go away and leave us to do our thing.

So, resolved to getting the job done before the working week begins, I hit the
upgrade button.  In the Mac Store.  Like I said: OS X, oddball, Unix.  There
probably is a command line alternative however when in Rome...

As a user the process would likely have been a breeze.  The update downloaded
and then proceeded to install.  As a developer however there were a few niggles:

*The worlds longest minute*: Total estimated install time was about 40 minutes
however the process ground to a halt in the last minute.  I sat and I waited and 
time sailed by as my Mac contentedly delivered no feedback whatsoever. It
continued to openly mock me with its near complete progress bar but that was
about it.  Turns out the problem lay with my use of the */usr/local* directory.

Within Unix-like systems, it's standard practice to install applications to
particular directories based on when they are likely to be called and their
necessary admin privileges.  One of these directories is */usr/local/* .  
This directory is commonly used to install applications desired by the user, 
separating them from both the system applications and the users home directory 
where personal data is stored.  It's just good practice.  Apple bucks the trend 
a little here by installing most applications into the */Applications* 
directory.  This is fine.  As a user the system is already configured for you to 
use and you need not know that */usr/local* even exists on your system.  But it 
does, and with good reason; because of wide spread use none Apple software often 
expects to be found within */usr/local*, installing it elsewhere can lead to 
unwanted breakages so Apple leaves this directory available for developers to 
use.

As part of the update process Apple very wisely backs up this directory by
copying its contents elsewhere.  At the end it less wisely copies it back over.
File by file.  If you ask anyone who is on OS X who is developing applications 
and using the Homebrew package manager, this is going to take a while.  And
Apple's estimated install time  does not include it.

On my system this stage alone appeared to take 50 minutes in addition to 40
estimated by Apple.  A quick Google pointed out that I could observe the process
by opening a log console during the upgrade using the *Cmd + L* keyboard
shortcut.  Finally complete, it was time to stretch my legs in Yosemite national
park.

*The First Commandment*:  Loving the Yosemite visual makeover, I tentatively
opened up a terminal and entered my first command:

``` console brew doctor 
$ brew doctor
Error: No such file or directory - /Library/Developer/CommandLineTools/usr/bin/clang
```

Of course.  Because why wouldn't Apple remove/ move clang as part of their
upgrade process.  Fire up XCode, sign my soul away to Apple's licensing
agreements of the developer tools, back to the terminal and run 
``xcode-select --install``.  Done.  Right back to Homebrew:

``` console brew doctor 
$ brew doctor
Warning: Your Xcode (6.0.1) is outdated
Please install Xcode 6.1.
```

Flips table and goes to put kettle on.  Right, back to terminal and I check
manually for updates using ``softwareupdate --list``.  Nada.  Weird.  Open up
the Mac App store and navigate to XCode to find that I am in fact using the
latest version.  6.1 is a dead parrot.  It has ceased to be.

As it turns out (because of course it hasn't)  XCode 6.1 has yet to be released
to the application store because of reasons upstream.  Which means if you would
like the newer version you have to download it manually [here][1].

Gritting through my teeth I install the updated XCode within my */Applications*
directory.  Back to the terminal, and ``brew doctor`` finally returns the all
clear.  The patient lives.

*The patient is trying my patience*:  The next installment of our epic quest for 
an up to date system:

``` console brew update
$ brew update
error: insufficient permission for adding an object to repository database .git/objects
fatal: failed to write object
fatal: unpack-objects failed
Error: Failed to update tap: homebrew/dupes
error: Unable to append to .git/logs/refs/remotes/origin/master: Permission denied
Error: Failed to update tap: homebrew/php
error: insufficient permission for adding an object to repository database .git/objects
fatal: failed to write object
fatal: unpack-objects failed
Error: Failed to update tap: homebrew/versions
Updated Homebrew from 6ac736a1 to b7feb05f.
```

At some point during the upgrade process files clearly got copied as a user that
wasn't me; a quick check with ``ls -l /usr/local/.git/objects`` shows us as 
much.  *Sigh*.  Enough of this twaddle.

``` console chown
$ sudo chown -R $USER /usr/local
```

And sure enough brew can now update, and my system appears to be in a state
similar to that which it was in prior to upgrading.  Aesthetically the update is
really slick, any iPhone user will recognise it.  Apple apps have already begun
releasing their new versions, iTunes got the update before I even realised
Yosemite was upon us.  Functionally, I spend most of my time in a terminal, but
I'm sure that as time goes on I'll find the strengths and weakness's of the new
look.  I've already repeatedly nearly shut down my browser when reaching for the
back button.

All is well. Until the next OS X update of course.

[1]: https://developer.apple.com/xcode/downloads/ "XCode 6.1"

