From: Pavel Machek <pavel@suse.cz>
Subject: Re: swsusp and suspend2 like to overheat my laptop
Date: Wed, 9 Aug 2006 09:39:58 +0200
Message-ID: <20060809073958.GK4886@elf.ucw.cz>
References: <Pine.LNX.4.58.0608081612380.17442@gandalf.stny.rr.com>
	<20060808235352.GA4751@elf.ucw.cz>
	<Pine.LNX.4.58.0608082215090.20396@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <suspend2-devel-bounces@lists.suspend2.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0608082215090.20396@gandalf.stny.rr.com>
List-Unsubscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=unsubscribe>
List-Archive: <http://lists.suspend2.net/lurker/list/suspend2-devel.html>
List-Post: <mailto:suspend2-devel@lists.suspend2.net>
List-Help: <mailto:suspend2-devel-request@lists.suspend2.net?subject=help>
List-Subscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=subscribe>
Sender: suspend2-devel-bounces@lists.suspend2.net
Errors-To: suspend2-devel-bounces@lists.suspend2.net
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-pm@osdl.org, LKML <linux-kernel@vger.kernel.org>, Suspend2-devel@lists.suspend2.net, ncunningham@linuxmail.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > > A few months ago, I installed suspend2 on my laptop.  It worked great for
> > > a few days, when suddenly my laptop started to get very hot and the fan
> > > costantly went off, and then I started getting these:
> >
> > I take it as "if I keep it for a week powered off, it will not do
> > this".
> 
> Not quite.  It's more of, "if I suspend everynight instead of leaving it
> running or shutting it down, it will do this" or "if I power off at night
> or just leave it running, it will not do this".

Okay, can you try to leave it up for a week or two (no suspends, no
poweroffs) and see what happens?

> > P4 has thermal protection, so you are actually safe.
> 
> Yeah, but still, the keyboard gets pretty hot too, and I'm actually more
> worried about damaging something that is close by than damaging the CPU
> itself.

If you damage something, machine was misdesigned in the first place.

cat we get contents of /proc/acpi/thermal*/*/* ?

> $ sudo modprobe ibm_acpi
> $ ls /proc/acpi/ibm/
> bay        bluetooth  driver     led        thermal
> beep       cmos       hotkey     light      video
> 
> No fan there

Does ibm/thermal work?

Seems like fan is completely controlled by hardware. What may still
help: either saving or avoiding saving reserved parts of memory. But
this is all magic.

How s2ram works would be useful info.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
