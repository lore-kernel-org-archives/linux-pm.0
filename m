From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: axp20x_usb_power: fix 64-bit build warning
Date: Thu, 12 Jan 2017 03:58:24 +0100
Message-ID: <20170112025824.ifplt45l3syibjda@earth>
References: <20170111145211.746189-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="let2c7qxekkw3fap"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750936AbdALC63 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Jan 2017 21:58:29 -0500
Content-Disposition: inline
In-Reply-To: <20170111145211.746189-1-arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Chen-Yu Tsai <wens@csie.org>, Quentin Schulz <quentin.schulz@free-electrons.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--let2c7qxekkw3fap
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Wed, Jan 11, 2017 at 03:51:55PM +0100, Arnd Bergmann wrote:
> Casting a pointer to 'int' is not always valid:
>=20
> drivers/power/supply/axp20x_usb_power.c: In function 'axp20x_usb_power_pr=
obe':
> drivers/power/supply/axp20x_usb_power.c:297:21: error: cast from pointer =
to integer of different size [-Werror=3Dpointer-to-int-cast]
>=20
> This makes the code use uintptr_t explicitly.
>=20
> Fixes: 0dcc70ca8644 ("power: supply: axp20x_usb_power: use of_device_id d=
ata field instead of device_is_compatible")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I queued Michal's patch instead:

https://git.kernel.org/cgit/linux/kernel/git/sre/linux-power-supply.git/com=
mit/?h=3Dfor-next&id=3D15df6d98ec3b40775918fc6ef73d7f1c2d0cf870

-- Sebastian

--let2c7qxekkw3fap
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlh28NAACgkQ2O7X88g7
+pphVw//R2qCYH32eqINez+QbpUIn6dBTBwL9BQZzJXhwKr0Gm+FOOn5yuI/vlPg
MGeSx4a6vbeyYsClRxKj0bA9n4JpsgDrBpe/y9ZwxKlsjw8Kapo8cWE9tfxb+NeM
FTdaUrOXOjkRaK9KLQ6qB4jA+NSRHYRCntqluPmEMAdaZW3t1pLQpbqua3rzhx4H
vmQ3UBBqO6Ir1HJpV+k2eB1ECR7NcHSn3pBI+wrmHnVoKNPP0mGaSO0cOiHp+mFN
QueOTWSJJKf4yT6zh+qTEUi2XiP3pX7s980GznZQgfHtTVti43wM/jFuito7xH7W
O8yi0a8d9gt7/14YkTb3xuNlFcpJIaButu9AOrR3o8oeieyo/PnVugTK7HAUhXRG
jYPKvHNihv+k1itHXalYhpfmEHVp0XCQXNxWjXjzhWXkm0elAhhLHI5HedfSziTA
eu2bQOPmxTbbwlMHgvEL1HWu8PsAbQp077O8pscni6Loafp+Cell4uwlF9D6gOgq
s8+jltAzZ0i4dsAwpKINcPN3Nn0BUTLU0LUwCVt/DYnxGAOwK62ZgVU4UjMSQOv5
XPeu8t4BzZcXnDkNoAw42cV5gpcS+bs+VWi/wQSl6c4M1Cvx3KZxQIT741xBcXtm
mJwMi4S5zejlh02c+cRj2gQgpIsoKRQ+SIahFatTY/GHkXZc7Uk=
=kUi3
-----END PGP SIGNATURE-----

--let2c7qxekkw3fap--
