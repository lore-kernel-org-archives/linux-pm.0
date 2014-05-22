From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [RFC PATCH 2/5] clk: Introduce 'clk_round_rate_nearest()'
Date: Thu, 22 May 2014 11:03:00 -0700
Message-ID: <ac335a38-b0f4-4d95-b111-56c05e1a6234@BN1BFFO11FD045.protection.gbl>
References: <20140519161949.GG16662@pengutronix.de>
 <db8633e5-01a9-4d3a-80e8-74e23a456d52@BN1BFFO11FD051.protection.gbl>
 <20140520073358.GJ16662@pengutronix.de>
 <4bb5f44a-60bb-4e34-8f88-f91b8419be8d@BL2FFO11FD050.protection.gbl>
 <537B957B.5010001@codeaurora.org>
 <668683e3-856e-4f30-9b11-8f3e91e12d1d@BL2FFO11FD038.protection.gbl>
 <20140521073457.GD31687@pengutronix.de>
 <e9090453-ce40-4662-a3ea-fbdaffdb2aa4@BN1AFFO11FD046.protection.gbl>
 <20140521182308.GN31687@pengutronix.de> <20140521203300.9521.67546@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140521203300.9521.67546@quantum>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Michal Simek <michal.simek@xilinx.com>, cpufreq@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2014-05-21 at 01:33PM -0700, Mike Turquette wrote:
> Quoting Uwe Kleine-K=C3=B6nig (2014-05-21 11:23:08)
> > Hello S=C3=B6ren,
> >=20
> > On Wed, May 21, 2014 at 08:58:10AM -0700, S=C3=B6ren Brinkmann wrot=
e:
> > > On Wed, 2014-05-21 at 09:34AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > > On Tue, May 20, 2014 at 02:48:20PM -0700, S=C3=B6ren Brinkmann =
wrote:
> > > > > On Tue, 2014-05-20 at 10:48AM -0700, Stephen Boyd wrote:
> > > > > > On 05/20/14 09:01, S=C3=B6ren Brinkmann wrote:
> > > > > > >
> > > > > > >>>>> +{
> > > > > > >>>>> + unsigned long lower, upper, cur, lower_last, upper_=
last;
> > > > > > >>>>> +
> > > > > > >>>>> + lower =3D clk_round_rate(clk, rate);
> > > > > > >>>>> + if (lower >=3D rate)
> > > > > > >>>>> +         return lower;
> > > > > > >>>> Is the >-case worth a warning?
> > > > > > >>> No, it's correct behavior. If you request a rate that i=
s way lower than what the
> > > > > > >>> clock can generate, returning something larger is perfe=
ctly valid, IMHO.
> > > > > > >>> Which reveals one problem in this whole discussion. The=
 API does not
> > > > > > >>> require clk_round_rate() to round down. It is actually =
an implementation
> > > > > > >>> choice that had been made for clk-divider.
> > > > > > >> I'm sure it's more than an implementation choice for clk=
-divider. But I
> > > > > > >> don't find any respective documentation (but I didn't tr=
y hard).
> > > > > > > A similar discussion - without final conclusion:
> > > > > > > https://lkml.org/lkml/2010/7/14/260
> > > > > > >
> > > > > > >
> > > > > >=20
> > > > > > Please call this new API something like clk_find_nearest_ra=
te() or
> > > > > > something. clk_round_rate() is supposed to return the rate =
that will be
> > > > > > set if you call clk_set_rate() with the same arguments. It'=
s up to the
> > > > > > implementation to decide if that means rounding the rate up=
 or down or
> > > > > > to the nearest value.
> > > > >=20
> > > > > Sounds good to me. Are there any cases of clocks that round u=
p? I think
> > > > > that case would not be handled correctly. But I also don't se=
e a use
> > > > > case for such an implementation.
> > > > I don't really care which semantic (i.e. round up, round down o=
r round
> > > > closest) is picked, but I'd vote that all should pick up the sa=
me. I
> > > > think the least surprising definition is to choose rounding dow=
n and add
> > > > the function that is under discussion here to get a nearest mat=
ch.
> > > >=20
> > > > So I suggest:
> > > >=20
> > > >     - if round_rate is given a rate that is smaller than the
> > > >       smallest available rate, return 0
> > > >     - add WARN_ONCE to round_rate and set_rate if they return w=
ith a
> > > >       rate bigger than requested
> > >=20
> > > Why do you think 0 is always valid? I think for a clock that can
> > > generate 40, 70, 120, clk_round_rate(20) should return 40.
> > I didn't say it's a valid value. It just makes the it possible to c=
heck
> > for clk_round_rate(clk, rate) <=3D rate.
> >=20
> > I grepped a bit around and found da850_round_armrate which implemen=
ts a
> > round_rate callback returning the best match.
> > omap1_clk_round_rate_ckctl_arm can return a value < 0.
> > s3c2412_roundrate_usbsrc can return values that are bigger than
> > requested. (I wonder if that is a bug though.)
> >=20
> > > >     - change the return values to unsigned long
> > >=20
> > > Yep, I agree, this should happen.
> > And we're using 0 as error value? e.g. for the case where
> > omap1_clk_round_rate_ckctl_arm returns -EIO now?
>=20
> No. clk_round_rate returns long for a reason, which is that we can
> provide an error code to the caller. From include/linux/clk.h:
>=20
> /**
>  * clk_round_rate - adjust a rate to the exact rate a clock can provi=
de
>  * @clk: clock source
>  * @rate: desired clock rate in Hz
>  *
>  * Returns rounded clock rate in Hz, or negative errno.
>  */
>=20
> This has the unfortunate side effect that the max value we can return
> safely is 2147483647 (~2GHz). So another issue here is converting clo=
ck
> rates to 64-bit values.

So, let's assume
 - a clock does either of these
   - round down
   - round nearest
   - round up (is there any such case? I don't see a use-case for this)
 - or return an error

I think my latest try handles such cases, with the limitation of
for a clock that rounds up, the up-rounded value is found instead of th=
e
nearest.


static long clk_find_nearest_rate(struct clk *clk, unsigned long rate)
{
	long ret;
	unsigned long lower, upper;

	clk_prepare_lock();

	lower =3D __clk_round_rate(clk, rate);
	if (lower >=3D rate || (long)lower < 0) {
		ret =3D lower;
		goto unlock;
	}

	upper =3D rate + (rate - lower) - 1;
	if (upper > LONG_MAX)
		upper =3D LONG_MAX;

	upper =3D __clk_round_rate(clk, upper);
	if (upper <=3D lower || (long)upper < 0) {
		ret =3D lower;
		goto unlock;
	}

	lower =3D rate + 1;
	while (lower < upper) {
		unsigned long rounded, mid;

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

	S=C3=B6ren
