From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v1] Thermal/int340x: Fix memleak for aux trip
Date: Thu, 5 Mar 2015 01:57:02 -0400
Message-ID: <20150305055700.GC3632@developer.hsd1.ca.comcast.net>
References: <1425330727-18854-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1425330727-18854-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:44272 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870AbbCEF4L (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 Mar 2015 00:56:11 -0500
Received: by padet14 with SMTP id et14so15883662pad.11
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2015 21:56:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1425330727-18854-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 02, 2015 at 01:12:07PM -0800, Srinivas Pandruvada wrote:
> When thermal zone device register fails or on module exit, the memory
> for aux_trip is not freed. This change fixes this issue.
>=20
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

applied into -fixes branch. Thanks.

> ---
>  drivers/thermal/int340x_thermal/int340x_thermal_zone.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/thermal/int340x_thermal/int340x_thermal_zone.c b/dri=
vers/thermal/int340x_thermal/int340x_thermal_zone.c
> index f88b088..1e25133 100644
> --- a/drivers/thermal/int340x_thermal/int340x_thermal_zone.c
> +++ b/drivers/thermal/int340x_thermal/int340x_thermal_zone.c
> @@ -208,7 +208,7 @@ struct int34x_thermal_zone *int340x_thermal_zone_add(=
struct acpi_device *adev,
>  				trip_cnt, GFP_KERNEL);
>  		if (!int34x_thermal_zone->aux_trips) {
>  			ret =3D -ENOMEM;
> -			goto free_mem;
> +			goto err_trip_alloc;
>  		}
>  		trip_mask =3D BIT(trip_cnt) - 1;
>  		int34x_thermal_zone->aux_trip_nr =3D trip_cnt;
> @@ -248,14 +248,15 @@ struct int34x_thermal_zone *int340x_thermal_zone_ad=
d(struct acpi_device *adev,
>  						0, 0);
>  	if (IS_ERR(int34x_thermal_zone->zone)) {
>  		ret =3D PTR_ERR(int34x_thermal_zone->zone);
> -		goto free_lpat;
> +		goto err_thermal_zone;
>  	}
> =20
>  	return int34x_thermal_zone;
> =20
> -free_lpat:
> +err_thermal_zone:
>  	acpi_lpat_free_conversion_table(int34x_thermal_zone->lpat_table);
> -free_mem:
> +	kfree(int34x_thermal_zone->aux_trips);
> +err_trip_alloc:
>  	kfree(int34x_thermal_zone);
>  	return ERR_PTR(ret);
>  }
> @@ -266,6 +267,7 @@ void int340x_thermal_zone_remove(struct int34x_therma=
l_zone
>  {
>  	thermal_zone_device_unregister(int34x_thermal_zone->zone);
>  	acpi_lpat_free_conversion_table(int34x_thermal_zone->lpat_table);
> +	kfree(int34x_thermal_zone->aux_trips);
>  	kfree(int34x_thermal_zone);
>  }
>  EXPORT_SYMBOL_GPL(int340x_thermal_zone_remove);
> --=20
> 1.9.3
>=20

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU9/AkAAoJEMLUO4d9pOJW/MUH/izbiCrsnrjDXFOcE+Um0jgR
x80lm8+kmtCirAYsW5ZyQO5Ssd/PQFQ+zN9zP/tucl2XJwwvpGUs/OG21YB++QP4
X3vZnsBLuhfI947P8OMo1zebP40urw30LRyVM8ae2YLmC5F9bYRiMSvpkBBMPk2j
YZgm0KbZO2IeeXZL/HLPL1SIq/KpU7+Wv0X9sxSTZ7n0CRtVldWnsRSmdDKIyn1L
fjhKzXQ3GUQ5KEP7eSzZ9nkxr0wxfoCtpJdlEV5CyOb2MR/i4yrc/2LHvUK41EDh
4+j8wkWTuK4JYagzwqGv6oSpP5vaPRmcaDUDyB9auzETtGmmD/Vkp2pwP1joxd4=
=wSwh
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--
