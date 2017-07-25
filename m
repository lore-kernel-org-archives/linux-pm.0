From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [RFC v1 1/6] power: supply: bq27xxx: Create single chip data
 table
Date: Tue, 25 Jul 2017 13:21:13 +0200
Message-ID: <20170725112113.jplophe6enkgabnb@earth>
References: <20170709021700.14354-1-liam@networkimprov.net>
 <20170709021700.14354-2-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rlq5cx4bbyshowmr"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:32824 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751103AbdGYLVW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jul 2017 07:21:22 -0400
Content-Disposition: inline
In-Reply-To: <20170709021700.14354-2-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-pm@vger.kernel.org, Paul Kocialkowski <contact@paulk.fr>, Liam Breck <kernel@networkimprov.net>


--rlq5cx4bbyshowmr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jul 08, 2017 at 07:16:55PM -0700, Liam Breck wrote:
> From: Liam Breck <kernel@networkimprov.net>
>=20
> To support new features which require different data for each chip, we
> unify the bq27xxx_regs and bq27xxx_battery_props tables into a single one.
>=20
> No functional changes to the driver.

Looks good to me except for one thing.

> [...]
> +#define BQ27XXX_DATA(ref) {			\
> +	.regs  =3D bq27##ref##_regs,		\
> +	.props =3D bq27##ref##_props,		\
> +	.props_size =3D ARRAY_SIZE(bq27##ref##_props) }
>
> [...]
>
> +	[BQ27000]   =3D BQ27XXX_DATA(000),
> +	[BQ27010]   =3D BQ27XXX_DATA(010),
> +	[BQ2750X]   =3D BQ27XXX_DATA(50x),
> +	[BQ2751X]   =3D BQ27XXX_DATA(51x),
> +	[BQ27500]   =3D BQ27XXX_DATA(500),
> +	[BQ27510G1] =3D BQ27XXX_DATA(510g1),
> +	[BQ27510G2] =3D BQ27XXX_DATA(510g2),
> +	[BQ27510G3] =3D BQ27XXX_DATA(510g3),
> +	[BQ27520G1] =3D BQ27XXX_DATA(520g1),
> +	[BQ27520G2] =3D BQ27XXX_DATA(520g2),
> +	[BQ27520G3] =3D BQ27XXX_DATA(520g3),
> +	[BQ27520G4] =3D BQ27XXX_DATA(520g4),
> +	[BQ27530]   =3D BQ27XXX_DATA(530),
> +	[BQ27541]   =3D BQ27XXX_DATA(541),
> +	[BQ27545]   =3D BQ27XXX_DATA(545),
> +	[BQ27421]   =3D BQ27XXX_DATA(421),
>  };

I would prefer to use ##ref##_regs and ##ref##_props above
and add the bq27 prefix here.

-- Sebastian

--rlq5cx4bbyshowmr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAll3KakACgkQ2O7X88g7
+poc0xAAnQtdUCADsJVPuUtVkGhHuSmc3IuAgLGtG2DZQXOSXEDDscfjz56MBxf2
/+cYxg3zc59TakcUbf3p9cd1yN5lot/946FzPp3NYEGpbH0yKL8gT/BNxM3AUCpp
LctqVLn1R7uFZQLlmedC4CK8oJppPAgTJoKtdYfatVrJm77SNM4tdaStp2oKt/Tu
mXpvdzIOHnSF+r1FnCnsOdyBVfClot+XvlQcRoJGb8UcfKia3sCjL8K4aqYrxuNm
KE96GV1ey2f7CY9iqXkaHJw4jG6t10LRqV44N9KtJ+2E/OdjhD0UYeqyXnS3UmNj
3oc4AX/WvRC0Voaae3Eu6ev1Ey7OsrW+10byPdv/Td3MTvhrVXu+R/hA/7Y3S/48
w8qQXTGyaJcIv8kyp+6GmcgOSjCFcewNBYnisCaalSY4VLInXrW3+21vjXmqb+ym
ig+y61o9vnDXWY9kjeCTpTjRdpMX8T88nVoZSijAC4imzpVFyAxnBoD1vnNChLAM
IZRxzfHTp14PV0Yi5q8cpM9hQnZaY9EwV7WaSWdzWruUGVN6iKtcNb+mL8qos9pK
pKfn38Tqk9xneK2+/YFOyCyomQLzppbwDlpPlD11XmHCQIVarBj/PuzINbbNWlZ3
E9WUAMfbmHiYHCieawu1pGhkqUOdI58BNm8XmH2FG8nD6prltRU=
=gr/o
-----END PGP SIGNATURE-----

--rlq5cx4bbyshowmr--
