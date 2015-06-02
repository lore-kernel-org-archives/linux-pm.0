From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power_supply: bq25890: make chip_id int
Date: Tue, 2 Jun 2015 21:28:17 +0200
Message-ID: <20150602192817.GB13930@earth>
References: <1433241411-27423-1-git-send-email-laurentiu.palcu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54047 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750704AbbFBT2q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Jun 2015 15:28:46 -0400
Content-Disposition: inline
In-Reply-To: <1433241411-27423-1-git-send-email-laurentiu.palcu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurentiu Palcu <laurentiu.palcu@intel.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Dan Carpenter <dan.carpenter@oracle.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Laurentiu,

On Tue, Jun 02, 2015 at 01:36:51PM +0300, Laurentiu Palcu wrote:
> Smatch static checker correctly detected an impossible condition because
> chip_id was declared as u8, instead of int:
>=20
> drivers/power/bq25890_charger.c:843 bq25890_probe()
> warn: impossible condition '(bq->chip_id < 0) =3D> (0-255 < 0)'
>=20
> Also, while at it, fix the return value too.

Thanks, queued for 4.2.

-- Sebastian

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVbgPRAAoJENju1/PIO/qav5MQAKdCbaJzJyz5cew2N3yHcYV9
zyHMla+JTEGyCWcQjpj2nJ5Xm50B73p4AC6oyVq79VDDlxpFxxBK/jC5Y/khENCf
PkAZFjZYYHD89EDl6N6iEK7gtanCkduKOTTxl7oKcxG4IywCcj1Hrs9IACqWrw1w
ykQSSb0dDsoEHU+sot34EfOEi6UaHr1NR/yE39ozDbGhd8vkWjKpUcDpFdH/LqDf
6KcAHTIEmWzbcMxHqNZuuzV0xJusohsg65+yvAzXgbe/jE9SCzds6U/VS83/cP9N
tl0GxVdxrjtXLQS06f9MN4vnILJe4iCmBzOSC2FNsRD92C90NXZ+jbjA5uH/K3IZ
rmCZ6TL+gJTiwkXXy1lKTYFH7OqApCczSSGT746V6HI2ogifPOkZ33V9szLdD1sk
PK3dbnMWgi1IdXfe59Z4DErdn6VkdqE97yUBh86QeQrkIzGzBs6rl/K6a4x41M2A
W2IbiBhqMyXRI0Krgog5bwR7RKr6Bg847LybQ4GEUh/5jFyzZX8zJlwA7ezSD+t0
Y8FUp9FMPmW4gY9Ej7jKvnLiEvuQe0bMku7N4HMcttoSh3Hl7Qjfy4/5nAJmVyHv
dEA7rHLb1nMe+ERtIbtvBqSQf3UJzFcnZiWKbYcZ/WCZV+ERiR2nqzDPzi5Ql5i8
yappjfiKBBTApyPD/sna
=UkfK
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--
