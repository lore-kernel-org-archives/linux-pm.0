From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V7 10/12] thermal: tegra: add PM support
Date: Mon, 14 Mar 2016 12:23:17 -0700
Message-ID: <20160314192316.GD1872@localhost.localdomain>
References: <1457665886-30098-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eheScQNz3K90DVRs"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33009 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755670AbcCNTXW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Mar 2016 15:23:22 -0400
Content-Disposition: inline
In-Reply-To: <1457665886-30098-1-git-send-email-wni@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Ni <wni@nvidia.com>
Cc: rui.zhang@intel.com, thierry.reding@gmail.com, MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--eheScQNz3K90DVRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 11, 2016 at 11:11:26AM +0800, Wei Ni wrote:
> Add suspend/resume function in soctherm driver.
> And enable it for Tegra124 and Tegra210.

I would prefer you either improve the description of changes needed to
get suspend and resume fully working or you split this patch into
smaller and properly described patches.

Looks like you need at least to:
(1) handle clocks
(2) reprogram hw trips,

right?


>=20
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  drivers/thermal/tegra/soctherm.c | 175 ++++++++++++++++++++++++++++-----=
------
>  1 file changed, 125 insertions(+), 50 deletions(-)
>=20
> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soc=
therm.c
> index dbaab160baba..702d9cf3969d 100644
> --- a/drivers/thermal/tegra/soctherm.c
> +++ b/drivers/thermal/tegra/soctherm.c
> @@ -88,6 +88,7 @@ struct tegra_soctherm {
>  	struct clk *clock_tsensor;
>  	struct clk *clock_soctherm;
>  	void __iomem *regs;
> +	struct thermal_zone_device **thermctl_tzs;
> =20
>  	u32 *calib;
>  	struct tegra_soctherm_soc *soc;
> @@ -95,19 +96,11 @@ struct tegra_soctherm {
>  	struct dentry *debugfs_dir;
>  };
> =20
> -static int enable_tsensor(struct tegra_soctherm *tegra,
> -			  unsigned int i,
> -			  const struct tsensor_shared_calib *shared)
> +static void enable_tsensor(struct tegra_soctherm *tegra, unsigned int i)
>  {
>  	const struct tegra_tsensor *sensor =3D &tegra->soc->tsensors[i];
>  	void __iomem *base =3D tegra->regs + sensor->base;
> -	u32 *calib =3D &tegra->calib[i];
>  	unsigned int val;
> -	int err;
> -
> -	err =3D tegra_calc_tsensor_calib(sensor, shared, calib);
> -	if (err)
> -		return err;
> =20
>  	val =3D sensor->config->tall << SENSOR_CONFIG0_TALL_SHIFT;
>  	writel(val, base + SENSOR_CONFIG0);
> @@ -118,9 +111,7 @@ static int enable_tsensor(struct tegra_soctherm *tegr=
a,
>  	val |=3D SENSOR_CONFIG1_TEMP_ENABLE;
>  	writel(val, base + SENSOR_CONFIG1);
> =20
> -	writel(*calib, base + SENSOR_CONFIG2);
> -
> -	return 0;
> +	writel(tegra->calib[i], base + SENSOR_CONFIG2);
>  }
> =20
>  /*
> @@ -425,6 +416,69 @@ static inline void soctherm_debug_init(struct platfo=
rm_device *pdev)
>  }
>  #endif
> =20
> +static int soctherm_clk_enable(struct platform_device *pdev, bool enable)
> +{
> +	struct tegra_soctherm *tegra =3D platform_get_drvdata(pdev);
> +	int err;
> +
> +	if (tegra->clock_soctherm =3D=3D NULL || tegra->clock_tsensor =3D=3D NU=
LL)
> +		return -EINVAL;
> +
> +	reset_control_assert(tegra->reset);
> +
> +	if (enable) {
> +		err =3D clk_prepare_enable(tegra->clock_soctherm);
> +		if (err) {
> +			reset_control_deassert(tegra->reset);
> +			return err;
> +		}
> +
> +		err =3D clk_prepare_enable(tegra->clock_tsensor);
> +		if (err) {
> +			clk_disable_unprepare(tegra->clock_soctherm);
> +			reset_control_deassert(tegra->reset);
> +			return err;
> +		}
> +	} else {
> +		clk_disable_unprepare(tegra->clock_tsensor);
> +		clk_disable_unprepare(tegra->clock_soctherm);
> +	}
> +
> +	reset_control_deassert(tegra->reset);
> +
> +	return 0;
> +}
> +
> +static void soctherm_init(struct platform_device *pdev)
> +{
> +	struct tegra_soctherm *tegra =3D platform_get_drvdata(pdev);
> +	const struct tegra_tsensor_group **ttgs =3D tegra->soc->ttgs;
> +	int i;
> +	u32 pdiv, hotspot;
> +
> +	/* Initialize raw sensors */
> +	for (i =3D 0; i < tegra->soc->num_tsensors; ++i)
> +		enable_tsensor(tegra, i);
> +
> +	/* Wait for sensor data to be ready */
> +	usleep_range(1000, 5000);


Is this range applicable for all supported chip versions?

> +
> +	/* program pdiv and hotspot offsets per THERM */
> +	pdiv =3D readl(tegra->regs + SENSOR_PDIV);
> +	hotspot =3D readl(tegra->regs + SENSOR_HOTSPOT_OFF);
> +	for (i =3D 0; i < tegra->soc->num_ttgs; ++i) {
> +		pdiv =3D REG_SET_MASK(pdiv, ttgs[i]->pdiv_mask,
> +				    ttgs[i]->pdiv);
> +		if (ttgs[i]->id =3D=3D TEGRA124_SOCTHERM_SENSOR_PLLX)
> +			continue;
> +		hotspot =3D  REG_SET_MASK(hotspot,
> +					ttgs[i]->pllx_hotspot_mask,
> +					ttgs[i]->pllx_hotspot_diff);
> +	}
> +	writel(pdiv, tegra->regs + SENSOR_PDIV);
> +	writel(hotspot, tegra->regs + SENSOR_HOTSPOT_OFF);
> +}
> +
>  static const struct of_device_id tegra_soctherm_of_match[] =3D {
>  #ifdef CONFIG_ARCH_TEGRA_124_SOC
>  	{
> @@ -452,7 +506,6 @@ static int tegra_soctherm_probe(struct platform_devic=
e *pdev)
>  	struct tegra_soctherm_soc *soc;
>  	unsigned int i;
>  	int err;
> -	u32 pdiv, hotspot;
> =20
>  	match =3D of_match_node(tegra_soctherm_of_match, pdev->dev.of_node);
>  	if (!match)
> @@ -493,52 +546,37 @@ static int tegra_soctherm_probe(struct platform_dev=
ice *pdev)
>  		return PTR_ERR(tegra->clock_soctherm);
>  	}
> =20
> -	reset_control_assert(tegra->reset);
> -
> -	err =3D clk_prepare_enable(tegra->clock_soctherm);
> -	if (err)
> -		return err;
> -
> -	err =3D clk_prepare_enable(tegra->clock_tsensor);
> -	if (err) {
> -		clk_disable_unprepare(tegra->clock_soctherm);
> -		return err;
> -	}
> -
> -	reset_control_deassert(tegra->reset);
> -
> -	/* Initialize raw sensors */
> -
>  	tegra->calib =3D devm_kzalloc(&pdev->dev,
>  				    sizeof(u32) * soc->num_tsensors,
>  				    GFP_KERNEL);
>  	if (!tegra->calib)
>  		return -ENOMEM;
> =20
> +	/* calculate shared calibration data */
>  	err =3D tegra_calc_shared_calib(soc->tfuse, &shared_calib);
>  	if (err)
> -		goto disable_clocks;
> +		return err;
> =20
> +	/* calculate tsensor calibaration data */
>  	for (i =3D 0; i < soc->num_tsensors; ++i) {
> -		err =3D enable_tsensor(tegra, i, &shared_calib);
> +		err =3D tegra_calc_tsensor_calib(&soc->tsensors[i],
> +					       &shared_calib,
> +					       &tegra->calib[i]);
>  		if (err)
> -			goto disable_clocks;
> +			return err;
>  	}
> =20
> -	/* Program pdiv and hotspot offsets per THERM */
> -	pdiv =3D readl(tegra->regs + SENSOR_PDIV);
> -	hotspot =3D readl(tegra->regs + SENSOR_HOTSPOT_OFF);
> -	for (i =3D 0; i < soc->num_ttgs; ++i) {
> -		pdiv =3D REG_SET_MASK(pdiv, soc->ttgs[i]->pdiv_mask,
> -				    soc->ttgs[i]->pdiv);
> -		if (soc->ttgs[i]->id =3D=3D TEGRA124_SOCTHERM_SENSOR_PLLX)
> -			continue;
> -		hotspot =3D  REG_SET_MASK(hotspot,
> -					soc->ttgs[i]->pllx_hotspot_mask,
> -					soc->ttgs[i]->pllx_hotspot_diff);
> -	}
> -	writel(pdiv, tegra->regs + SENSOR_PDIV);
> -	writel(hotspot, tegra->regs + SENSOR_HOTSPOT_OFF);
> +	tegra->thermctl_tzs =3D devm_kzalloc(&pdev->dev,
> +					   sizeof(*z) * soc->num_ttgs,
> +					   GFP_KERNEL);
> +	if (!tegra->thermctl_tzs)
> +		return -ENOMEM;
> +
> +	err =3D soctherm_clk_enable(pdev, true);
> +	if (err)
> +		return err;
> +
> +	soctherm_init(pdev);
> =20
>  	for (i =3D 0; i < soc->num_ttgs; ++i) {
>  		struct tegra_thermctl_zone *zone =3D
> @@ -563,6 +601,7 @@ static int tegra_soctherm_probe(struct platform_devic=
e *pdev)
>  		}
> =20
>  		zone->tz =3D z;
> +		tegra->thermctl_tzs[soc->ttgs[i]->id] =3D z;
> =20
>  		/* Configure hw trip points */
>  		tegra_soctherm_set_hwtrips(&pdev->dev, soc->ttgs[i], z);
> @@ -573,8 +612,7 @@ static int tegra_soctherm_probe(struct platform_devic=
e *pdev)
>  	return 0;
> =20
>  disable_clocks:
> -	clk_disable_unprepare(tegra->clock_tsensor);
> -	clk_disable_unprepare(tegra->clock_soctherm);
> +	soctherm_clk_enable(pdev, false);
> =20
>  	return err;
>  }
> @@ -585,17 +623,54 @@ static int tegra_soctherm_remove(struct platform_de=
vice *pdev)
> =20
>  	debugfs_remove_recursive(tegra->debugfs_dir);
> =20
> -	clk_disable_unprepare(tegra->clock_tsensor);
> -	clk_disable_unprepare(tegra->clock_soctherm);
> +	soctherm_clk_enable(pdev, false);
> +
> +	return 0;
> +}
> +
> +static int soctherm_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +
> +	soctherm_clk_enable(pdev, false);
> =20
>  	return 0;
>  }
> =20
> +static int soctherm_resume(struct device *dev)
> +{
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct tegra_soctherm *tegra =3D platform_get_drvdata(pdev);
> +	struct tegra_soctherm_soc *soc =3D tegra->soc;
> +	int err, i;
> +
> +	err =3D soctherm_clk_enable(pdev, true);
> +	if (err) {
> +		dev_err(&pdev->dev,
> +			"Resume failed: enable clocks failed\n");
> +		return err;
> +	}
> +
> +	soctherm_init(pdev);
> +
> +	for (i =3D 0; i < soc->num_ttgs; ++i) {
> +		struct thermal_zone_device *tz;
> +
> +		tz =3D tegra->thermctl_tzs[soc->ttgs[i]->id];
> +		tegra_soctherm_set_hwtrips(dev, soc->ttgs[i], tz);
> +	}
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(tegra_soctherm_pm, soctherm_suspend, soctherm_r=
esume);
> +
>  static struct platform_driver tegra_soctherm_driver =3D {
>  	.probe =3D tegra_soctherm_probe,
>  	.remove =3D tegra_soctherm_remove,
>  	.driver =3D {
>  		.name =3D "tegra_soctherm",
> +		.pm =3D &tegra_soctherm_pm,
>  		.of_match_table =3D tegra_soctherm_of_match,
>  	},
>  };
> --=20
> 1.9.1
>=20

--eheScQNz3K90DVRs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJW5w+iAAoJEMLUO4d9pOJWhP8H/01sjXUd/DRSeWHnYLCz8J6g
OvgFcbXxGR33gH+KmJG//6GADFUjz125RSkm5qpRJe50pjNq1VA8n30d1EIo0iC4
ly9JrtD2N0xQtYqq2ToNFZjPjyeWW9B0LY3JczvLe520zuqqtjFAlzF76IxoEMvg
P81kqtrGu6zXHsJSlg7q4H9bQo7RM7GZGKNDYpiaM6FwkNSO2nC+OTcR0FIOQaah
M7VRfCOFer5KbSHfsoVAu0/Tq8gFYCtkY2xaAvNdd5R2xBj+RveD8eOEe7FhagpZ
kFmjpxCzellfHF6HD2IJZWExfdUCTsjQcyVAsrv8Fp/u6PkzLDFxB7n3yws6j+8=
=uU3m
-----END PGP SIGNATURE-----

--eheScQNz3K90DVRs--
