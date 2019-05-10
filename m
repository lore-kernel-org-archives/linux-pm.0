From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: ucs1002: Fix build error without
 CONFIG_REGULATOR
Date: Fri, 10 May 2019 18:22:39 +0200
Message-ID: <20190510162239.qbnmtw7fxszwbwiw@earth.universe>
References: <20190510071823.2984-1-yuehaibing@huawei.com>
 <9b37be09-c323-94c6-8bba-44e854597e95@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="abf7t6ubodig5fry"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9b37be09-c323-94c6-8bba-44e854597e95@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: YueHaibing <yuehaibing@huawei.com>, andrew.smirnov@gmail.com, enric.balletbo@collabora.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--abf7t6ubodig5fry
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 10, 2019 at 06:05:06AM -0700, Guenter Roeck wrote:
> On 5/10/19 12:18 AM, YueHaibing wrote:
> > Fix gcc build error while CONFIG_REGULATOR is not set
> >=20
> > drivers/power/supply/ucs1002_power.o: In function `ucs1002_probe':
> > drivers/power/supply/ucs1002_power.c:593: undefined reference to `devm_=
regulator_register'
> > drivers/power/supply/ucs1002_power.o:(.rodata+0x3b8): undefined referen=
ce to `regulator_enable_regmap'
> > drivers/power/supply/ucs1002_power.o:(.rodata+0x3c0): undefined referen=
ce to `regulator_disable_regmap'
> > drivers/power/supply/ucs1002_power.o:(.rodata+0x3c8): undefined referen=
ce to `regulator_is_enabled_regmap'
> >=20
> > Add Kconfig dependency to CONFIG_REGULATOR.
> >=20
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Fixes: 9a2688e42638 ("power: supply: Add driver for Microchip UCS1002")
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>=20
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Thanks, queued.

-- Sebastian

--abf7t6ubodig5fry
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlzVpUwACgkQ2O7X88g7
+poDGRAAnJb/Jvso2KCVfj7f63PFAscr2hzeDdrgKWpbl+flff18pOOhwCMHNi7I
rpv6dZMohdH2/Vaae06lyp/LAgXudeZwsObVLwvgX6qQPtC9kaDq80dLQmEdQINv
SPMxH+spTNq5sIaVftSvex+vByNe6gzKf4fMOfa8JGuBgoMTJM0pAjbvqOVr3RET
v57J5yumNT1+zIKEaA3MQD2NJDRsE7bgJoLP+3SJkXSC/jnvDLC8F6OqmSF8cfv7
zbjiivy/HndJr/tzAgD0zIkoFvNG4Gey7C1OoZPdc4Qzijh9caUjfr3vjbF4Af0b
2Cl69ar/e1l/Dh1hIG4tl7K2oOOK6EKMDlq3IUxYKIVSxY06hX5vaCm0EJBg1Wc2
MAcHDQ3Rnyxdx8y9qcv/qdVmh9Rfrj8x6SmEgwgDQLKxu9LS1r7UI23SVKRzF2O/
7cgJ6jSpa41Dz1Gn2VKmysSHFMpdYNBAkKcsVjPlQX5gFDpnxNv5xphKXLzGG1cC
AojhO6WPAgUU1vb7Yc70EIaMJkzEzryQQ4ul37T+l/4oSiuxnwd/cQy8eDTWQYfh
0f/3LGYEKXQxwdnj+1EonBxOIojGcfjTTnmj8PqW6ZDnFTkbxpifig/RXcf+AQSb
64+vkH5yDbuPL7m776g/QVIeJ6aKQCfdC3li+1J+W75xqhuxzVQ=
=1NGs
-----END PGP SIGNATURE-----

--abf7t6ubodig5fry--
