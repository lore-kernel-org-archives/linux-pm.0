From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: Replaced spaces with tabs in indent
Date: Wed, 15 Mar 2017 22:21:51 +0100
Message-ID: <20170315212151.y6uiiwcr62u5cd6g@earth>
References: <20170219231953.GA13155@munir-lfs>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h7hsgzjwpavjbtm3"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753558AbdCOVV4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Mar 2017 17:21:56 -0400
Content-Disposition: inline
In-Reply-To: <20170219231953.GA13155@munir-lfs>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Munir Contractor <munircontractor@gmail.com>
Cc: linux-pm@vger.kernel.org


--h7hsgzjwpavjbtm3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Feb 19, 2017 at 06:19:53PM -0500, Munir Contractor wrote:
> This patch fixes 4 checkpatch.pl errors on lines 433 to 436:
> ERROR: code indent should use tabs where possible
>=20
> Signed-off-by: Munir Contractor <munircontractor@gmail.com>
> ---
>  drivers/power/supply/ab8500_bmdata.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/=
ab8500_bmdata.c
> index d298645..8c495860 100644
> --- a/drivers/power/supply/ab8500_bmdata.c
> +++ b/drivers/power/supply/ab8500_bmdata.c
> @@ -430,10 +430,10 @@ static const struct abx500_maxim_parameters ab8500_=
maxi_params =3D {
>  };
> =20
>  static const struct abx500_maxim_parameters abx540_maxi_params =3D {
> -        .ena_maxi =3D true,
> -        .chg_curr =3D 3000,
> -        .wait_cycles =3D 10,
> -        .charger_curr_step =3D 200,
> +	.ena_maxi =3D true,
> +	.chg_curr =3D 3000,
> +	.wait_cycles =3D 10,
> +	.charger_curr_step =3D 200,
>  };
> =20
>  static const struct abx500_bm_charger_parameters chg =3D {
> --=20
> 2.4.4
>=20

Thanks, queued. I fixed up the subject while applying.
Also please always Cc mailinglists.

-- Sebastian

--h7hsgzjwpavjbtm3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljJsG4ACgkQ2O7X88g7
+pq3IQ//ceOA6GtcmnpFX+W1KIN1uARDZjG+/Pxn7P1+vPX93RQ45958ge2mxDri
Nd3d2lUSkZVHGk4XLCY9Zl4QzyVSnzTxyNt0P8Dz4F00X/4tFVwcp70wKYhzywsL
L/+LkIM/9w5brB93oMFhMlqRxV5GruO9XWLZxs3mce/QDdXJc9eAI7ns429D9gVA
i5cH83DoYnACgv15UZ5R8gHEdDPxAtPqqxiD4AxZVjshDkboSHw/zIwLWMSx4+tE
yLKdSJhr0iX1trvZwL83ru2sxpiuhCSEuCsmDT7/ZaVYaoH7+d4oz6US7U0jAv5K
UqmD1DIYDxBxcQVShLtsb7VC3KtlWuw5JNcV7yytrHMmZqw0deVzDhGUd4jRG0WJ
8m/bT8zeDNdcnIyq9If5K2ArgVkCiIB9xbldDsDBiCi02EP2vOTEFScFGJuw0YY2
mJ4oLT8e2y2L5MaOEZoz2mUcUyaE9ODhHlmFapfRagifPqtEToCck4YIdpUdtxYG
EbD9JMVrybQRO2qxIK7iXCE2P3a+HAKvoGoMsSE6t2jx9W5J+Fc1vW3fFSc4DFHw
7OEQQlFOe+KOQnLD2OVhqjURoRo8OsO1ghvrux8WmoSqNflMsQAzap5nRj0CSIwt
HHdQOocEh4eGf0k+ccEPigIopd10z94aCjGiMSGsKJRjGZd/xwo=
=mvux
-----END PGP SIGNATURE-----

--h7hsgzjwpavjbtm3--
