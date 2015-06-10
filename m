From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/2] power_supply: max17042: Add OF support for setting
 thresholds
Date: Wed, 10 Jun 2015 16:46:48 +0200
Message-ID: <20150610144648.GC11618@earth>
References: <1433725899-13849-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QRj9sO5tAVLaXnSD"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1433725899-13849-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--QRj9sO5tAVLaXnSD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 08, 2015 at 10:11:38AM +0900, Krzysztof Kozlowski wrote:
> The commit edd4ab055931 ("power: max17042_battery: add HEALTH and TEMP_*
> properties support") added support for setting voltage and temperature
> thresholds with platform data. For DeviceTree default of 0 was always
> used.
>=20
> This caused reporting battery health always as over voltage or
> over heated.
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Fixes: edd4ab055931 ("power: max17042_battery: add HEALTH and TEMP_* prop=
erties support")

Thanks, queued.

-- Sebastian

--QRj9sO5tAVLaXnSD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVeE3YAAoJENju1/PIO/qaZTEP/RIvjxtyyEeKMRqNFOpRINN2
iBIDYkjkwZ78PSnMy4GX27N4LLavS/O472tRkM5m/+qW74Qv0G4L2fiCfQVAUltb
IFzKcvQpPNH+enfhKUe4M2W8+xLnli2FvVVgyfMHt2ShICJgZfalB7a5S8LYUCRi
1aWsd6Ufnk7nupkhyacraOC4FcO30WbHgOs7KMShc9nisz4BdaBAz/faGxe8iTQT
awZa6vcg1mL8lqwP8C7Ej0hpm65BQ3kn6/JmDU1chQnVzU5ygERsp23nfkzX23eE
IeVG9YJCjRKqIAMo+Gz0f0I2GvGRUyWjGC6vN8ivJhOAmZeSKry9CiX5YIXmqpGj
bfW8toQlrroKu5y19mCoftBjeaOa96i+DZss0UFUKQamcXvzbxpCVDmmiW3CSJiX
TBgv7eoEyPy1ldbSbYM4sv1QyXisCd2S2L4AyQ0hEhGkypmKpKEn+XgoSdpl7enZ
d1jARwduBdSy5x8KsmNWDCLrSqnX0s+CeVnGXj5K9ditZF6in6FqLSOB8/4+ktgw
04SOWJWyFyzYOD/2nWv9z5ZtX5DT+1ESfm48Nnm/t1PJ3tu2SfnVa+0EWhptbude
uDgLAATUDhy9wU77PaRNn8pn9aZ3QxrkSLTrhhr76tOLVEBk+L6/N6mE/l1ne+Z2
RPlWW8YVWrI7z5bJsguP
=pwbv
-----END PGP SIGNATURE-----

--QRj9sO5tAVLaXnSD--
