From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 1/2] thermal: of: Match function to pass bindparam index
Date: Tue, 20 Jan 2015 09:44:10 -0400
Message-ID: <20150120134408.GA5830@developer.hsd1.ca.comcast.net>
References: <1421171482-16101-1-git-send-email-kapileshwar.singh@arm.com>
 <1421171482-16101-2-git-send-email-kapileshwar.singh@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:39054 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152AbbATNpl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 Jan 2015 08:45:41 -0500
Received: by mail-pd0-f180.google.com with SMTP id ft15so13891723pdb.11
        for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2015 05:45:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1421171482-16101-2-git-send-email-kapileshwar.singh@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kapileshwar Singh <kapileshwar.singh@arm.com>
Cc: linux-pm@vger.kernel.org, rui.zhang@intel.com, javi.merino@arm.com, punit.agrawal@arm.com


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2015 at 05:51:21PM +0000, Kapileshwar Singh wrote:
> From: KP Singh <kapileshwar.singh@arm.com>

The encoding still seams to be scrambled to me.

>=20
> The match function should pass the index of the binding parameters
> which the cooling device needs to be matched against. There are currently
> no implementations of match function within the kernel. A successful
> match requires:
>=20
> 	trip_mask =3D=3D expected_trip_mask;
> 	weight =3D=3D expected_weight;
> 	binding_limits =3D=3D expected_binding_limits;
> 	thermal_zone =3D=3D expected_thermal_zone;

ok. The .match callback is documented under
Documentation/thermal/sysfs-api.txt. Can you please also make sure the
documentation is sane after your change?

>=20
> Signed-off-by: Kapileshwar Singh <kapileshwar.singh@arm.com>
> ---
>  drivers/thermal/thermal_core.c |    4 ++--
>  include/linux/thermal.h        |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 87e0b0782023..db4d6407c1ec 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -276,7 +276,7 @@ static void bind_cdev(struct thermal_cooling_device *=
cdev)
>  		for (i =3D 0; i < tzp->num_tbps; i++) {
>  			if (tzp->tbp[i].cdev || !tzp->tbp[i].match)
>  				continue;
> -			if (tzp->tbp[i].match(pos, cdev))
> +			if (tzp->tbp[i].match(pos, cdev, i))
>  				continue;
>  			tzp->tbp[i].cdev =3D cdev;
>  			__bind(pos, tzp->tbp[i].trip_mask, cdev,
> @@ -315,7 +315,7 @@ static void bind_tz(struct thermal_zone_device *tz)
>  		for (i =3D 0; i < tzp->num_tbps; i++) {
>  			if (tzp->tbp[i].cdev || !tzp->tbp[i].match)
>  				continue;
> -			if (tzp->tbp[i].match(tz, pos))
> +			if (tzp->tbp[i].match(tz, pos, i))
>  				continue;
>  			tzp->tbp[i].cdev =3D pos;
>  			__bind(tz, tzp->tbp[i].trip_mask, pos,
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index fc52e307efab..dc8cf6dc59e5 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -237,7 +237,7 @@ struct thermal_bind_params {
>  	 */
>  	unsigned long *binding_limits;
>  	int (*match) (struct thermal_zone_device *tz,
> -			struct thermal_cooling_device *cdev);
> +		      struct thermal_cooling_device *cdev, int index);
>  };
> =20
>  /* Structure to define Thermal Zone parameters */
> --=20
> 1.7.9.5
>=20
>=20

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUvlueAAoJEMLUO4d9pOJWPHAH/A0XbCLeJufZ4IJj4RtU+00J
sCX/RGXVeezENfyiqq2FVcvgcU65NWESX24KIqafvdwePpo4RU5qf3WvewgWPlVn
ssbDXOVy+N4d3CAnYlvotm6vz62P+qIYUUtAg+4ohEEtuxdwJkJvMSSGLFQGN5yN
2bWQjN4K2xXoqHT3AgGSD1RwgeoBMyZ82ehVaIxInw5CN5pcMnUs3UgYRO19RF4z
1LXf1puceE6xxYs2pYJzBlaZKPRkGmOZ3qC9nd8goeTasw7M+XRln1RVt74orlcT
W25qZSPj+rK7ND8lg6n8pIDZZ2HTLzQhyarM1mQNruLygbD0cgV2+W5zuesC4u4=
=j7OV
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
