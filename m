From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 7/7] drivers/power: Convert non-modular syscon-reboot to
 use builtin_driver_register
Date: Sat, 23 May 2015 19:55:46 +0200
Message-ID: <20150523175545.GB16004@earth>
References: <1431287385-1526-1-git-send-email-paul.gortmaker@windriver.com>
 <1431287385-1526-8-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55312 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754116AbbEWR4I (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 23 May 2015 13:56:08 -0400
Content-Disposition: inline
In-Reply-To: <1431287385-1526-8-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, May 10, 2015 at 03:49:45PM -0400, Paul Gortmaker wrote:
> This file depends on Kconfig options all of which are a bool, so
> we use the appropriate registration function, which avoids us
> relying on an implicit inclusion of <module.h> which we are
> doing currently.
>=20
> While this currently works, we really don't want to be including
> the module.h header in non-modular code, which we'd be forced
> to do, pending some upcoming code relocation from init.h into
> module.h.  So we fix it now by using the non-modular equivalent.
>=20
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  drivers/power/reset/syscon-reboot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/reset/syscon-reboot.c b/drivers/power/reset/sy=
scon-reboot.c
> index d3c7d245ae63..7d0d269a0837 100644
> --- a/drivers/power/reset/syscon-reboot.c
> +++ b/drivers/power/reset/syscon-reboot.c
> @@ -88,4 +88,4 @@ static struct platform_driver syscon_reboot_driver =3D {
>  		.of_match_table =3D syscon_reboot_of_match,
>  	},
>  };
> -module_platform_driver(syscon_reboot_driver);
> +builtin_platform_driver(syscon_reboot_driver);

Acked-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVYL8eAAoJENju1/PIO/qalswQAKc4a6ba9oSfMVGRA3wUmw6l
mNmjoSTqxoQhivFhYPEibTxmzE4y/jCkmn7gOA0iccWP+igpXGarMjVHUj+GByoH
Me/n8b0JozHTqaCTOPe9zommGMuFalTjjWVn27gxCG5sw/8iUcQ6hs+RV8FFyvUe
JlgXRCwDpjEVJm6koxDygGHvsu+mxhEGwXSfdyp2UTJ5IrOGP+DV8SzBaUG2jc68
kaZeXVWFlkVgSn4zbdXQ1qBJMvWMaW8NsPcxmKsHOpTyz9G7rqxLXMjuNdkD1Hi2
FUDVS0mEkWv8TSZucWgBReD+vrGbImbvG2hkzA5saUlhIqR810DcfOmiALZTwzK8
Ap0efoawQISpdBJr9VkFgsVYVfu2wnk/aJKuBYRRjAeB5xPWsBdaNmqSf6nhWwZ3
B5Jp+PuMazeym4scNf519bndU7SXUsscwyBj7Bc6yqIa9Z2QZFgABHS6gH8IWBO3
uhf87eBeFtBecoMqo5iRYxyjAn5P5GEOgHcgT7oO6NWD8BWXJAtYgcxWJAOWGucy
lrqu7JwukORWG4RQ8+ydgDWDc7bryoCQyDkKo/1pb9+TOvO3xpQinthmohBkqRix
wZ4UF4Yaa55tw995mGkDQbGFZf8CNL6wN8wq1r8gja/Ehuo2NDweFxqfGf8hsm/u
XfkX1Zy/litnDt1OEbti
=EmXD
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--
