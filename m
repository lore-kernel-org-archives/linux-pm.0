From: Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V3 06/19] clk: tegra: remove TEGRA_PLL_USE_LOCK for
 PLLD/PLLD2
Date: Mon, 13 Jul 2015 16:41:51 +0300
Message-ID: <20150713134151.GQ6287@tbergstrom-lnx.Nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
 <1436791197-32358-7-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1436791197-32358-7-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Terje =?iso-8859-1?Q?Bergstr=F6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 13, 2015 at 01:39:44PM +0100, Jon Hunter wrote:
> From: Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>=20
> Tegra114 has a HW bug that the PLLD/PLLD2 lock bit cannot be asserted=
 when
> the DIS power domain is during up-powergating process but the clamp t=
o this

I think there is missing 'off' in this sentence?

ie. ... 'the DIS power domain is off=A0during up-powergating process'

Also 'un-powergating sequence' would be nicer.

> domain is not removed yet. That causes a timeout and aborts the power
> sequence, although the PLLD/PLLD2 has already locked. To remove the f=
alse
> alarm, we don't use the lock for PLLD/PLLD2. Just wait 1ms and treat =
the
> clocks as locked.
>=20
> Signed-off-by: Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/clk/tegra/clk-tegra114.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk=
-tegra114.c
> index 8237d16b4075..2e5c20c7c088 100644
> --- a/drivers/clk/tegra/clk-tegra114.c
> +++ b/drivers/clk/tegra/clk-tegra114.c
> @@ -456,8 +456,7 @@ static struct tegra_clk_pll_params pll_d_params =3D=
 {
>  	.lock_delay =3D 1000,
>  	.div_nmp =3D &pllp_nmp,
>  	.freq_table =3D pll_d_freq_table,
> -	.flags =3D TEGRA_PLL_HAS_CPCON | TEGRA_PLL_SET_LFCON |
> -		 TEGRA_PLL_USE_LOCK,
> +	.flags =3D TEGRA_PLL_HAS_CPCON | TEGRA_PLL_SET_LFCON,
>  };
> =20
>  static struct tegra_clk_pll_params pll_d2_params =3D {
> @@ -474,8 +473,7 @@ static struct tegra_clk_pll_params pll_d2_params =
=3D {
>  	.lock_delay =3D 1000,
>  	.div_nmp =3D &pllp_nmp,
>  	.freq_table =3D pll_d_freq_table,
> -	.flags =3D TEGRA_PLL_HAS_CPCON | TEGRA_PLL_SET_LFCON |
> -		 TEGRA_PLL_USE_LOCK,
> +	.flags =3D TEGRA_PLL_HAS_CPCON | TEGRA_PLL_SET_LFCON,
>  };
> =20
>  static struct pdiv_map pllu_p[] =3D {
> --=20
> 2.1.4
>=20
