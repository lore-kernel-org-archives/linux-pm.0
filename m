From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH] power: supply: axp20x_usb_power: add IIO dependency
Date: Mon, 1 May 2017 13:34:25 +0200
Message-ID: <20170501113425.gykyrjzjmr5jazqm@earth>
References: <20170427191216.2089294-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="23efo6xtqjr2y7z6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170427191216.2089294-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--23efo6xtqjr2y7z6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 27, 2017 at 09:11:48PM +0200, Arnd Bergmann wrote:
> When CONFIG_IIO=3Dm and the axp20x_usb_power driver is built-in, we get
> a link time error:
>=20
> drivers/power/built-in.o: In function `axp20x_usb_power_get_property':
> undefined reference to `iio_read_channel_processed'
> drivers/power/built-in.o: In function `axp20x_usb_power_probe':
> undefined reference to `devm_iio_channel_get'
> undefined reference to `devm_iio_channel_get'
>=20
> This adds the same dependency that we already have for the AC power driver
> to the USB power driver. For consistency, I'm also moving the two closer
> together in the Kconfig file.
>=20
> Fixes: 33863c938caa ("power: supply: axp20x_usb_power: use IIO channels w=
hen available")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, queued.

-- Sebastian

--23efo6xtqjr2y7z6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkHHUEACgkQ2O7X88g7
+pp3Zw//atzoJJQ+JWZGiBETgFAvR8FFJt00+jB4cgXpAf1l4x+tMJT9l7UV8/6l
GMV8FNCUQ6+PN/C3yO5M0qStDGrelJA9tlYJ9rkNFZO73v0j8vBCJ1dLqBQl8wdh
/CJmDsPF0Kbvfl4UxfaK0ufPiqPqpcLU6nEF1aq1nLNHTzPaYM2ZzG5I709mXPo6
3+pEMJAUfLeurpAOBKps5ZZW1GlGRGeHsXHAwCGFPjz+xmiVhhENCAmM2Q3I72FT
lrRWq0/VgFAEuRTityfV4fwNdJxwU/pd6UDq7nm0coXURraX5fSRcuQsDR6N2hJb
y4TynXJaJHNM2cUT4etG/PPCUlanAhGDXxGSq8I38X9QrdigeJuNtKmYUd1MdbkR
eTmrKOEXZQqUZJryhsC88HzBkH6h9ZgjrtwGP5ryW3sC2g3C8A7o5FVF+HK/oR+X
gDRPKAqJFmoy/PSeBlz7pDTVW0nytDHowBvGL1TsT392wZaOP07eOtAmfZoBW2T9
O1NxVIJ9X2hxRZMprjmEuFRYIWwKADakMCXMI8/yT0OTnr/UJHdk5H6/0q84QG67
vqFALwWJk5Irm4wTLhUkftGX6KvglpPWnThW3fzNE2FC3KWLWXVSK6OlPXR0VWP6
Gn1W9cVSeXoHDQ0DZ+/P+LlBzVs8kKMBAMlAek7nDswAKqUZ57c=
=GpPh
-----END PGP SIGNATURE-----

--23efo6xtqjr2y7z6--
