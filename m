From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH 0/2] power: generic-adc-battery: fix out of bounds write
Date: Fri, 6 Jul 2018 19:00:23 +0200
Message-ID: <20180706170023.mpz2vj2mj6vzsc2d@earth.universe>
References: <cover.1530019688.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tyul24fgxwrwyztr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1530019688.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: anish kumar <anish198519851985@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Jonathan Cameron <jic23@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com
List-Id: linux-pm@vger.kernel.org


--tyul24fgxwrwyztr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 26, 2018 at 03:28:28PM +0200, H. Nikolaus Schaller wrote:
> This patch set addresses two bugs in the gab_probe() function which are
> there since the first commit in 3.7-rc1:
>=20
> 1. there is an out of bounds write access by a miscalculated destination
>    address for the memcpy()
> 2. if iio channels are already represented by default properties, they
>    appear as duplicates in uevent

Thanks, both queued into power-supply-fixes.

-- Sebastian

--tyul24fgxwrwyztr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAls/oCMACgkQ2O7X88g7
+ppnGg//arX6a+lPENOZlMOs7L1LWLdO/nV8d67xC3sqSU/1+GGs1b0FvRc15NP7
aQ//Hh1b5ISiErnJ+c+G3cPDqldJZ5tl5pd0IYZVtLE4NqkyEqMgZdvovCjih5Uq
PpM33XmjcTGl1DUhxUvZIme73iI1X4QhGblh82skmjet2ReO1y88fW7QphdzJIpy
WZvjJ/G1a0v/Ktq3EgbOMyATEZB5TupiAF3mIk3gCEB9lXNshmC9nSuM0kfnbnl+
UWXDxfs9WFoJlijl07ZkU4RslB0pZVg4/6df5NFH08O4GnEgPeMK2CkjCqx1x2Ts
LTivvxuR+GZ0CrVr5S5niS96HHkE31CRc0T96xq7dvbHCSuggTnnJui80RWcs+fQ
9oHL1B+7RYPmImFGBp7iXh1mJfChvsohotZGTZUfG5I9Ew4j8IL1GY0SEJMmCPGu
TNjqx98/XaIeAxKshLm9ev659ku+x+vb/T6tbD16D/v8nuQ+g5urWM7vjKW1pDxk
9Mcy2gYQyrD0mkd5bNzzwTxW5/VccxDi402AVWyE19d0hWMyv2NHhmtLs2Br5l2n
5uFfOqMIoiSk6XdbFq0ykZ6/IIYjRfLf8xoCxw5q4AvG7a7Bf9+VJ2IV3OtokAqP
pzhQTN7e4V0NY7vPP/LAyEWHwxEWY6xMt8Rlys4+OtYgYOjYt4k=
=tUTR
-----END PGP SIGNATURE-----

--tyul24fgxwrwyztr--
