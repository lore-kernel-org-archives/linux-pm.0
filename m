From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [RFC PATCH 2/5] clk: Introduce 'clk_round_rate_nearest()'
Date: Mon, 19 May 2014 09:41:32 -0700
Message-ID: <db8633e5-01a9-4d3a-80e8-74e23a456d52@BN1BFFO11FD051.protection.gbl>
References: <1400106655-22465-1-git-send-email-soren.brinkmann@xilinx.com>
 <1400106655-22465-3-git-send-email-soren.brinkmann@xilinx.com>
 <20140515073816.GI16662@pengutronix.de>
 <91822600-39d0-4e71-b0f5-9eda35b76ec0@BN1AFFO11FD016.protection.gbl>
 <20140519161949.GG16662@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140519161949.GG16662@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Russell King <linux@arm.linux.org.uk>, Michal Simek <michal.simek@xilinx.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2014-05-19 at 06:19PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hi S=C3=B6ren,
>=20
> On Sun, May 18, 2014 at 05:51:05PM -0700, S=C3=B6ren Brinkmann wrote:
> > ------------------8<-----------------8<---------------------8<-----=
--------8<---
> > From: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > Date: Tue, 2 Apr 2013 10:08:13 -0700
> > Subject: [PATCH] clk: Introduce 'clk_round_rate_nearest()'
> >=20
> > Introduce a new API function to round a rate to the closest possibl=
e
> > rate the HW clock can generate.
> > In contrast to 'clk_round_rate()' which works similar, but always r=
eturns
> > a frequency <=3D its input rate.
> >=20
> > Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > ---
> >  drivers/clk/clk.c   | 43 +++++++++++++++++++++++++++++++++++++++++=
--
> >  include/linux/clk.h | 14 ++++++++++++--
> >  2 files changed, 53 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index dff0373f53c1..faf24d0569df 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -1011,8 +1011,9 @@ unsigned long __clk_round_rate(struct clk *cl=
k, unsigned long rate)
> >   * @rate: the rate which is to be rounded
> >   *
> >   * Takes in a rate as input and rounds it to a rate that the clk c=
an actually
> > - * use which is then returned.  If clk doesn't support round_rate =
operation
> > - * then the parent rate is returned.
> > + * use and does not exceed the requested frequency, which is then =
returned.
> > + * If clk doesn't support round_rate operation then the parent rat=
e
> > + * is returned.
> >   */
> >  long clk_round_rate(struct clk *clk, unsigned long rate)
> >  {
> > @@ -1027,6 +1028,44 @@ long clk_round_rate(struct clk *clk, unsigne=
d long rate)
> >  EXPORT_SYMBOL_GPL(clk_round_rate);
> > =20
> >  /**
> > + * clk_round_rate_nearest - round the given rate for a clk
> > + * @clk: the clk for which we are rounding a rate
> > + * @rate: the rate which is to be rounded
> > + *
> > + * Takes in a rate as input and rounds it to the closest rate that=
 the clk
> > + * can actually use which is then returned. If clk doesn't support
> > + * round_rate operation then the parent rate is returned.
> > + */
> > +long clk_round_rate_nearest(struct clk *clk, unsigned long rate)
> Why does this function doesn't return an unsigned long when it never
> returns a negative value? Ditto for clk_round_rate?

I matched the definition of clk_round_rate(). But you're probably right=
,
it may be the right thing to change clk_round_rate to return an
unsigned, but with that being exposed API it would be a risky change.

>=20
> > +{
> > +	unsigned long lower, upper, cur, lower_last, upper_last;
> > +
> > +	lower =3D clk_round_rate(clk, rate);
> > +	if (lower >=3D rate)
> > +		return lower;
> Is the >-case worth a warning?

No, it's correct behavior. If you request a rate that is way lower than=
 what the
clock can generate, returning something larger is perfectly valid, IMHO=
=2E
Which reveals one problem in this whole discussion. The API does not
require clk_round_rate() to round down. It is actually an implementatio=
n
choice that had been made for clk-divider.

>=20
> > +
> > +	upper =3D clk_round_rate(clk, rate + rate - lower);
> This was parenthesized in my original patch on purpose. If rate is bi=
g
>=20
> 	rate + rate - lower
>=20
> might overflow when
>=20
> 	rate + (rate - lower)
>=20
> doesn't. Thinking again, there is no real problem, because this is
> unsigned arithmetic. To be save we still need to check if rate + (rat=
e -
> lower) overflows.

Good point. I'll add the parentheses.

>=20
> > +	if (upper =3D=3D lower)
> if (upper <=3D rate) is the better check here. (=3D would be a bug.)

I don't understand. Passing rate + x to round rate can never return
something below 'lower'. Only something in the range [lower,lower+x].
So, if upper =3D=3D lower we found our closest frequency and return it.
Otherwise we have to iterate over [lower+1,upper]. Or what did I miss?

>=20
> > +		return upper;
> > +
> > +	lower =3D rate + 1;
> ok, so your loop invariant is that the best freq is in [lower; upper]=
=2E

right.

>=20
> > +	do {
> > +		upper_last =3D upper;
> > +		lower_last =3D lower;
> > +
> > +		cur =3D clk_round_rate(clk, lower + ((upper - lower) >> 1));
> > +		if (cur < lower)
> > +			lower +=3D (upper - lower) >> 1;
> You already know that lower + ((upper - lower) >> 1) is too small, so
> you can better do
>=20
> 	lower +=3D ((upper - lower) >> 1) + 1;

right. I'll add the '+1'

>=20
> > +		else
> > +			upper =3D cur;
> > +
> > +	} while (lower_last !=3D lower && upper_last !=3D upper);
> > +
> > +	return upper;
> > +}
> > +EXPORT_SYMBOL_GPL(clk_round_rate_nearest);
> I think the function still has potential for optimisation, what about=
:

At first glance, I don't see many differences except for the comments
you made above. I'll have a closer look though.

>=20
> unsigned long clk_round_rate_nearest(struct clk *clk, unsigned long r=
ate)
> {
> 	unsigned long lower, upper, rounded;
>=20
> 	rounded =3D clk_round_rate(clk, rate);
>=20
> 	if (rounded >=3D rate)
> 		return rounded;
>=20
> 	/*
> 	 * rounded is the best approximation for rate that is not
> 	 * bigger than rate. If there is a better one, it must be in the
> 	 * interval (rate; rate + (rate - rounded)).
> 	 * Note that the upper limit isn't better than rate itself, so
> 	 * that one doesn't need to be considered.
> 	 */
> 	=20
> 	upper =3D rate + (rate - rounded) - 1;
> 	if (upper < rate)
> 		upper =3D ULONG_MAX;=20

Aren't we done here? Your search for an upper boundary resulted in
'lower'. Hence there is no valid frequency closer to 'rate' than 'lower=
'. Why do
you extend to ULONG_MAX?

	Thanks,
	S=C3=B6ren
