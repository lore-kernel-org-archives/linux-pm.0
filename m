From: Sebastian Reichel <sre@kernel.org>
Subject: [GIT PULL] power supply changes for 3.20
Date: Mon, 9 Feb 2015 15:56:35 +0100
Message-ID: <20150209145635.GA12425@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 06efe0e54018cb19cf0807447dc3ac747ffcfd1c:

  Merge tag 'pinctrl-v3.19-3' of git://git.kernel.org/pub/scm/linux/kernel/=
git/linusw/linux-pinctrl (2015-01-20 21:23:41 +1200)

are available in the git repository at:

  git://git.infradead.org/battery-2.6.git tags/for-v3.20

for you to fetch changes up to 24727b45b484e8937dcde53fa8d1aa70ac30ec0c:

  power_supply: 88pm860x: Fix leaked power supply on probe fail (2015-01-28=
 15:08:10 +0100)

----------------------------------------------------------------
power supply and reset changes for the v3.20 series

 * new drivers
  - charger driver for Maxim 77693
  - battery gauge driver for LTC 2941/2943
  - battery gauge driver for RT5033
  - reset driver for R-Mobile platforms
 * convert drivers to restart handler framework
  - arm-versatile
  - at91
  - st-poweroff
 * remove deprecated sun6i reboot driver
 * use alarmtimer instead of rtc in charger-manager
 * misc. fixes

----------------------------------------------------------------
Beomho Seo (1):
      power: rt5033_battery: Add RT5033 Fuel gauge device driver

Dmitry Eremin-Solenikov (2):
      power: gpio-charger: balance enable/disable_irq_wake calls
      power: collie_battery: support generating wakeup event

Eric B=E9nard (1):
      bq27x00_battery: fix register offset for bq27425

Frans Klaver (13):
      power: reset: ltc2952: prefer devm_kzalloc over kzalloc
      power: reset: ltc2952: prefer devm_request_irq over request_irq
      power: reset: ltc2952: unroll gpio_desc array
      power: reset: ltc2952: prefer devm_gpiod_get over gpiod_get
      power: reset: ltc2952: reduce dependency on global variables
      power: reset: ltc2952: remove global variable poweroff_panic
      power: reset: ltc2952: drop empty suspend/resume functions
      power: reset: ltc2952: cleanup control flow in poweroff_handler
      power: reset: ltc2952: fix C++ style function pointers
      power: reset: ltc2952: disable timers in _remove
      power: reset: ltc2952: check trigger value before starting timer
      power: reset: ltc2952: make trigger input optional
      power: reset: ltc2952: document optional trigger behavior

Geert Uytterhoeven (1):
      power: reset: Add reset driver for R-Mobile platforms

Guenter Roeck (7):
      power/reset: at91-poweroff: Fix error handling and other compiler war=
nings
      power/reset: arm-versatile: Register with kernel restart handler
      power/reset: at91: Register with kernel restart handler
      power/reset: Remove sun6i reboot driver
      power/reset: st-poweroff: Register with kernel restart handler
      power/reset: st-poweroff: Fix misleading Kconfig description
      power/reset: restart-poweroff: Remove arm dependencies

Jonghwa Lee (1):
      power: charger-manager: Use alarmtimer for battery monitoring in susp=
end.

Karol Wrona (1):
      power: max14577: Remove SYSFS dependency from Kconfig

Kevin Cernekee (3):
      power/reset: brcmstb: Make the driver buildable on MIPS
      power/reset: brcmstb: Use the DT "compatible" string to indicate bit =
positions
      power/reset: brcmstb: Add support for old 65nm chips

Krzysztof Kozlowski (9):
      power: bq24190: Fix ignored supplicants
      power: max17042: Constify struct regmap_config
      devicetree: power/mfd: max77693: Document new bindings for charger
      mfd: max77693: Add defines for MAX77693 charger driver
      power: max77693: Add charger driver for Maxim 77693
      Documentation: power: max77693-charger: Document exported sysfs entry
      MAINTAINERS: Add entry for Maxim chargers on Samsung boards
      power: test_power: Use enum as index for array of supplies
      power_supply: 88pm860x: Fix leaked power supply on probe fail

Lad, Prabhakar (1):
      power: bq24190_charger: suppress build warning

Linus Walleij (1):
      power: reset: augment versatile driver for integrator

Mike Looijmans (2):
      Add LTC2941/LTC2943 Battery Gauge Driver
      Add devicetree binding documentation for the LTC2941/LTC2943 driver

Pawel Moll (1):
      power/reset: vexpress: Remove non-DT code

Puthikorn Voravootivat (1):
      bq27x00_battery: Call power_supply_changed only when capacity changed

Rickard Strandqvist (1):
      power: ab8500_fg.c: Remove unused function

kbuild test robot (2):
      power: max77693: fix simple_return.cocci warnings
      power: max77693: fix platform_no_drv_owner.cocci warnings

 Documentation/ABI/testing/sysfs-class-power                        |  42 +=
++++
 Documentation/devicetree/bindings/arm/brcm-brcmstb.txt             |   4 +-
 Documentation/devicetree/bindings/mfd/max77693.txt                 |  45 +=
++++
 Documentation/devicetree/bindings/power/ltc2941.txt                |  27 +=
++
 Documentation/devicetree/bindings/power/reset/ltc2952-poweroff.txt |  13 +-
 MAINTAINERS                                                        |   7 +
 drivers/power/88pm860x_charger.c                                   |   1 +
 drivers/power/Kconfig                                              |  25 +=
+-
 drivers/power/Makefile                                             |   3 +
 drivers/power/ab8500_fg.c                                          |  14 --
 drivers/power/bq24190_charger.c                                    |   4 +-
 drivers/power/bq27x00_battery.c                                    |  19 +=
+-
 drivers/power/charger-manager.c                                    | 289 +=
+++++++++----------------------
 drivers/power/collie_battery.c                                     |  24 +=
+-
 drivers/power/gpio-charger.c                                       |   4 +-
 drivers/power/ltc2941-battery-gauge.c                              | 547 +=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/power/max17042_battery.c                                   |   2 +-
 drivers/power/max77693_charger.c                                   | 753 +=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 drivers/power/reset/Kconfig                                        |  26 +=
+-
 drivers/power/reset/Makefile                                       |   2 +-
 drivers/power/reset/arm-versatile-reboot.c                         |  49 +=
++++-
 drivers/power/reset/at91-poweroff.c                                |   7 +-
 drivers/power/reset/at91-reset.c                                   |  28 +=
+--
 drivers/power/reset/brcmstb-reboot.c                               |  41 +=
+++-
 drivers/power/reset/ltc2952-poweroff.c                             | 290 +=
+++++++++++++------------------
 drivers/power/reset/restart-poweroff.c                             |   1 -
 drivers/power/reset/rmobile-reset.c                                |  91 +=
++++++++++
 drivers/power/reset/st-poweroff.c                                  |  17 +-
 drivers/power/reset/sun6i-reboot.c                                 |  85 -=
---------
 drivers/power/reset/vexpress-poweroff.c                            |  17 +-
 drivers/power/rt5033_battery.c                                     | 177 +=
+++++++++++++++++++
 drivers/power/test_power.c                                         |  33 +=
+--
 include/linux/mfd/abx500/ab8500-bm.h                               |   1 -
 include/linux/mfd/max77693-private.h                               | 108 +=
+++++++++++
 include/linux/power/charger-manager.h                              |  32 +=
---
 35 files changed, 2224 insertions(+), 604 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/ltc2941.txt
 create mode 100644 drivers/power/ltc2941-battery-gauge.c
 create mode 100644 drivers/power/max77693_charger.c
 create mode 100644 drivers/power/reset/rmobile-reset.c
 delete mode 100644 drivers/power/reset/sun6i-reboot.c
 create mode 100644 drivers/power/rt5033_battery.c

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU2MqgAAoJENju1/PIO/qarlQP/R/5kxqN/87I5/Zm8aosBZ9j
B04wvolkCEryJ30wKNBB+J18GJMpynO5rXbjtYgLlQ2yjZUavldzYkJdr4sY/aW8
ate3X6A0Pvh5hjhiS/nHwMNJn0pPX3GRTkB4kiA615bTbkf3XZpFSl6QrWcvJADi
d8NvokwKiaj08c6vXlosoGDZtkrJAKbtcREQxDsr2/TSq2xsUI5N9lxsPY4g1vrf
vv5aoYqim2BDfO8VNEcYN5/7/6uDmVWsaH3PkGGwxhMMM85j4uI5zW/LFwfajEGb
PKU7VuZ5BBvmYxohrsh5PDH1Zpo/oSvhFw0mjnXBglVt0oyc+vY0gg3k82s91Lko
02QXcaPBEhmkHZTC6u369ioM1Wu/Tgmh4vcLo38tWvV4IxLs5ABlFZ/eSXLkvQGo
j+nBck0SU5vU/ib/saljKSXYmWukP3PPSxHnJ7bF+ufSwvt2qZS8f7rVj0BqaOKN
DTaXNA7YZBVwKQ9vv4i0nYj/s6O6idWwN+pDeySfCbIDt+Z7kXXv90EKYhaXX6um
0oTm+wcY3ddKpniUwI5/4Se13uXeiqqYB9arTwrC3ybsFUQW4aKYfhB3pFH3KjiB
W8aVDOv3wJ7D+4wfbjweWtzhMiWfGLKKIY/x8lNA9OLQB1Y9FpHQHGHo6rNU6ZPC
7t7iC6q0KDjdHhchOcw/
=GbHO
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
