From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH V6 15/30] thermal: exynos: Return success even if no cooling
 data supplied
Date: Wed, 19 Jun 2013 18:54:21 -0400
Message-ID: <51C2369D.1090303@ti.com>
References: <1371451599-31035-1-git-send-email-amit.daniel@samsung.com> <1371451599-31035-16-git-send-email-amit.daniel@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2ODMCBIPLROQKLSJMKPQE"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51922 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964822Ab3FSWyh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 19 Jun 2013 18:54:37 -0400
In-Reply-To: <1371451599-31035-16-git-send-email-amit.daniel@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.kachhap@gmail.com, Kukjin Kim <kgene.kim@samsung.com>, jonghwa3.lee@samsung.com

------enig2ODMCBIPLROQKLSJMKPQE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 17-06-2013 02:46, Amit Daniel Kachhap wrote:
> This patch removes the error return in the bind/unbind routine
> as the platform may not register any cpufreq cooling data.
>=20
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> Acked-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> ---
>  drivers/thermal/samsung/exynos_thermal_common.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/thermal/samsung/exynos_thermal_common.c b/drivers/=
thermal/samsung/exynos_thermal_common.c
> index 7064eb7..86d39aa 100644
> --- a/drivers/thermal/samsung/exynos_thermal_common.c
> +++ b/drivers/thermal/samsung/exynos_thermal_common.c
> @@ -131,7 +131,7 @@ static int exynos_bind(struct thermal_zone_device *=
thermal,
>  	tab_size =3D data->cooling_data.freq_clip_count;
> =20
>  	if (tab_ptr =3D=3D NULL || tab_size =3D=3D 0)
> -		return -EINVAL;
> +		return 0;
> =20
>  	/* find the cooling device registered*/
>  	for (i =3D 0; i < th_zone->cool_dev_size; i++)
> @@ -180,7 +180,7 @@ static int exynos_unbind(struct thermal_zone_device=
 *thermal,
>  	tab_size =3D data->cooling_data.freq_clip_count;
> =20
>  	if (tab_size =3D=3D 0)
> -		return -EINVAL;
> +		return 0;
> =20
>  	/* find the cooling device registered*/
>  	for (i =3D 0; i < th_zone->cool_dev_size; i++)
>=20

I have one question before acking this one: what happens if one
registers a TMU with no freq tab? Say the case where you have three
sensors, just like SOC_ARCH_EXYNOS5440. Would you register
cpufreq_cooling device for all of them? In other way, are you having 3
cpufreq_cooling devices?


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


------enig2ODMCBIPLROQKLSJMKPQE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlHCNp0ACgkQCXcVR3XQvP2lsAD6AliygWHV68AxPqIWFsNSUmW8
e+fNldiHZhW7gN6AnNIBAP2oY+TUFaDa4Ed6RcD8AVmIsLLX7Cz1cJRt1ivgm/fy
=ixXh
-----END PGP SIGNATURE-----

------enig2ODMCBIPLROQKLSJMKPQE--
