From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power_supply: charger-manager: Fix dereferencing of
 ERR_PTR
Date: Tue, 24 Mar 2015 16:08:13 +0100
Message-ID: <20150324150813.GB22934@earth>
References: <1427183923-7317-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427183923-7317-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-pm@vger.kernel.org


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Tue, Mar 24, 2015 at 08:58:43AM +0100, Krzysztof Kozlowski wrote:
> If power_supply_register() fails do not dereference returned ERR_PTR.
> The pointer was dereferenced to print name of battery which registration
> failed. Instead use the name from the power supply description passed to
> the power_supply_register() function.
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks, pulled.

-- Sebastian

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVEX3dAAoJENju1/PIO/qa6ZgQAIZn2IMF458Dh0+npYCUat1v
ZcMGwyw7y4WX8PCqiW1V4tiSg2FalqD1AWv693ZA5GYMuDdMAE/LFRXirEghdsum
hKN4JqyvfEX0wpxDs8prh1kahCqLxNl3DcvzJUlD75zt+iaJaPaOMWjUH4uNLVRK
AgtImqFEqwIVVY34O1qgUdXlJs5njP3Vlo32vbg2yFm5fFRTmI/mfZKm86ngaGMY
PV0bk09A+x/XO+Uc4qEYgg48L2d1SHCeckl/VwoDQV28u6amLkJ3ldccyBg0+Hg2
IOiqjpoyTpILxdNKvfGlhJFB02fR9MRUDNbaxzk6j1xZgjIjUDurKWHmxoJEAi68
/XbIyk8z8Yy/9y33JazOfrREczsXji6oF90SvgEL+DzD5wlnz4/L8/0R775uif9a
Ag6zwzxPqZiQyupxjPnbzycFvmWvHSKouSTgZdxkbWJWFZ6QxLFUVLDcbh6yOdMc
en1RSscQvqy6DQVMU3tcECctxXW2gmWgMPcFoaI18uliwHKEYLxBALrU2X8l3Gf9
9LRiszVM3L69ULGnrVqHBgmCsVaLgGUvuJUbmDlB6MLwk9TgIbfOyO4qbpCkKsud
2yNMjd6OZ03LYyu2dIFy5znE6MnDN+KqEiDfpq6fk96faD2KRWc/0ly332NAnDuk
1fwz3sk9bUq2orwkkB/u
=1/1P
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
