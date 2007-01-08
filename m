From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [PATCH 3/6] [-mm]: ACPI: duplicate ACPI sleep "alarm" attribute in	sysfs
Date: Mon, 8 Jan 2007 12:36:12 +0100
Message-ID: <20070108113612.GC25857@elf.ucw.cz>
References: <1168083318.5619.37.camel@localhost.localdomain> <20070107111859.GB4792@ucw.cz> <200701071944.59470.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200701071944.59470.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org, Alessandro Zummo <alessandro.zummo@towertech.it>, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Paul Sokolovsky <pmiscml@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > Create /sys/power/alarm.
> > > The way it works is exactly the same as /proc/acpi/alarm.
> > > I.e. "#echo yyyy-mm-dd hh-mm-ss >/sys/power/alarm" supports existing absolute time.
> > > And "#echo +yyyy-mm-dd hh-mm-ss >/sys/power/alarm" supports a duration.
> > 
> > NAK. /proc/acpi/alarm is a mess, and this just moves it to /sysfs.
> > 'One value per file', please.
> 
> Sort of like the appended patch, instead ... which doesn't need to know a
> thing about ACPI.  This is what I suggested in response to an earlier patch
> from Paul Sokolovsky.

Yes, I suspected your patches would be solving this one.

>  - It can be written with an alarm time in the future, again seconds
>    since the POSIX epoch, which enables the alarm.
> 
>  - It can be written with an alarm time not in the future (such as 0,
>    the start of the POSIX epoch) to disable the alarm.

...and it is certainly way better than original (parsing)
solution. ACK.

(What about periodic alarms? I guess we want to simply forget about
them? Doc*/ file would be nice, but you probably have that in separate
patch.)
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
