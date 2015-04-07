From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V4 1/3] Thermal: initialize thermal zone device correctly
Date: Mon, 6 Apr 2015 19:47:11 -0700
Message-ID: <20150407024709.GI4648@localhost.localdomain>
References: <1428373476-14257-1-git-send-email-rui.zhang@intel.com>
 <1428373476-14257-2-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qVyHzDF4yf4A8jkR"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:34862 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752961AbbDGCrC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Apr 2015 22:47:02 -0400
Received: by pddn5 with SMTP id n5so63583997pdd.2
        for <linux-pm@vger.kernel.org>; Mon, 06 Apr 2015 19:47:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1428373476-14257-2-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org


--qVyHzDF4yf4A8jkR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 07, 2015 at 10:24:34AM +0800, Zhang Rui wrote:
> After thermal zone device registered, as we have not read any
> temperature before, thus tz->temperature should not be 0, which actually
> means 0C, and thermal trend is not available.
> In this case, we need specially handling for the first
> thermal_zone_device_update().
>=20
> Both thermal core framework and step_wise governor is enhanced to handle =
this.
>=20
> CC: <stable@vger.kernel.org> #3.18+
> Tested-by: Manuel Krause <manuelkrause@netscape.net>
> Tested-by: szegad <szegadlo@poczta.onet.pl>
> Tested-by: prash <prash.n.rao@gmail.com>
> Tested-by: amish <ammdispose-arch@yahoo.com>
> Tested-by: Matthias <morpheusxyz123@yahoo.de>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Can you please consider the comments I made on V3?

Summary:

1. Change initialized to trend_valid
2. return next_target earlier in the get_target_state, so the behavior
is consistent.

> ---
>  drivers/thermal/step_wise.c    | 15 +++++++++++++--
>  drivers/thermal/thermal_core.c | 19 +++++++++++++++++--
>  drivers/thermal/thermal_core.h |  1 +
>  include/linux/thermal.h        |  3 +++
>  4 files changed, 34 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
> index 5a0f12d..c2bb37c 100644
> --- a/drivers/thermal/step_wise.c
> +++ b/drivers/thermal/step_wise.c
> @@ -63,6 +63,16 @@ static unsigned long get_target_state(struct thermal_i=
nstance *instance,
>  	next_target =3D instance->target;
>  	dev_dbg(&cdev->device, "cur_state=3D%ld\n", cur_state);
> =20
> +	if (!instance->initialized) {
> +		if (throttle) {
> +			next_target =3D (cur_state + 1) >=3D instance->upper ?
> +					instance->upper :
> +					((cur_state + 1) < instance->lower ?
> +					instance->lower : (cur_state + 1));
> +		} else
> +			next_target =3D THERMAL_NO_TARGET;
> +	}
> +
>  	switch (trend) {
>  	case THERMAL_TREND_RAISING:
>  		if (throttle) {
> @@ -149,7 +159,8 @@ static void thermal_zone_trip_update(struct thermal_z=
one_device *tz, int trip)
>  		dev_dbg(&instance->cdev->device, "old_target=3D%d, target=3D%d\n",
>  					old_target, (int)instance->target);
> =20
> -		if (old_target =3D=3D instance->target)
> +		if (instance->initialized &&
> +		    old_target =3D=3D instance->target)
>  			continue;
> =20
>  		/* Activate a passive thermal instance */
> @@ -161,7 +172,7 @@ static void thermal_zone_trip_update(struct thermal_z=
one_device *tz, int trip)
>  			instance->target =3D=3D THERMAL_NO_TARGET)
>  			update_passive_instance(tz, trip_type, -1);
> =20
> -
> +		instance->initialized =3D true;
>  		instance->cdev->updated =3D false; /* cdev needs update */
>  	}
> =20
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 174d3bc..9d6f71b 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -469,8 +469,22 @@ static void update_temperature(struct thermal_zone_d=
evice *tz)
>  	mutex_unlock(&tz->lock);
> =20
>  	trace_thermal_temperature(tz);
> -	dev_dbg(&tz->device, "last_temperature=3D%d, current_temperature=3D%d\n=
",
> -				tz->last_temperature, tz->temperature);
> +	if (tz->last_temperature =3D=3D THERMAL_TEMP_INVALID)
> +		dev_dbg(&tz->device, "last_temperature N/A, current_temperature=3D%d\n=
",
> +			tz->temperature);
> +	else
> +		dev_dbg(&tz->device, "last_temperature=3D%d, current_temperature=3D%d\=
n",
> +			tz->last_temperature, tz->temperature);
> +}
> +
> +static void thermal_zone_device_reset(struct thermal_zone_device *tz)
> +{
> +	struct thermal_instance *pos;
> +
> +	tz->temperature =3D THERMAL_TEMP_INVALID;
> +	tz->passive =3D 0;
> +	list_for_each_entry(pos, &tz->thermal_instances, tz_node)
> +		pos->initialized =3D false;
>  }
> =20
>  void thermal_zone_device_update(struct thermal_zone_device *tz)
> @@ -1574,6 +1588,7 @@ struct thermal_zone_device *thermal_zone_device_reg=
ister(const char *type,
>  	if (!tz->ops->get_temp)
>  		thermal_zone_device_set_polling(tz, 0);
> =20
> +	thermal_zone_device_reset(tz);
>  	thermal_zone_device_update(tz);
> =20
>  	return tz;
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_cor=
e.h
> index 0531c75..6d9ffa5 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -41,6 +41,7 @@ struct thermal_instance {
>  	struct thermal_zone_device *tz;
>  	struct thermal_cooling_device *cdev;
>  	int trip;
> +	bool initialized;
>  	unsigned long upper;	/* Highest cooling state for this trip point */
>  	unsigned long lower;	/* Lowest cooling state for this trip point */
>  	unsigned long target;	/* expected cooling state */
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 5eac316..fb96b15 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -40,6 +40,9 @@
>  /* No upper/lower limit requirement */
>  #define THERMAL_NO_LIMIT	((u32)~0)
> =20
> +/* use value, which < 0K, to indicate an invalid/uninitialized temperatu=
re */
> +#define THERMAL_TEMP_INVALID	-274000
> +
>  /* Unit conversion macros */
>  #define KELVIN_TO_CELSIUS(t)	(long)(((long)t-2732 >=3D 0) ?	\
>  				((long)t-2732+5)/10 : ((long)t-2732-5)/10)
> --=20
> 1.9.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--qVyHzDF4yf4A8jkR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVI0UpAAoJEMLUO4d9pOJWNlAH/i7eHBxQEgL42oGl2UHvzAcx
q1tQqnwiKHe3U67n+3rPmlVaTJ+w7xY1GMOpyL3cEaMUi/kiwIInhCtiSayVGZag
7ngOOffskssiaRQEApR+ywvUbrgWmUGdKYVzOgELSJBrCYdDhBnYcTCslo+wpP+X
Y+RnEAdLqGK3goBsOjb2ZnWIs4kNHkoHq0nasojPp8ldg4bNZMepwpKiwWZoJspt
EL9MEjQS28vM3jh+5eJDk8zg3lM9Nb0x39zcVN7frazlhEF/68s7ywI0zza9Msra
iz9q1V8dJXdgxBrq0S2zIDUKCTCxknAOBSHtRAhGOv8SPbSYz8xEfJxvvpSBTLU=
=yfxS
-----END PGP SIGNATURE-----

--qVyHzDF4yf4A8jkR--
