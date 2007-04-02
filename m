From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [PATCH v2] Add suspend/resume for HPET
Date: Mon, 2 Apr 2007 10:16:43 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0704021000450.1743-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965494AbXDBOQp@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Greg KH <greg@kroah.com>, Thomas Gleixner <tglx@linutronix.de>, Kernel development list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Saturday March 31, 2007, David Brownell wrote:

> I'm about ready to test the appended patch... a "move one device" call
> might be safest at this point in the release cycle though.
> 
> - Dave
> 
> ========================	SNIP!
> Change how the PM list is constructed, so that devices are added right
> after their parents (when they have one) rather than at the end of the
> list.  This preserves sequencing guarantees, but enables sequencing of
> suspend/resume operations by more important characteristics than "when
> device happened to enumerate" ... e.g. clocksources and clockevents
> at a clearly defined point during suspend and resume.
> 
> This patch has a potential downside for devices that have multiple
> power dependencies and which "just happened to work" before.

Dave:

Would you mind retracting this patch?  It will interfere with some work
I've been doing in USB, work that relies on exactly the sort of multiple 
power dependency you mention.

The problem is this: When a low- or full-speed USB device is resumed 
following a power loss (this is part of the "persistent USB" patch), it's 
necessary for the corresponding EHCI root hub to be resumed first so that 
the port's OWNER bit can be set properly.

It works fine as long as devices are resumed in order of registration,
because a low- or full-speed USB device can't be registered before the
high-speed root hub.  (If it was, it would be disconnected when the
high-speed root hub initialized and took control of the port.)  So this
isn't a "just happened to work" situation; it really is a critical
ordering dependency.

The clock source problem can be solved in other ways.  For instance, right 
now things are set up so that clock sources are registered at various 
random times and the clockevents code adapts to use the best available 
device, right?.  So simply arrange for a clock source to "depart" as it is 
suspended; then clockevents can fall back to using other lower-precision 
sources.  As long as devices suspend in reverse order of discovery, the 
system should always function properly.

Alan Stern
