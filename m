From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v5 07/18] thermal: exynos: Modify exynos thermal code to
 use device tree for cpu cooling configuration
Date: Tue, 20 Jan 2015 22:18:33 -0400
Message-ID: <20150121021831.GE5830@developer.hsd1.ca.comcast.net>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1421666462-7606-1-git-send-email-l.majewski@samsung.com>
 <1421666462-7606-8-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Epv4kl9IRBfg3rk"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1421666462-7606-8-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org


--4Epv4kl9IRBfg3rk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2015 at 12:20:51PM +0100, Lukasz Majewski wrote:
> Up till now exynos_tmu_data.c was used for storing CPU cooling configurat=
ion
> data. Now the Exynos thermal core code uses device tree to get this data.
> For this purpose generic thermal code for configuring CPU cooling was
> used.
>=20
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> ---
> Changes for v2:
> - None
> Changes for v3:
> - Rewrite code responsible for registering CPU cooling device to not depe=
nd
>   on explicit "/cpus/cpu@0" path since now Exynos SoCs use new cpu node
>   names (e.g. cpu@A00). New approach iterates over "cpus" node children.
> - Patch title changed to thermal: exynos
> Changes for v4:
> - None
> Changes for v5:
> - None
>=20
> ---
>  drivers/cpufreq/exynos-cpufreq.c                |  30 +++++-
>  drivers/thermal/samsung/exynos_thermal_common.c | 122 ++++++++++++++----=
------
>  drivers/thermal/samsung/exynos_tmu.c            |   7 --
>  drivers/thermal/samsung/exynos_tmu.h            |   5 -
>  drivers/thermal/samsung/exynos_tmu_data.c       |  42 +-------
>  5 files changed, 101 insertions(+), 105 deletions(-)
>=20
> diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cp=
ufreq.c
> index f99a0b0..32bc64d 100644
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
> +	struct device_node *cpus, *np;
>  	int ret =3D -EINVAL;
> =20
>  	exynos_info =3D kzalloc(sizeof(*exynos_info), GFP_KERNEL);
> @@ -198,9 +202,31 @@ static int exynos_cpufreq_probe(struct platform_devi=
ce *pdev)
>  	/* Done here as we want to capture boot frequency */
>  	locking_frequency =3D clk_get_rate(exynos_info->cpu_clk) / 1000;
> =20
> -	if (!cpufreq_register_driver(&exynos_driver))
> -		return 0;
> +	if (cpufreq_register_driver(&exynos_driver))
> +		goto err;
> =20
> +	cpus =3D of_find_node_by_path("/cpus");
> +	if (!cpus) {
> +		pr_err("failed to find cpus node\n");
> +		return -ENOENT;
> +	}
> +
> +	for (np =3D of_get_next_child(cpus, NULL); np;
> +	     of_node_put(np), np =3D of_get_next_child(cpus, np)) {
> +		if (of_find_property(np, "#cooling-cells", NULL)) {
> +			cdev =3D of_cpufreq_cooling_register(np,
> +							   cpu_present_mask);
> +			if (IS_ERR(cdev))
> +				pr_err("running cpufreq without cooling device: %ld\n",
> +				       PTR_ERR(cdev));
> +			break;
> +		}
> +	}
> +	of_node_put(np);
> +	of_node_put(cpus);
> +
> +	return 0;
> + err:
>  	dev_err(&pdev->dev, "failed to register cpufreq driver\n");
>  	regulator_put(arm_regulator);
>  err_vdd_arm:

You need at least an ack from a cpufreq maintainer to get this patch in.
I would prefer if you split the cpufreq part from the thermal part. It
avoids merge conflicts in the upstreaming process.

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
> index 5000727..ae30f6a 100644
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
> index 7f880d2..627dec9 100644
> --- a/drivers/thermal/samsung/exynos_tmu.h
> +++ b/drivers/thermal/samsung/exynos_tmu.h
> @@ -83,9 +83,6 @@ enum soc_type {
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
> @@ -111,8 +108,6 @@ struct exynos_tmu_platform_data {
>  	enum soc_type type;
>  	u32 cal_type;
>  	u32 cal_mode;
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

--4Epv4kl9IRBfg3rk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUvwxvAAoJEMLUO4d9pOJWGtEH/0BJ2KvNNIK5lYGtDO5iltlV
NYpjRyjzQy0n+bYCM3duwoIAZ5hjuBAczsJzdHrRT5F3r9fVsY48ZTr77fEgXh1A
1DTRxr0aW/LizhqmfJ+P5/SLmoRAgLL9gFkh3dKrwESvRypWq6GaZwAh3D4l7uRt
3tEnPPEov2Gfyka0HU/goTtKcTEo069BkvaHrcencoiR2h3gMRvyG0RlYD/XMaqn
Yzmcz+USpUxcU43b6jO9kM/tT2kORvvKynVnux8LOjlrqnSJm1Me19iT9CdjL8Nr
jCZtgIAMxqmCWUA9HjptkAxrHdWSvraDqz+GP6+v9VvStpwj0PJLfsVgiYAL9vk=
=8fm+
-----END PGP SIGNATURE-----

--4Epv4kl9IRBfg3rk--
