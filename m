From: Brian Norris <computersforpeace@gmail.com>
Subject: clk: clock rates can overflow 32-bit fields
Date: Sun, 12 Apr 2015 21:24:22 -0700
Message-ID: <CAN8TOE_7q1k_owngmwfzSADR_2Qe23A_PQfdmMCHcWqyrob2kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:33974 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbbDMEYX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Apr 2015 00:24:23 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Jim Quinlan <jim2101024@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>

Hi,

I've recently been looking at using the common clock framework to
handle my CPU clocks for use by the cpufreq-dt driver, and I ran
across a few problems with integer overflow. On a 32-bit system,
'unsigned long' (the type used in clk_set_rate() and similar APIs) is
often a 32-bit integer. This constrains the maximum clock frequency to
~4.3 GHz, which is sufficient for most CPUs these days. However, I've
run into problems with high clock rates in the common clock framework
when

(1) using clk-divider.c; and/or
(2) using intermediate clocks that run faster than 4.3 GHz

With clk-divider.c, we can run into problems at lower clock rates due
to the usage of DIV_ROUND_UP (see, e.g., commit b11d282dbea2 "clk:
divider: fix rate calculation for fractional rates"), since this might
create overflows when doing the addition -- e.g., DIV_ROUND_UP(3 G,
1.5 G) = (3 G + 1.5 G - 1) / 1.5 G = (OVERFLOW) / 1.5 G

I could probably fix up the clk-divider.c issue locally, if necessary.
But problem (2) seems to suggest a larger change may be required
throughout the framework, and I'd like to solicit opinions before
hacking away.

So, any thoughts on how to best tackle this problem? Should we upgrade
the clock framework to use a guaranteed 64-bit type for clock rates
(e.g., u64)? I'm not sure if this will yield problems on certain
32-bit architectures when we start doing 64-bit integer division. But
I don't have many other great ideas at the moment...

Brian
