From: Sebastian Reichel <sre@kernel.org>
Subject: [GIT PULL] power supply changes for 4.6
Date: Wed, 16 Mar 2016 17:41:13 +0100
Message-ID: <20160316164112.GA13875@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46729 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932223AbcCPQlS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 16 Mar 2016 12:41:18 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please note, that I already sent the MAINTAINER update via a fixes
pull request for 4.5. Since Stephen didn't report any merge problems
I avoided rebasing my next branch (to drop the commit).

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git =
tags/for-v4.6

for you to fetch changes up to 0df6e32b0e36710fe989095241833e09dac3e41d:

  power: pm2301-charger: use __maybe_unused to hide pm functions (2016-03-0=
3 15:12:08 +0100)

----------------------------------------------------------------
power supply and reset changes for the v4.6 series

 * add types for USB Type C and PD chargers
 * add act8945a charger driver
 * add ACPI/DT bindings for goldfish-battery
 * add support for versatile reset controller
 * misc. fixes

----------------------------------------------------------------
Arnd Bergmann (3):
      power: collie_battery: hide unused variable
      power: ipaq-micro-battery: use __maybe_unused to hide pm functions
      power: pm2301-charger: use __maybe_unused to hide pm functions

Benson Leung (1):
      power_supply: Add types for USB Type C and PD chargers

Colin Ian King (2):
      power_supply: lp8788-charger: initialize boolean 'found'
      power_supply: 88pm860x_charger: do not pass NULL to power_supply_put

Greg Hackmann (1):
      power: goldfish_battery: add devicetree bindings

Jonathan Tinkham (3):
      power: bq24735-charger: fix failed i2c with ac-detect
      power: bq24735-charger: document 'ti,external-control' option
      power: bq24735-charger: add 'ti,external-control' option

Linus Walleij (1):
      power/reset: versatile: support the actual versatile

Maarten ter Huurne (1):
      jz4740-battery: Correct voltage change check

Pali Roh=E1r (6):
      power_supply: isp1704_charger: Error messages when probe fail
      power_supply: isp1704_charger: Add compatible of match for nxp,isp1707
      power_supply: bq2415x_charger: Do not add acpi modalias when CONFIG_A=
CPI is not enabled
      power_supply: bq2415x_charger: Add of modalias and match table when C=
ONFIG_OF is enabled
      power_supply: bq27xxx_battery: Add of modalias and match table when C=
ONFIG_OF is enabled
      ARM: dts: n900: Rename isp1704 to isp1707 to match correct name

Peter Rosin (1):
      bq24735_charger: add status property to view/enable/disable charging

Richard Weinberger (1):
      power: reset: Fix dependencies for !HAS_IOMEM archs

Sebastian Reichel (1):
      MAINTAINERS: update bq27xxx driver

Wenyou Yang (2):
      power: add documentation for ACT8945A's charger DT bindings
      power: act8945a: add charger driver for ACT8945A

Yu Ning (1):
      goldfish: Enable ACPI-based enumeration for goldfish battery

 .../devicetree/bindings/goldfish/battery.txt       |  17 +
 .../devicetree/bindings/power/act8945a-charger.txt |  35 ++
 .../bindings/power_supply/ti,bq24735.txt           |   3 +
 MAINTAINERS                                        |  10 +-
 arch/arm/boot/dts/omap3-n900.dts                   |   6 +-
 drivers/power/88pm860x_charger.c                   |   2 +-
 drivers/power/Kconfig                              |   7 +
 drivers/power/Makefile                             |   1 +
 drivers/power/act8945a_charger.c                   | 359 +++++++++++++++++=
++++
 drivers/power/bq2415x_charger.c                    |  22 ++
 drivers/power/bq24735-charger.c                    | 146 +++++++--
 drivers/power/bq27xxx_battery.c                    |  12 +
 drivers/power/bq27xxx_battery_i2c.c                |  24 ++
 drivers/power/collie_battery.c                     |   3 +-
 drivers/power/goldfish_battery.c                   |  17 +-
 drivers/power/ipaq_micro_battery.c                 |   4 +-
 drivers/power/isp1704_charger.c                    |  19 +-
 drivers/power/jz4740-battery.c                     |   2 +-
 drivers/power/lp8788-charger.c                     |   2 +-
 drivers/power/pm2301_charger.c                     |  22 +-
 drivers/power/power_supply_sysfs.c                 |   3 +-
 drivers/power/reset/Kconfig                        |   2 +
 drivers/power/reset/arm-versatile-reboot.c         |  39 ++-
 include/linux/power/bq24735-charger.h              |   2 +
 include/linux/power_supply.h                       |   3 +
 25 files changed, 695 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/goldfish/battery.txt
 create mode 100644 Documentation/devicetree/bindings/power/act8945a-charge=
r.txt
 create mode 100644 drivers/power/act8945a_charger.c

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJW6YylAAoJENju1/PIO/qajhYP/AzPZoCXIAWDrfgmAPqRT/aX
P+75oV6u+yy3U8iytDx2Qz5ZW8vIPG0+3AiTJIHSZ57QYzlQ2mYjt5UKWLrkxYvS
wXdgRqv/17K53bWK+JL3RGcHA49YSQhfj92fkbVbJc9688xSl2fO3+MNH89MhSSR
YLlSkk2ZxinmHvOTvGSfdKbGHVY7wWGhWcap8k/F7c0QOVIk47jRXeJJcEKvddqk
mvdMgiNX9JU1FqyBUvtwDcpq5kDrRchjQuaZqM0FFawYNjbor2fgqx/GBiq0vVBG
2ShOp6NpiPFbUl/lca+yJsTEl7GgCA9aP2UfYpi8Drh0vwjoyO9dITl1XXZ/UR7q
r3ZbTyajAeuPpyx6csUdVn5Far0BZH4Tt5qUVACZqwYYVBShMG2YPyytXP8sznkW
eneJMwXOSMoZjxRhA9kB7T8joRLTzvlt4UdmggGLV1UAfmFtphMNAcDggfUnH5eM
p09dVsSjhwahHyuY+gdcsC/VZTmlbuDe1boCbxPapLA7pK7q+rSr8MlpMMTIb797
+mt9GFwAKDaaNIGCseKWr+tM+W2orGeCaVfURyoL6idlWcXl6QKOVFgtVsFeDolU
fSR52X/q3o7tcLIcOpaTVzlw+m8J6dX4er6LaIowPiWCS0YEA86cbhhXFaahcoXE
GkzR2hFL/q7CFpxddlyI
=Gksp
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
