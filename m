From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V7 09/12] thermal: tegra: add thermtrip function
Date: Mon, 14 Mar 2016 12:16:39 -0700
Message-ID: <20160314191637.GC1872@localhost.localdomain>
References: <1457665872-30046-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f+W+jCU1fRNres8c"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36107 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755670AbcCNTQm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Mar 2016 15:16:42 -0400
Content-Disposition: inline
In-Reply-To: <1457665872-30046-1-git-send-email-wni@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Ni <wni@nvidia.com>
Cc: rui.zhang@intel.com, thierry.reding@gmail.com, MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--f+W+jCU1fRNres8c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 11, 2016 at 11:11:12AM +0800, Wei Ni wrote:
> Add support for hardware critical thermal limits to the
> SOC_THERM driver. It use the Linux thermal framework to
> create critical trip temp, and set it to SOC_THERM hardware.
> If these limits are breached, the chip will reset, and if
> appropriately configured, will turn off the PMIC.
>=20
> This support is critical for safe usage of the chip.
>=20
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  drivers/thermal/tegra/soctherm.c          | 166 ++++++++++++++++++++++++=
+++++-
>  drivers/thermal/tegra/soctherm.h          |   7 ++
>  drivers/thermal/tegra/tegra124-soctherm.c |  24 +++++
>  drivers/thermal/tegra/tegra210-soctherm.c |  24 +++++
>  4 files changed, 216 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soc=
therm.c
> index 02ac6d2e5a20..dbaab160baba 100644
> --- a/drivers/thermal/tegra/soctherm.c
> +++ b/drivers/thermal/tegra/soctherm.c
> @@ -73,9 +73,14 @@
>  #define REG_SET_MASK(r, m, v)	(((r) & ~(m)) | \
>  				 (((v) & (m >> (ffs(m) - 1))) << (ffs(m) - 1)))
> =20
> +static const int min_low_temp =3D -127000;
> +static const int max_high_temp =3D 127000;
> +
>  struct tegra_thermctl_zone {
>  	void __iomem *reg;
> -	u32 mask;
> +	struct device *dev;
> +	struct thermal_zone_device *tz;


Why not using tz->dev for the *dev above?

> +	const struct tegra_tsensor_group *sg;
>  };
> =20
>  struct tegra_soctherm {
> @@ -145,22 +150,158 @@ static int tegra_thermctl_get_temp(void *data, int=
 *out_temp)
>  	u32 val;
> =20
>  	val =3D readl(zone->reg);
> -	val =3D REG_GET_MASK(val, zone->mask);
> +	val =3D REG_GET_MASK(val, zone->sg->sensor_temp_mask);
>  	*out_temp =3D translate_temp(val);
> =20
>  	return 0;
>  }
> =20
> +static int
> +thermtrip_program(struct device *dev, const struct tegra_tsensor_group *=
sg,
> +		  int trip_temp);
> +
> +static int tegra_thermctl_set_trip_temp(void *data, int trip, int temp)
> +{
> +	struct tegra_thermctl_zone *zone =3D data;
> +	struct thermal_zone_device *tz =3D zone->tz;
> +	const struct tegra_tsensor_group *sg =3D zone->sg;
> +	struct device *dev =3D zone->dev;
> +	enum thermal_trip_type type;
> +	int ret;
> +
> +	if (!tz)
> +		return -EINVAL;


Is the above check needed? If you saw a case in which your function is
called without tz, would it be the case we have a but in the probe (or
even worse, in thermal-core)?

> +
> +	ret =3D tz->ops->get_trip_type(tz, trip, &type);
> +	if (ret)
> +		return ret;
> +
> +	if (type !=3D THERMAL_TRIP_CRITICAL)
> +		return 0;
> +
> +	return thermtrip_program(dev, sg, temp);
> +}
> +
>  static const struct thermal_zone_of_device_ops tegra_of_thermal_ops =3D {
>  	.get_temp =3D tegra_thermctl_get_temp,
> +	.set_trip_temp =3D tegra_thermctl_set_trip_temp,
>  };
> =20
> +/**
> + * enforce_temp_range() - check and enforce temperature range [min, max]
> + * @trip_temp: the trip temperature to check
> + *
> + * Checks and enforces the permitted temperature range that SOC_THERM
> + * HW can support This is
> + * done while taking care of precision.
> + *
> + * Return: The precision adjusted capped temperature in millicelsius.
> + */
> +static int enforce_temp_range(struct device *dev, int trip_temp)
> +{
> +	int temp;
> +
> +	temp =3D clamp_val(trip_temp, min_low_temp, max_high_temp);
> +	if (temp !=3D trip_temp)
> +		dev_info(dev, "soctherm: trip temperature %d forced to %d\n",
> +			 trip_temp, temp);
> +	return temp;
> +}
> +
> +/**
> + * thermtrip_program() - Configures the hardware to shut down the
> + * system if a given sensor group reaches a given temperature
> + * @dev: ptr to the struct device for the SOC_THERM IP block
> + * @sg: pointer to the sensor group to set the thermtrip temperature for
> + * @trip_temp: the temperature in millicelsius to trigger the thermal tr=
ip at
> + *
> + * Sets the thermal trip threshold of the given sensor group to be the
> + * @trip_temp.  If this threshold is crossed, the hardware will shut
> + * down.
> + *
> + * Note that, although @trip_temp is specified in millicelsius, the
> + * hardware is programmed in degrees Celsius.
> + *
> + * Return: 0 upon success, or %-EINVAL upon failure.
> + */
> +static int thermtrip_program(struct device *dev,
> +			     const struct tegra_tsensor_group *sg,
> +			     int trip_temp)
> +{
> +	struct tegra_soctherm *ts =3D dev_get_drvdata(dev);
> +	int temp;
> +	u32 r;
> +
> +	if (!dev || !sg)
> +		return -EINVAL;
> +
> +	if (!sg->thermtrip_threshold_mask)
> +		return -EINVAL;
> +
> +	temp =3D enforce_temp_range(dev, trip_temp) / ts->soc->thresh_grain;
> +
> +	r =3D readl(ts->regs + THERMCTL_THERMTRIP_CTL);
> +	r =3D REG_SET_MASK(r, sg->thermtrip_threshold_mask, temp);
> +	r =3D REG_SET_MASK(r, sg->thermtrip_enable_mask, 1);
> +	r =3D REG_SET_MASK(r, sg->thermtrip_any_en_mask, 0);
> +	writel(r, ts->regs + THERMCTL_THERMTRIP_CTL);
> +
> +	return 0;
> +}
> +
> +/**
> + * tegra_soctherm_set_hwtrips() - set HW trip point from DT data
> + * @dev: struct device * of the SOC_THERM instance
> + *
> + * Configure the SOC_THERM HW trip points, setting "THERMTRIP"
> + * trip points , using "critical" type trip_temp from thermal
> + * zone.
> + * After they have been configured, THERMTRIP will take action
> + * when the configured SoC thermal sensor group reaches a
> + * certain temperature.
> + *
> + * Return: 0 upon success, or a negative error code on failure.
> + * "Success" does not mean that trips was enabled; it could also
> + * mean that no node was found in DT.
> + * THERMTRIP has been enabled successfully when a message similar to
> + * this one appears on the serial console:
> + * "thermtrip: will shut down when sensor group XXX reaches YYYYYY mC"
> + */
> +static int tegra_soctherm_set_hwtrips(struct device *dev,
> +				      const struct tegra_tsensor_group *sg,
> +				      struct thermal_zone_device *tz)
> +{
> +	int temperature;
> +	int ret;
> +
> +	ret =3D tz->ops->get_crit_temp(tz, &temperature);
> +	if (ret) {
> +		dev_warn(dev, "thermtrip: %s: missing critical temperature\n",
> +			sg->name);
> +		return ret;
> +	}
> +
> +	ret =3D thermtrip_program(dev, sg, temperature);
> +	if (ret) {
> +		dev_err(dev, "thermtrip: %s: error during enable\n",
> +			sg->name);
> +		return ret;
> +	}
> +
> +	dev_info(dev,
> +		 "thermtrip: will shut down when %s reaches %d mC\n",
> +		 sg->name, temperature);
> +
> +	return 0;
> +}
> +
>  #ifdef CONFIG_DEBUG_FS
>  static int regs_show(struct seq_file *s, void *data)
>  {
>  	struct platform_device *pdev =3D s->private;
>  	struct tegra_soctherm *ts =3D platform_get_drvdata(pdev);
>  	const struct tegra_tsensor *tsensors =3D ts->soc->tsensors;
> +	const struct tegra_tsensor_group **ttgs =3D ts->soc->ttgs;
>  	u32 r, state;
>  	int i;
> =20
> @@ -233,6 +374,17 @@ static int regs_show(struct seq_file *s, void *data)
>  	state =3D REG_GET_MASK(r, SENSOR_TEMP2_MEM_TEMP_MASK);
>  	seq_printf(s, " MEM(%d)\n", translate_temp(state));
> =20
> +	r =3D readl(ts->regs + THERMCTL_THERMTRIP_CTL);
> +	state =3D REG_GET_MASK(r, ttgs[0]->thermtrip_any_en_mask);
> +	seq_printf(s, "Thermtrip Any En(%d)\n", state);
> +	for (i =3D 0; i < ts->soc->num_ttgs; i++) {
> +		state =3D REG_GET_MASK(r, ttgs[i]->thermtrip_enable_mask);
> +		seq_printf(s, "     %s En(%d) ", ttgs[i]->name, state);
> +		state =3D REG_GET_MASK(r, ttgs[i]->thermtrip_threshold_mask);
> +		state *=3D ts->soc->thresh_grain;
> +		seq_printf(s, "Thresh(%d)\n", state);
> +	}
> +
>  	return 0;
>  }
> =20
> @@ -388,8 +540,6 @@ static int tegra_soctherm_probe(struct platform_devic=
e *pdev)
>  	writel(pdiv, tegra->regs + SENSOR_PDIV);
>  	writel(hotspot, tegra->regs + SENSOR_HOTSPOT_OFF);
> =20
> -	/* Initialize thermctl sensors */
> -
>  	for (i =3D 0; i < soc->num_ttgs; ++i) {
>  		struct tegra_thermctl_zone *zone =3D
>  			devm_kzalloc(&pdev->dev, sizeof(*zone), GFP_KERNEL);
> @@ -399,7 +549,8 @@ static int tegra_soctherm_probe(struct platform_devic=
e *pdev)
>  		}
> =20
>  		zone->reg =3D tegra->regs + soc->ttgs[i]->sensor_temp_offset;
> -		zone->mask =3D soc->ttgs[i]->sensor_temp_mask;
> +		zone->dev =3D &pdev->dev;
> +		zone->sg =3D soc->ttgs[i];
> =20
>  		z =3D devm_thermal_zone_of_sensor_register(&pdev->dev,
>  							 soc->ttgs[i]->id, zone,
> @@ -410,6 +561,11 @@ static int tegra_soctherm_probe(struct platform_devi=
ce *pdev)
>  				err);
>  			goto disable_clocks;
>  		}
> +
> +		zone->tz =3D z;
> +
> +		/* Configure hw trip points */
> +		tegra_soctherm_set_hwtrips(&pdev->dev, soc->ttgs[i], z);
>  	}
> =20
<cut>

> 1.9.1
>=20

--f+W+jCU1fRNres8c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJW5w4TAAoJEMLUO4d9pOJWbSsH/R4OkE73UahE6Gmty0wH05Ym
mhyRN6eJedIiIuqZWfNSffXgJTb5bYlpYyc46kh4PlyBy9Ezkk88am/NEdOymc2A
Iho8VzJppkXczwlEq2aP+27R5LwsplU7WGvhbcBRNz5L9YvfP6pInMVUt71zFo22
wL2/yri8ufpwU8OOgEI1E/Vht2TKSHUl8hCStmnvRB+MLCYadgpTQ8L0NuEWwFgq
69JIZYVgVkhahdjOGn1taa5RTINro8RG0muqiW2zuapyefPpNcEgsTCRlSD2s+ih
kUnv+NYmV9Tj+BxtOTUSiaRidK+fwM1ueVXdw+de9VSQ8bB+WWJ8H+qBG+siQww=
=YMA1
-----END PGP SIGNATURE-----

--f+W+jCU1fRNres8c--
