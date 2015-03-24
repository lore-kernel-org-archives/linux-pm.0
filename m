From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 1/3] Thermal: initialize thermal zone device correctly
Date: Tue, 24 Mar 2015 11:00:06 -0400
Message-ID: <20150324150004.GB29155@developer.hsd1.ca.comcast.net>
References: <1427174490-7974-1-git-send-email-rui.zhang@intel.com>
 <1427174490-7974-2-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427174490-7974-2-git-send-email-rui.zhang@intel.com>
Sender: stable-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Rui,

A couple of comments.

On Tue, Mar 24, 2015 at 01:21:28PM +0800, Zhang Rui wrote:
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
> ---
>  drivers/thermal/step_wise.c    | 15 +++++++++++++--
>  drivers/thermal/thermal_core.c | 19 +++++++++++++++++--
>  drivers/thermal/thermal_core.h |  1 +
>  include/linux/thermal.h        |  3 +++
>  4 files changed, 34 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c

Should this patch also include changes in other governors ?

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

Why it makes sense to change the next state if a instance is
uninitialized?

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

Should we also teach the tracing facility about THERMAL_TEMP_INVALID?

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
> index 5eac316..8650b0b 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -40,6 +40,9 @@
>  /* No upper/lower limit requirement */
>  #define THERMAL_NO_LIMIT	((u32)~0)
> =20
> +/* Invalid/uninitialized temperature */
> +#define THERMAL_TEMP_INVALID	-27400
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

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJVEXv0AAoJEMLUO4d9pOJWvjQIAIEKp79/jw30G8JrlzcX+9TF
++o5T2M4DDCtPSbJ6Wfh88463Opj5vXufp2wRzxPgdEC4A810g9Y5CjAlXPw0LlF
8LJkT9NDkTRmw5zEMC8dK8hRweh7/2o6ziUXQou8JRlpgJCs5fS12Tl7OD8c9NP4
YHbUm8ENXdb343SQpgAzMAmI2gDVdnpQ8i1fTyWKxK9sftjH4MojnJ/cKad+TefH
bv+cy1m58dWrmrULEj+Z4wNrbrQ6/h2+zs7r69VMxsFTD4Tzp6PMU/ogttcHjI7h
ZEaqBYQ7Syy/bx/GJXhiTWsWMvhsafZCr19qfSJFevLL82p1QdRF7nqbmXELyPo=
=t1jo
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--
