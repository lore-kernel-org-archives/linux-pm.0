From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [RFC PATCH 2/5] clk: Introduce 'clk_round_rate_nearest()'
Date: Tue, 20 May 2014 09:01:38 -0700
Message-ID: <4bb5f44a-60bb-4e34-8f88-f91b8419be8d@BL2FFO11FD050.protection.gbl>
References: <1400106655-22465-1-git-send-email-soren.brinkmann@xilinx.com>
 <1400106655-22465-3-git-send-email-soren.brinkmann@xilinx.com>
 <20140515073816.GI16662@pengutronix.de>
 <91822600-39d0-4e71-b0f5-9eda35b76ec0@BN1AFFO11FD016.protection.gbl>
 <20140519161949.GG16662@pengutronix.de>
 <db8633e5-01a9-4d3a-80e8-74e23a456d52@BN1BFFO11FD051.protection.gbl>
 <20140520073358.GJ16662@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140520073358.GJ16662@pengutronix.de>
Sender: cpufreq-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Russell King <linux@arm.linux.org.uk>, Michal Simek <michal.simek@xilinx.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Uwe,

On Tue, 2014-05-20 at 09:33AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hi S=C3=B6ren,
>=20
> On Mon, May 19, 2014 at 09:41:32AM -0700, S=C3=B6ren Brinkmann wrote:
> > On Mon, 2014-05-19 at 06:19PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > Hi S=C3=B6ren,
> > >=20
> > > On Sun, May 18, 2014 at 05:51:05PM -0700, S=C3=B6ren Brinkmann wr=
ote:
> > > > ------------------8<-----------------8<---------------------8<-=
------------8<---
> > > > From: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > > > Date: Tue, 2 Apr 2013 10:08:13 -0700
> > > > Subject: [PATCH] clk: Introduce 'clk_round_rate_nearest()'
> > > >=20
> > > > Introduce a new API function to round a rate to the closest pos=
sible
> > > > rate the HW clock can generate.
> > > > In contrast to 'clk_round_rate()' which works similar, but alwa=
ys returns
> > > > a frequency <=3D its input rate.
> > > >=20
> > > > Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > > > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > > > ---
> > > >  drivers/clk/clk.c   | 43 +++++++++++++++++++++++++++++++++++++=
++++--
> > > >  include/linux/clk.h | 14 ++++++++++++--
> > > >  2 files changed, 53 insertions(+), 4 deletions(-)
> > > >=20
> > > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > > index dff0373f53c1..faf24d0569df 100644
> > > > --- a/drivers/clk/clk.c
> > > > +++ b/drivers/clk/clk.c
> > > > @@ -1011,8 +1011,9 @@ unsigned long __clk_round_rate(struct clk=
 *clk, unsigned long rate)
> > > >   * @rate: the rate which is to be rounded
> > > >   *
> > > >   * Takes in a rate as input and rounds it to a rate that the c=
lk can actually
> > > > - * use which is then returned.  If clk doesn't support round_r=
ate operation
> > > > - * then the parent rate is returned.
> > > > + * use and does not exceed the requested frequency, which is t=
hen returned.
> > > > + * If clk doesn't support round_rate operation then the parent=
 rate
> > > > + * is returned.
> > > >   */
> > > >  long clk_round_rate(struct clk *clk, unsigned long rate)
> > > >  {
> > > > @@ -1027,6 +1028,44 @@ long clk_round_rate(struct clk *clk, uns=
igned long rate)
> > > >  EXPORT_SYMBOL_GPL(clk_round_rate);
> > > > =20
> > > >  /**
> > > > + * clk_round_rate_nearest - round the given rate for a clk
> > > > + * @clk: the clk for which we are rounding a rate
> > > > + * @rate: the rate which is to be rounded
> > > > + *
> > > > + * Takes in a rate as input and rounds it to the closest rate =
that the clk
> > > > + * can actually use which is then returned. If clk doesn't sup=
port
> > > > + * round_rate operation then the parent rate is returned.
> > > > + */
> > > > +long clk_round_rate_nearest(struct clk *clk, unsigned long rat=
e)
> > > Why does this function doesn't return an unsigned long when it ne=
ver
> > > returns a negative value? Ditto for clk_round_rate?
> >=20
> > I matched the definition of clk_round_rate(). But you're probably r=
ight,
> > it may be the right thing to change clk_round_rate to return an
> > unsigned, but with that being exposed API it would be a risky chang=
e.
> Russell, what do you think?
>=20
> > > > +{
> > > > +	unsigned long lower, upper, cur, lower_last, upper_last;
> > > > +
> > > > +	lower =3D clk_round_rate(clk, rate);
> > > > +	if (lower >=3D rate)
> > > > +		return lower;
> > > Is the >-case worth a warning?
> >=20
> > No, it's correct behavior. If you request a rate that is way lower =
than what the
> > clock can generate, returning something larger is perfectly valid, =
IMHO.
> > Which reveals one problem in this whole discussion. The API does no=
t
> > require clk_round_rate() to round down. It is actually an implement=
ation
> > choice that had been made for clk-divider.
> I'm sure it's more than an implementation choice for clk-divider. But=
 I
> don't find any respective documentation (but I didn't try hard).

A similar discussion - without final conclusion:
https://lkml.org/lkml/2010/7/14/260

>=20
>=20
> > > > +
> > > > +	upper =3D clk_round_rate(clk, rate + rate - lower);
> > > This was parenthesized in my original patch on purpose. If rate i=
s big
> > >=20
> > > 	rate + rate - lower
> > >=20
> > > might overflow when
> > >=20
> > > 	rate + (rate - lower)
> > >=20
> > > doesn't. Thinking again, there is no real problem, because this i=
s
> > > unsigned arithmetic. To be save we still need to check if rate + =
(rate -
> > > lower) overflows.
> >=20
> > Good point. I'll add the parentheses.
> >=20
> > >=20
> > > > +	if (upper =3D=3D lower)
> > > if (upper <=3D rate) is the better check here. (=3D would be a bu=
g.)
> >=20
> > I don't understand. Passing rate + x to round rate can never return
> > something below 'lower'. Only something in the range [lower,lower+x=
].
> > So, if upper =3D=3D lower we found our closest frequency and return=
 it.
> > Otherwise we have to iterate over [lower+1,upper]. Or what did I mi=
ss?
> Assuming a correct implementation of clk_round_rate there is no
> difference. Checking for <=3D rate is just a bit more robust for brok=
en
> implementations.
>=20
> > > > +		return upper;
> > > > +
> > > > +	lower =3D rate + 1;
> > > ok, so your loop invariant is that the best freq is in [lower; up=
per].
> >=20
> > right.
> >=20
> > >=20
> > > > +	do {
> > > > +		upper_last =3D upper;
> > > > +		lower_last =3D lower;
> > > > +
> > > > +		cur =3D clk_round_rate(clk, lower + ((upper - lower) >> 1));
> > > > +		if (cur < lower)
> > > > +			lower +=3D (upper - lower) >> 1;
> > > You already know that lower + ((upper - lower) >> 1) is too small=
, so
> > > you can better do
> > >=20
> > > 	lower +=3D ((upper - lower) >> 1) + 1;
> >=20
> > right. I'll add the '+1'
> >=20
> > >=20
> > > > +		else
> > > > +			upper =3D cur;
> > > > +
> > > > +	} while (lower_last !=3D lower && upper_last !=3D upper);
> > > > +
> > > > +	return upper;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(clk_round_rate_nearest);
> > > I think the function still has potential for optimisation, what a=
bout:
> >=20
> > At first glance, I don't see many differences except for the commen=
ts
> > you made above. I'll have a closer look though.
> I would expect my variant to result in more effective code as it has
> simpler expressions.
>=20
> > > unsigned long clk_round_rate_nearest(struct clk *clk, unsigned lo=
ng rate)
> > > {
> > > 	unsigned long lower, upper, rounded;
> > >=20
> > > 	rounded =3D clk_round_rate(clk, rate);
> > >=20
> > > 	if (rounded >=3D rate)
> > > 		return rounded;
> > >=20
> > > 	/*
> > > 	 * rounded is the best approximation for rate that is not
> > > 	 * bigger than rate. If there is a better one, it must be in the
> > > 	 * interval (rate; rate + (rate - rounded)).
> > > 	 * Note that the upper limit isn't better than rate itself, so
> > > 	 * that one doesn't need to be considered.
> > > 	 */
> > > 	=20
> > > 	upper =3D rate + (rate - rounded) - 1;
> > > 	if (upper < rate)
> > > 		upper =3D ULONG_MAX;=20
> >=20
> > Aren't we done here? Your search for an upper boundary resulted in
> > 'lower'. Hence there is no valid frequency closer to 'rate' than 'l=
ower'. Why do
> > you extend to ULONG_MAX?
> Consider a clock that can do (assuming ULONG_MAX =3D 4294967295):
>=20
> 	12000, 4294967285
>=20
> and you call
>=20
> 	clk_round_rate_nearest(clk, 4294967283)
>=20
> Then we have:
>=20
> 	rounded =3D clk_round_rate(clk, 4294967283) =3D 12000.
> 	upper =3D 4294955269
>=20
> because the addition overflowed upper is smaller than rate. Still we
> want to find rate=3D4294967285, right?

Ah, now I see the problem. Thanks. Due to the return type being long, I
kinda assumed that we operate far away from an overflow and should be
pretty much safe. Taking an overflow into account complicates things a
bit. I give this another look.

 	S=C3=B6ren

