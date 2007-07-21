From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Hibernation considerations
Date: Sat, 21 Jul 2007 21:49:06 +0200
Message-ID: <20070721194906.GC3701__1564.20246135003$1185047456$gmane$org@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0707171010490.3551-100000@iolanthe.rowland.org>
	<200707171802.30903.rjw@sisk.pl>
	<Pine.LNX.4.64.0707170959160.2467@asgard.lang.hm>
	<200707172150.44417.rjw@sisk.pl>
	<Pine.LNX.4.64.0707171302430.2467@asgard.lang.hm>
	<20070721102520.GE1902@elf.ucw.cz> <87ps2lojlc.fsf@jbms.ath.cx>
	<20070721175639.GA3701@elf.ucw.cz>
	<Pine.LNX.4.64.0707211232580.6577@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707211232580.6577@asgard.lang.hm>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: LKML <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, Al Boldi <a1426z@gawab.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "Huang,
	Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

Hi!

> >>>So it will be break at least battery status and "AC plugged in"
> >>>status, because those are handled by ACPI and we do not know how to
> >>>control them by hand.
> >>
> >>It seems that it should be possible to initialize ACPI as if the system
> >>just booted up normally.  Then battery status and such should be
> >>correct, since they are correct after normal initialization.
> >>
> >>It should be possible to make hibernate look just like a reboot to all
> >>of the devices, including ACPI stuff.
> >
> >Patch to make that work with swsusp/shutdown method would be indeed
> >welcome. It does not work today.
> 
> is this a problem in the restore path?
> 
> with the kexec approach (and ignoring suspend to ram and disk for the 
> moment) the system will actually get shutdown completely after the image 
> is written. on resume it gets cold booted. at this point the ACPI stuff 
> should have no problem
> 
> now if the ACPI drivers are storing something in ram about the battery 
> status and AC power status, but don't re-check after the resume, it
>seems

That seems to be the problem. They store something in ram, and we
don't tell them that we resumed. That's why platform mode is
important, and way to go on ACPI systems.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
