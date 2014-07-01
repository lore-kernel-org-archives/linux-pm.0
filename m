From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH 1/4] clk: Introduce 'clk_find_nearest_rate()'
Date: Mon, 30 Jun 2014 17:12:23 -0700
Message-ID: <475a8ee0-11aa-4fad-94dc-9e5360f298d2@BL2FFO11FD028.protection.gbl>
References: <1404147396-8041-1-git-send-email-soren.brinkmann@xilinx.com>
 <1404147396-8041-2-git-send-email-soren.brinkmann@xilinx.com>
 <20140630212707.1eb44db6@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140630212707.1eb44db6@bbrezillon>
Sender: cpufreq-owner@vger.kernel.org
To: Boris BREZILLON <boris.brezillon@free-electrons.com>
Cc: Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Russell King <linux@arm.linux.org.uk>, linux-pm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Michal Simek <michal.simek@xilinx.com>, cpufreq@vger.kernel.org, linux-kernel@vger.kernel.org, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Boris,

On Mon, 2014-06-30 at 09:27PM +0200, Boris BREZILLON wrote:
> Hello Soren,
>=20
> On Mon, 30 Jun 2014 09:56:33 -0700
> Soren Brinkmann <soren.brinkmann@xilinx.com> wrote:
>=20
> > Introduce a new API function to find the rate a clock can provide
> > which is closest to a given rate.
> >=20
> > clk_round_rate() leaves it to the clock driver how rounding is done=
=2E
> > Commonly implementations round down due to use-cases that have a
> > certain frequency maximum that must not be exceeded.
>=20
> I had the same concern (how could a driver decide whether it should
> round up, down or to the closest value), but had a slightly different
> approach in mind.
>=20
> AFAIU, you're assuming the clock is always a power of two (which is
> true most of the time, but some clock implementation might differ,
> i.e. a PLL accept any kind of multiplier not necessarily a power of 2=
).

No, the idea is to always work. There should not be any such limitation=
=2E
Where do you see that?

>=20
> How about improving the clk_ops interface instead by adding a new met=
hod
>=20
> 	long (*round_rate_with_constraint)(struct clk_hw *hw,
> 					   unsigned long requested_rate,
> 					   unsigned long *parent_rate,
> 					   enum clk_round_type type);
>=20
> with
>=20
> enum clk_round_type {
> 	CLK_ROUND_DOWN,
> 	CLK_ROUND_UP,
> 	CLK_ROUND_CLOSEST,
> };

I thought about that, but the find_nearest() did already exist more or
less and in the end it is not much of a difference, IMHO. If it turns o=
ut that
the others are needed as well and somebody implements it, they could be
added as another convenience function like I did, and/or it could be
wrapped in the function you propose here.

>=20
> or just adding these 3 methods:
>=20
> 	long (*round_rate_up)(struct clk_hw *hw,
> 			      unsigned long requested_rate,
> 			      unsigned long *parent_rate);
>=20
> 	long (*round_rate_down)(struct clk_hw *hw,
> 				unsigned long requested_rate,
> 				unsigned long *parent_rate);
>=20
> 	long (*round_rate_closest)(struct clk_hw *hw,
> 				   unsigned long requested_rate,
> 				   unsigned long *parent_rate);

That would be quite a change for clock drivers. So far, there are not m=
any
restrictions on round_rate. I think there has already been a discussion
in this direction that went nowhere. https://lkml.org/lkml/2010/7/14/26=
0

>=20
> and let the round_rate method implement the default behaviour.

There is no real default. Rounding is not specified for the current API=
=2E

>=20
> This way you could add 3 functions to the API:
>=20
> clk_round_closest (or clk_find_nearest_rate as you called it),
> clk_round_up and clk_round_down, and let the clk driver implementatio=
n
> return the appropriate rate.

I'd say the current patch set does kind of align with that, doesn't it?
We can add the find_nearest_rate() (there was a discussion on the name,
ane we decided against round_closest in favor of the current proposal)
now and the other functions could be added later if people find them to
be useful. And if they all get added we can think about consolidating
them if it made sense.

	Thanks,
	S=C3=B6ren

