From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] [PATCH 3/6] [-mm]: ACPI: duplicate ACPI sleep "alarm" attribute in	sysfs
Date: Thu, 25 Jan 2007 01:39:31 -0800
Message-ID: <200701250139.32101.david-b@pacbell.net>
References: <1168083318.5619.37.camel@localhost.localdomain> <200701071944.59470.david-b@pacbell.net> <200701242321.09850.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200701242321.09850.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@lists.osdl.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, Alessandro Zummo <alessandro.zummo@towertech.it>, Paul Sokolovsky <pmiscml@gmail.com>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

> > This adds a new "wakealarm" sysfs attribute to RTC class devices which
> > support alarm operations and are wakeup-capable:
> > 
> >  - It reads as either empty, or the scheduled alarm time as seconds
> >    since the POSIX epoch.  (That time may already have passed, since
> >    nothing currently enforces one-shot alarm semantics...)
> > 
> >  - It can be written with an alarm time in the future, again seconds
> >    since the POSIX epoch, which enables the alarm.
> > 
> >  - It can be written with an alarm time not in the future (such as 0,
> >    the start of the POSIX epoch) to disable the alarm.
> > 
> > ...
> 
> How do I ask to wake up "as soon as possible"?

That doesn't exactly correspond to a hardware mechanism.  The hardware
supports only "wake up at <this> specific time".

 
> This is what a box that is testing suspend-resume would want to do.

What I've done in that case is notice how long the suspend cycle takes,
add a bit of fuzz (I use 10 seconds), and specify that for the relative
"when to wake" time.

Of course, "how long suspend takes" is variable.  If you disable IDE DMA
(maybe the native driver doesn't suspend right yet?), suspend-to-disk
seems to take forever on a PC.

And even without suspend-to-disk, it often doesn't seem to be as quick
as you'd think it should be.  Traversing the list of devices, and then
suspending them, seems to take surprisingly long even on slim systems
without ACPI in the way.

On the plus side, at least most systems seem to be able to handle RTCs
as wakeup devices, so at least you _can_ automate that testing!

- Dave

