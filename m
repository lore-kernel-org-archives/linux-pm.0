From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: Default OF created trip points to writable
Date: Mon, 16 Feb 2015 11:14:34 -0400
Message-ID: <20150216151432.GB8648@developer.hsd1.ca.comcast.net>
References: <1423592506-20620-1-git-send-email-punit.agrawal@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:42529 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570AbbBPULr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Feb 2015 15:11:47 -0500
Received: by padhz1 with SMTP id hz1so718294pad.9
        for <linux-pm@vger.kernel.org>; Mon, 16 Feb 2015 12:11:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1423592506-20620-1-git-send-email-punit.agrawal@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hey Punit,

On Tue, Feb 10, 2015 at 06:21:46PM +0000, Punit Agrawal wrote:
> When registering a thermal zone from device tree, default the trip
> points to writable. By default, only the root user can change these.
>=20
> This allows the trip points to be tweaked after the system has
> booted.

Can you please elaborate more on why having default writable makes sense
against having default read only? The purpose of this patch seams to be
targeted to development/debugging systems, not productions systems. The
default has to make sense for production systems.


>=20
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> ---
> Hi Eduardo,
>=20
> We've been using this patch internally and haven't run into any
>  issues. Without these changes there is no way to change trip points
>  from a running system.

Ok. I see.

So, the problem statement here is to be able to change the trip points
=66rom a running system. What is the purpose? Do you have something in
userland that is benefiting of having these trips writable? Or is it
just for development fun?


BR,

Eduardo Valentin

>=20
> Comments welcome.
>=20
> Cheers,
> Punit
>=20
>  drivers/thermal/of-thermal.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index 668fb1b..b7ad5c0 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -865,6 +865,7 @@ int __init of_parse_thermal_zones(void)
>  	for_each_child_of_node(np, child) {
>  		struct thermal_zone_device *zone;
>  		struct thermal_zone_params *tzp;
> +		int i, mask =3D 0;
> =20
>  		/* Check whether child is enabled or not */
>  		if (!of_device_is_available(child))
> @@ -891,8 +892,11 @@ int __init of_parse_thermal_zones(void)
>  		/* No hwmon because there might be hwmon drivers registering */
>  		tzp->no_hwmon =3D true;
> =20
> +		for (i =3D 0; i < tz->ntrips; i++)
> +			mask |=3D 1 << i;
> +
>  		zone =3D thermal_zone_device_register(child->name, tz->ntrips,
> -						    0, tz,
> +						    mask, tz,
>  						    ops, tzp,
>  						    tz->passive_delay,
>  						    tz->polling_delay);
> --=20
> 2.1.4
>=20

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU4glMAAoJEMLUO4d9pOJWFj8H/ixFyZQhY7N/yUk3IQ4CMG/l
hqxYiZWv+Fz//+tv/gysc9PhY1WH3NNFVrSlGeBDlFhFz9QIXWyGg1GhT9wjeiQM
cNuO74qC2kuPc7qa2GlYt2H7+Blki6eMXQ4OgqgHefrQe+peSdoP7mKSAqbWj4u5
nNiWxxntBWVssDlSUBF3qVeMmMTWsDPNAmfPtlIpD20lQKJ7rL333Y/KllKTTEjI
tgwoszROg2GGFYWUWAi/McU/y0GCBYumrrZlnU4XbpBBYeBG9vzWr8W7Hx5aRmoo
M997Pt52cMRfnWrlVPw/l6lYkt86Yg+iCwb6ec4rGJO8loOsWfgjP9Ev1JUqPV4=
=jveZ
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
