From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 09/10] power: supplies: bq275xx: adds specific support for bq27520-g4 revision.
Date: Thu, 22 Dec 2016 09:57:41 +0100
Message-ID: <201612220957.42162@pali>
References: <1482369743-79764-1-git-send-email-chris@lapa.com.au> <1482369743-79764-10-git-send-email-chris@lapa.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2862707.7t0sM6UTiJ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wj0-f194.google.com ([209.85.210.194]:35180 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752694AbcLVI5q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Dec 2016 03:57:46 -0500
In-Reply-To: <1482369743-79764-10-git-send-email-chris@lapa.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chris Lapa <chris@lapa.com.au>
Cc: afd@ti.com, sre@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

--nextPart2862707.7t0sM6UTiJ
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 22 December 2016 02:22:22 Chris Lapa wrote:
> @@ -925,7 +963,7 @@ static bool bq27xxx_battery_overtemp(struct
> if (di->chip =3D=3D BQ275XX || di->chip =3D=3D BQ27500 || di->chip =3D=3D=
 BQ27510G1
>=20
>  			|| di->chip =3D=3D BQ27510G2 || di->chip =3D=3D BQ27510G3 || di->chip=
 =3D=3D
>  			|| BQ27541 di->chip =3D=3D BQ27520G1 || di->chip =3D=3D BQ27520G2 ||
>  			|| di->chip =3D=3D BQ27520G3
>=20
> -			|| di->chip =3D=3D BQ27545)
> +			|| di->chip =3D=3D BQ27520G4 || di->chip =3D=3D BQ27545)

Please move this check for BQ275XX into static inline function.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2862707.7t0sM6UTiJ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlhblYYACgkQi/DJPQPkQ1JJiACgzhEzY5mjZxg83cowOgsAf16I
0MwAmgORaegQz6iLCvzBBgo9ovIrwFNh
=bGFo
-----END PGP SIGNATURE-----

--nextPart2862707.7t0sM6UTiJ--
