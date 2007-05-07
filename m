From: Pavel Machek <pavel@ucw.cz>
Subject: Re: driver power operations (was Re: suspend2 merge)
Date: Mon, 7 May 2007 14:29:15 +0200
Message-ID: <20070507122915.GF20605__17318.5211177499$1178541114$gmane$org@elf.ucw.cz>
References: <alpine.LFD.0.98.0704241327180.9964@woody.linux-foundation.org>
	<alpine.LFD.0.98.0704251231111.9964@woody.linux-foundation.org>
	<20070425200836.GB17387@elf.ucw.cz>
	<200704252233.25296.rjw@sisk.pl>
	<20070425203150.GD17387@elf.ucw.cz>
	<1177669279.7828.55.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1177669279.7828.55.camel@johannes.berg>
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

> > > So, the "suspend" and "resume" for the functions being called for that are
> > > wrong, but then we call them with PMSG_FREEZE. ;-)  Still, we could add
> > > .freeze() and .thaw() callbacks for hibernation just fine.  This wouldn't even
> > > be that difficult ...
> > 
> > It would be ugly big patch I'm afraid.
> 
> It'd be a lot of code churn, but well worth it. And most of the changes
> would be trivial too. You need to start looking beyond "this is ugly in
> the short term" and realise that it's much more maintainable in the long
> term if driver writers know what they're supposed to do as opposed to
> just hacking at it until it mostly works or just doing a full device
> down/up cycle including resetting full driver state.

I do not disagree with you. It will be ugly big patch, but it is
probably worth it, so the patch will be welcome.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
