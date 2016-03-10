From: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 12/13] thermal: convert tegra_thermal to use devm_thermal_zone_of_sensor_register
Date: Thu, 10 Mar 2016 16:46:55 +0800
Message-ID: <56E1347F.8040406@nvidia.com>
References: <1457559336-17652-1-git-send-email-edubezval@gmail.com> <1457559336-17652-13-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457559336-17652-13-git-send-email-edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rui Zhang <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org



On 2016=E5=B9=B403=E6=9C=8810=E6=97=A5 05:35, Eduardo Valentin wrote:
> This changes the driver to use the devm_ version
> of thermal_zone_of_sensor_register and cleans
> up the  local points and unregister calls.
>=20
> Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
> Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/thermal/tegra_soctherm.c | 31 +++++++++---------------------=
-
>  1 file changed, 9 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/thermal/tegra_soctherm.c b/drivers/thermal/tegra=
_soctherm.c
> index 74ea576..0018ccd 100644
> --- a/drivers/thermal/tegra_soctherm.c
> +++ b/drivers/thermal/tegra_soctherm.c
> @@ -168,7 +168,7 @@ struct tegra_soctherm {
>  	struct clk *clock_soctherm;
>  	void __iomem *regs;
> =20
> -	struct thermal_zone_device *thermctl_tzs[4];
> +#define ZONE_NUMBER		4
>  };
> =20
>  struct tsensor_shared_calibration {
> @@ -342,7 +342,7 @@ static const struct thermctl_zone_desc t124_therm=
ctl_temp_zones[] =3D {
>  static int tegra_soctherm_probe(struct platform_device *pdev)
>  {
>  	struct tegra_soctherm *tegra;
> -	struct thermal_zone_device *tz;
> +	struct thermal_zone_device *z;
>  	struct tsensor_shared_calibration shared_calib;
>  	struct resource *res;
>  	unsigned int i;
> @@ -408,36 +408,29 @@ static int tegra_soctherm_probe(struct platform=
_device *pdev)
> =20
>  	/* Initialize thermctl sensors */
> =20
> -	for (i =3D 0; i < ARRAY_SIZE(tegra->thermctl_tzs); ++i) {
> +	for (i =3D 0; i < ZONE_NUMBER; ++i) {
>  		struct tegra_thermctl_zone *zone =3D
>  			devm_kzalloc(&pdev->dev, sizeof(*zone), GFP_KERNEL);
>  		if (!zone) {
>  			err =3D -ENOMEM;
> -			goto unregister_tzs;
> +			goto disable_clocks;
>  		}
> =20
>  		zone->reg =3D tegra->regs + t124_thermctl_temp_zones[i].offset;
>  		zone->shift =3D t124_thermctl_temp_zones[i].shift;
> =20
> -		tz =3D thermal_zone_of_sensor_register(&pdev->dev, i, zone,
> -						     &tegra_of_thermal_ops);
> -		if (IS_ERR(tz)) {
> -			err =3D PTR_ERR(tz);
> +		z =3D devm_thermal_zone_of_sensor_register(&pdev->dev, i, zone,

I prefer to still use "tz", it seems this line isn't over 80 characters=
, or we
can add newline.

> +							 &tegra_of_thermal_ops);
> +		if (IS_ERR(z)) {
> +			err =3D PTR_ERR(z);
>  			dev_err(&pdev->dev, "failed to register sensor: %d\n",
>  				err);
> -			goto unregister_tzs;
> +			goto disable_clocks;
>  		}
> -
> -		tegra->thermctl_tzs[i] =3D tz;
>  	}
> =20
>  	return 0;
> =20
> -unregister_tzs:
> -	while (i--)
> -		thermal_zone_of_sensor_unregister(&pdev->dev,
> -						  tegra->thermctl_tzs[i]);
> -
>  disable_clocks:
>  	clk_disable_unprepare(tegra->clock_tsensor);
>  	clk_disable_unprepare(tegra->clock_soctherm);
> @@ -448,12 +441,6 @@ disable_clocks:
>  static int tegra_soctherm_remove(struct platform_device *pdev)
>  {
>  	struct tegra_soctherm *tegra =3D platform_get_drvdata(pdev);
> -	unsigned int i;
> -
> -	for (i =3D 0; i < ARRAY_SIZE(tegra->thermctl_tzs); ++i) {
> -		thermal_zone_of_sensor_unregister(&pdev->dev,
> -						  tegra->thermctl_tzs[i]);
> -	}
> =20
>  	clk_disable_unprepare(tegra->clock_tsensor);
>  	clk_disable_unprepare(tegra->clock_soctherm);
>=20
