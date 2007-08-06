From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: [Resend][PATCH] PM: Fix dependencies of
	CONFIG_SUSPEND and CONFIG_HIBERNATION (updated)
Date: Mon, 6 Aug 2007 12:26:59 +0200
Message-ID: <20070806102659.GB1875__20320.2838114978$1186398460$gmane$org@elf.ucw.cz>
References: <200708051906.22865.rjw@sisk.pl>
	<20070806090713.GC15329@atrey.karlin.mff.cuni.cz>
	<1186392591.28655.35.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1186392591.28655.35.camel@johannes.berg>
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

On Mon 2007-08-06 11:29:51, Johannes Berg wrote:
> On Mon, 2007-08-06 at 11:07 +0200, Pavel Machek wrote:
> > Hi!
> > 
> > > +config SUSPEND_UP_POSSIBLE
> > > +	bool
> > > +	depends on (X86 && !X86_VOYAGER) || (PPC32 && PPC_MPC52xx) \
> > > +		   || (PPC64 && (PPC_PSERIES || PPC_PMAC)) || ARM || BLACKFIN \
> > > +		   || MIPS || SUPERH || FRV
> > > +	depends on !SMP
> > > +	default y
> > 
> > I guess I'd rather left SUSPEND_UP_POSSIBLE to allways y (as it always
> > was), and let architectures that can't handle it  not return "mem"
> > from list of valid states...
> 
> Yeah, that's the utterly broken interface we used to have. Until I fixed
> it to have no valid states until architectures implement suspend_ops.
> Still, I disagree, why bother with compiling code that can't ever be
> used?

Well, so that it does not bitrot? This is few bytes, I'd say, and I
believe we have too many config options already. I do not think
suspend_ops code is big enough to warrant separate config
option... just disable CONFIG_PM or something.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
