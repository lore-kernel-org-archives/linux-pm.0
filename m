From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 2/2] thermal: of: Match function for of-thermal
Date: Tue, 20 Jan 2015 09:57:15 -0400
Message-ID: <20150120135710.GB5830@developer.hsd1.ca.comcast.net>
References: <1421171482-16101-1-git-send-email-kapileshwar.singh@arm.com>
 <1421171482-16101-3-git-send-email-kapileshwar.singh@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:54798 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911AbbATN64 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 Jan 2015 08:58:56 -0500
Received: by mail-pa0-f48.google.com with SMTP id rd3so45847058pab.7
        for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2015 05:58:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1421171482-16101-3-git-send-email-kapileshwar.singh@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kapileshwar Singh <kapileshwar.singh@arm.com>
Cc: linux-pm@vger.kernel.org, rui.zhang@intel.com, javi.merino@arm.com, punit.agrawal@arm.com


--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Same here, enconding is not helping.

On Tue, Jan 13, 2015 at 05:51:22PM +0000, Kapileshwar Singh wrote:
> From: KP Singh <kapileshwar.singh@arm.com>
>=20
> This patch introduces the following changes:
>=20
> * Creation of a parsed_bind_params data structure to
>   uniquely identify the bind parameters per coolig

s/coolig/cooling

>   device and optimize the match callback
>=20
> * Adding a match call-back to of-thermal to replace
>   the specific bind operation
>=20
> * In the previous implementation the thermal_zone_params
>   and thermal_bind_params are not populated and the weight
>   parameter which is read from the device tree
>   (as contribution) does not get propagated to the governor

Is it possible to break this patch into smaller parts?


>=20
> Signed-off-by: Kapileshwar Singh <kapileshwar.singh@arm.com>
> ---
>  drivers/thermal/of-thermal.c |  340 ++++++++++++++++++++++++++++++++++--=
------
>  1 file changed, 278 insertions(+), 62 deletions(-)
>=20
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index e145b66df444..82f7e4b48845 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -31,6 +31,7 @@
>  #include <linux/export.h>
>  #include <linux/string.h>
>  #include <linux/thermal.h>
> +#include <linux/bitops.h>
> =20
>  #include "thermal_core.h"
> =20
> @@ -54,6 +55,26 @@ struct __thermal_bind_params {
>  };
> =20
>  /**
> + * struct parsed_bind_params - parsed bind parameters from device tree
> + * @cdev_node: a pointer to identify the device tree node of the cdev
> + * @trip_mask: a mask of all the trips the cdev is to be bound to
> + * @weight: the percentage (0 to 100) of cooling conrtibution
> + * @binding_limits: the max and min limits for each trip point
> + *
> + * The struct __thermal_bind_params is a raw representation of the
> + * data read from the device tree. This is then parsed into this
> + * struct such that there is only on param per cooling device

s/on/one

> + * and can be correlated efficiently with thermal_bind_params.
> + */
> +
> +struct parsed_bind_params {
> +	struct device_node *cdev_node;
> +	unsigned long trip_mask;
> +	unsigned int weight;
> +	unsigned long *binding_limits;
> +};
> +
> +/**
>   * struct __thermal_zone - internal representation of a thermal zone
>   * @mode: current thermal zone device mode (enabled/disabled)
>   * @passive_delay: polling interval while passive cooling is activated
> @@ -78,6 +99,8 @@ struct __thermal_zone {
>  	/* cooling binding data */
>  	int num_tbps;
>  	struct __thermal_bind_params *tbps;
> +	struct parsed_bind_params *pbs;
> +	int num_parsed_tbps;
> =20
>  	/* sensor interface */
>  	void *sensor_data;
> @@ -208,60 +231,6 @@ static int of_thermal_get_trend(struct thermal_zone_=
device *tz, int trip,
>  	return 0;
>  }
> =20
> -static int of_thermal_bind(struct thermal_zone_device *thermal,
> -			   struct thermal_cooling_device *cdev)
> -{
> -	struct __thermal_zone *data =3D thermal->devdata;
> -	int i;
> -
> -	if (!data || IS_ERR(data))
> -		return -ENODEV;
> -
> -	/* find where to bind */
> -	for (i =3D 0; i < data->num_tbps; i++) {
> -		struct __thermal_bind_params *tbp =3D data->tbps + i;
> -
> -		if (tbp->cooling_device =3D=3D cdev->np) {
> -			int ret;
> -
> -			ret =3D thermal_zone_bind_cooling_device(thermal,
> -						tbp->trip_id, cdev,
> -						tbp->max,
> -						tbp->min);
> -			if (ret)
> -				return ret;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -static int of_thermal_unbind(struct thermal_zone_device *thermal,
> -			     struct thermal_cooling_device *cdev)
> -{
> -	struct __thermal_zone *data =3D thermal->devdata;
> -	int i;
> -
> -	if (!data || IS_ERR(data))
> -		return -ENODEV;
> -
> -	/* find where to unbind */
> -	for (i =3D 0; i < data->num_tbps; i++) {
> -		struct __thermal_bind_params *tbp =3D data->tbps + i;
> -
> -		if (tbp->cooling_device =3D=3D cdev->np) {
> -			int ret;
> -
> -			ret =3D thermal_zone_unbind_cooling_device(thermal,
> -						tbp->trip_id, cdev);
> -			if (ret)
> -				return ret;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
>  static int of_thermal_get_mode(struct thermal_zone_device *tz,
>  			       enum thermal_device_mode *mode)
>  {
> @@ -384,9 +353,6 @@ static struct thermal_zone_device_ops of_thermal_ops =
=3D {
>  	.get_trip_hyst =3D of_thermal_get_trip_hyst,
>  	.set_trip_hyst =3D of_thermal_set_trip_hyst,
>  	.get_crit_temp =3D of_thermal_get_crit_temp,
> -
> -	.bind =3D of_thermal_bind,
> -	.unbind =3D of_thermal_unbind,
>  };
> =20
>  /***   sensor API   ***/
> @@ -621,6 +587,237 @@ static int thermal_of_populate_bind_params(struct d=
evice_node *np,
>  	return ret;
>  }
> =20
> +int of_thermal_match_bind_param(struct thermal_zone_device *tz,
> +				struct thermal_cooling_device *cdev,
> +				int index)
> +{
> +	struct __thermal_zone *__tz;
> +	struct parsed_bind_params *pbs;
> +	struct thermal_bind_params *tbp;
> +	int i;
> +
> +	if (!tz->devdata)
> +		return 1;
> +
> +	__tz =3D (struct __thermal_zone *)tz->devdata;
> +
> +	if (!__tz->pbs || !__tz->num_parsed_tbps)
> +		return 1;
> +
> +	pbs =3D __tz->pbs;
> +	tbp =3D tz->tzp->tbp;
> +
> +	for (i =3D 0; i < __tz->num_parsed_tbps; i++) {
> +		if (pbs[i].cdev_node =3D=3D cdev->np) {
> +			if (tbp[index].trip_mask !=3D pbs[i].trip_mask)
> +				return 1;
> +			if (tbp[index].binding_limits !=3D pbs[i].binding_limits)
> +				return 1;
> +			if (tbp[index].weight !=3D pbs[i].weight)
> +				return 1;
> +			return 0;
> +		}
> +	}
> +	return 1;
> +}
> +
> +/**
> + * get_unique_mask - return a mask indicating repeated cdevs
> + * @__tbp: __thermal_bind_params internal data structre
> + * @num_tbps: total number of cdev<->trip bindings
> + *
> + * A cooling device may be bound to more than one
> + * thermal trips. These multiple bindings are populated as
> + * separate entries in the @__tbp params internal data structure
> + * from the device tree. The unique mask identifies the location
> + * of re-ocurring cooling devices which is further used to
> + * populate the thermal_bind_params external data structre.
> + *
> + * Return: the calculated bitmask (long)
> +	   (set bit means a non-unique cdev at that index)
> + */
> +static unsigned long get_unique_mask(struct __thermal_bind_params *__tbp,
> +			       unsigned int num_tbps)
> +{
> +	unsigned long unique_mask =3D 0;
> +	int i, j;
> +	/*
> +	 * A bit set in the mask means that the cooling device
> +	 * at that position is not unique
> +	 */
> +	for (i =3D 0; i < num_tbps; i++)
> +		for (j =3D i + 1; j < num_tbps; j++)
> +			if (!test_bit(j, &unique_mask) &&
> +			   (__tbp[i].cooling_device =3D=3D __tbp[j].cooling_device))
> +				set_bit(j, &unique_mask);
> +
> +	return  unique_mask;
> +}
> +
> +static void fill_parsed_params(struct parsed_bind_params *pbs,
> +				struct __thermal_bind_params *__tbp,
> +				int unique)
> +{
> +	pbs->binding_limits[2 * __tbp->trip_id] =3D __tbp->min;
> +	pbs->binding_limits[2 * __tbp->trip_id + 1] =3D __tbp->max;
> +
> +	if (unique) {
> +		pbs->weight =3D __tbp->usage;
> +		pbs->trip_mask =3D (1  << __tbp->trip_id);
> +		pbs->cdev_node =3D __tbp->cooling_device;
> +	} else {
> +		if (pbs->weight !=3D __tbp->usage)
> +			pr_err("Multiple weights (%u, %u) sepcified for cdev %s",
> +			       pbs->weight, __tbp->usage, pbs->cdev_node->name);
> +		pbs->trip_mask |=3D (1 << __tbp->trip_id);
> +	}
> +}
> +
> +/**
> + * of_thermal_parse_bind_params - parse the populated bind params
> + * @__tz: __thermal_zone private device data for of-thermal
> + *
> + * This function creates a reflection of the thermal_bind_params
> + * data structure and condenses the cooling-map populated from the
> + * device tree. This structure is then used when the match
> + * callback of_thermal_match_bind_param is invoked.
> + *
> + * Return: parsed_bind_parameters structure
> + */
> +static struct parsed_bind_params*
> +of_thermal_parse_bind_params(struct __thermal_zone *__tz)
> +{
> +	struct parsed_bind_params *pbs;
> +	struct __thermal_bind_params *__tbp =3D __tz->tbps;
> +	unsigned long unique_mask;
> +	unsigned long *limits;
> +	unsigned int num_parsed;
> +	int i, j, err;
> +	int bind_count =3D 0;
> +
> +	unique_mask =3D get_unique_mask(__tbp, __tz->num_tbps);
> +	num_parsed =3D __tz->num_tbps - hweight_long(unique_mask);
> +	__tz->num_parsed_tbps =3D num_parsed;
> +
> +	pbs =3D kcalloc(num_parsed, sizeof(*pbs), GFP_KERNEL);
> +	if (!pbs) {
> +		err =3D -ENOMEM;
> +		goto err_exit;
> +	}
> +
> +	/* We have a number of trips in tz */
> +	for (i =3D 0; i < __tz->num_tbps; i++) {
> +
> +		/*
> +		 * We have two cases here :
> +		 * First occurence of the cooling device
> +		 * In this case we need to allocate a new binding_limits array
> +		 * and assign the limits ( __tbp[i].min and __tbp[i].max )
> +		 * and set the bit in the trip mask
> +		 *
> +		 * Repeated occurence of the cooling device:
> +		 * In this case we need to find the previously allocated
> +		 * binding_param and update the binding_limits and trip_mask.
> +		 */
> +
> +		int unique =3D !test_bit(i, &unique_mask);
> +
> +		if (unique) {
> +			pbs[bind_count].weight =3D __tbp[i].usage;
> +			limits =3D kcalloc(2 * __tz->ntrips, sizeof(*limits),
> +					 GFP_KERNEL);
> +			if (!limits) {
> +				err =3D -ENOMEM;
> +				goto free_bp;
> +			}
> +			pbs[bind_count].binding_limits =3D limits;
> +			fill_parsed_params(&pbs[bind_count], &__tbp[i],
> +					     unique);
> +			bind_count++;
> +		} else {
> +			struct device_node *curr;
> +			struct device_node *prev;
> +
> +			for (j =3D 0; j < bind_count; j++) {
> +				curr =3D __tbp[i].cooling_device;
> +				prev =3D pbs[j].cdev_node;
> +				if (curr =3D=3D prev) {
> +					fill_parsed_params(&pbs[j],
> +							   &__tbp[i],
> +							   unique);
> +					break;
> +				}
> +			}
> +		}
> +
> +	}
> +
> +	return pbs;
> +
> +free_bp:
> +	for (i =3D 0; i < num_parsed; i++)
> +		kfree(pbs[i].binding_limits);
> +	kfree(pbs);
> +
> +err_exit:
> +	return ERR_PTR(err);
> +
> +}
> +
> +/**
> + * of_thermal_populate_tzp - populate the thermal zone params
> + * @__tz: __thermal_zone private device data for of-thermal
> + *
> + * This function populates the thermal_zone_params and also the
> + * tzp->tbp based on the parsed_bind_params (__tz->pbs)
> + *
> + * Return: struct thermal_zone params
> + */
> +static struct thermal_zone_params*
> +of_thermal_populate_tzp(struct __thermal_zone *__tz)
> +{
> +
> +	struct thermal_zone_params *tzp;
> +	struct parsed_bind_params *pbs =3D __tz->pbs;
> +	struct thermal_bind_params *tbp;
> +	int err;
> +	int i;
> +
> +	tzp =3D kzalloc(sizeof(*tzp), GFP_KERNEL);
> +	if (!tzp)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (!pbs || !__tz->num_parsed_tbps) {
> +		err =3D -ENODEV;
> +		goto free_tzp;
> +	}
> +
> +	tbp =3D kcalloc(__tz->num_parsed_tbps, sizeof(*tbp), GFP_KERNEL);
> +	if (!tbp) {
> +		err =3D -ENOMEM;
> +		goto free_tzp;
> +	 }
> +
> +	for (i =3D 0; i < __tz->num_parsed_tbps; i++) {
> +		tbp[i].weight =3D pbs[i].weight;
> +		tbp[i].binding_limits =3D pbs[i].binding_limits;
> +		tbp[i].trip_mask =3D pbs[i].trip_mask;
> +		tbp[i].match =3D of_thermal_match_bind_param;
> +	}
> +
> +	tzp->tbp =3D tbp;
> +	tzp->num_tbps =3D __tz->num_parsed_tbps;
> +
> +	/* No hwmon because there might be hwmon drivers registering */
> +	tzp->no_hwmon =3D true;
> +
> +	return tzp;
> +
> +free_tzp:
> +	kfree(tzp);
> +	return ERR_PTR(err);
> +}
> +
>  /**
>   * It maps 'enum thermal_trip_type' found in include/linux/thermal.h
>   * into the device tree binding of 'trip', property type.
> @@ -800,6 +997,12 @@ thermal_of_build_thermal_zone(struct device_node *np)
>  			goto free_tbps;
>  	}
> =20
> +	tz->pbs =3D of_thermal_parse_bind_params(tz);
> +	if (IS_ERR(tz->pbs)) {
> +		ret =3D -ENOMEM;
> +		goto free_tbps;
> +	}
> +
>  finish:
>  	of_node_put(child);
>  	tz->mode =3D THERMAL_DEVICE_DISABLED;
> @@ -829,6 +1032,8 @@ static inline void of_thermal_free_zone(struct __the=
rmal_zone *tz)
>  	for (i =3D 0; i < tz->num_tbps; i++)
>  		of_node_put(tz->tbps[i].cooling_device);
>  	kfree(tz->tbps);
> +	/* Free the parsed_bind_params */
> +	kfree(tz->pbs);
>  	for (i =3D 0; i < tz->ntrips; i++)
>  		of_node_put(tz->trips[i].np);
>  	kfree(tz->trips);
> @@ -879,15 +1084,14 @@ int __init of_parse_thermal_zones(void)
>  		if (!ops)
>  			goto exit_free;
> =20
> -		tzp =3D kzalloc(sizeof(*tzp), GFP_KERNEL);
> -		if (!tzp) {
> +
> +		tzp =3D of_thermal_populate_tzp(tz);
> +
> +		if (IS_ERR(tzp)) {
>  			kfree(ops);
>  			goto exit_free;
>  		}
> =20
> -		/* No hwmon because there might be hwmon drivers registering */
> -		tzp->no_hwmon =3D true;
> -
>  		zone =3D thermal_zone_device_register(child->name, tz->ntrips,
>  						    0, tz,
>  						    ops, tzp,
> @@ -936,6 +1140,7 @@ void of_thermal_destroy_zones(void)
> =20
>  	for_each_child_of_node(np, child) {
>  		struct thermal_zone_device *zone;
> +		int i;
> =20
>  		/* Check whether child is enabled or not */
>  		if (!of_device_is_available(child))
> @@ -946,6 +1151,17 @@ void of_thermal_destroy_zones(void)
>  			continue;
> =20
>  		thermal_zone_device_unregister(zone);
> +		/*
> +		 * free the binding_limits
> +		 * free the thermal_bind_params
> +		 */
> +		if (zone->tzp && zone->tzp->tbp) {
> +			const struct thermal_zone_params *tzp =3D zone->tzp;
> +
> +			for (i =3D 0; i < tzp->num_tbps; i++)
> +				kfree(tzp->tbp[i].binding_limits);
> +			kfree(tzp->tbp);
> +		}
>  		kfree(zone->tzp);
>  		kfree(zone->ops);
>  		of_thermal_free_zone(zone->devdata);
> --=20
> 1.7.9.5
>=20
>=20

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUvl6rAAoJEMLUO4d9pOJW2c0IAIo/ZTEt/qSciM/JKzkMgD9w
VX8pwOiAOKP6M1xfs/cKVagq+ZFfd58nvxnpvcjI+1JrowLGsqcwWxYc+8dFjs6t
JQeaa41gn1gh2nuF9Xetkp2CCAzxNnHjx7xPYOTwIFuwvqg3Wdl3rXLbChtbJKCL
gOUl3pHRQtsohf8f4cqYG3WgM3I7QZTJV+6TikSzc52X4ZcpsGo54bGu3jN7cGue
u/orZJgp+hae7yt/ujq3xu203E9y7zTLktfzrIg2Lv41SwR/LI4FMpXo6ZTJ8ZfZ
9iCOObGCQlytArWUOHGQdPjSbtZb7nAvmSvmzpKd2sskazE3bpn5m6A+r/tloyw=
=TKHf
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--
