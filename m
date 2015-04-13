From: Michael Turquette <mturquette@linaro.org>
Subject: Re: clk: clock rates can overflow 32-bit fields
Date: Sun, 12 Apr 2015 22:53:07 -0700
Message-ID: <20150413055307.19585.53815@quantum>
References: <CAN8TOE_7q1k_owngmwfzSADR_2Qe23A_PQfdmMCHcWqyrob2kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:35565 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbbDMFxQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Apr 2015 01:53:16 -0400
Received: by iejt8 with SMTP id t8so56748905iej.2
        for <linux-pm@vger.kernel.org>; Sun, 12 Apr 2015 22:53:15 -0700 (PDT)
In-Reply-To: <CAN8TOE_7q1k_owngmwfzSADR_2Qe23A_PQfdmMCHcWqyrob2kQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, Linux PM mailing list <linux-pm@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, u.kleine-koenig@pengutronix.de, Jim Quinlan <jim2101024@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>

Quoting Brian Norris (2015-04-12 21:24:22)
> Hi,
> 
> I've recently been looking at using the common clock framework to
> handle my CPU clocks for use by the cpufreq-dt driver, and I ran
> across a few problems with integer overflow. On a 32-bit system,
> 'unsigned long' (the type used in clk_set_rate() and similar APIs) is
> often a 32-bit integer. This constrains the maximum clock frequency to
> ~4.3 GHz, which is sufficient for most CPUs these days. However, I've
> run into problems with high clock rates in the common clock framework
> when

Morbid curiosity: what cpu/soc are you running that hits this problem?

> 
> (1) using clk-divider.c; and/or
> (2) using intermediate clocks that run faster than 4.3 GHz
> 
> With clk-divider.c, we can run into problems at lower clock rates due
> to the usage of DIV_ROUND_UP (see, e.g., commit b11d282dbea2 "clk:
> divider: fix rate calculation for fractional rates"), since this might
> create overflows when doing the addition -- e.g., DIV_ROUND_UP(3 G,
> 1.5 G) = (3 G + 1.5 G - 1) / 1.5 G = (OVERFLOW) / 1.5 G
> 
> I could probably fix up the clk-divider.c issue locally, if necessary.
> But problem (2) seems to suggest a larger change may be required
> throughout the framework, and I'd like to solicit opinions before
> hacking away.

Yes, we've seen this problem coming up on us for a while. A related
problem is fractional rates where we simply lop off the fractional Hz.
Eg. 2.5Hz will be either 2 or 3 Hz depending on how your clock driver
rounds things.

> 
> So, any thoughts on how to best tackle this problem? Should we upgrade
> the clock framework to use a guaranteed 64-bit type for clock rates
> (e.g., u64)?

Well here is the bat shit crazy idea I've had for a while:

1) make rates 64-bit so that we're future proof. Max rate: 18 exahertz.

2) make all clk api functions return s64 so that error codes can be
baked into rates (that is a LOT of unused error codes). Likely all rate
representation inside the clock framework will be s64. Max rate: 9
exahertz.

3) instead of hertz as the base unit, use millihertz (or something else
sub-Hz?) to capture the fractional hertz stuff. Max rate: 9 petahertz.

> I'm not sure if this will yield problems on certain
> 32-bit architectures when we start doing 64-bit integer division. But
> I don't have many other great ideas at the moment...

It will yield problems. There has been resistance on this topic before.
I'm not sure the best way forward. Compile time options to change the
definition of a yet-uncreated clk_rate_t could be one way, but that
seems like the path to madness.

Maybe once most of the upstream clock framework users upgrade to 64-bit
machines then we can gain a consensus? I dunno, probably not :-/

Regards,
Mike

> 
> Brian
