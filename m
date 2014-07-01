From: Boris BREZILLON <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH 1/4] clk: Introduce 'clk_find_nearest_rate()'
Date: Tue, 1 Jul 2014 09:18:04 +0200
Message-ID: <20140701091804.78bd529f@bbrezillon>
References: <1404147396-8041-1-git-send-email-soren.brinkmann@xilinx.com>
	<1404147396-8041-2-git-send-email-soren.brinkmann@xilinx.com>
	<20140630212707.1eb44db6@bbrezillon>
	<475a8ee0-11aa-4fad-94dc-9e5360f298d2@BL2FFO11FD028.protection.gbl>
	<20140701083214.5b31295e@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:60771 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753150AbaGAHSJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Jul 2014 03:18:09 -0400
In-Reply-To: <20140701083214.5b31295e@bbrezillon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Boris BREZILLON <boris.brezillon@free-electrons.com>
Cc: =?UTF-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>, Mike Turquette <mturquette@linaro.org>, linux-pm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Michal Simek <michal.simek@xilinx.com>, cpufreq@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org

On Tue, 1 Jul 2014 08:32:14 +0200
Boris BREZILLON <boris.brezillon@free-electrons.com> wrote:

> Hi S=C3=B6ren,
>=20
> On Mon, 30 Jun 2014 17:12:23 -0700
> S=C3=B6ren Brinkmann <soren.brinkmann@xilinx.com> wrote:
>=20
> > Hi Boris,
> >=20
> > On Mon, 2014-06-30 at 09:27PM +0200, Boris BREZILLON wrote:
> > > Hello Soren,
> > >=20
> > > On Mon, 30 Jun 2014 09:56:33 -0700
> > > Soren Brinkmann <soren.brinkmann@xilinx.com> wrote:
> > >=20
> > > > Introduce a new API function to find the rate a clock can
> > > > provide which is closest to a given rate.
> > > >=20
> > > > clk_round_rate() leaves it to the clock driver how rounding is
> > > > done. Commonly implementations round down due to use-cases that
> > > > have a certain frequency maximum that must not be exceeded.
> > >=20
> > > I had the same concern (how could a driver decide whether it
> > > should round up, down or to the closest value), but had a slightl=
y
> > > different approach in mind.
> > >=20
> > > AFAIU, you're assuming the clock is always a power of two (which
> > > is true most of the time, but some clock implementation might
> > > differ, i.e. a PLL accept any kind of multiplier not necessarily
> > > a power of 2).
> >=20
> > No, the idea is to always work. There should not be any such
> > limitation. Where do you see that?
>=20
> My bad, I should have read the code more carefully.
> BTW, it could help readers if you add some comments to explain how yo=
u
> are finding the nearest rate.
>=20
> My main concern with this approach is that you can spend some time
> iterating to find the nearest rate where a clk driver would find it
> quite quickly (because it knows exactly how the clk works and what ar=
e
> the possible clk muxing and clk modifiers options).
>=20
> >=20
> > >=20
> > > How about improving the clk_ops interface instead by adding a new
> > > method
> > >=20
> > > 	long (*round_rate_with_constraint)(struct clk_hw *hw,
> > > 					   unsigned long
> > > requested_rate, unsigned long *parent_rate,
> > > 					   enum clk_round_type
> > > type);
> > >=20
> > > with
> > >=20
> > > enum clk_round_type {
> > > 	CLK_ROUND_DOWN,
> > > 	CLK_ROUND_UP,
> > > 	CLK_ROUND_CLOSEST,
> > > };
> >=20
> > I thought about that, but the find_nearest() did already exist more
> > or less and in the end it is not much of a difference, IMHO. If it
> > turns out that the others are needed as well and somebody
> > implements it, they could be added as another convenience function
> > like I did, and/or it could be wrapped in the function you propose
> > here.
> >
> > >=20
> > > or just adding these 3 methods:
> > >=20
> > > 	long (*round_rate_up)(struct clk_hw *hw,
> > > 			      unsigned long requested_rate,
> > > 			      unsigned long *parent_rate);
> > >=20
> > > 	long (*round_rate_down)(struct clk_hw *hw,
> > > 				unsigned long requested_rate,
> > > 				unsigned long *parent_rate);
> > >=20
> > > 	long (*round_rate_closest)(struct clk_hw *hw,
> > > 				   unsigned long requested_rate,
> > > 				   unsigned long *parent_rate);
> >=20
> > That would be quite a change for clock drivers. So far, there are
> > not many restrictions on round_rate. I think there has already been
> > a discussion in this direction that went nowhere.
> > https://lkml.org/lkml/2010/7/14/260
> >=20
>=20
> Not if we keep these (or this, depending on the solution you chose)
> functions optional, and return -ENOTSUP, if they're not implemented.

Or even better: fall back to your implementation.

>=20
> > >=20
> > > and let the round_rate method implement the default behaviour.
> >=20
> > There is no real default. Rounding is not specified for the current
> > API.
>=20
> What I meant by default behavior is the behavior already implemented
> by the clock driver (either round up, down or closest).
> This way you do not introduce regressions with existing users, and ca=
n
> use new methods in new use cases.
>=20
> >=20
> > >=20
> > > This way you could add 3 functions to the API:
> > >=20
> > > clk_round_closest (or clk_find_nearest_rate as you called it),
> > > clk_round_up and clk_round_down, and let the clk driver
> > > implementation return the appropriate rate.
> >=20
> > I'd say the current patch set does kind of align with that, doesn't
> > it? We can add the find_nearest_rate() (there was a discussion on
> > the name, ane we decided against round_closest in favor of the
> > current proposal) now and the other functions could be added later
> > if people find them to be useful. And if they all get added we can
> > think about consolidating them if it made sense.
>=20
> Yes sure.
>=20
> Best Regards,
>=20
> Boris
>=20



--=20
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
