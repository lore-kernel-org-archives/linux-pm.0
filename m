From: Boris BREZILLON <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH 1/4] clk: Introduce 'clk_find_nearest_rate()'
Date: Tue, 1 Jul 2014 08:32:14 +0200
Message-ID: <20140701083214.5b31295e@bbrezillon>
References: <1404147396-8041-1-git-send-email-soren.brinkmann@xilinx.com>
	<1404147396-8041-2-git-send-email-soren.brinkmann@xilinx.com>
	<20140630212707.1eb44db6@bbrezillon>
	<475a8ee0-11aa-4fad-94dc-9e5360f298d2@BL2FFO11FD028.protection.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <475a8ee0-11aa-4fad-94dc-9e5360f298d2@BL2FFO11FD028.protection.gbl>
Sender: cpufreq-owner@vger.kernel.org
To: =?UTF-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Cc: Mike Turquette <mturquette@linaro.org>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5p?= =?UTF-8?B?Zw==?= <u.kleine-koenig@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Michal Simek <michal.simek@xilinx.com>, cpufreq@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi S=C3=B6ren,

On Mon, 30 Jun 2014 17:12:23 -0700
S=C3=B6ren Brinkmann <soren.brinkmann@xilinx.com> wrote:

> Hi Boris,
>=20
> On Mon, 2014-06-30 at 09:27PM +0200, Boris BREZILLON wrote:
> > Hello Soren,
> >=20
> > On Mon, 30 Jun 2014 09:56:33 -0700
> > Soren Brinkmann <soren.brinkmann@xilinx.com> wrote:
> >=20
> > > Introduce a new API function to find the rate a clock can provide
> > > which is closest to a given rate.
> > >=20
> > > clk_round_rate() leaves it to the clock driver how rounding is
> > > done. Commonly implementations round down due to use-cases that
> > > have a certain frequency maximum that must not be exceeded.
> >=20
> > I had the same concern (how could a driver decide whether it should
> > round up, down or to the closest value), but had a slightly
> > different approach in mind.
> >=20
> > AFAIU, you're assuming the clock is always a power of two (which is
> > true most of the time, but some clock implementation might differ,
> > i.e. a PLL accept any kind of multiplier not necessarily a power of
> > 2).
>=20
> No, the idea is to always work. There should not be any such
> limitation. Where do you see that?

My bad, I should have read the code more carefully.
BTW, it could help readers if you add some comments to explain how you
are finding the nearest rate.

My main concern with this approach is that you can spend some time
iterating to find the nearest rate where a clk driver would find it
quite quickly (because it knows exactly how the clk works and what are
the possible clk muxing and clk modifiers options).

>=20
> >=20
> > How about improving the clk_ops interface instead by adding a new
> > method
> >=20
> > 	long (*round_rate_with_constraint)(struct clk_hw *hw,
> > 					   unsigned long
> > requested_rate, unsigned long *parent_rate,
> > 					   enum clk_round_type
> > type);
> >=20
> > with
> >=20
> > enum clk_round_type {
> > 	CLK_ROUND_DOWN,
> > 	CLK_ROUND_UP,
> > 	CLK_ROUND_CLOSEST,
> > };
>=20
> I thought about that, but the find_nearest() did already exist more o=
r
> less and in the end it is not much of a difference, IMHO. If it turns
> out that the others are needed as well and somebody implements it,
> they could be added as another convenience function like I did,
> and/or it could be wrapped in the function you propose here.
>
> >=20
> > or just adding these 3 methods:
> >=20
> > 	long (*round_rate_up)(struct clk_hw *hw,
> > 			      unsigned long requested_rate,
> > 			      unsigned long *parent_rate);
> >=20
> > 	long (*round_rate_down)(struct clk_hw *hw,
> > 				unsigned long requested_rate,
> > 				unsigned long *parent_rate);
> >=20
> > 	long (*round_rate_closest)(struct clk_hw *hw,
> > 				   unsigned long requested_rate,
> > 				   unsigned long *parent_rate);
>=20
> That would be quite a change for clock drivers. So far, there are not
> many restrictions on round_rate. I think there has already been a
> discussion in this direction that went nowhere.
> https://lkml.org/lkml/2010/7/14/260
>=20

Not if we keep these (or this, depending on the solution you chose)
functions optional, and return -ENOTSUP, if they're not implemented.

> >=20
> > and let the round_rate method implement the default behaviour.
>=20
> There is no real default. Rounding is not specified for the current
> API.

What I meant by default behavior is the behavior already implemented by
the clock driver (either round up, down or closest).
This way you do not introduce regressions with existing users, and can
use new methods in new use cases.

>=20
> >=20
> > This way you could add 3 functions to the API:
> >=20
> > clk_round_closest (or clk_find_nearest_rate as you called it),
> > clk_round_up and clk_round_down, and let the clk driver
> > implementation return the appropriate rate.
>=20
> I'd say the current patch set does kind of align with that, doesn't
> it? We can add the find_nearest_rate() (there was a discussion on the
> name, ane we decided against round_closest in favor of the current
> proposal) now and the other functions could be added later if people
> find them to be useful. And if they all get added we can think about
> consolidating them if it made sense.

Yes sure.

Best Regards,

Boris

--=20
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
