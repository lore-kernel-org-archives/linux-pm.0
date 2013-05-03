From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 1/6] Thermal: armada_thermal: Remove redundant platform_set_drvdata()
Date: Fri, 3 May 2013 08:46:40 -0400
Message-ID: <5183B1B0.5030806@ti.com>
References: <1367575034-18432-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2KQCBAFUCUPGKBDVKWBCJ"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45121 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751700Ab3ECMq6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 3 May 2013 08:46:58 -0400
In-Reply-To: <1367575034-18432-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pm@vger.kernel.org, eduardo.valentin@ti.com, rui.zhang@intel.com, patches@linaro.org, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

------enig2KQCBAFUCUPGKBDVKWBCJ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03-05-2013 05:57, Sachin Kamat wrote:
> Commit 0998d06310 (device-core: Ensure drvdata =3D NULL when no
> driver is bound) removes the need to set driver data field to
> NULL.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

I am fine with this patch.

Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>

> ---
>  drivers/thermal/armada_thermal.c |    1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_=
thermal.c
> index 5b4d75f..0d02d4e 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -210,7 +210,6 @@ static int armada_thermal_exit(struct platform_devi=
ce *pdev)
>  		platform_get_drvdata(pdev);
> =20
>  	thermal_zone_device_unregister(armada_thermal);
> -	platform_set_drvdata(pdev, NULL);
> =20
>  	return 0;
>  }
>=20



------enig2KQCBAFUCUPGKBDVKWBCJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlGDsbAACgkQCXcVR3XQvP3zuwD/QEr4TxEZoLkbkL5yKYt8eRYj
VkM7ZqfCPnJ6FzoC+5sBAOwylfn1R2qMW1cu49WHCZEhscpgI4hdohnFBYwYhRtP
=fhgh
-----END PGP SIGNATURE-----

------enig2KQCBAFUCUPGKBDVKWBCJ--
