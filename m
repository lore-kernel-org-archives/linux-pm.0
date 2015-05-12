From: Sebastian Reichel <sre@kernel.org>
Subject: [GIT PULL] power supply changes for 4.1-rc
Date: Tue, 12 May 2015 03:31:23 +0200
Message-ID: <20150512013123.GA24231@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56352 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751922AbbELBbh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 11 May 2015 21:31:37 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.infradead.org/battery-2.6.git tags/for-v4.1-rc

for you to fetch changes up to 8ebb7e9c1a502cfc300618c19c3c6f06fc76d237:

  power: bq27x00_battery: Add missing MODULE_ALIAS (2015-05-01 23:01:48 +02=
00)

----------------------------------------------------------------
power supply and reset fixes for the v4.1 series

 * misc. fixes

----------------------------------------------------------------
Dmitry Eremin-Solenikov (1):
      power_supply: fix oops in collie_battery driver

Florian Fainelli (1):
      power: reset: Add MFD_SYSCON depends for brcmstb

Marek Belisko (1):
      power: bq27x00_battery: Add missing MODULE_ALIAS

Pali Roh=E1r (1):
      MAINTAINERS: Add me as maintainer of Nokia N900 power supply drivers

Ramakrishna Pallala (1):
      axp288_fuel_gauge: Add original author details

Thomas Gleixner (1):
      power: reset: ltc2952: Remove bogus hrtimer_start() return value chec=
ks

Wei Yongjun (1):
      power/reset: at91: fix return value check in at91_reset_platform_prob=
e()

 MAINTAINERS                            | 11 +++++++++++
 drivers/power/axp288_fuel_gauge.c      |  1 +
 drivers/power/bq27x00_battery.c        |  8 ++++++++
 drivers/power/collie_battery.c         |  2 +-
 drivers/power/reset/Kconfig            |  1 +
 drivers/power/reset/at91-reset.c       |  4 ++--
 drivers/power/reset/ltc2952-poweroff.c | 18 +++---------------
 7 files changed, 27 insertions(+), 18 deletions(-)

-- Sebastian

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVUVfrAAoJENju1/PIO/qa1VMQAJkt64Ndok+BQ0wGUJM+jS5T
3tgGWHMXnSqMrqW6+8hO6ZNLXGt7xzwVRHk69Wh9h3P2PtZM4EvfJLQVJSbdAyKR
s2GMbC/EIR+f3aSOyumYv0D5kYMXkrmBvhoRQBJGYO4YYMIVHEdlhyeyqeVBACg9
OxFjhF5959Cm2m6wUOdGmyOqtZ3+OcnkUQALMkTaqaAULaeVCyVpdj7bLXb5oq+o
zvl59vXAfE45xHoMqYoH7Uyzni2eAZDEfM2zrqqZP+LsVcB76VThhrd1El8QKLEh
NTu/gzGezd5OJYb5AhjNhFbO8+/RPiv+PXR4XuC/75+jQ8YKh/NGjk1h9Laf8tjD
qoH/s30EmPuXoXFYrA6sXA2mYPm1OrBLne1DP8G/TTPwi7J6V8osRcHxmLVBcR5X
6iNeS2nYpopn7OsCNfF/lxdezradBXLAV6b/t9c/uxgHa1p0sEC1OXQRniHDXLhY
1nFZZGW4sIvbfs+M2kD3/0ERGmhiUeKj6BBTVdXHGU/RvqVKaDCFGuZRrFv+hNRm
KTjTzNME4wUi58bAu8+Kz8bnUIpkHHg90aErA7eFn8VY/euOx0yVStEB0DXPbz+u
zLiRccULZ6hNWU91E6fk6Qwv6TUfBGV5cdFDNaVmqLOzpAAAGyO3XA9RDJdQFwUM
AuGOKMrkNqOk0RBehjDq
=XFFM
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
