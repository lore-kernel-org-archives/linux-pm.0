From: jonghwa3.lee@samsung.com
Subject: Re: [PATCH V4 16/30] thermal: exynos: Make the zone handling dependent
 on trip count
Date: Fri, 17 May 2013 21:17:40 +0900
Message-ID: <51961FE4.60105@samsung.com>
References: <1368525540-15034-1-git-send-email-amit.daniel@samsung.com>
 <1368525540-15034-17-git-send-email-amit.daniel@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1368525540-15034-17-git-send-email-amit.daniel@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.kachhap@gmail.com, Kukjin Kim <kgene.kim@samsung.com>, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-pm@vger.kernel.org

On 2013=EB=85=84 05=EC=9B=94 14=EC=9D=BC 18:58, Amit Daniel Kachhap wro=
te:

> This code simplifies the zone handling to use the trip count passed
> by the TMU driver. This also helps in adding more zone support.
>=20
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> ---
>  drivers/thermal/samsung/exynos_thermal_common.c |   55 ++++++++++++-=
----------
>  drivers/thermal/samsung/exynos_thermal_common.h |    2 -
>  2 files changed, 29 insertions(+), 28 deletions(-)
>=20
> diff --git a/drivers/thermal/samsung/exynos_thermal_common.c b/driver=
s/thermal/samsung/exynos_thermal_common.c
> index 86d39aa..2369417 100644
> --- a/drivers/thermal/samsung/exynos_thermal_common.c
> +++ b/drivers/thermal/samsung/exynos_thermal_common.c
> @@ -78,17 +78,16 @@ static int exynos_set_mode(struct thermal_zone_de=
vice *thermal,
>  static int exynos_get_trip_type(struct thermal_zone_device *thermal,=
 int trip,
>  				 enum thermal_trip_type *type)
>  {
> -	switch (GET_ZONE(trip)) {
> -	case MONITOR_ZONE:
> -	case WARN_ZONE:
> -		*type =3D THERMAL_TRIP_ACTIVE;
> -		break;
> -	case PANIC_ZONE:
> -		*type =3D THERMAL_TRIP_CRITICAL;
> -		break;
> -	default:
> +	struct exynos_thermal_zone *th_zone =3D thermal->devdata;
> +	int max_trip =3D th_zone->sensor_conf->trip_data.trip_count;
> +
> +	if (trip < 0 || trip >=3D max_trip)
>  		return -EINVAL;
> -	}
> +	else if (trip =3D=3D (max_trip - 1))
> +		*type =3D THERMAL_TRIP_CRITICAL;
> +	else
> +		*type =3D THERMAL_TRIP_ACTIVE;
> +


 In current exynos_thermal driver, it is hard to set various trip type =
for each
trip, especially passive type. (not impossible, but complicated)

What do you think we just keep trip information with trip temperature i=
n private
data? I mean if we just make trip level information to driver's private=
 data
(like exynos_thermal_zone), it might be helpful to control trip type an=
d trip
temperature. Like this,

struct exynos_thermal_trip_info {
	int trip_temp;
	enum thermal_trip_type type;
};
struct exynos_thermal_device {=09
	.
	struct exynos_thermal_trip_info *trips;
	int num_trips;
};

Thanks,
Jonghwa

>  	return 0;
>  }
> =20
> @@ -97,8 +96,9 @@ static int exynos_get_trip_temp(struct thermal_zone=
_device *thermal, int trip,
>  				unsigned long *temp)
>  {
>  	struct exynos_thermal_zone *th_zone =3D thermal->devdata;
> +	int max_trip =3D th_zone->sensor_conf->trip_data.trip_count;
> =20
> -	if (trip < GET_TRIP(MONITOR_ZONE) || trip > GET_TRIP(PANIC_ZONE))
> +	if (trip < 0 || trip >=3D max_trip)
>  		return -EINVAL;
> =20
>  	*temp =3D th_zone->sensor_conf->trip_data.trip_val[trip];
> @@ -112,10 +112,10 @@ static int exynos_get_trip_temp(struct thermal_=
zone_device *thermal, int trip,
>  static int exynos_get_crit_temp(struct thermal_zone_device *thermal,
>  				unsigned long *temp)
>  {
> -	int ret;
> -	/* Panic zone */
> -	ret =3D exynos_get_trip_temp(thermal, GET_TRIP(PANIC_ZONE), temp);
> -	return ret;
> +	struct exynos_thermal_zone *th_zone =3D thermal->devdata;
> +	int max_trip =3D th_zone->sensor_conf->trip_data.trip_count;
> +	/* Get the temp of highest trip*/
> +	return exynos_get_trip_temp(thermal, max_trip - 1, temp);
>  }
> =20
>  /* Bind callback functions for thermal zone */
> @@ -340,19 +340,22 @@ int exynos_register_thermal(struct thermal_sens=
or_conf *sensor_conf)
>  		return -ENOMEM;
> =20
>  	th_zone->sensor_conf =3D sensor_conf;
> -	cpumask_set_cpu(0, &mask_val);
> -	th_zone->cool_dev[0] =3D cpufreq_cooling_register(&mask_val);
> -	if (IS_ERR(th_zone->cool_dev[0])) {
> -		pr_err("Failed to register cpufreq cooling device\n");
> -		ret =3D -EINVAL;
> -		goto err_unregister;
> +	if (sensor_conf->cooling_data.freq_clip_count > 0) {
> +		cpumask_set_cpu(0, &mask_val);
> +		th_zone->cool_dev[0] =3D cpufreq_cooling_register(&mask_val);
> +		if (IS_ERR(th_zone->cool_dev[0])) {
> +			pr_err("Failed to register cpufreq cooling device\n");
> +			ret =3D -EINVAL;
> +			goto err_unregister;
> +		}
> +		th_zone->cool_dev_size++;
>  	}
> -	th_zone->cool_dev_size++;
> =20
> -	th_zone->therm_dev =3D thermal_zone_device_register(sensor_conf->na=
me,
> -			EXYNOS_ZONE_COUNT, 0, th_zone, &exynos_dev_ops, NULL, 0,
> -			sensor_conf->trip_data.trigger_falling ?
> -			0 : IDLE_INTERVAL);
> +	th_zone->therm_dev =3D thermal_zone_device_register(
> +			sensor_conf->name, sensor_conf->trip_data.trip_count,
> +			0, th_zone, &exynos_dev_ops, NULL, 0,
> +			sensor_conf->trip_data.trigger_falling ? 0 :
> +			IDLE_INTERVAL);
> =20
>  	if (IS_ERR(th_zone->therm_dev)) {
>  		pr_err("Failed to register thermal zone device\n");
> diff --git a/drivers/thermal/samsung/exynos_thermal_common.h b/driver=
s/thermal/samsung/exynos_thermal_common.h
> index 59138ae..7b938e1 100644
> --- a/drivers/thermal/samsung/exynos_thermal_common.h
> +++ b/drivers/thermal/samsung/exynos_thermal_common.h
> @@ -42,8 +42,6 @@
>  #define GET_ZONE(trip) (trip + 2)
>  #define GET_TRIP(zone) (zone - 2)
> =20
> -#define EXYNOS_ZONE_COUNT	3
> -
>  /**
>   * struct freq_clip_table
>   * @freq_clip_max: maximum frequency allowed for this cooling state.
