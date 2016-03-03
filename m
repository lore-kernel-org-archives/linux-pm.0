From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 03/14] power: ipaq-micro-battery: use __maybe_unused to
 hide pm functions
Date: Thu, 3 Mar 2016 15:23:23 +0100
Message-ID: <20160303142323.GF29689@earth>
References: <1456934350-1389172-1-git-send-email-arnd@arndb.de>
 <1456934350-1389172-4-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DEueqSqTbz/jWVG1"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1456934350-1389172-4-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--DEueqSqTbz/jWVG1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 02, 2016 at 04:58:55PM +0100, Arnd Bergmann wrote:
> The ipaq micro battery driver has suspend/resume functions that
> are accessed using SIMPLE_DEV_PM_OPS, which hide the reference
> when CONFIG_PM_SLEEP is not set, resulting in a warning about
> unused functions:
>=20
> drivers/power/ipaq_micro_battery.c:284:12: error: 'micro_batt_suspend' de=
fined but not used [-Werror=3Dunused-function]
> drivers/power/ipaq_micro_battery.c:292:12: error: 'micro_batt_resume' def=
ined but not used [-Werror=3Dunused-function]
>=20
> This adds __maybe_unused annotations to let the compiler know
> it can silently drop the function definition.

Thanks, queued.

-- Sebastian

--DEueqSqTbz/jWVG1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJW2EjbAAoJENju1/PIO/qaJx0QAJDv5fM9tAOM2LqYkGv6fDS8
eUwEz9wtcyTfGr2AsxRQmZTikK4TytindjGUQwqRW/HncwS6Af0ulNlf/pI3vBxB
N6/rGhb1nBgca5/y70wWTsoLwEPBpcRCDrQoaew9PvOx9sVvY4nXafBb+WYmUeFH
9U9DpVoeeHNXwEBSlKDdkFuo9EaaSFIDeMl6E3KB/WroJovdXHXMYwbosM6eIAb4
ftF6anBnzB7rwuTKUk168yo3kk1bBd35t7IyDAoUYjSeGDIJjDxdbhViAU5ikdbn
lrc6J6A10mkPA1f24WSURj4udIeANBmYxkWADSOQiqi9LnjoXhNh8592Z4/fAUVh
QOcO+XBXC32FqqCQTC0QUtuAER6dOkidm2kpRXPw0mPGdzVkCrB1kiDXwzE0ojRQ
t7Wus+ZZvSRuAc1iAssKsDoo6zFdur8xCawOqsFI+isLRdLQMaKm0mrO3Dl6Cc79
hRT26HAJhW54E7zaKk1oYNVLVh6tBpa86qyAK8940IXgwA6t29gcWdW9sbzN5LQF
RuTjuxPiG6ZhhrvcOJNLtWGoqbtM0lb/i06y0jAA86vt/Z1IvyrMauKBdTR90GLX
AqQ1gSajAB7PJGNX8spH7FVygQntZYKO1wZk6vylkN+6D70C9PAgEBZeskn2BEWU
bHZ+nj2/fglmSl1Rh5Et
=JBne
-----END PGP SIGNATURE-----

--DEueqSqTbz/jWVG1--
