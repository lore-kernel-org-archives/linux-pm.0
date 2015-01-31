From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 1/5] thermal: of: fix cooling device weights in device
 tree
Date: Fri, 30 Jan 2015 20:00:19 -0400
Message-ID: <20150131000018.GB14374@developer.amazonguestwifi.org>
References: <1421947625-19708-1-git-send-email-javi.merino@arm.com>
 <1421947625-19708-2-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:61937 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903AbbAaAAY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 Jan 2015 19:00:24 -0500
Received: by mail-pa0-f41.google.com with SMTP id kq14so58222839pab.0
        for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2015 16:00:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1421947625-19708-2-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: linux-pm@vger.kernel.org, Punit.Agrawal@arm.com, Kapileshwar.Singh@arm.com, Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene@kernel.org>


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2015 at 05:27:01PM +0000, Javi Merino wrote:
> From: Kapileshwar Singh <kapileshwar.singh@arm.com>
>=20
> Currently you can specify the weight of the cooling device in the device
> tree but that information is not populated to the
> thermal_bind_params where the fair share governor expects it to
> be.  The of thermal zone device doesn't have a thermal_bind_params
> structure and arguably it's better to pass the weight inside the
> thermal_instance as it is specific to the bind of a cooling device to a
> thermal zone parameter.
>=20
> Core thermal code is fixed to populate the weight in the instance from
> the thermal_bind_params, so platform code that was passing the weight
> inside the thermal_bind_params continue to work seamlessly.
>=20
> While we are at it, create a default value for the weight parameter for
> those thermal zones that currently don't define it and remove the
> hardcoded default in of-thermal.
>=20
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Signed-off-by: Kapileshwar Singh <kapileshwar.singh@arm.com>
> ---
>=20
> This patch was previously suggested here[0].  During the discussion,
> Eduardo suggested that dropping the bind op for of-thermal and using
> tbps and their .match() function was preferrable.  We sent a series
> that did that in [1].  However, looking at the code we think that this
> patch is preferrable as it is simpler and enables the rest of the
> patches in these series, specially the simplification in patch 2.
> That's why we are reposting it, now properly asking for inclusion.
>=20
> [0] http://thread.gmane.org/gmane.linux.power-management.general/54622
> [1] http://thread.gmane.org/gmane.linux.power-management.general/55339

Despite going one way or another, this patch breaks existing users of
the thermal_zone_bind_cooling_device API.

>=20
>  Documentation/thermal/sysfs-api.txt                |  4 +++-
>  drivers/thermal/db8500_thermal.c                   |  2 +-
>  drivers/thermal/fair_share.c                       |  2 +-
>  drivers/thermal/imx_thermal.c                      |  3 ++-
>  drivers/thermal/of-thermal.c                       |  5 +++--
>  drivers/thermal/samsung/exynos_thermal_common.c    |  3 ++-
>  drivers/thermal/thermal_core.c                     | 22 ++++++++++++++++=
------
>  drivers/thermal/thermal_core.h                     |  1 +
>  drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  3 ++-
>  include/linux/thermal.h                            |  6 +++++-
>  10 files changed, 36 insertions(+), 15 deletions(-)

$ git grep thermal_zone_bind_cooling_device
Documentation/thermal/sysfs-api.txt:1.3.1 int thermal_zone_bind_cooling_dev=
ice(struct thermal_zone_device *tz,
Documentation/thermal/sysfs-api.txt:thermal_zone_bind_cooling_device/therma=
l_zone_unbind_cooling_device.
drivers/acpi/thermal.c:					thermal_zone_bind_cooling_device
drivers/acpi/thermal.c:				result =3D thermal_zone_bind_cooling_device
drivers/acpi/thermal.c:				result =3D thermal_zone_bind_cooling_device

We are not supposed to break ACPI code base :-)

drivers/platform/x86/acerhdf.c:	if (thermal_zone_bind_cooling_device(therma=
l, 0, cdev,

You may want to add acerhdf to your patch.

drivers/thermal/db8500_thermal.c:		ret =3D thermal_zone_bind_cooling_device=
(thermal, i, cdev,
drivers/thermal/imx_thermal.c:	ret =3D thermal_zone_bind_cooling_device(tz,=
 IMX_TRIP_PASSIVE, cdev,
drivers/thermal/of-thermal.c:			ret =3D thermal_zone_bind_cooling_device(th=
ermal,
drivers/thermal/thermal_core.c:			ret =3D thermal_zone_bind_cooling_device(=
tz, i, cdev,
drivers/thermal/thermal_core.c:				thermal_zone_bind_cooling_device(tz,
drivers/thermal/thermal_core.c: * thermal_zone_bind_cooling_device() - bind=
 a cooling device to a thermal zone
drivers/thermal/thermal_core.c:int thermal_zone_bind_cooling_device(struct =
thermal_zone_device *tz,
drivers/thermal/thermal_core.c:EXPORT_SYMBOL_GPL(thermal_zone_bind_cooling_=
device);
drivers/thermal/ti-soc-thermal/ti-thermal-common.c:	return thermal_zone_bin=
d_cooling_device(thermal, 0, cdev,
include/linux/thermal.h:int thermal_zone_bind_cooling_device(struct thermal=
_zone_device *, int,

>=20
> diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/=
sysfs-api.txt
> index 87519cb379ee..7ec632ed9769 100644
> --- a/Documentation/thermal/sysfs-api.txt
> +++ b/Documentation/thermal/sysfs-api.txt
> @@ -95,7 +95,7 @@ temperature) and throttle appropriate devices.
>  1.3 interface for binding a thermal zone device with a thermal cooling d=
evice
>  1.3.1 int thermal_zone_bind_cooling_device(struct thermal_zone_device *t=
z,
>  	int trip, struct thermal_cooling_device *cdev,
> -	unsigned long upper, unsigned long lower);
> +	unsigned long upper, unsigned long lower, unsigned int weight);
> =20
>      This interface function bind a thermal cooling device to the certain=
 trip
>      point of a thermal zone device.
> @@ -110,6 +110,8 @@ temperature) and throttle appropriate devices.
>      lower:the Minimum cooling state can be used for this trip point.
>            THERMAL_NO_LIMIT means no lower limit,
>  	  and the cooling device can be in cooling state 0.
> +    weight: the influence of this cooling device in this thermal
> +            zone.  See 1.4.1 below for more information.
> =20
>  1.3.2 int thermal_zone_unbind_cooling_device(struct thermal_zone_device =
*tz,
>  		int trip, struct thermal_cooling_device *cdev);
> diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_th=
ermal.c
> index 20adfbe27df1..2fb273c4baa9 100644
> --- a/drivers/thermal/db8500_thermal.c
> +++ b/drivers/thermal/db8500_thermal.c
> @@ -76,7 +76,7 @@ static int db8500_cdev_bind(struct thermal_zone_device =
*thermal,
>  		upper =3D lower =3D i > max_state ? max_state : i;
> =20
>  		ret =3D thermal_zone_bind_cooling_device(thermal, i, cdev,
> -			upper, lower);
> +			upper, lower, THERMAL_WEIGHT_DEFAULT);
> =20
>  		dev_info(&cdev->device, "%s bind to %d: %d-%s\n", cdev->type,
>  			i, ret, ret ? "fail" : "succeed");
> diff --git a/drivers/thermal/fair_share.c b/drivers/thermal/fair_share.c
> index 6e0a3fbfae86..c3b25187b467 100644
> --- a/drivers/thermal/fair_share.c
> +++ b/drivers/thermal/fair_share.c
> @@ -109,7 +109,7 @@ static int fair_share_throttle(struct thermal_zone_de=
vice *tz, int trip)
>  			continue;
> =20
>  		instance->target =3D get_target_state(tz, cdev,
> -					tzp->tbp[i].weight, cur_trip_level);
> +					instance->weight, cur_trip_level);
> =20
>  		instance->cdev->updated =3D false;
>  		thermal_cdev_update(cdev);
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index 2ccbc0788353..36579c05605f 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -306,7 +306,8 @@ static int imx_bind(struct thermal_zone_device *tz,
> =20
>  	ret =3D thermal_zone_bind_cooling_device(tz, IMX_TRIP_PASSIVE, cdev,
>  					       THERMAL_NO_LIMIT,
> -					       THERMAL_NO_LIMIT);
> +					       THERMAL_NO_LIMIT
> +					       THERMAL_WEIGHT_DEFAULT);
>  	if (ret) {
>  		dev_err(&tz->device,
>  			"binding zone %s with cdev %s failed:%d\n",
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index d717f3dab6f1..60e3a21461e7 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -227,7 +227,8 @@ static int of_thermal_bind(struct thermal_zone_device=
 *thermal,
>  			ret =3D thermal_zone_bind_cooling_device(thermal,
>  						tbp->trip_id, cdev,
>  						tbp->max,
> -						tbp->min);
> +						tbp->min,
> +						tbp->usage);
>  			if (ret)
>  				return ret;
>  		}
> @@ -578,7 +579,7 @@ static int thermal_of_populate_bind_params(struct dev=
ice_node *np,
>  	u32 prop;
> =20
>  	/* Default weight. Usage is optional */
> -	__tbp->usage =3D 0;
> +	__tbp->usage =3D THERMAL_WEIGHT_DEFAULT;
>  	ret =3D of_property_read_u32(np, "contribution", &prop);
>  	if (ret =3D=3D 0)
>  		__tbp->usage =3D prop;
> diff --git a/drivers/thermal/samsung/exynos_thermal_common.c b/drivers/th=
ermal/samsung/exynos_thermal_common.c
> index 6dc3815cc73f..03f2ebb1e5c3 100644
> --- a/drivers/thermal/samsung/exynos_thermal_common.c
> +++ b/drivers/thermal/samsung/exynos_thermal_common.c
> @@ -163,7 +163,8 @@ static int exynos_bind(struct thermal_zone_device *th=
ermal,
>  		case MONITOR_ZONE:
>  		case WARN_ZONE:
>  			if (thermal_zone_bind_cooling_device(thermal, i, cdev,
> -								level, 0)) {
> +						level, 0,
> +						THERMAL_WEIGHT_DEFAULT)) {
>  				dev_err(data->dev,
>  					"error unbinding cdev inst=3D%d\n", i);
>  				ret =3D -EINVAL;
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 87e0b0782023..9a424a66c83a 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -218,7 +218,8 @@ static void print_bind_err_msg(struct thermal_zone_de=
vice *tz,
> =20
>  static void __bind(struct thermal_zone_device *tz, int mask,
>  			struct thermal_cooling_device *cdev,
> -			unsigned long *limits)
> +			unsigned long *limits,
> +			unsigned int weight)
>  {
>  	int i, ret;
> =20
> @@ -233,7 +234,8 @@ static void __bind(struct thermal_zone_device *tz, in=
t mask,
>  				upper =3D limits[i * 2 + 1];
>  			}
>  			ret =3D thermal_zone_bind_cooling_device(tz, i, cdev,
> -							       upper, lower);
> +							       upper, lower,
> +							       weight);
>  			if (ret)
>  				print_bind_err_msg(tz, cdev, ret);
>  		}
> @@ -280,7 +282,8 @@ static void bind_cdev(struct thermal_cooling_device *=
cdev)
>  				continue;
>  			tzp->tbp[i].cdev =3D cdev;
>  			__bind(pos, tzp->tbp[i].trip_mask, cdev,
> -			       tzp->tbp[i].binding_limits);
> +			       tzp->tbp[i].binding_limits,
> +			       tzp->tbp[i].weight);
>  		}
>  	}
> =20
> @@ -319,7 +322,8 @@ static void bind_tz(struct thermal_zone_device *tz)
>  				continue;
>  			tzp->tbp[i].cdev =3D pos;
>  			__bind(tz, tzp->tbp[i].trip_mask, pos,
> -			       tzp->tbp[i].binding_limits);
> +			       tzp->tbp[i].binding_limits,
> +			       tzp->tbp[i].weight);
>  		}
>  	}
>  exit:
> @@ -711,7 +715,8 @@ passive_store(struct device *dev, struct device_attri=
bute *attr,
>  				thermal_zone_bind_cooling_device(tz,
>  						THERMAL_TRIPS_NONE, cdev,
>  						THERMAL_NO_LIMIT,
> -						THERMAL_NO_LIMIT);
> +						THERMAL_NO_LIMIT,
> +						THERMAL_WEIGHT_DEFAULT);
>  		}
>  		mutex_unlock(&thermal_list_lock);
>  		if (!tz->passive_delay)
> @@ -913,6 +918,9 @@ thermal_cooling_device_trip_point_show(struct device =
*dev,
>   * @lower:	the Minimum cooling state can be used for this trip point.
>   *		THERMAL_NO_LIMIT means no lower limit,
>   *		and the cooling device can be in cooling state 0.
> + * @weight:	The weight of the cooling device to be bound to the
> + *		thermal zone. Use THERMAL_WEIGHT_DEFAULT for the
> + *		default value
>   *
>   * This interface function bind a thermal cooling device to the certain =
trip
>   * point of a thermal zone device.
> @@ -923,7 +931,8 @@ thermal_cooling_device_trip_point_show(struct device =
*dev,
>  int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
>  				     int trip,
>  				     struct thermal_cooling_device *cdev,
> -				     unsigned long upper, unsigned long lower)
> +				     unsigned long upper, unsigned long lower,
> +				     unsigned int weight)
>  {
>  	struct thermal_instance *dev;
>  	struct thermal_instance *pos;
> @@ -968,6 +977,7 @@ int thermal_zone_bind_cooling_device(struct thermal_z=
one_device *tz,
>  	dev->upper =3D upper;
>  	dev->lower =3D lower;
>  	dev->target =3D THERMAL_NO_TARGET;
> +	dev->weight =3D weight;
> =20
>  	result =3D get_idr(&tz->idr, &tz->lock, &dev->id);
>  	if (result)
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_cor=
e.h
> index 0531c752fbbb..7a465e9d456c 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -48,6 +48,7 @@ struct thermal_instance {
>  	struct device_attribute attr;
>  	struct list_head tz_node; /* node in tz->thermal_instances */
>  	struct list_head cdev_node; /* node in cdev->thermal_instances */
> +	unsigned int weight; /* The weight of the cooling device */
>  };
> =20
>  int thermal_register_governor(struct thermal_governor *);
> diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers=
/thermal/ti-soc-thermal/ti-thermal-common.c
> index 3fb054a10f6a..4638718fabf6 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> @@ -146,7 +146,8 @@ static int ti_thermal_bind(struct thermal_zone_device=
 *thermal,
>  	return thermal_zone_bind_cooling_device(thermal, 0, cdev,
>  	/* bind with min and max states defined by cpu_cooling */
>  						THERMAL_NO_LIMIT,
> -						THERMAL_NO_LIMIT);
> +						THERMAL_NO_LIMIT,
> +						THERMAL_WEIGHT_DEFAULT);
>  }
> =20
>  /* Unbind callback functions for thermal zone */
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index fc52e307efab..2ed7062fac1d 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -40,6 +40,9 @@
>  /* No upper/lower limit requirement */
>  #define THERMAL_NO_LIMIT	((u32)~0)
> =20
> +/* Default weight of a bound cooling device */
> +#define THERMAL_WEIGHT_DEFAULT 0
> +
>  /* Unit conversion macros */
>  #define KELVIN_TO_CELSIUS(t)	(long)(((long)t-2732 >=3D 0) ?	\
>  				((long)t-2732+5)/10 : ((long)t-2732-5)/10)
> @@ -321,7 +324,8 @@ void thermal_zone_device_unregister(struct thermal_zo=
ne_device *);
> =20
>  int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
>  				     struct thermal_cooling_device *,
> -				     unsigned long, unsigned long);
> +				     unsigned long, unsigned long,
> +				     unsigned int);
>  int thermal_zone_unbind_cooling_device(struct thermal_zone_device *, int,
>  				       struct thermal_cooling_device *);
>  void thermal_zone_device_update(struct thermal_zone_device *);
> --=20
> 1.9.1
>=20

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUzBsKAAoJEMLUO4d9pOJWMjIH/0+5Ip5uXOL7l+b5pzMk0crU
W0YrzpzqtgmHI/RaCa6bZTz9KEZPvqYox5fqRHKykgROSAVnHCI3WIqWYckdXzhS
kZXlL2dUVs6nvDOXMKcurWhCIrpka2+tcv4P5ubCey+KTb0894i4p/vWxsNfCfoX
v96dBO0KpOCOUCRkdo5hWoqh7AVksAEpogqFyqmz+g1qm5iNSkk1TwP5JIxdoccW
DEH3HSqUMojHFrD56fMHeyZu7W7+OCiaXQbvdi0fY+0XY/3n8r47y/EqEymwHW9C
wlsgCRWJWk2QpfY53EtOMLyrb6KxUfiSbm+StBsGUwGfUx0sqEgoq63Y4R6x+s4=
=Cxa8
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--
