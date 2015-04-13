From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: clk: clock rates can overflow 32-bit fields
Date: Mon, 13 Apr 2015 10:54:40 -0700
Message-ID: <20150413175440.GP32500@ld-irv-0074>
References: <CAN8TOE_7q1k_owngmwfzSADR_2Qe23A_PQfdmMCHcWqyrob2kQ@mail.gmail.com>
 <20150413055307.19585.53815@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:35435 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753635AbbDMRyt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Apr 2015 13:54:49 -0400
Content-Disposition: inline
In-Reply-To: <20150413055307.19585.53815@quantum>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, Linux PM mailing list <linux-pm@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, u.kleine-koenig@pengutronix.de, Jim Quinlan <jim2101024@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>

Hi Mike,

On Sun, Apr 12, 2015 at 10:53:07PM -0700, Michael Turquette wrote:
> Quoting Brian Norris (2015-04-12 21:24:22)
> > Hi,
> > 
> > I've recently been looking at using the common clock framework to
> > handle my CPU clocks for use by the cpufreq-dt driver, and I ran
> > across a few problems with integer overflow. On a 32-bit system,
> > 'unsigned long' (the type used in clk_set_rate() and similar APIs) is
> > often a 32-bit integer. This constrains the maximum clock frequency to
> > ~4.3 GHz, which is sufficient for most CPUs these days. However, I've
> > run into problems with high clock rates in the common clock framework
> > when
> 
> Morbid curiosity: what cpu/soc are you running that hits this problem?

I'm running into clk-divider.c overflows on a Broadcom BCM7xxx STB SoC
with an ARM Brahma B15 CPU (quad core, ARMv7, ~1.5 GHz). Our clock tree
contains a 3 GHz clock with a divider (divide by 2, 3, etc.) that yields
a max 1.5GHz CPU clock. I noticed the problem with a divisor of 2.

(I haven't seen >4.3GHz clocks on a 32-bit system yet, so my 2nd concern
is just theoretical at the moment.)

> > (1) using clk-divider.c; and/or
> > (2) using intermediate clocks that run faster than 4.3 GHz
> > 
> > With clk-divider.c, we can run into problems at lower clock rates due
> > to the usage of DIV_ROUND_UP (see, e.g., commit b11d282dbea2 "clk:
> > divider: fix rate calculation for fractional rates"), since this might
> > create overflows when doing the addition -- e.g., DIV_ROUND_UP(3 G,
> > 1.5 G) = (3 G + 1.5 G - 1) / 1.5 G = (OVERFLOW) / 1.5 G
> > 
> > I could probably fix up the clk-divider.c issue locally, if necessary.
> > But problem (2) seems to suggest a larger change may be required
> > throughout the framework, and I'd like to solicit opinions before
> > hacking away.
> 
> Yes, we've seen this problem coming up on us for a while. A related
> problem is fractional rates where we simply lop off the fractional Hz.
> Eg. 2.5Hz will be either 2 or 3 Hz depending on how your clock driver
> rounds things.

I was wondering if we have any problems with fractional Hz. Have you
seen users of such low frequencies?

How about adding floating point support to kernel space, and solve both
problems without widening the field size? :)

> > So, any thoughts on how to best tackle this problem? Should we upgrade
> > the clock framework to use a guaranteed 64-bit type for clock rates
> > (e.g., u64)?
> 
> Well here is the bat shit crazy idea I've had for a while:
> 
> 1) make rates 64-bit so that we're future proof. Max rate: 18 exahertz.
> 
> 2) make all clk api functions return s64 so that error codes can be
> baked into rates (that is a LOT of unused error codes). Likely all rate
> representation inside the clock framework will be s64. Max rate: 9
> exahertz.
> 
> 3) instead of hertz as the base unit, use millihertz (or something else
> sub-Hz?) to capture the fractional hertz stuff. Max rate: 9 petahertz.

These don't sound too fundamentally crazy to me, though the
implementation changeover could be a bit hairy (would we need
transitional APIs?), and I'm a little green on the implications for
users with limited 64-bit arithmetic.

> > I'm not sure if this will yield problems on certain
> > 32-bit architectures when we start doing 64-bit integer division. But
> > I don't have many other great ideas at the moment...
> 
> It will yield problems. There has been resistance on this topic before.
> I'm not sure the best way forward.

I'm not familiar with prior discussions (and resistance). Could you
point me to anything?

> Compile time options to change the
> definition of a yet-uncreated clk_rate_t could be one way, but that
> seems like the path to madness.
> 
> Maybe once most of the upstream clock framework users upgrade to 64-bit
> machines then we can gain a consensus? I dunno, probably not :-/

Consensus is often hard to come by :) Anything I can do to help? I'd
prefer not to just defer this known problem for another "while." I'll be
having to do significant downstream patching if this can't be solved
upstream.

Also, in your opinion, is it worth trying to patch around the
DIV_ROUND_UP() issues in clk-divider.c without resolving the wider
overflow problem? Technically, my clock rates should still all fit
within 2^32-1, but DIV_ROUND_UP() requires more arithmetic headroom...

Brian
