From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v2 5/6] power: bq27xxx_battery: Add support for additional bq27xxx family devices
Date: Tue, 28 Jul 2015 21:59:29 +0200
Message-ID: <201507282159.30013@pali>
References: <1438112353-19704-1-git-send-email-afd@ti.com> <1438112353-19704-6-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5087847.R1AYbf9tm4";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:36985 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942AbbG1T7d (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2015 15:59:33 -0400
In-Reply-To: <1438112353-19704-6-git-send-email-afd@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Murphy <dmurphy@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

--nextPart5087847.R1AYbf9tm4
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 28 July 2015 21:39:12 Andrew F. Davis wrote:
> Add support for additional devices and register equivalent family
> devices including the bq27010, bq27210, bq272500, bq27510, bq27520,
                                            ^^^^^^
                                            maybe incorrect number?
> bq27530, bq27531, bq27541, bq27542, bq27546, bq27545, bq27441,
> bq27421, and the bq27641.
>=20
> To facilitate this process the register mapings have been moved to
> tables and other small cleanups have been made.
>=20
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---

>  static const struct i2c_device_id bq27xxx_id[] =3D {
> -	{ "bq27200", BQ27000 },	/* bq27200 is same as bq27000, but with i2c
> */ +	{ "bq27200", BQ27000 },
> +	{ "bq27210", BQ27010 },
>  	{ "bq27500", BQ27500 },
> -	{ "bq27425", BQ27425 },
> -	{ "bq27742", BQ27742 },
> -	{ "bq27510", BQ27510 },
> +	{ "bq27510", BQ27500 },
> +	{ "bq27520", BQ27500 },
> +	{ "bq27530", BQ27530 },
> +	{ "bq27531", BQ27530 },
> +	{ "bq27541", BQ27541 },
> +	{ "bq27542", BQ27541 },
> +	{ "bq27546", BQ27541 },
> +	{ "bq27742", BQ27541 },
> +	{ "bq27545", BQ27545 },
> +	{ "bq27421", BQ27421 },
> +	{ "bq27425", BQ27421 },
> +	{ "bq27441", BQ27421 },
> +	{ "bq27621", BQ27421 },
>  	{},
>  };

I'm trying to understand comparator which you used for sorting these=20
values... but I do not see any logic here. What about sorting list by=20
first value? Now it is long list of device names and for better ability=20
to read it, it would be better to have it in some order.

> -enum bq27xxx_chip { BQ27000, BQ27500, BQ27425, BQ27742, BQ27510 };
> +enum bq27xxx_chip {
> +	BQ27000, /* bq27000, bq27200 */
> +	BQ27010, /* bq27010, bq27210 */
> +	BQ27500, /* bq27500, bq27510, bq27520 */
> +	BQ27530, /* bq27530, bq27531 */
> +	BQ27541, /* bq27541, bq27542, bq27546, bq27742 */
> +	BQ27545, /* bq27545 */
> +	BQ27421, /* bq27421, bq27425, bq27441, bq27621 */
> +};
>=20

Maybe same here? Putting BQ27421 before BQ27500?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart5087847.R1AYbf9tm4
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlW33yIACgkQi/DJPQPkQ1KrEQCfSKtNbvg/gMsJlG5ZDPdicvbl
lmQAn1Y13owJGYCgqTnL+Sn6Wa+B4Zbj
=sFEf
-----END PGP SIGNATURE-----

--nextPart5087847.R1AYbf9tm4--
