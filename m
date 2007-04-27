From: Pavel Machek <pavel@ucw.cz>
Subject: Re: driver power operations (was Re: suspend2 merge)
Date: Fri, 27 Apr 2007 14:50:01 +0200
Message-ID: <20070427125001.GI22250@elf.ucw.cz>
References: <alpine.LFD.0.98.0704241327180.9964@woody.linux-foundation.org>
	<20070425203150.GD17387@elf.ucw.cz>
	<1177669279.7828.55.camel@johannes.berg>
	<200704271407.00879.rjw@sisk.pl>
	<20070427124029.GH22250@elf.ucw.cz>
	<1177678002.6024.11.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1177678002.6024.11.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>, Adrian Bunk <bunk@stusta.de>, suspend2-devel@lists.suspend2.net, linux-pm <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > Five callbacks are fine by me, especially if we can define reasonable defaults
> > > for the hibernation (and can we?).
> > 
> > Well, we still can default to suspend(PMSG_FREEZE) for freeze(), and
> > resume() for thaw(). Anything else is just not sane way forward.
> 
> I think we should remove the argument to suspend() in the same patch
> series. Yes, that would mean porting all drivers that currently use
> it,

Well, if you can do it in one patch series, go ahead. But I think such
massive change all over kernel will take slightly longer, so I'd
prefer to keep the dummy argument for a while (so it still compiles)
and fix it slowly.

Of course, it is up to the person doing the series. And yes, such
series would be welcome.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
