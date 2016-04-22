From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 02/11] clk: tegra: dfll: Move SoC specific data into
 of_device_id
Date: Fri, 22 Apr 2016 15:04:09 +0200
Message-ID: <20160422130409.GK9047@ulmo.ba.sec>
References: <1461321071-6431-1-git-send-email-pchiu@nvidia.com>
 <1461321071-6431-3-git-send-email-pchiu@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wIc/V6YLA2QdyfT4"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35785 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192AbcDVNEN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Apr 2016 09:04:13 -0400
Content-Disposition: inline
In-Reply-To: <1461321071-6431-3-git-send-email-pchiu@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Penny Chiu <pchiu@nvidia.com>
Cc: swarren@wwwdotorg.org, gnurou@gmail.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@baylibre.com, sboyd@codeaurora.org, linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org, linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org


--wIc/V6YLA2QdyfT4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 22, 2016 at 06:31:02PM +0800, Penny Chiu wrote:
> Move all SoC specific fcpu data into of_device_id structure, and
> move SoC fcpu data assignments from init function to probe
> function.
>=20
> Signed-off-by: Penny Chiu <pchiu@nvidia.com>
> ---
>  drivers/clk/tegra/clk-tegra124-dfll-fcpu.c | 51 ++++++++++++++++++++++--=
------
>  1 file changed, 37 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c b/drivers/clk/teg=
ra/clk-tegra124-dfll-fcpu.c
> index 5e5958e..b577bc6 100644
> --- a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
> +++ b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
> @@ -21,6 +21,7 @@
>  #include <linux/err.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <soc/tegra/fuse.h>
> =20
> @@ -28,8 +29,15 @@
>  #include "clk-dfll.h"
>  #include "cvb.h"
> =20
> +struct dfll_fcpu_data {
> +	const unsigned long *cpu_max_freq_table;
> +	unsigned int cpu_max_freq_table_size;
> +	const struct cvb_table *cpu_cvb_tables;
> +	unsigned int cpu_cvb_tables_size;
> +};
> +
>  /* Maximum CPU frequency, indexed by CPU speedo id */
> -static const unsigned long cpu_max_freq_table[] =3D {
> +static const unsigned long tegra124_cpu_max_freq_table[] =3D {
>  	[0] =3D 2014500000UL,
>  	[1] =3D 2320500000UL,
>  	[2] =3D 2116500000UL,
> @@ -79,18 +87,39 @@ static const struct cvb_table tegra124_cpu_cvb_tables=
[] =3D {
>  	},
>  };
> =20
> +static const struct dfll_fcpu_data tegra124_dfll_fcpu_data =3D {
> +	.cpu_max_freq_table =3D tegra124_cpu_max_freq_table,
> +	.cpu_max_freq_table_size =3D ARRAY_SIZE(tegra124_cpu_max_freq_table),
> +	.cpu_cvb_tables =3D tegra124_cpu_cvb_tables,
> +	.cpu_cvb_tables_size =3D ARRAY_SIZE(tegra124_cpu_cvb_tables)
> +};
> +
> +static const struct of_device_id tegra124_dfll_fcpu_of_match[] =3D {

There's no need to prefix this with tegra124_ since obviously the goal
is to make this a table that works at least on Tegra210 as well.

> +	{
> +		.compatible =3D "nvidia,tegra124-dfll",
> +		.data =3D &tegra124_dfll_fcpu_data
> +	},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, tegra124_dfll_fcpu_of_match);
> +
>  static int tegra124_dfll_fcpu_probe(struct platform_device *pdev)
>  {
>  	int process_id, speedo_id, speedo_value, ret;
>  	struct rail_alignment align;
>  	struct tegra_dfll_soc_data *soc;
>  	const struct cvb_table *cvb;
> +	const struct of_device_id *of_id;
> +	const struct dfll_fcpu_data *fcpu_data;
> +
> +	of_id =3D of_match_device(tegra124_dfll_fcpu_of_match, &pdev->dev);
> +	fcpu_data =3D of_id->data;

You should be using of_device_get_match_data() nowadays. That allows you
to do this in one step while at the same time allowing to keep the match
tables where they are.

> =20
>  	process_id =3D tegra_sku_info.cpu_process_id;
>  	speedo_id =3D tegra_sku_info.cpu_speedo_id;
>  	speedo_value =3D tegra_sku_info.cpu_speedo_value;
> =20
> -	if (speedo_id >=3D ARRAY_SIZE(cpu_max_freq_table)) {
> +	if (speedo_id >=3D fcpu_data->cpu_max_freq_table_size) {
>  		dev_err(&pdev->dev, "unknown max CPU freq for speedo_id=3D%d\n",
>  			speedo_id);
>  		return -ENODEV;
> @@ -121,12 +150,12 @@ static int tegra124_dfll_fcpu_probe(struct platform=
_device *pdev)
>  		return -EINVAL;
>  	}
> =20
> -	cvb =3D tegra_cvb_build_opp_table(tegra124_cpu_cvb_tables,
> -					ARRAY_SIZE(tegra124_cpu_cvb_tables),
> -					&align,
> -					process_id, speedo_id, speedo_value,
> -					cpu_max_freq_table[speedo_id],
> -					soc->dev);
> +	cvb =3D tegra_cvb_build_opp_table(fcpu_data->cpu_cvb_tables,
> +				fcpu_data->cpu_cvb_tables_size,
> +				&align,
> +				process_id, speedo_id, speedo_value,
> +				fcpu_data->cpu_max_freq_table[speedo_id],
> +				soc->dev);

This, and potentially other parts will conflict with some cleanup I
recently did to this code. You may want to rebase on some linux-next
earlier next week which should have those cleanup patches.

Thierry

--wIc/V6YLA2QdyfT4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXGiFIAAoJEN0jrNd/PrOhdrUQAIg46qfJRBZdtpZLPib8iNwv
5q9IE8KHsTuGc7fcz5lEroc2nkBhMO6zwaRo/BL+IdPhbohDCLlEbZ+CGi1jRGY6
Rbn0KfB9etmEB9wRbNwR+IdI7uWqmFaXm6HrYNjWpFz/B+rJBlZu0EqfP3DDQ1dW
42RZRqkHluqQ2Tkv4cENG1qUsTlSJtPT0h8vGlpuJIOEep3q5z2sOFC9C2cehc82
JEhS6iBjELJwKbMZDT5bXF3TjtWHKA9+Q9S84Ju/2yYtC8RkpYasabwdlHAAcLsC
MimTQtsiM6r+//+U5GZ2Edw9fj6rfnpzNwObnW2mrUOCvzgfY3ui1lbltOqwZLvg
xSRDwSR3ZQw/IDQ88pX2DqUGWbXvJbD/JWnEqH+pGlbQruM5AYd0JhE1AlqgMnc2
PGuzcmlBS7BCOCHUbXPsHydxASWQLEl7akpc1/b6y0zDsBG3OCFW9+awASHEZ8tQ
FhFPQRBFQVs5mfLP+7fqMtIzlrS1U96ylDk0YgpJ/PyYAoJa8kXzS1z/WUTnCAAF
Z9YCZIIo+MdLQAQPNwpPVrphD/9TNIaOd8nSPqf2UnS7cKWfAfL2wd96Vs+aX0TI
8j1gxbj6k0rLBGh6bsXTjznQi5Vp06baTudqAKSXBAvofkccPhq4BCCFRHP2urPf
2OtUk5aQZqYbITWbjGWU
=EiSu
-----END PGP SIGNATURE-----

--wIc/V6YLA2QdyfT4--
