From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v2 07/17] thermal: cpu_cooling: Modify exynos thermal
 code to use device tree for cpu cooling configuration
Date: Fri, 2 Jan 2015 14:18:09 -0400
Message-ID: <20150102181807.GD12130@developer>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1418213396-743-1-git-send-email-l.majewski@samsung.com>
 <1418213396-743-8-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qrgsu6vtpU/OV/zm"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1418213396-743-8-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org


--Qrgsu6vtpU/OV/zm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2014 at 01:09:46PM +0100, Lukasz Majewski wrote:
> Up till now exynos_tmu_data.c was used for storing CPU cooling configurat=
ion
> data. Now the Exynos thermal core code uses device tree to get this data.
> For this purpose generic thermal code for configuring CPU cooling was
> used.

Title prefix also does not help here, I would use 'thermal: exynos: ....'

>=20
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> ---
> Changes for v2:
> - None
> ---
>  drivers/cpufreq/exynos-cpufreq.c                |  23 ++++-
>  drivers/thermal/samsung/exynos_thermal_common.c | 122 ++++++++++++++----=
------
>  drivers/thermal/samsung/exynos_tmu.c            |   7 --
>  drivers/thermal/samsung/exynos_tmu.h            |   5 -
>  drivers/thermal/samsung/exynos_tmu_data.c       |  42 +-------
>  5 files changed, 94 insertions(+), 105 deletions(-)
>=20
> diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cp=
ufreq.c
> index 1e0ec57..fdedb8d 100644
> --- a/drivers/cpufreq/exynos-cpufreq.c
> +++ b/drivers/cpufreq/exynos-cpufreq.c
> @@ -18,10 +18,13 @@
>  #include <linux/cpufreq.h>
>  #include <linux/platform_device.h>
>  #include <linux/of.h>
> +#include <linux/cpu_cooling.h>
> +#include <linux/cpu.h>
> =20
>  #include "exynos-cpufreq.h"
> =20
>  static struct exynos_dvfs_info *exynos_info;
> +static struct thermal_cooling_device *cdev;
>  static struct regulator *arm_regulator;
>  static unsigned int locking_frequency;
> =20
> @@ -156,6 +159,7 @@ static struct cpufreq_driver exynos_driver =3D {
> =20
>  static int exynos_cpufreq_probe(struct platform_device *pdev)
>  {
> +	struct device_node *np;
>  	int ret =3D -EINVAL;
> =20
>  	exynos_info =3D kzalloc(sizeof(*exynos_info), GFP_KERNEL);
> @@ -198,9 +202,24 @@ static int exynos_cpufreq_probe(struct platform_devi=
ce *pdev)
>  	/* Done here as we want to capture boot frequency */
>  	locking_frequency =3D clk_get_rate(exynos_info->cpu_clk) / 1000;
> =20
> -	if (!cpufreq_register_driver(&exynos_driver))
> -		return 0;
> +	if (cpufreq_register_driver(&exynos_driver))
> +		goto err;
> =20
> +	np =3D of_find_node_by_path("/cpus/cpu@0");
> +	if (!np) {
> +		pr_err("failed to find cpu0 node\n");
> +		return -ENOENT;
> +	}
> +	if (of_find_property(np, "#cooling-cells", NULL)) {
> +		cdev =3D of_cpufreq_cooling_register(np, cpu_present_mask);
> +		if (IS_ERR(cdev))
> +			pr_err("running cpufreq without cooling device: %ld\n",
> +			       PTR_ERR(cdev));
> +	}
> +	of_node_put(np);
> +
> +	return 0;
> + err:
>  	dev_err(&pdev->dev, "failed to register cpufreq driver\n");
>  	regulator_put(arm_regulator);
>  err_vdd_arm:
> diff --git a/drivers/thermal/samsung/exynos_thermal_common.c b/drivers/th=
ermal/samsung/exynos_thermal_common.c
> index 6dc3815..00aa688 100644
> --- a/drivers/thermal/samsung/exynos_thermal_common.c
> +++ b/drivers/thermal/samsung/exynos_thermal_common.c
> @@ -133,47 +133,62 @@ static int exynos_get_crit_temp(struct thermal_zone=
_device *thermal,
>  static int exynos_bind(struct thermal_zone_device *thermal,
>  			struct thermal_cooling_device *cdev)
>  {
> -	int ret =3D 0, i, tab_size, level;
> -	struct freq_clip_table *tab_ptr, *clip_data;
>  	struct exynos_thermal_zone *th_zone =3D thermal->devdata;
>  	struct thermal_sensor_conf *data =3D th_zone->sensor_conf;
> +	struct device_node *child, *gchild, *np;
> +	struct of_phandle_args cooling_spec;
> +	unsigned long max, state =3D 0;
> +	int ret =3D 0, i =3D 0;
> =20
> -	tab_ptr =3D (struct freq_clip_table *)data->cooling_data.freq_data;
> -	tab_size =3D data->cooling_data.freq_clip_count;
> -
> -	if (tab_ptr =3D=3D NULL || tab_size =3D=3D 0)
> +	/*
> +	 * Below code is necessary to skip binding when cpufreq's
> +	 * frequency table is not yet initialized.
> +	 */
> +	cdev->ops->get_max_state(cdev, &state);
> +	if (!state && !th_zone->cool_dev_size) {
> +		th_zone->cool_dev_size =3D 1;
> +		th_zone->cool_dev[0] =3D cdev;
> +		th_zone->bind =3D false;
>  		return 0;
> +	}
> =20
> -	/* find the cooling device registered*/
> -	for (i =3D 0; i < th_zone->cool_dev_size; i++)
> -		if (cdev =3D=3D th_zone->cool_dev[i])
> -			break;
> +	np =3D of_find_node_by_path("/thermal-zones/cpu-thermal");
> +	if (!np) {
> +		pr_err("failed to find thmerla-zones/cpu-thermal node\n");
> +		return -ENOENT;
> +	}
> =20
> -	/* No matching cooling device */
> -	if (i =3D=3D th_zone->cool_dev_size)
> -		return 0;
> +	child =3D of_get_child_by_name(np, "cooling-maps");
> =20
> -	/* Bind the thermal zone to the cpufreq cooling device */
> -	for (i =3D 0; i < tab_size; i++) {
> -		clip_data =3D (struct freq_clip_table *)&(tab_ptr[i]);
> -		level =3D cpufreq_cooling_get_level(0, clip_data->freq_clip_max);
> -		if (level =3D=3D THERMAL_CSTATE_INVALID)
> -			return 0;
> -		switch (GET_ZONE(i)) {
> -		case MONITOR_ZONE:
> -		case WARN_ZONE:
> -			if (thermal_zone_bind_cooling_device(thermal, i, cdev,
> -								level, 0)) {
> -				dev_err(data->dev,
> -					"error unbinding cdev inst=3D%d\n", i);
> -				ret =3D -EINVAL;
> -			}
> -			th_zone->bind =3D true;
> -			break;
> -		default:
> +	for_each_child_of_node(child, gchild) {
> +		ret =3D of_parse_phandle_with_args(gchild, "cooling-device",
> +						 "#cooling-cells",
> +						 0, &cooling_spec);


hmm.. Why do we need to duplicate the same parsing found at of-thermal?
Can you please help me understand the reasoning?

> +		if (ret < 0) {
> +			pr_err("missing cooling_device property\n");
> +			goto end;
> +		}
> +
> +		if (cooling_spec.args_count < 2) {
>  			ret =3D -EINVAL;
> +			goto end;
>  		}
> +
> +		max =3D cooling_spec.args[0];
> +		if (thermal_zone_bind_cooling_device(thermal, i, cdev,
> +						     max, 0)) {
> +			dev_err(data->dev,
> +				"thermal error unbinding cdev inst=3D%d\n", i);
> +
> +			ret =3D -EINVAL;
> +			goto end;
> +		}
> +		i++;
>  	}
> +	th_zone->bind =3D true;
> +end:
> +	of_node_put(child);
> +	of_node_put(np);
> =20
>  	return ret;
>  }
> @@ -182,16 +197,12 @@ static int exynos_bind(struct thermal_zone_device *=
thermal,
>  static int exynos_unbind(struct thermal_zone_device *thermal,
>  			struct thermal_cooling_device *cdev)
>  {
> -	int ret =3D 0, i, tab_size;
> +	int ret =3D 0, i;
>  	struct exynos_thermal_zone *th_zone =3D thermal->devdata;
>  	struct thermal_sensor_conf *data =3D th_zone->sensor_conf;
> +	struct device_node *child, *gchild, *np;
> =20
> -	if (th_zone->bind =3D=3D false)
> -		return 0;
> -
> -	tab_size =3D data->cooling_data.freq_clip_count;
> -
> -	if (tab_size =3D=3D 0)
> +	if (th_zone->bind =3D=3D false || !th_zone->cool_dev_size)
>  		return 0;
> =20
>  	/* find the cooling device registered*/
> @@ -203,23 +214,30 @@ static int exynos_unbind(struct thermal_zone_device=
 *thermal,
>  	if (i =3D=3D th_zone->cool_dev_size)
>  		return 0;
> =20
> -	/* Bind the thermal zone to the cpufreq cooling device */
> -	for (i =3D 0; i < tab_size; i++) {
> -		switch (GET_ZONE(i)) {
> -		case MONITOR_ZONE:
> -		case WARN_ZONE:
> -			if (thermal_zone_unbind_cooling_device(thermal, i,
> -								cdev)) {
> -				dev_err(data->dev,
> -					"error unbinding cdev inst=3D%d\n", i);
> -				ret =3D -EINVAL;
> -			}
> -			th_zone->bind =3D false;
> -			break;
> -		default:
> +	np =3D of_find_node_by_path("/thermal-zones/cpu-thermal");
> +	if (!np) {
> +		pr_err("failed to find thmerla-zones/cpu-thermal node\n");
> +		return -ENOENT;
> +	}
> +
> +	child =3D of_get_child_by_name(np, "cooling-maps");
> +
> +	i =3D 0;
> +	for_each_child_of_node(child, gchild) {
> +		if (thermal_zone_unbind_cooling_device(thermal, i,
> +						       cdev)) {
> +			dev_err(data->dev,
> +				"error unbinding cdev inst=3D%d\n", i);
>  			ret =3D -EINVAL;
> +			goto end;
>  		}
> +		i++;
>  	}
> +	th_zone->bind =3D false;
> +end:
> +	of_node_put(child);
> +	of_node_put(np);
> +
>  	return ret;
>  }
> =20
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsu=
ng/exynos_tmu.c
> index 936d16f..d2d6b53 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -916,13 +916,6 @@ static int exynos_tmu_probe(struct platform_device *=
pdev)
> =20
>  	sensor_conf->trip_data.trigger_falling =3D pdata->threshold_falling;
> =20
> -	sensor_conf->cooling_data.freq_clip_count =3D pdata->freq_tab_count;
> -	for (i =3D 0; i < pdata->freq_tab_count; i++) {
> -		sensor_conf->cooling_data.freq_data[i].freq_clip_max =3D
> -					pdata->freq_tab[i].freq_clip_max;
> -		sensor_conf->cooling_data.freq_data[i].temp_level =3D
> -					pdata->freq_tab[i].temp_level;
> -	}
>  	sensor_conf->dev =3D &pdev->dev;
>  	/* Register the sensor with thermal management interface */
>  	ret =3D exynos_register_thermal(sensor_conf);
> diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsu=
ng/exynos_tmu.h
> index 03ebdd0..fcdb2fc 100644
> --- a/drivers/thermal/samsung/exynos_tmu.h
> +++ b/drivers/thermal/samsung/exynos_tmu.h
> @@ -73,9 +73,6 @@
>   * @second_point_trim: temp value of the second point trimming
>   * @default_temp_offset: default temperature offset in case of no trimmi=
ng
>   * @cal_type: calibration type for temperature
> - * @freq_clip_table: Table representing frequency reduction percentage.
> - * @freq_tab_count: Count of the above table as frequency reduction may
> - *	applicable to only some of the trigger levels.
>   *
>   * This structure is required for configuration of exynos_tmu driver.
>   */
> @@ -101,8 +98,6 @@ struct exynos_tmu_platform_data {
>  	u32 cal_type;
>  	u32 cal_mode;
>  	u32 type;
> -	struct freq_clip_table freq_tab[4];
> -	unsigned int freq_tab_count;
>  };
> =20
>  /**
> diff --git a/drivers/thermal/samsung/exynos_tmu_data.c b/drivers/thermal/=
samsung/exynos_tmu_data.c
> index b239100..a993f3d 100644
> --- a/drivers/thermal/samsung/exynos_tmu_data.c
> +++ b/drivers/thermal/samsung/exynos_tmu_data.c
> @@ -47,15 +47,6 @@ struct exynos_tmu_init_data const exynos4210_default_t=
mu_data =3D {
>  		.first_point_trim =3D 25,
>  		.second_point_trim =3D 85,
>  		.default_temp_offset =3D 50,
> -		.freq_tab[0] =3D {
> -			.freq_clip_max =3D 800 * 1000,
> -			.temp_level =3D 85,
> -			},
> -		.freq_tab[1] =3D {
> -			.freq_clip_max =3D 200 * 1000,
> -			.temp_level =3D 100,
> -		},
> -		.freq_tab_count =3D 2,
>  		.type =3D SOC_ARCH_EXYNOS4210,
>  		},
>  	},
> @@ -87,16 +78,7 @@ struct exynos_tmu_init_data const exynos4210_default_t=
mu_data =3D {
>  	.max_efuse_value =3D 100, \
>  	.first_point_trim =3D 25, \
>  	.second_point_trim =3D 85, \
> -	.default_temp_offset =3D 50, \
> -	.freq_tab[0] =3D { \
> -		.freq_clip_max =3D 800 * 1000, \
> -		.temp_level =3D 70, \
> -	}, \
> -	.freq_tab[1] =3D { \
> -		.freq_clip_max =3D 400 * 1000, \
> -		.temp_level =3D 95, \
> -	}, \
> -	.freq_tab_count =3D 2
> +	.default_temp_offset =3D 50
> =20
>  struct exynos_tmu_init_data const exynos3250_default_tmu_data =3D {
>  	.tmu_data =3D {
> @@ -133,16 +115,7 @@ struct exynos_tmu_init_data const exynos3250_default=
_tmu_data =3D {
>  	.max_efuse_value =3D 100, \
>  	.first_point_trim =3D 25, \
>  	.second_point_trim =3D 85, \
> -	.default_temp_offset =3D 50, \
> -	.freq_tab[0] =3D { \
> -		.freq_clip_max =3D 1400 * 1000, \
> -		.temp_level =3D 70, \
> -	}, \
> -	.freq_tab[1] =3D { \
> -		.freq_clip_max =3D 400 * 1000, \
> -		.temp_level =3D 95, \
> -	}, \
> -	.freq_tab_count =3D 2
> +	.default_temp_offset =3D 50
> =20
>  struct exynos_tmu_init_data const exynos4412_default_tmu_data =3D {
>  	.tmu_data =3D {
> @@ -189,16 +162,7 @@ struct exynos_tmu_init_data const exynos5250_default=
_tmu_data =3D {
>  	.max_efuse_value =3D 100, \
>  	.first_point_trim =3D 25, \
>  	.second_point_trim =3D 85, \
> -	.default_temp_offset =3D 50, \
> -	.freq_tab[0] =3D { \
> -		.freq_clip_max =3D 800 * 1000, \
> -		.temp_level =3D 85, \
> -	}, \
> -	.freq_tab[1] =3D { \
> -		.freq_clip_max =3D 200 * 1000, \
> -		.temp_level =3D 103, \
> -	}, \
> -	.freq_tab_count =3D 2, \
> +	.default_temp_offset =3D 50,
> =20
>  #define EXYNOS5260_TMU_DATA \
>  	__EXYNOS5260_TMU_DATA \
> --=20
> 2.0.0.rc2
>=20

--Qrgsu6vtpU/OV/zm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUpuDXAAoJEMLUO4d9pOJWt5oH/3oLtmn1I6wNg+8xWsuUQgZI
iLc6hE+oSEO5bn+Blg53v+T2dZcSSmrNQ1G9FW63G+g+7e4A+Bgr0kxTI2fAuZdl
weovaNl/05Nn9qOlCCtYqrN81Z0yr3PqfgW9PWsCSrOq3vCqJ2t6T/PY3uTudKbW
Pi3We5TWLkacK9GeMI22gfnTwA/1eJYW/4XVYNONpn7t8N5HWSc6Mmn+agT5jjd9
eneZ6XSYNavynFvncAkoxuPqNPcGOKjZbeKFv6MkEdENSCxqAcpRGMxK1OIBAX0W
mu1QLFpWffp5/2BHfzzA5Ass50p+DgD9JpsrUnMZ6gq3GHKI4oM+nI1PueBnk3Y=
=gcF5
-----END PGP SIGNATURE-----

--Qrgsu6vtpU/OV/zm--
