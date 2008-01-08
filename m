From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC] sleepy linux
Date: Tue, 8 Jan 2008 17:37:44 +0100
Message-ID: <20080108163744.GB13746@elte.hu>
References: <20071225230731.GA29030@elf.ucw.cz> <20071230111552.GA8578@elte.hu> <20080105215123.GA21565@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762050AbYAHQiY@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080105215123.GA21565@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org


* Pavel Machek <pavel@ucw.cz> wrote:

> > a quick feature request: could you please make the wake-on-RTC 
> > capability generic and add a CONFIG_DEBUG_SUSPEND_ON_RAM=y config 
> > option (disabled by default) that does a short 1-second 
> > suspend-to-RAM sequence upon bootup? That way we could test s2ram 
> > automatically (which is a MUCH needed feature for automated 
> > regression testing and automatic bisection). In addition, some sort 
> > of 'suspend for N seconds' /sys or /dev/rtc capability would be nice 
> > as well.
> 
> Hmm, are you sure it is good idea to do this from kernel? I guess this 
> is better done from script...

i have this low-prio effort to make all self-checks automatically 
available via 'make randconfig' as well, for all features that have no 
natural exposure during normal bootup. So far we've got rcutorture, 
kprobes-check, locking/lockdep-self-test and a handful of others. 
External scripts tend to go out of sync and LTP takes way too much time 
to finish.

> > btw., how far are you from having a working prototype?
> 
> SCSI/SATA issues stop me just now, but even if I get that to work, it 
> will be extremely disgusting hack... and it is unclear how to do it 
> nicely :-(.

as long as the sleep periods are within say 10-20 seconds, and our s2ram 
cycle is fast and optimal enough, we could do this with networking 
enabled too, without dropping/stalling TCP connections left and right.

(Perhaps if we could notify routers that they should batch packets for N 
seconds and we could turn off PHY during that time, it would be even 
nicer - is there any such router extension in existence?)

but if it's nothing else but a s2ram debug/stress utility, that alone 
would be great too :-)

	Ingo
