From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/4] clk: Introduce 'clk_find_nearest_rate()'
Date: Tue, 1 Jul 2014 10:23:02 +0200
Message-ID: <20140701082302.GL14781@pengutronix.de>
References: <1404147396-8041-1-git-send-email-soren.brinkmann@xilinx.com>
 <1404147396-8041-2-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1404147396-8041-2-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Soren Brinkmann <soren.brinkmann@xilinx.com>
Cc: Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Russell King <linux@arm.linux.org.uk>, Michal Simek <michal.simek@xilinx.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 30, 2014 at 09:56:33AM -0700, Soren Brinkmann wrote:
> Introduce a new API function to find the rate a clock can provide whi=
ch
> is closest to a given rate.
>=20
> clk_round_rate() leaves it to the clock driver how rounding is done.
> Commonly implementations round down due to use-cases that have a cert=
ain
> frequency maximum that must not be exceeded.
>=20
> The new API call enables use-cases where accuracy is preferred. E.g.
> Ethernet clocks.
>=20
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>=20
>  drivers/clk/clk.c   | 57 +++++++++++++++++++++++++++++++++++++++++++=
++++++++++
>  include/linux/clk.h |  9 +++++++++
>  2 files changed, 66 insertions(+)
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 8b73edef151d..fce1165cd879 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1030,6 +1030,63 @@ long clk_round_rate(struct clk *clk, unsigned =
long rate)
>  EXPORT_SYMBOL_GPL(clk_round_rate);
> =20
>  /**
> + * clk_find_nearest_rate - round the given rate for a clk
> + * @clk: the clk for which we are rounding a rate
> + * @rate: the rate which is to be rounded
> + *
> + * Takes in a rate as input and finds the closest rate that the clk
> + * can actually use which is then returned.
> + * Note: This function relies on the clock's clk_round_rate() implem=
entation.
> + * For cases clk_round_rate() rounds up, not the closest but the rou=
nded up
> + * rate is found.
> + */
> +long clk_find_nearest_rate(struct clk *clk, unsigned long rate)
> +{
> +	long ret, lower, upper;
> +	unsigned long tmp;
> +
> +	clk_prepare_lock();
> +
> +	lower =3D __clk_round_rate(clk, rate);
> +	if (lower >=3D rate || lower < 0) {
> +		ret =3D lower;
> +		goto unlock;
> +	}
> +
> +	tmp =3D rate + (rate - lower) - 1;
> +	if (tmp > LONG_MAX)
> +		upper =3D LONG_MAX;
> +	else
> +		upper =3D tmp;
Consider rate =3D 0xf0000000, lower =3D 0x7fffffff (=3D LONG_MAX). Then=
 tmp =3D
(unsigned long)0x160000000 =3D 0x60000000. In this case you pick upper =
=3D
0x60000000 while you should use upper =3D LONG_MAX.

I think you need

-	if (tmp > LONG_MAX)
+	if (tmp > LONG_MAX || tmp < rate)

(and a comment)

> +
> +	upper =3D __clk_round_rate(clk, upper);
> +	if (upper <=3D lower || upper < 0) {
Is it an idea to do something like:

		if (IS_ENABLED(CONFIG_CLK_SANITY_CHECKS))
			WARN_ON(upper < lower && upper >=3D 0);

here?

> +		ret =3D lower;
> +		goto unlock;
> +	}
> +
> +	lower =3D rate + 1;
> +	while (lower < upper) {
> +		long rounded, mid;
> +
> +		mid =3D lower + ((upper - lower) >> 1);
> +		rounded =3D __clk_round_rate(clk, mid);
> +		if (rounded < lower)
> +			lower =3D mid + 1;
> +		else
> +			upper =3D rounded;
> +	}
This is broken if you don't assume that __clk_round_rate rounds down.
Consider an implementation that already does round_nearest and clk can
assume the values 0x60000 and 0x85000 (and nothing in between), and rat=
e
=3D 0x70000. This results in

	lower =3D 0x60000;
	tmp =3D 0x7ffff;
	upper =3D __clk_round_rate(clk, 0x7ffff) =3D 0x85000

before the loop and the loop then doesn't even terminate.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
