From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] power: supply: isp1704: switch to gpiod API
Date: Sat, 15 Dec 2018 20:42:02 +0100
Message-ID: <20181215194201.GB31052@amd>
References: <20181213013858.23996-1-sebastian.reichel@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181213013858.23996-1-sebastian.reichel@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Sebastian Reichel <sre@kernel.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-12-13 02:38:58, Sebastian Reichel wrote:
> This migrates isp1704 driver from old GPIO API to new descriptor
> based GPIO API and drops useless platform data as a side-effect.
>=20
> Migration is simple, since all mainline users are DT based and
> DT API does not change. Out of tree users of the platform data
> need to migrate to gpiod_lookup_table as described here:
>=20
> Documentation/driver-api/gpio/board.rst
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwVWQkACgkQMOfwapXb+vI2XwCfQ1Tx9Bx7hb1V9trNx0wWdtep
l5AAniXQcMV7UwsqACdEXEdcZtGKj9EJ
=YdWX
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
