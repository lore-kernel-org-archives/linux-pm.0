From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re : Re : [HELP] Power management for embedded system
Date: Thu, 24 Aug 2006 14:42:05 +0000 (GMT)
Message-ID: <20060824144205.52988.qmail@web25801.mail.ukl.yahoo.com>
References: <1156414325.5555.11.camel@localhost.localdomain>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932098AbWHXOmJ@vger.kernel.org>
In-Reply-To: <1156414325.5555.11.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Richard Purdie wrote:
> It provides an apm_bios device which behaves the same way as a "real"
> APM bios on x86. The same apmd used on x86 can be used on ARM.
> 
> Its main purpose is to be to run suspend/resume events past userspace
> before acting on them (and allow suspend/resume events to be triggered
> from userspace). It also allows exporting of battery status information
> to userspace in a rather broken way. 
> 
> It would be nice to move that to some arch independent generic
> implementation of these things and to leave the APM emulation behind.

Yes. Hence the generic code would deal with battery info, suspend/resume
events to userspace, cpu idle logic. And arches specific code would deal
with hardware to get status on battery for example. On i386 that would
lead to call the BIOS, on others arches, they would use whatever available
on the platform to report the status.

> The battery information should be a sysfs class (see the backlight/led
> classes as examples of sysfs classes). The suspend/resume event handling
> would be something new as far as I know and ideally should support
> suspending/resuming individual sections of device hardware as well as

Well, maybe the first step is to unify this APM for all arches hence 
everybody could better improve it.

> the whole system. The linux-pm mailing list might have more of an idea
> of whether these things are being worked on and their current status.
> 

That's actually this status I was trying to get when posting my initial
email.

Francis
