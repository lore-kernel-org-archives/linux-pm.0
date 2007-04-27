From: Pavel Machek <pavel@ucw.cz>
Subject: Re: driver power operations (was Re: suspend2 merge)
Date: Fri, 27 Apr 2007 14:40:29 +0200
Message-ID: <20070427124029.GH22250__24876.9149686725$1177678298$gmane$org@elf.ucw.cz>
References: <alpine.LFD.0.98.0704241327180.9964@woody.linux-foundation.org>
	<20070425203150.GD17387@elf.ucw.cz>
	<1177669279.7828.55.camel@johannes.berg>
	<200704271407.00879.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200704271407.00879.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nick Piggin <npiggin@suse.de>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>, Adrian Bunk <bunk@stusta.de>, suspend2-devel@lists.suspend2.net, linux-pm <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > And, incidentally, it could possibly make both suspend and hibernate
> > work much faster too. The comments there talk about "minimally power
> > management aware" drivers which always do the wrong thing for suspend,
> > in that they always reset everything... Of course, some drivers will
> > actually need to do that, but if freeze/suspend and thaw/restart/resume
> > have the same prototypes (probably just int <function>(void)) then
> > drivers can trivially assign the same there.
> > And hibernate would benefit since a lot of drivers could do a lot less
> > work for freeze/thaw.
> 
> I violently agree with all of the above.
> 
> Moreover, for the hibernation we have two special cases that are of no interest
> for the suspend:
> 1) drivers compiled as modules and not loaded before we restore the image
> 2) drivers that need to allocate much memory in .freeze()
> 
> > Or, if we don't want to have five calls and use 40 bytes (on 64-bit)
> > just for these callback pointers for each device we could just as well
> > have a single callback ->pm(what) and make "what" indicate which one of
> > these five things... But then drivers can't make that code depend on the
> > swsusp configuration which would be doable with five callbacks.
> 
> Five callbacks are fine by me, especially if we can define reasonable defaults
> for the hibernation (and can we?).

Well, we still can default to suspend(PMSG_FREEZE) for freeze(), and
resume() for thaw(). Anything else is just not sane way forward.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
