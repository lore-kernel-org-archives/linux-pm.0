From: Sebastian Reichel <sre@kernel.org>
Subject: [GIT PULL] power supply changes for 4.7
Date: Fri, 20 May 2016 20:41:39 +0200
Message-ID: <20160520184139.GA16485@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53176 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750973AbcETSlp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 20 May 2016 14:41:45 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Just a few changes for the power supply tree this time, since I was
quite busy the last few weeks.

The following changes since commit 9735a22799b9214d17d3c231fe377fc852f042e9:

  Linux 4.6-rc2 (2016-04-03 09:09:40 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v4.7

for you to fetch changes up to 4a99fa06a8ca27a5187636e630568658000af575:

  sbs-battery: fix power status when battery charging near dry (2016-04-10 17:22:35 +0200)

----------------------------------------------------------------
power supply and reset changes for the v4.7 series

 * alternative reset driver for new at91 SoCs
 * misc. fixes

----------------------------------------------------------------
Dan Carpenter (2):
      power/max8925: freeing wrong variable
      power: ipaq-micro-battery: freeing the wrong variable

Nicolas Ferre (2):
      ARM: dts: at91: shdwc binding: add new shutdown controller documentation
      power: reset: at91-shdwc: add new shutdown controller driver

YH Huang (1):
      sbs-battery: fix power status when battery charging near dry

 .../devicetree/bindings/arm/atmel-at91.txt         |  59 +++++
 MAINTAINERS                                        |   5 +
 drivers/power/ipaq_micro_battery.c                 |   2 +-
 drivers/power/max8925_power.c                      |  10 +-
 drivers/power/reset/Kconfig                        |   8 +
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/at91-sama5d2_shdwc.c           | 282 +++++++++++++++++++++
 drivers/power/sbs-battery.c                        |   4 -
 8 files changed, 361 insertions(+), 10 deletions(-)
 create mode 100644 drivers/power/reset/at91-sama5d2_shdwc.c

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXP1pgAAoJENju1/PIO/qa67YP/1AsJF3IMOybw05Et8VVPQEa
SlI6uDGxZM+leiyTmod5YWIteuB4rIapP/vyYCB0dmSFHFiAxipuNa+fUMxtOjqt
C4PeULisC+2c+d+oTJtFIPiCLaw8vEJzGwfoY3A20P0BAbBw14pIKUKvVfaMOQK/
aICVtbLWrGRbTqmh2TFbn7JFfcNCmystoU7oN997NPhTjcx3h/JVFBS6PBHjuW97
devJqDoq5fu9xAVZrxsxZFeM0+ktOl0bbIR723hxn9TTPg5D4nNTBviFlCXtFRow
d31ful4TGv2BpZj2zlOfjuVvzMoNhM9OcOOiOGRazxMWbcJT6lnOAvazGFlBSzqP
DehrlH2f0VQ3UD86UiLD4aux9eZmcvb2OCE4uel93zn0J/R7FON2u/Y8Qng0I8NX
AzEKnfpMnmvMELSHjrW1XJYruT9RFPrZlZ1Z7kE+RG4srES+wtOulzmOJIGSIcFE
mgv2Y9uR4i11yES9dBU6zPkSApsQmN6iMoZ0en67sETxftotn7z6mZbJWH6CyBSX
dHsrJS+7JHWUjKgUR1Qz5AekexW/WI7OE2lmf60GGtncSxEVgrrBo/RmbtoXVcfc
1EYJtdEqJzseS6etTICZrpYVsIMOvPPqRNy4B5NiZGI+hMkfEgQ5IklWiwfYW/yd
IU24ZChgODTyq9Jyv1MR
=C4ZA
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
