From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [RFC PATCH 2/5] clk: Introduce 'clk_round_rate_nearest()'
Date: Mon, 19 May 2014 18:19:49 +0200
Message-ID: <20140519161949.GG16662@pengutronix.de>
References: <1400106655-22465-1-git-send-email-soren.brinkmann@xilinx.com>
 <1400106655-22465-3-git-send-email-soren.brinkmann@xilinx.com>
 <20140515073816.GI16662@pengutronix.de>
 <91822600-39d0-4e71-b0f5-9eda35b76ec0@BN1AFFO11FD016.protection.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57689 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932361AbaESQT7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 19 May 2014 12:19:59 -0400
Content-Disposition: inline
In-Reply-To: <91822600-39d0-4e71-b0f5-9eda35b76ec0@BN1AFFO11FD016.protection.gbl>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>
Cc: Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Russell King <linux@arm.linux.org.uk>, Michal Simek <michal.simek@xilinx.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi S=F6ren,

On Sun, May 18, 2014 at 05:51:05PM -0700, S=F6ren Brinkmann wrote:
> ------------------8<-----------------8<---------------------8<-------=
------8<---
> From: Soren Brinkmann <soren.brinkmann@xilinx.com>
> Date: Tue, 2 Apr 2013 10:08:13 -0700
> Subject: [PATCH] clk: Introduce 'clk_round_rate_nearest()'
>=20
> Introduce a new API function to round a rate to the closest possible
> rate the HW clock can generate.
> In contrast to 'clk_round_rate()' which works similar, but always ret=
urns
> a frequency <=3D its input rate.
>=20
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>  drivers/clk/clk.c   | 43 +++++++++++++++++++++++++++++++++++++++++--
>  include/linux/clk.h | 14 ++++++++++++--
>  2 files changed, 53 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index dff0373f53c1..faf24d0569df 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1011,8 +1011,9 @@ unsigned long __clk_round_rate(struct clk *clk,=
 unsigned long rate)
>   * @rate: the rate which is to be rounded
>   *
>   * Takes in a rate as input and rounds it to a rate that the clk can=
 actually
> - * use which is then returned.  If clk doesn't support round_rate op=
eration
> - * then the parent rate is returned.
> + * use and does not exceed the requested frequency, which is then re=
turned.
> + * If clk doesn't support round_rate operation then the parent rate
> + * is returned.
>   */
>  long clk_round_rate(struct clk *clk, unsigned long rate)
>  {
> @@ -1027,6 +1028,44 @@ long clk_round_rate(struct clk *clk, unsigned =
long rate)
>  EXPORT_SYMBOL_GPL(clk_round_rate);
> =20
>  /**
> + * clk_round_rate_nearest - round the given rate for a clk
> + * @clk: the clk for which we are rounding a rate
> + * @rate: the rate which is to be rounded
> + *
> + * Takes in a rate as input and rounds it to the closest rate that t=
he clk
> + * can actually use which is then returned. If clk doesn't support
> + * round_rate operation then the parent rate is returned.
> + */
> +long clk_round_rate_nearest(struct clk *clk, unsigned long rate)
Why does this function doesn't return an unsigned long when it never
returns a negative value? Ditto for clk_round_rate?

> +{
> +	unsigned long lower, upper, cur, lower_last, upper_last;
> +
> +	lower =3D clk_round_rate(clk, rate);
> +	if (lower >=3D rate)
> +		return lower;
Is the >-case worth a warning?

> +
> +	upper =3D clk_round_rate(clk, rate + rate - lower);
This was parenthesized in my original patch on purpose. If rate is big

	rate + rate - lower

might overflow when

	rate + (rate - lower)

doesn't. Thinking again, there is no real problem, because this is
unsigned arithmetic. To be save we still need to check if rate + (rate =
-
lower) overflows.

> +	if (upper =3D=3D lower)
if (upper <=3D rate) is the better check here. (=3D would be a bug.)

> +		return upper;
> +
> +	lower =3D rate + 1;
ok, so your loop invariant is that the best freq is in [lower; upper].

> +	do {
> +		upper_last =3D upper;
> +		lower_last =3D lower;
> +
> +		cur =3D clk_round_rate(clk, lower + ((upper - lower) >> 1));
> +		if (cur < lower)
> +			lower +=3D (upper - lower) >> 1;
You already know that lower + ((upper - lower) >> 1) is too small, so
you can better do

	lower +=3D ((upper - lower) >> 1) + 1;

> +		else
> +			upper =3D cur;
> +
> +	} while (lower_last !=3D lower && upper_last !=3D upper);
> +
> +	return upper;
> +}
> +EXPORT_SYMBOL_GPL(clk_round_rate_nearest);
I think the function still has potential for optimisation, what about:

unsigned long clk_round_rate_nearest(struct clk *clk, unsigned long rat=
e)
{
	unsigned long lower, upper, rounded;

	rounded =3D clk_round_rate(clk, rate);

	if (rounded >=3D rate)
		return rounded;

	/*
	 * rounded is the best approximation for rate that is not
	 * bigger than rate. If there is a better one, it must be in the
	 * interval (rate; rate + (rate - rounded)).
	 * Note that the upper limit isn't better than rate itself, so
	 * that one doesn't need to be considered.
	 */
	=20
	upper =3D rate + (rate - rounded) - 1;
	if (upper < rate)
		upper =3D ULONG_MAX;=20

	upper =3D clk_round_rate(clk, upper);

	lower =3D rate + 1;

	/*
	 * If there is a better approximation than clk_round_rate(clk,
	 * rate), it is in the interval [lower, upper]. Otherwise all
	 * values in this interval yield clk_round_rate(clk, rate).
	 */
	while (lower < upper) {
		unsigned long mid;

		mid =3D lower + (upper - lower) >> 1;
		rounded =3D clk_round_rate(clk, mid);

		if (rounded < rate) {
			/* implies rounded =3D=3D clk_round_rate(clk, rate); */
			lower =3D mid + 1;
		} else {
			/*
			 * rounded is a better approximation than lower
			 * assuming that rounded <=3D mid
			 */
			upper =3D rounded;
		}
	}

	/*
	 * upper is always assigned a return value from clk_round_rate,
	 * so it's suitable for direct return.
	 */
	return upper;
}

? Note this is not even compile tested ...

=09
> +
> +/**
>   * __clk_notify - call clk notifier chain
>   * @clk: struct clk * that is changing rate
>   * @msg: clk notifier type (see include/linux/clk.h)
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index fb5e097d8f72..2f83bf030ac6 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -255,15 +255,25 @@ void devm_clk_put(struct device *dev, struct cl=
k *clk);
> =20
> =20
>  /**
> - * clk_round_rate - adjust a rate to the exact rate a clock can prov=
ide
> + * clk_round_rate - round a rate to the exact rate a clock can provi=
de not
> + *		    exceeding @rate
>   * @clk: clock source
>   * @rate: desired clock rate in Hz
>   *
> - * Returns rounded clock rate in Hz, or negative errno.
> + * Returns rounded clock rate in Hz, or parent rate
>   */
I'd put the changes in this hunk up to here into a separate patch.

Best regards
Uwe

>  long clk_round_rate(struct clk *clk, unsigned long rate);
> =20
>  /**
> + * clk_round_rate_nearest - round a rate to the exact rate a clock c=
an provide
> + * @clk: the clk for which we are rounding a rate
> + * @rate: the rate which is to be rounded
> + *
> + * Returns rounded clock rate in Hz, or parent rate
> + */
> +long clk_round_rate_nearest(struct clk *clk, unsigned long rate);
> +
> +/**
>   * clk_set_rate - set the clock rate for a clock source
>   * @clk: clock source
>   * @rate: desired clock rate in Hz
> --=20
> 1.9.3.1.ga73a6ad
>=20
>=20
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
