From: David Brownell <david-b@pacbell.net>
Subject: Re: Bugs in MMC [was: [Bug 10030] Suspend doesn't work
	when SD card is inserted]
Date: Thu, 6 Mar 2008 13:23:29 -0800
Message-ID: <200803061323.30314.david-b__11353.4266515218$1204838740$gmane$org@pacbell.net>
References: <200802241500.41969.rjw@sisk.pl>
	<200803040144.09601.david-b@pacbell.net>
	<20080304105841.6c951665@mjolnir.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080304105841.6c951665@mjolnir.drzeus.cx>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pierre Ossman <drzeus-mmc@drzeus.cx>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>
List-Id: linux-pm@vger.kernel.org


> > > > Card insert/remove events can be system wake events though.  Which
> > > > makes that restriction impractical.
> > 
> > This part seems to be ignored by your comment ... wake events.
> 
> How so? How is a wake caused by the MMC controller different
> than any other source? 

They aren't.  Which is part of why the way MMC currently assumes that
insert/remove events don't work is a problem.


> > That is, the MMC core doesn't understand wakeup events.
> > 
> > Or, as pointed out elsewhere, well-behaved MMC hosts ... which don't
> > need either such reprobing or the associated remove-on-suspend.
> 
> You need well behaved _systems_, not just hosts to achieve that
> guarantee.

Sure, but a host can't be well behaved all by itself!

And in any case, I had already made clear I was talking
about _systems_ that behave properly.


> SDHCI controllers have the ability to wake up the 
> system on card removal, but there is zero guarantee that the
> platform actually wired the controller up in a way that actually
> allows it to do this. Throw suspend to disk, where the system might
> completely lose power, into the mix and you're completely screwed.     

I'm talking about generic MMC/SD controllers of the type
that have been around for years ... on systems which won't
use hibernation ("suspend to disk"), but do use real system
sleep states where card detection (by IRQs) works.

 
> So for the default behaviour to change, we need one of two things:
> 
> - Certainty that removals cannot go unnoticed. (even then, you
>   also need wakeup latency guarantees) 
> - Ability to detect a removal after the fact.
>
> For the general case, the first one is impossible given todays
> hardware.

Odd that it's very possible on the systems I mentioned.


> The second might be solvable, but noone has done the work.  

I don't know what you mean by "detect a removal after
the fact", or why it'd be needed if you detected it
in the first place.

 
> (If your complete system can satisfy the first option, feel
> free to add the "unsafe" option to you defconfig, but that is
> hardly adequate reason to have it on by default.)  

Thing is, I had also pointed out that it wasn't "unsafe"
in the least on many systems.

I'll refresh the patch which improves that mechanism and
updates its description.

- Dave
