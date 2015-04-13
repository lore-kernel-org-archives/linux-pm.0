From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: clk: clock rates can overflow 32-bit fields
Date: Mon, 13 Apr 2015 13:14:33 -0700
Message-ID: <20150413201433.GQ32500@ld-irv-0074>
References: <CAN8TOE_7q1k_owngmwfzSADR_2Qe23A_PQfdmMCHcWqyrob2kQ@mail.gmail.com>
 <20150413055307.19585.53815@quantum>
 <20150413175440.GP32500@ld-irv-0074>
 <20150413184903.19585.42945@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150413184903.19585.42945@quantum>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Turquette <mturquette@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, Linux PM mailing list <linux-pm@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, u.kleine-koenig@pengutronix.de, Jim Quinlan <jim2101024@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 13, 2015 at 11:49:03AM -0700, Michael Turquette wrote:
> Quoting Brian Norris (2015-04-13 10:54:40)
> > On Sun, Apr 12, 2015 at 10:53:07PM -0700, Michael Turquette wrote:
> > > Quoting Brian Norris (2015-04-12 21:24:22)
> > > > (1) using clk-divider.c; and/or
> > > > (2) using intermediate clocks that run faster than 4.3 GHz
> > > > 
> > > > With clk-divider.c, we can run into problems at lower clock rates due
> > > > to the usage of DIV_ROUND_UP (see, e.g., commit b11d282dbea2 "clk:
> > > > divider: fix rate calculation for fractional rates"), since this might
> > > > create overflows when doing the addition -- e.g., DIV_ROUND_UP(3 G,
> > > > 1.5 G) = (3 G + 1.5 G - 1) / 1.5 G = (OVERFLOW) / 1.5 G
> > > > 
> > > > I could probably fix up the clk-divider.c issue locally, if necessary.
> > > > But problem (2) seems to suggest a larger change may be required
> > > > throughout the framework, and I'd like to solicit opinions before
> > > > hacking away.
> > > 
> > > Yes, we've seen this problem coming up on us for a while. A related
> > > problem is fractional rates where we simply lop off the fractional Hz.
> > > Eg. 2.5Hz will be either 2 or 3 Hz depending on how your clock driver
> > > rounds things.
> > 
> > I was wondering if we have any problems with fractional Hz. Have you
> > seen users of such low frequencies?
> 
> Absolute value doesn't matter here. The point is that we lose anything
> to the right of the decimal. E.g. 1000000.5 Hz.

Sure, but that's a lot less of a problem at the scale of 1 MHz than at
the scale of 1 Hz. Or are we promising perfection? Infinite precision
math?

> > How about adding floating point support to kernel space, and solve both
> > problems without widening the field size? :)
> 
> Haha, don't bother Ccing me on that patch.

:)

> > > > So, any thoughts on how to best tackle this problem? Should we upgrade
> > > > the clock framework to use a guaranteed 64-bit type for clock rates
> > > > (e.g., u64)?
> > > 
> > > Well here is the bat shit crazy idea I've had for a while:
> > > 
> > > 1) make rates 64-bit so that we're future proof. Max rate: 18 exahertz.
> > > 
> > > 2) make all clk api functions return s64 so that error codes can be
> > > baked into rates (that is a LOT of unused error codes). Likely all rate
> > > representation inside the clock framework will be s64. Max rate: 9
> > > exahertz.
> > > 
> > > 3) instead of hertz as the base unit, use millihertz (or something else
> > > sub-Hz?) to capture the fractional hertz stuff. Max rate: 9 petahertz.
> > 
> > These don't sound too fundamentally crazy to me, though the
> > implementation changeover could be a bit hairy (would we need
> > transitional APIs?), and I'm a little green on the implications for
> > users with limited 64-bit arithmetic.
> > 
> > > > I'm not sure if this will yield problems on certain
> > > > 32-bit architectures when we start doing 64-bit integer division. But
> > > > I don't have many other great ideas at the moment...
> > > 
> > > It will yield problems. There has been resistance on this topic before.
> > > I'm not sure the best way forward.
> > 
> > I'm not familiar with prior discussions (and resistance). Could you
> > point me to anything?
> 
> Quick search through the archives gives a recent discussion on 64-bit
> rates and base unit for clocks and cpufreq:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/260463.html
> 
> Seems like the last few mails were never picked up by the archives, but
> I went on to identify the architectures using the clk framework back in
> 3.16 and it is of course a mix of 32-bit and 64-bit.
> 
> And an older one from 2011 highlights the issues (or non-issues) with
> 64-bit division on 32-bit machines:
> 
> http://marc.info/?l=linux-kernel&m=132313553515474&w=2

Thanks for the pointers. So I see complaints about "bad code
generation", which seems like a vague claim and possibly unfounded,
though I don't nominate myself as the judge of that. It might suggest
that we could do better with unsigned than with signed.

There were also objections to dragging along cpufreq with you, and I
think those might be valid complaints. Cpufreq seems especially likely
not to care below KHz, and it's really not a problem if a clock consumer
wants to lose precision by dealing with 32-bit clock rates represented
in KHz. The clock core can still improve its precision (or at least not
choke on large values).

But otherwise, I see some helpful suggestions from Paul Walmsley, which
reminded me that do_div() and DIV_ROUND_UP_ULL() can get us a safe
64-bit / 32-bit division, at least.

> > > Compile time options to change the
> > > definition of a yet-uncreated clk_rate_t could be one way, but that
> > > seems like the path to madness.
> > > 
> > > Maybe once most of the upstream clock framework users upgrade to 64-bit
> > > machines then we can gain a consensus? I dunno, probably not :-/
> > 
> > Consensus is often hard to come by :) Anything I can do to help? I'd
> > prefer not to just defer this known problem for another "while." I'll be
> > having to do significant downstream patching if this can't be solved
> > upstream.
> 
> In your original mail you mentioned fixing up clk-divider with a
> band-aid fix. Care to post that to the list?

Sure. I was mostly referring to hacks that probably aren't acceptable
upstream, but I've now found something that might be OK.

My first solution was just to revert commit b11d282dbea2 "clk: divider:
fix rate calculation for fractional rates" and replace DIV_ROUND_UP()
with normal division again. But that obviously wouldn't be nice to some
users.

But I found a better solution that works for me: replace

  DIV_ROUND_UP(x, y)

with

  DIV_ROUND_UP_ULL((u64)x, y)

If that doesn't look like garbage to you, I'll send a patch shortly.

> > Also, in your opinion, is it worth trying to patch around the
> > DIV_ROUND_UP() issues in clk-divider.c without resolving the wider
> > overflow problem? Technically, my clock rates should still all fit
> > within 2^32-1, but DIV_ROUND_UP() requires more arithmetic headroom...
> 
> Well I don't want to change the semantics of how we round rates by
> accident. There is already enough discussion around that topic as it
> stands (e.g. round "nearest" or "floor" or "ceil" values).

Right, I wasn't planning on changing semantics (though my initial
solution would do just that). My latter solution should retain
stability.

Brian
