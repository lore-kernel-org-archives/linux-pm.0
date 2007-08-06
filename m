From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: [Resend][PATCH] PM: Fix dependencies of
	CONFIG_SUSPEND and CONFIG_HIBERNATION (updated)
Date: Mon, 6 Aug 2007 13:36:45 +0200
Message-ID: <20070806113644.GA1790__48747.9198062376$1186400419$gmane$org@elf.ucw.cz>
References: <200708051906.22865.rjw@sisk.pl>
	<20070806090713.GC15329@atrey.karlin.mff.cuni.cz>
	<1186392591.28655.35.camel@johannes.berg>
	<20070806102659.GB1875@elf.ucw.cz>
	<1186398917.28655.69.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1186398917.28655.69.camel@johannes.berg>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Russell King <rmk@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

On Mon 2007-08-06 13:15:17, Johannes Berg wrote:
> On Mon, 2007-08-06 at 12:26 +0200, Pavel Machek wrote:
> 
> > Well, so that it does not bitrot? This is few bytes, I'd say, and I
> > believe we have too many config options already.
> 
> This is not an option the user is ever going to see. I think I'd
> prefer

Ok, option that users can't set is probably not evil.

> having two new per-ARCH config symbols though:
> config SUSPEND_UP_POSSIBLE
> 	depends on ARCH_SUSPEND_UP_POSSIBLE
> 
> and then the architecture gets to define that when it can suspend.

Looks like a plan.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
