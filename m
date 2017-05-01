From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH 1/1] power: Fix unchecked return value of devm_kzalloc
Date: Mon, 1 May 2017 13:32:14 +0200
Message-ID: <20170501113214.htknlnfxbyf2dt25@earth>
References: <1493022128-3918-1-git-send-email-bianpan2016@163.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w3tl56rgsmooqr6d"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1493022128-3918-1-git-send-email-bianpan2016@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pan Bian <bianpan2016@163.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--w3tl56rgsmooqr6d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 24, 2017 at 04:22:08PM +0800, Pan Bian wrote:
> Function devm_kzalloc() will return a NULL pointer. However, in function
> isp1704_charger_probe(), the return value of devm_kzalloc() is directly
> used without validation. This may result in a bad memory access bug.
>=20
> Signed-off-by: Pan Bian <bianpan2016@163.com>

Thanks, queued.

-- Sebastian

--w3tl56rgsmooqr6d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkHHL4ACgkQ2O7X88g7
+ppCThAApQm9qRFrmFb4omBFTPFncMUtyEMdmmJgTHqufS5w7k0jPl5+sO/xGvNb
Gk7IKqdi3L9puCbOtj0KAOUtymXu/s3B7vYz2bj7x4SuSLguQJPm3rpfCmaQ0ved
PYWMcCbL6VWez2p9SZKG7rJd2Ch6hOuyEKVIv9MvBuuIMMohiNLsS9vBUj/waskz
xmpIT840/4QGrlOMq6pIIFwvOkt+Yrvh6LUvaZLLjNsWscjj1R5TP6qu5KmDDaih
oXR5c1fV2AAZiZrqG3zPFtz7LtprbXLluKK9Np5FWmAsLP0/POR89ZWkB/jysqSM
z9xZLqadCrj1onbGrGCacZ81JrKwmqE4p9ZgTghiJVM6dWdq/ieNacEGWXoFpUOo
edN2hYfS17PA6JQzReUuIbcMxovg7ECa+njDgteh0w7gkF/4k58XHUclcnU/5xsj
r8gQAjGQUI8iY4zj1mk7JYdKJkGynpijbDPXqQ6RBAzOBnZpy7SI4cPbOIow9DHt
gwViILnYNuMIhp/lHLB1sFb2c271lkPhddbankuJJwa8pQPYoEM4TRkQxVB7vfI0
mY+G7GNubsQ8HPCt46IU5HuQ+BixfewbU0hVS3rBpgnLfbCz/ZcJGTOWLEWQCJcZ
3ok8jCJeFbYsXqYFOTF3UJOhGvub9BIbiixwF4K38HlhVC+wceo=
=hWZT
-----END PGP SIGNATURE-----

--w3tl56rgsmooqr6d--
