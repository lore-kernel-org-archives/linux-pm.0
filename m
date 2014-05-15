From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [RFC PATCH 2/5] clk: Introduce 'clk_round_rate_nearest()'
Date: Thu, 15 May 2014 09:38:16 +0200
Message-ID: <20140515073816.GI16662@pengutronix.de>
References: <1400106655-22465-1-git-send-email-soren.brinkmann@xilinx.com>
 <1400106655-22465-3-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43978 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753995AbaEOHi0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 May 2014 03:38:26 -0400
Content-Disposition: inline
In-Reply-To: <1400106655-22465-3-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Soren Brinkmann <soren.brinkmann@xilinx.com>
Cc: Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Russell King <linux@arm.linux.org.uk>, Michal Simek <michal.simek@xilinx.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

it's great you pick that up.

On Wed, May 14, 2014 at 03:30:52PM -0700, Soren Brinkmann wrote:
> Introduce a new API function to round a rate to the closest possible
> rate the HW clock can generate.
> In contrast to 'clk_round_rate()' which works similar, but always ret=
urns
> a frequency <=3D its input rate.
>=20
> The code comes from Uwe and was copied from this LKML thread:
> https://lkml.org/lkml/2013/3/21/115
>=20
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>=20
>  drivers/clk/clk.c   | 26 ++++++++++++++++++++++++--
>  include/linux/clk.h | 14 ++++++++++++--
>  2 files changed, 36 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index dff0373f53c1..b715f5a9826c 100644
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
> @@ -1027,6 +1028,27 @@ long clk_round_rate(struct clk *clk, unsigned =
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
> +{
> +	long lower_limit =3D clk_round_rate(clk, rate);
> +	long upper_limit =3D clk_round_rate(clk, rate + (rate - lower_limit=
));
> +
> +	if (rate - lower_limit < upper_limit - rate)
> +		return lower_limit;
> +	else
> +		return upper_limit;
I wanted to suggest to add some comment to describe why the calculation
works here. While trying to proove it, I noticed that this
implementation is buggy.
Consider a clock that can provide the following frequencies: 38000,
38401, 38600.

	clk_round_rate_nearest(clk, 38400)
	  lower_limit =3D clk_round_rate(clk, 38400) -> 38000
	  upper_limit =3D clk_round_rate(clk, 38800) -> 38600

	  return 38600

but 38401 would have been the better/correct answer. I think you cannot
implement clk_round_rate_nearest without iteration if you don't want to
add specific logic to the clock providers.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
