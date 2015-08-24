From: Sebastian Reichel <sre@kernel.org>
Subject: [GIT PULL] power supply changes for 4.3
Date: Mon, 24 Aug 2015 15:54:38 +0200
Message-ID: <20150824135437.GA29044@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39246 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754595AbbHXNyn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 24 Aug 2015 09:54:43 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

This time the pull-request comes a bit early, since I'm on vacation from
tomorrow until 2015-09-10 without any internet connection. In addition
to the git.infradead.org based repository used so far, I also pushed the
tag to git.kernel.org.

-- Sebastian

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repositories at:

  git://git.infradead.org/battery-2.6.git tags/for-v4.3
  git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git =
tags/for-v4.3

for you to fetch changes up to b68c3161430a4c7c0a001e658188bfea6a2fe5bd:

  bq2415x_charger: Allow to load and use driver even if notify device is no=
t registered yet (2015-08-21 16:46:38 +0200)

----------------------------------------------------------------
power supply and reset changes for the v4.3 series

 * new reset driver for ZTE SoCs
 * add support for sama5d3 reset handling
 * overhaul of twl4030 charger driver
 * misc. fixes and cleanups

----------------------------------------------------------------
Anda-Maria Nicolae (1):
      power_supply: rt9455_charger: Properly notify userspace about chargin=
g events

Andreas Dannenberg (1):
      power: bq24190_charger: Fix charge type sysfs property

Andrew F. Davis (4):
      power: bq27x00_battery: Add manufacturer property
      power: bq27x00_battery: Fix lines over 80 characters long
      power: bq27x00_battery: Fix function parameter alignment
      power: bq27x00_battery: Checkpatch fixes

Geert Uytterhoeven (1):
      power: Allow compile test of GPIO consumers if !GPIOLIB

Javier Martinez Canillas (1):
      power: Export I2C module alias information in missing drivers

Josh Wu (1):
      power: reset: at91: add sama5d3 reset function

Jun Nie (2):
      power/reset: zx: Register restart handler
      power/reset: zx: Remove unnecessary include file

Krzysztof Kozlowski (1):
      power_supply: Drop owner assignment from i2c_driver

Mike Looijmans (1):
      power/ltc2941-battery-gauge.c: Use the devicetree node name as supply=
 name

NeilBrown (14):
      twl4030_charger: use devm_request_threaded_irq
      twl4030_charger: use devres for power_supply_register and kzalloc.
      twl4030_charger: use runtime_pm to keep usb phy active while charging.
      twl4030_charger: correctly handle -EPROBE_DEFER from devm_usb_get_phy=
_by_node
      twl4030_charger: trust phy to determine when USB power is available.
      twl4030_charger: split uA calculation into a function.
      twl4030_charger: allow fine control of charger current.
      twl4030_charger: distinguish between USB current and 'AC' current
      twl4030_charger: allow max_current to be managed via sysfs.
      twl4030_charger: enable manual enable/disable of usb charging.
      twl4030_charger: add software controlled linear charging mode.
      twl4030_charger: add ac/mode to match usb/mode
      twl4030_charger: Increase current carefully while watching voltage.
      twl4030_charger: fix compile error when TWL4030_MADC not available.

Pali Roh=E1r (2):
      rx51-battery: Set name to rx51-battery
      bq2415x_charger: Allow to load and use driver even if notify device i=
s not registered yet

Pavel Machek (1):
      twl4030_charger: convert to module_platform_driver instead of ..._pro=
be.

Sebastian Reichel (1):
      MAINTAINERS: AVS is not maintained via power supply tree

Vaishali Thakkar (1):
      power_supply: bq24735: Convert to using managed resources

Vladimir Zapolskiy (3):
      power: ds2780_battery: clean up eeprom read/write functions
      power: ds2781_battery: clean up eeprom read/write functions
      power: olpc_battery: clean up eeprom read function

 .../ABI/testing/sysfs-class-power-twl4030          |  45 ++
 .../devicetree/bindings/arm/atmel-at91.txt         |   2 +-
 MAINTAINERS                                        |   1 +
 drivers/mfd/twl-core.c                             |   9 +-
 drivers/power/Kconfig                              |  17 +-
 drivers/power/bq2415x_charger.c                    | 143 ++---
 drivers/power/bq24190_charger.c                    |   4 +-
 drivers/power/bq24735-charger.c                    |  52 +-
 drivers/power/bq27x00_battery.c                    | 123 +++--
 drivers/power/ds2780_battery.c                     |  20 +-
 drivers/power/ds2781_battery.c                     |   8 -
 drivers/power/ltc2941-battery-gauge.c              |  54 +-
 drivers/power/olpc_battery.c                       |   7 +-
 drivers/power/pm2301_charger.c                     |   1 -
 drivers/power/reset/Kconfig                        |   7 +
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/at91-reset.c                   |  26 +-
 drivers/power/reset/zx-reboot.c                    |  80 +++
 drivers/power/rt5033_battery.c                     |   2 +-
 drivers/power/rt9455_charger.c                     |  16 +-
 drivers/power/rx51_battery.c                       |   2 +-
 drivers/power/twl4030_charger.c                    | 598 +++++++++++++++++=
----
 22 files changed, 862 insertions(+), 356 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-twl4030
 create mode 100644 drivers/power/reset/zx-reboot.c

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJV2yIbAAoJENju1/PIO/qaT38P/iYTIqbBKpDbpFet5uIDYtK9
HWTdnk3smok/I9Ij+wHWNSN+ZVhhRFdRklu5U6alisf7bM0CsrDMRzG4LzSDWvu9
6/RdZUUu9/xLI/9zTXFn7eELbFqyOqLiTPjV1MNGAraik2wjRVDdYiS9ergEmN0y
ULuHPJe4FfAHNuZnBpeVGPVveFq/VSyoO7q0GcBNAE8RoiASTSuiaVswaxsOijy+
LFbo9sf/LNASr0+pQMUABXlYZ2Jq3OhxlVQTzTSsev5VE6lwfZjRwiZQJSMHgX1S
NOJy+sTpVt7Y1SNwQOYvnjiNz0njAr5DICT8ar3m2OvP4PL7QN2hXJud3FsyptCy
+wuBCVPWTE1qXtJFMNTR6zo2o6gXb//DoGp73kU1MN8HoPBa+qfb/qSZSdlKJTTZ
7tZENFekXBxRFnX3yRKY2h9q7zmgfx/anCea1+OEcg0XOF6lI40mATXQo5lDzHpQ
+nx6+wzVoWd3oEyCYP++q//8P0wABThDRnPtX5t360Uu8aspvEtLHCpdg1fXKCWh
ytWqzfnZ4st4ms1KpOn8fjvTMIbemQBMahKGmlmmKJYgJhRaLXaVp7vrG8UkWbfS
vcjhj7N/F4F90vmqWeXteTEIgfgaxapCkjBsXCEUTKnXGNzxfxZBcckubF4emyxl
EH1rsuUNy8WxmKS28eUG
=f/2j
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
