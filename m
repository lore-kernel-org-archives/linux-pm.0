From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH 1/4] clk: Introduce 'clk_find_nearest_rate()'
Date: Tue, 1 Jul 2014 10:52:09 -0700
Message-ID: <1cc8398e-bbbb-47f9-9f02-30f4d1237ab4@BY2FFO11FD003.protection.gbl>
References: <1404147396-8041-1-git-send-email-soren.brinkmann@xilinx.com>
 <1404147396-8041-2-git-send-email-soren.brinkmann@xilinx.com>
 <20140701082302.GL14781@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140701082302.GL14781@pengutronix.de>
Sender: cpufreq-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Russell King <linux@arm.linux.org.uk>, Michal Simek <michal.simek@xilinx.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Uwe,

On Tue, 2014-07-01 at 10:23AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Mon, Jun 30, 2014 at 09:56:33AM -0700, Soren Brinkmann wrote:
> > Introduce a new API function to find the rate a clock can provide w=
hich
> > is closest to a given rate.
> >=20
> > clk_round_rate() leaves it to the clock driver how rounding is done=
=2E
> > Commonly implementations round down due to use-cases that have a ce=
rtain
> > frequency maximum that must not be exceeded.
> >=20
> > The new API call enables use-cases where accuracy is preferred. E.g=
=2E
> > Ethernet clocks.
> >=20
> > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > ---
> >=20
> >  drivers/clk/clk.c   | 57 +++++++++++++++++++++++++++++++++++++++++=
++++++++++++
> >  include/linux/clk.h |  9 +++++++++
> >  2 files changed, 66 insertions(+)
> >=20
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index 8b73edef151d..fce1165cd879 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -1030,6 +1030,63 @@ long clk_round_rate(struct clk *clk, unsigne=
d long rate)
> >  EXPORT_SYMBOL_GPL(clk_round_rate);
> > =20
> >  /**
> > + * clk_find_nearest_rate - round the given rate for a clk
> > + * @clk: the clk for which we are rounding a rate
> > + * @rate: the rate which is to be rounded
> > + *
> > + * Takes in a rate as input and finds the closest rate that the cl=
k
> > + * can actually use which is then returned.
> > + * Note: This function relies on the clock's clk_round_rate() impl=
ementation.
> > + * For cases clk_round_rate() rounds up, not the closest but the r=
ounded up
> > + * rate is found.
> > + */
> > +long clk_find_nearest_rate(struct clk *clk, unsigned long rate)
> > +{
> > +	long ret, lower, upper;
> > +	unsigned long tmp;
> > +
> > +	clk_prepare_lock();
> > +
> > +	lower =3D __clk_round_rate(clk, rate);
> > +	if (lower >=3D rate || lower < 0) {
> > +		ret =3D lower;
> > +		goto unlock;
> > +	}
> > +
> > +	tmp =3D rate + (rate - lower) - 1;
> > +	if (tmp > LONG_MAX)
> > +		upper =3D LONG_MAX;
> > +	else
> > +		upper =3D tmp;
> Consider rate =3D 0xf0000000, lower =3D 0x7fffffff (=3D LONG_MAX). Th=
en tmp =3D
> (unsigned long)0x160000000 =3D 0x60000000. In this case you pick uppe=
r =3D
> 0x60000000 while you should use upper =3D LONG_MAX.
Strictly speaking yes, but isn't 0xf000000 already an invalid argument?
I kept it as unsigned long to match the round_rate prototype, but as we
discussed before, rates should probably all be long only since the
return type of these functions is signed. Unless I miss something,
requesting a rate > LONG_MAX while we can return a long only should not
be possible. Hence, I was assuming to work with rates in the range up t=
o
LONG_MAX only for now.
But adding a something like 'if (rate > LONG_MAX) return -EINVAL;' woul=
d
probably be a good idea in this case.

>=20
> I think you need
>=20
> -	if (tmp > LONG_MAX)
> +	if (tmp > LONG_MAX || tmp < rate)
I was looking for how to correctly check for arithmetic overflows (sinc=
e
you pointed out the flaws with my solution using casts), and this check
relies on undefined behavior as well, IIUC.

>=20
> (and a comment)
>=20
> > +
> > +	upper =3D __clk_round_rate(clk, upper);
> > +	if (upper <=3D lower || upper < 0) {
> Is it an idea to do something like:
>=20
> 		if (IS_ENABLED(CONFIG_CLK_SANITY_CHECKS))
> 			WARN_ON(upper < lower && upper >=3D 0);
>=20
> here?
Probably a good idea. I assumed that we can - more or less - safely
count on that behavior once we are through those checks above.

>=20
> > +		ret =3D lower;
> > +		goto unlock;
> > +	}
> > +
> > +	lower =3D rate + 1;
> > +	while (lower < upper) {
> > +		long rounded, mid;
> > +
> > +		mid =3D lower + ((upper - lower) >> 1);
> > +		rounded =3D __clk_round_rate(clk, mid);
> > +		if (rounded < lower)
> > +			lower =3D mid + 1;
> > +		else
> > +			upper =3D rounded;
> > +	}
> This is broken if you don't assume that __clk_round_rate rounds down.
> Consider an implementation that already does round_nearest and clk ca=
n
> assume the values 0x60000 and 0x85000 (and nothing in between), and r=
ate
> =3D 0x70000. This results in
>=20
> 	lower =3D 0x60000;
> 	tmp =3D 0x7ffff;
> 	upper =3D __clk_round_rate(clk, 0x7ffff) =3D 0x85000
>=20
> before the loop and the loop then doesn't even terminate.
Good catch. With rounding being unspecified, there are a lot of
corner cases.
I think this change would fix that corner case, but I'm not sure it
covers all:
=20
        tmp =3D rate + (rate - lower) - 1;
        if (tmp > LONG_MAX)
-               upper =3D LONG_MAX;
-       else
-               upper =3D tmp;
+               tmp =3D LONG_MAX;
=20
-       upper =3D __clk_round_rate(clk, upper);
-       if (upper <=3D lower || upper < 0) {
+       upper =3D __clk_round_rate(clk, tmp);
+       if (upper <=3D lower || upper < 0 || upper > tmp) {
                ret =3D lower;
                goto unlock;
        }

	Thanks,
	S=C3=B6ren

