From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH] clk: divider: handle integer overflow when dividing
 large clock rates
Date: Mon, 14 Sep 2015 14:08:39 -0700
Message-ID: <20150914210839.GA60225@google.com>
References: <1428966201-23365-1-git-send-email-computersforpeace@gmail.com>
 <20150414221137.19585.91216@quantum>
 <20150427154910.16410.11498@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34406 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbbINVIm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Sep 2015 17:08:42 -0400
Content-Disposition: inline
In-Reply-To: <20150427154910.16410.11498@quantum>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Jim Quinlan <jim2101024@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, u.kleine-koenig@pengutronix.de

(New address)

Hi Mike,

On Mon, Apr 27, 2015 at 08:49:10AM -0700, Michael Turquette wrote:
> Quoting Michael Turquette (2015-04-14 15:11:37)
> > Quoting Brian Norris (2015-04-13 16:03:21)
> > > On 32-bit architectures, 'unsigned long' (the type used to hold clock
> > > rates, in Hz) is often only 32 bits wide. DIV_ROUND_UP() (as used in,
> > > e.g., commit b11d282dbea2 "clk: divider: fix rate calculation for
> > > fractional rates") can yield an integer overflow on clock rates that are
> > > not (by themselves) too large to fit in 32 bits, because it performs
> > > addition before the division. See for example:
> > > 
> > >   DIV_ROUND_UP(3000000000, 1500000000) = (3.0G + 1.5G - 1) / 1.5G
> > >                                        = OVERFLOW / 1.5G
> > > 
> > > This patch fixes such cases by always promoting the dividend to 64-bits
> > > (unsigned long long) before doing the division. While this patch does
> > > not resolve the issue with large clock rates across the common clock
> > > framework nor address the problems with doing full 64-bit arithmetic on
> > > a 32-bit architecture, it does fix some issues seen when using clock
> > > dividers on a 3GHz reference clock to produce a 1.5GHz CPU clock for an
> > > ARMv7 Brahma B15 SoC.
> > > 
> > > Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> > > Reference: lkml.kernel.org/g/20150413201433.GQ32500@ld-irv-0074
> > > ---
> > > I'll admit I only compile-tested this particular patch. I have tested a version
> > > of this patch on top of a few backports on an older kernel, and everything
> > > works fine. Unforunately, some of my SoC's clock drivers still rely on
> > > out-of-tree code.
> > 
> > I smoke tested this on some hardware and it seemed fine to me. I'll give
> > some time for others to comment, otherwise I'll take this for 4.2 after
> > -rc1 drops.
> 
> Applied to clk-next.

I was rebasing my old patches onto Linus' latest, and I noticed that
this one never got in.

Brian
