From: Sebastian Reichel <sre@kernel.org>
Subject: [GIT PULL] power supply changes for 4.4
Date: Wed, 4 Nov 2015 23:12:44 +0100
Message-ID: <20151104221243.GB12849@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit 1f93e4a96c9109378204c147b3eec0d0e8100fde:

  Linux 4.3-rc2 (2015-09-20 14:32:34 -0700)

are available in the git repositories at:

 git://git.infradead.org/battery-2.6.git tags/for-v4.4
 git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git t=
ags/for-v4.4

for you to fetch changes up to 6bd03ce3c12a22d86f59070f1da15aaa2bde8a51:

  power: bq27xxx_battery: Remove unneeded dependency in Kconfig (2015-10-19=
 10:38:50 +0200)

----------------------------------------------------------------
power supply and reset changes for the v4.4 series

 * new AXP20X USB Power driver
 * new Qualcomm SMBB driver
 * new TPS65217 Charger driver
 * BQ24257: add BQ24250/BQ24251 support
 * overhaul bq27x00 battery driver, rename to bq27xxx
 * misc. fixes and cleanups

----------------------------------------------------------------
Alexandre Belloni (5):
      power/reset: at91-reset: remove useless at91_reset_platform_probe()
      power/reset: at91-reset: allow compiling as a module
      power/reset: at91-reset: get and use slow clock
      power/reset: at91-poweroff: allow compiling as a module
      power/reset: at91-poweroff: get and use slow clock

Andreas Dannenberg (14):
      power: bq24257: Remove IRQ config through stat-gpios
      power: bq24257: Streamline input current limit setup
      power: bq24257: Use managed power supply register
      power: bq24257: Simplify bq24257_power_supply_init()
      dt: power: bq24257-charger: Cover additional devices
      power: bq24257: Add basic support for bq24250/bq24251
      power: bq24257: Add bit definition for temp sense enable
      power: bq24257: Allow manual setting of input current limit
      power: bq24257: Add SW-based approach for Power Good determination
      power: bq24257: Add over voltage protection setting support
      power: bq24257: Add input DPM voltage threshold setting support
      power: bq24257: Allow input current limit sysfs access
      power: bq24257: Add various device-specific sysfs properties
      Documentation: power: bq24257: Document exported sysfs entries

Andrew F. Davis (8):
      power: bq27x00_battery: Remove unneeded i2c MODULE_ALIAS
      power: bq27x00_battery: Renaming for consistency
      power: bq27xxx_battery: Platform initialization must declare a device
      power: bq27xxx_battery: Fix typos and change naming for state of char=
ge functions
      power: bq27xxx_battery: Add support for additional bq27xxx family dev=
ices
      power: bq27xxx_battery: Cleanup health checking
      power: bq27xxx_battery: Add interrupt handling support
      power: bq27xxx_battery: Remove unneeded dependency in Kconfig

Andrzej Hajda (1):
      power: bq27xxx_battery: fix signedness bug in bq27xxx_battery_read_he=
alth()

Courtney Cavin (2):
      dt-binding: power: Add Qualcomm SMBB binding
      power: Add Qualcomm SMBB driver

Dan Carpenter (1):
      power: qcom_smbb: test the correct variable

Enric Balletbo i Serra (2):
      devicetree: Add TPS65217 charger binding.
      power_supply: Add support for tps65217-charger.

Hans de Goede (2):
      ARM: dts: Add binding documentation for AXP20x pmic usb power supply
      power: Add an axp20x-usb-power driver

Javier Martinez Canillas (1):
      power: Remove unnecessary MODULE_ALIAS() for I2C drivers

Julia Lawall (1):
      power_supply: charger-manager: add missing of_node_put

Luis de Bethencourt (1):
      tps65090-charger: Fix module autoload for OF platform driver

Marcel Ziswiler (1):
      power: charger-manager: comment spelling fixes

Marek Belisko (2):
      ARM: dts: twl4030: Add iio properties for bci subnode
      drivers: power: twl4030_charger: fix link problems when building as m=
odule

Mark Brown (1):
      power: wm831x_power: Convert to devm_kzalloc()

Milo Kim (2):
      power:lp8727_charger: use the private data instead of updating I2C de=
vice platform data
      power:lp8727_charger: parsing child node after getting debounce-ms

Nicolas Ferre (1):
      power: reset: at91-reset/trivial: driver applies to SAMA5 family as w=
ell

Pali Roh=E1r (1):
      bq2415x_charger: Fix null pointer dereference

Sebastian Reichel (3):
      twl4030_charger: add missing iio dependency
      power: bq27xxx_battery: fix platform probe
      power: bq27xxx_battery: move irq handler to i2c section

Vaishali Thakkar (4):
      88pm860x_battery: Convert to using managed resources
      power: max17042_battery: Convert to using managed resources
      max8903_charger: Convert to using managed resources
      power_supply: max8998: Use devm_power_supply_register

Valentin Rothberg (1):
      wm831x_power: Use IRQF_ONESHOT to request threaded IRQs

 Documentation/ABI/testing/sysfs-class-power                         |   58=
 ++++
 Documentation/devicetree/bindings/power/bq24257.txt                 |   53=
 +++-
 Documentation/devicetree/bindings/power_supply/axp20x_usb_power.txt |   34=
 +++
 Documentation/devicetree/bindings/power_supply/qcom_smbb.txt        |  131=
 ++++++++
 Documentation/devicetree/bindings/power_supply/tps65217_charger.txt |   12=
 +
 MAINTAINERS                                                         |    4=
 +-
 arch/arm/boot/dts/twl4030.dtsi                                      |    2=
 +
 arch/arm/configs/omap2plus_defconfig                                |    2=
 +-
 arch/unicore32/Kconfig                                              |    2=
 +-
 drivers/power/88pm860x_battery.c                                    |   37=
 +--
 drivers/power/Kconfig                                               |   56=
 +++-
 drivers/power/Makefile                                              |    5=
 +-
 drivers/power/axp20x_usb_power.c                                    |  248=
 +++++++++++++++
 drivers/power/bq2415x_charger.c                                     |    2=
 +-
 drivers/power/bq24190_charger.c                                     |    1=
 -
 drivers/power/bq24257_charger.c                                     |  492=
 ++++++++++++++++++++++++-----
 drivers/power/bq27x00_battery.c                                     | 1129=
 -------------------------------------------------------------------
 drivers/power/bq27xxx_battery.c                                     | 1375=
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 drivers/power/charger-manager.c                                     |    4=
 +-
 drivers/power/lp8727_charger.c                                      |   31=
 +-
 drivers/power/max17042_battery.c                                    |   26=
 +-
 drivers/power/max8903_charger.c                                     |   93=
 ++----
 drivers/power/max8998_charger.c                                     |   29=
 +-
 drivers/power/pm2301_charger.c                                      |    1=
 -
 drivers/power/qcom_smbb.c                                           |  951=
 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/power/reset/Kconfig                                         |    4=
 +-
 drivers/power/reset/at91-poweroff.c                                 |   33=
 +-
 drivers/power/reset/at91-reset.c                                    |   69=
 ++---
 drivers/power/rt9455_charger.c                                      |    1=
 -
 drivers/power/smb347-charger.c                                      |    1=
 -
 drivers/power/tps65090-charger.c                                    |    1=
 +
 drivers/power/tps65217_charger.c                                    |  264=
 ++++++++++++++++
 drivers/power/twl4030_charger.c                                     |   39=
 ++-
 drivers/power/wm831x_power.c                                        |   15=
 +-
 drivers/w1/slaves/w1_bq27000.c                                      |    5=
 +-
 include/linux/mfd/axp20x.h                                          |   24=
 ++
 include/linux/power/bq27x00_battery.h                               |   19=
 --
 include/linux/power/bq27xxx_battery.h                               |   31=
 ++
 include/linux/power/charger-manager.h                               |    8=
 +-
 39 files changed, 3818 insertions(+), 1474 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power_supply/axp20x_u=
sb_power.txt
 create mode 100644 Documentation/devicetree/bindings/power_supply/qcom_smb=
b.txt
 create mode 100644 Documentation/devicetree/bindings/power_supply/tps65217=
_charger.txt
 create mode 100644 drivers/power/axp20x_usb_power.c
 delete mode 100644 drivers/power/bq27x00_battery.c
 create mode 100644 drivers/power/bq27xxx_battery.c
 create mode 100644 drivers/power/qcom_smbb.c
 create mode 100644 drivers/power/tps65217_charger.c
 delete mode 100644 include/linux/power/bq27x00_battery.h
 create mode 100644 include/linux/power/bq27xxx_battery.h

-- Sebastian

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWOoLbAAoJENju1/PIO/qa/FwP/31QNSrzORwdZhixxwB6faBo
pHZDTlF2UDD6hmmaZV/S8iPBockciNZk2XjABHfjcIQGsIqAdzNoqFfkg3id7UFl
h/qRWINTnhOgTKlCRloFFwzCvCSk1U1nEe7irSHK50zjQOXaFOqOlrj5yjM2WWF1
tyRPVIxQGWALdRQuvND9jOlS9EbdUBy7R7XLfBfwtaERB9ow5onPdchPnfDUIOeC
ux+zQzHvFWR4F+9KdbTekDATH7+ZQTZwh/ZPYjbm8ljPw59hszE/ykgxROuiWLND
OR52ZWz8zLAdd5NN6o8vHmDM5Wns0IXaUIa5fSB8Rhm5ndsaZbqGfuEXOesKPhtI
I6SfVRJz7aTZNVr/eciCTFm9av8C+RZ5e9Nfvt7JT+BqNa+u+Rmn1hyJsHiA2JNA
PhtdkrNnnMkTbxlkWc7ErOXHoVgs5QhAUMHcWbg3IIvizpyawo+dnKkRSQakDDba
U2BDY1ZOoxG6Xk2DXWsmONgdcmDQQg5j76Fx6vrPzooqRL2Qzbb4jQiILrnxbdS2
PE9u9lUIVKCRFxJhq0xm6D+wYy0A3mzdvR8Mt3yibXl7mW95ykkYMw96zo5PGWVd
mP8tQBDM9JqymAS//fs6Hu+Mj5H1aAfVQM+ZKxhBzH3JlBPLAnsIn1EqD8bK7KIJ
P9tjRoirOhGbexzc/JCZ
=WoRX
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
