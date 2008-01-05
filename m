From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] sleepy linux
Date: Sat, 5 Jan 2008 22:51:23 +0100
Message-ID: <20080105215123.GA21565@elf.ucw.cz>
References: <20071225230731.GA29030@elf.ucw.cz> <20071230111552.GA8578@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758448AbYAEVvY@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20071230111552.GA8578@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

On Sun 2007-12-30 12:15:52, Ingo Molnar wrote:
> 
> * Pavel Machek <pavel@ucw.cz> wrote:
> 
> > Todays hardware is mostly capable of doing better: with correctly set 
> > up wakeups, machine can sleep and successfully pretend it is not 
> > sleeping -- by waking up whenever something interesting happens. Of 
> > course, it is easier on machines not connected to the network, and on 
> > notebook computers.
> > 
> > Requirements:
> > 
> > 0) Working suspend-to-RAM, with kernel being able to bring video back.
> > 
> > 1) RTC clock that can wake up system
> 
> very nice approach! It might require smarter hardware to be really 
> efficient, but the generic ability for Linux to utilize S3 automatically 
> would _quickly_ drive the creation of smarter hardware i'm sure - so i'd 
> propose to include this even if it wastes power in some cases.
> 
> a quick feature request: could you please make the wake-on-RTC 
> capability generic and add a CONFIG_DEBUG_SUSPEND_ON_RAM=y config option 
> (disabled by default) that does a short 1-second suspend-to-RAM sequence 
> upon bootup? That way we could test s2ram automatically (which is a MUCH 
> needed feature for automated regression testing and automatic 
> bisection). In addition, some sort of 'suspend for N seconds' /sys or 
> /dev/rtc capability would be nice as well.

Hmm, are you sure it is good idea to do this from kernel? I guess this
is better done from script... 

> btw., how far are you from having a working prototype?

SCSI/SATA issues stop me just now, but even if I get that to work, it
will be extremely disgusting hack... and it is unclear how to do it
nicely :-(.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
