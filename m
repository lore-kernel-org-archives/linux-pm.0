From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [RFC PATCH 2/5] clk: Introduce 'clk_round_rate_nearest()'
Date: Fri, 6 Jun 2014 17:44:57 -0700
Message-ID: <fabca95a-fca0-4a8e-b79a-c7d6437de9f0@BL2FFO11FD042.protection.gbl>
References: <20140520073358.GJ16662@pengutronix.de>
 <4bb5f44a-60bb-4e34-8f88-f91b8419be8d@BL2FFO11FD050.protection.gbl>
 <537B957B.5010001@codeaurora.org>
 <668683e3-856e-4f30-9b11-8f3e91e12d1d@BL2FFO11FD038.protection.gbl>
 <20140521073457.GD31687@pengutronix.de>
 <e9090453-ce40-4662-a3ea-fbdaffdb2aa4@BN1AFFO11FD046.protection.gbl>
 <20140521182308.GN31687@pengutronix.de> <20140521203300.9521.67546@quantum>
 <ac335a38-b0f4-4d95-b111-56c05e1a6234@BN1BFFO11FD045.protection.gbl>
 <20140522182040.GB20155@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140522182040.GB20155@pengutronix.de>
Sender: cpufreq-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Mike Turquette <mturquette@linaro.org>, Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Michal Simek <michal.simek@xilinx.com>, cpufreq@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2014-05-22 at 08:20PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello S=C3=B6ren,
>=20
> On Thu, May 22, 2014 at 11:03:00AM -0700, S=C3=B6ren Brinkmann wrote:
> > On Wed, 2014-05-21 at 01:33PM -0700, Mike Turquette wrote:
> > > Quoting Uwe Kleine-K=C3=B6nig (2014-05-21 11:23:08)
> > > > Hello S=C3=B6ren,
> > > >=20
> > > > On Wed, May 21, 2014 at 08:58:10AM -0700, S=C3=B6ren Brinkmann =
wrote:
> > > > > On Wed, 2014-05-21 at 09:34AM +0200, Uwe Kleine-K=C3=B6nig wr=
ote:
> > > > > > On Tue, May 20, 2014 at 02:48:20PM -0700, S=C3=B6ren Brinkm=
ann wrote:
> > > > > > > On Tue, 2014-05-20 at 10:48AM -0700, Stephen Boyd wrote:
> > > > > > > > On 05/20/14 09:01, S=C3=B6ren Brinkmann wrote:
> > > > > > > > >
> > > > > > > > >>>>> +{
> > > > > > > > >>>>> + unsigned long lower, upper, cur, lower_last, up=
per_last;
> > > > > > > > >>>>> +
> > > > > > > > >>>>> + lower =3D clk_round_rate(clk, rate);
> > > > > > > > >>>>> + if (lower >=3D rate)
> > > > > > > > >>>>> +         return lower;
> > > > > > > > >>>> Is the >-case worth a warning?
> > > > > > > > >>> No, it's correct behavior. If you request a rate th=
at is way lower than what the
> > > > > > > > >>> clock can generate, returning something larger is p=
erfectly valid, IMHO.
> > > > > > > > >>> Which reveals one problem in this whole discussion.=
 The API does not
> > > > > > > > >>> require clk_round_rate() to round down. It is actua=
lly an implementation
> > > > > > > > >>> choice that had been made for clk-divider.
> > > > > > > > >> I'm sure it's more than an implementation choice for=
 clk-divider. But I
> > > > > > > > >> don't find any respective documentation (but I didn'=
t try hard).
> > > > > > > > > A similar discussion - without final conclusion:
> > > > > > > > > https://lkml.org/lkml/2010/7/14/260
> > > > > > > > >
> > > > > > > > >
> > > > > > > >=20
> > > > > > > > Please call this new API something like clk_find_neares=
t_rate() or
> > > > > > > > something. clk_round_rate() is supposed to return the r=
ate that will be
> > > > > > > > set if you call clk_set_rate() with the same arguments.=
 It's up to the
> > > > > > > > implementation to decide if that means rounding the rat=
e up or down or
> > > > > > > > to the nearest value.
> > > > > > >=20
> > > > > > > Sounds good to me. Are there any cases of clocks that rou=
nd up? I think
> > > > > > > that case would not be handled correctly. But I also don'=
t see a use
> > > > > > > case for such an implementation.
> > > > > > I don't really care which semantic (i.e. round up, round do=
wn or round
> > > > > > closest) is picked, but I'd vote that all should pick up th=
e same. I
> > > > > > think the least surprising definition is to choose rounding=
 down and add
> > > > > > the function that is under discussion here to get a nearest=
 match.
> > > > > >=20
> > > > > > So I suggest:
> > > > > >=20
> > > > > >     - if round_rate is given a rate that is smaller than th=
e
> > > > > >       smallest available rate, return 0
> > > > > >     - add WARN_ONCE to round_rate and set_rate if they retu=
rn with a
> > > > > >       rate bigger than requested
> > > > >=20
> > > > > Why do you think 0 is always valid? I think for a clock that =
can
> > > > > generate 40, 70, 120, clk_round_rate(20) should return 40.
> > > > I didn't say it's a valid value. It just makes the it possible =
to check
> > > > for clk_round_rate(clk, rate) <=3D rate.
> > > >=20
> > > > I grepped a bit around and found da850_round_armrate which impl=
ements a
> > > > round_rate callback returning the best match.
> > > > omap1_clk_round_rate_ckctl_arm can return a value < 0.
> > > > s3c2412_roundrate_usbsrc can return values that are bigger than
> > > > requested. (I wonder if that is a bug though.)
> > > >=20
> > > > > >     - change the return values to unsigned long
> > > > >=20
> > > > > Yep, I agree, this should happen.
> > > > And we're using 0 as error value? e.g. for the case where
> > > > omap1_clk_round_rate_ckctl_arm returns -EIO now?
> > >=20
> > > No. clk_round_rate returns long for a reason, which is that we ca=
n
> > > provide an error code to the caller. From include/linux/clk.h:
> > >=20
> > > /**
> > >  * clk_round_rate - adjust a rate to the exact rate a clock can p=
rovide
> > >  * @clk: clock source
> > >  * @rate: desired clock rate in Hz
> > >  *
> > >  * Returns rounded clock rate in Hz, or negative errno.
> > >  */
> > >=20
> > > This has the unfortunate side effect that the max value we can re=
turn
> > > safely is 2147483647 (~2GHz). So another issue here is converting=
 clock
> > > rates to 64-bit values.
> >=20
> > So, let's assume
> >  - a clock does either of these
> >    - round down
> >    - round nearest
> >    - round up (is there any such case? I don't see a use-case for t=
his)
> >  - or return an error
> >=20
> > I think my latest try handles such cases, with the limitation of
> > for a clock that rounds up, the up-rounded value is found instead o=
f the
> > nearest.
> >=20
> >=20
> > static long clk_find_nearest_rate(struct clk *clk, unsigned long ra=
te)
> > {
> > 	long ret;
> > 	unsigned long lower, upper;
> >=20
> > 	clk_prepare_lock();
> >=20
> > 	lower =3D __clk_round_rate(clk, rate);
> this is CCF specific while I don't see a need for it. (But yes, a
> lock-less clk_find_nearest_rate is of course racy.)
>=20
> > 	if (lower >=3D rate || (long)lower < 0) {
> If you made lower and upper a signed long, you could drop the casting
> here. BTW, why does __clk_round_rate return an unsigned long??
> There seem to be several more type mismatches in that area.
> Maybe we should add a waring if rate is > LONG_MAX?
>=20
> (And ISTR that the C standard doesn't specify what the result of
> (long)lower is given that lower is of type unsigned long and holding =
a
> value > LONG_MAX.)

I have another iteration. I kept the locking part, switched to assuming
'long' being used for frequencies and hopefully got rid of constructs
that are not defined by the C standard:

long clk_find_nearest_rate(struct clk *clk, unsigned long rate)
{
	long ret, lower, upper;
	unsigned long tmp;

	clk_prepare_lock();

	lower =3D __clk_round_rate(clk, rate);
	if (lower >=3D rate || lower < 0) {
		ret =3D lower;
		goto unlock;
	}

	tmp =3D rate + (rate - lower) - 1;
	if (tmp > LONG_MAX)
		upper =3D LONG_MAX;
	else
		upper =3D tmp;

	upper =3D __clk_round_rate(clk, upper);
	if (upper <=3D lower || upper < 0) {
		ret =3D lower;
		goto unlock;
	}

	lower =3D rate + 1;
	while (lower < upper) {
		long rounded, mid;

		mid =3D lower + ((upper - lower) >> 1);
		rounded =3D __clk_round_rate(clk, mid);
		if (rounded < lower)
			lower =3D mid + 1;
		else
			upper =3D rounded;
	}

	ret =3D upper;

unlock:
	clk_prepare_unlock();

	return ret;
}

Is there a more elegant way to check for the arithmetic overflow?

	Thanks,
	S=C3=B6ren

