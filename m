From: Sebastian Reichel <sre@kernel.org>
Subject: [GIT PULL] power-supply changes for 4.11
Date: Mon, 20 Feb 2017 07:17:00 +0100
Message-ID: <20170220061700.ckhwabihd5rmx3e2@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xrdcvtbl3rbss7zh"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750858AbdBTGRG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 Feb 2017 01:17:06 -0500
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--xrdcvtbl3rbss7zh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Everything in my pull-request has been in linux-next for three
weeks. There are overlappings with mfd & arm, but no problems
were reported by Stephen, so I assume the immutable branches
worked as expected.

-- Sebastian

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git =
tags/for-v4.11

for you to fetch changes up to 744cc304a18f1c9de4f3215fbe93fe878f934179:

  power: supply: add AC power supply driver for AXP20X and AXP22X PMICs (20=
17-01-29 23:15:18 +0100)

----------------------------------------------------------------
power supply and reset changes for the v4.11 series

* New drivers
 - sbs-charger driver
 - max14656_charger_detector
 - axp20x_ac_power
* New chip/feature support
 - axp20x_usb_power: add AXP223 support
 - tps65217: add usb charger support
 - qcom_smbb: support otg regulator
 - at91-reset: add samx7 support
* Dropped drivers
 - intel_mid_battery (platform was dropped)
* Fixes
 - at91-poweroff: avoid wearing off LPDDR memory
 - replace deprecated extcon API
 - lots of cleanup and style fixes
 - misc. minor functionality fixes

----------------------------------------------------------------
Alexander Kurz (2):
      dt-bindings: power: supply: Add max14656_charger_detector
      power: supply: Add support for MAX14656 USB charger detector

Alexandre Belloni (3):
      ARM: at91: define LPDDR types
      power: reset: at91-poweroff: timely shutdown LPDDR memories
      power: reset: at91-reset: remove leftover platform_device_id

Andy Shevchenko (1):
      power: supply: remove Intel Moorestown battery support

Arnd Bergmann (1):
      power: supply: qcom_smbb: add regulator dependency

Bird, Tim (2):
      dt-bindings: power: supply: Add otg regulator binding
      power: supply: qcom_smbb: Add otg regulator for control of vbus

Chanwoo Choi (2):
      power: supply: axp288_charger: Replace the extcon API
      power: supply: qcom_smbb: Replace the deprecated extcon API

Chris Lapa (12):
      power: supply: bq27xxx: move overtemp tests to a switch statement.
      power: supply: bq27xxx: rename BQ27500 allow for deprecation in futur=
e.
      power: supply: bq27xxx: rename BQ27510 allow for deprecation in futur=
e.
      power: supply: bq27xxx: adds specific support for bq27500/1 revision.
      power: supply: bq27xxx: adds specific support for bq27510-g1 revision.
      power: supply: bq27xxx: adds specific support for bq27510-g2 revision.
      power: supply: bq27xxx: adds specific support for bq27510-g3 revision.
      power: supply: bq27xxx: adds specific support for bq27520-g1 revision.
      power: supply: bq27xxx: adds specific support for bq27520-g2 revision.
      power: supply: bq27xxx: adds specific support for bq27520-g3 revision.
      power: supply: bq27xxx: adds specific support for bq27520-g4 revision.
      power: supply: bq27xxx: adds device tree binding documentation.

Colin Ian King (3):
      power: supply: wm97xx_battery: remove redundant 2nd null check on pda=
ta
      power: supply: fix spelling mistake: supply: "Celcius" -> "Celsius"
      power: supply: bq2415x: check for NULL acpi_id to avoid null pointer =
dereference

Gustavo A. R. Silva (2):
      power: supply: ab8500_btemp: Compress return logic into one line.
      power: supply: pcf50633-charger: Compress return logic into one line.

Hans de Goede (18):
      power: supply: axp288_charger: Make charger_init_hw_regs propagate i2=
c errors
      power: supply: axp288_charger: Drop platform_data dependency
      power: supply: axp288_fuel_gauge: Drop platform_data dependency
      power: supply: axp288_fuel_gauge: Fix fuel_gauge_reg_readb return on =
error
      power: supply: axp288_fuel_gauge: Read 15 bit values 2 registers at a=
 time
      power: supply: axp288_fuel_gauge: Read 12 bit values 2 registers at a=
 time
      power: supply: axp288_charger: Use devm_power_supply_register
      power: supply: axp288_charger: Register extcon notifers after power_s=
upply
      power: supply: axp288_charger: Move init_hw_regs call before supply r=
egistration
      power: supply: axp288_charger: Actually get and use the USB_HOST extc=
on device
      power: supply: axp288_charger: Handle charger type changing without d=
isconnect
      power: supply: axp288_charger: Some minor cleanups
      power: supply: axp288_charger: Get and process initial hardware-state
      power: supply: axp288_charger: Fix wrong regmap_update_bits
      power: supply: axp288_charger: Remove unnecessary irq?_en register wr=
ites
      power: supply: axp288_charger: Fix the module not auto-loading
      power: supply: axp288_charger: Use one notifier_block per extcon cable
      power: supply: axp288_fuel_gauge: Remove unnecessary irq?_en register=
 writes

Javier Martinez Canillas (1):
      power: supply: max14656: Export I2C and OF device ID as module aliases

Liam Breck (7):
      power: supply: bq24190_charger: Fix irq trigger to IRQF_TRIGGER_FALLI=
NG
      power: supply: bq24190_charger: Call set_mode_host() on pm_resume()
      power: supply: bq24190_charger: Install irq_handler_thread() at end o=
f probe()
      power: supply: bq24190_charger: Call power_supply_changed() for relev=
ant component
      power: supply: bq24190_charger: Don't read fault register outside irq=
_handle_thread()
      power: supply: bq24190_charger: Handle fault before status on interru=
pt
      power: supply: bq24190_charger: Adjust formatting

Linus Walleij (1):
      power: supply: gpio_charger: switch to using GPIO descriptors

Michal Suchanek (1):
      power: supply: axp20x_usb_power: fix warning on 64bit

Milo Kim (8):
      power: supply: tps65217: Use 'poll_task' on unloading the module
      power: supply: tps65217: Support USB charger interrupt
      power: supply: tps65217: Use generic name for charger online
      power: supply: tps65217: Use generic name for power supply structure
      power: supply: tps65217: Use generic name for power supply property
      power: supply: tps65217: Use generic name for get_property()
      power: supply: tps65217: Use generic charger name
      dt-bindings: power: supply: Update TPS65217 properties

Nicolas Saenz Julienne (2):
      dt-bindings: power: supply: sbs-charger bindings
      power: supply: add sbs-charger driver

Peter Rosin (8):
      power: supply: bq24735-charger: simplify register update to stop char=
ging
      dt-bindings: power: supply: bq24735: reverse the polarity of ac-detect
      power: supply: bq24735-charger: optionally poll the ac-detect gpio
      power: supply: bq24735: move down bq24735_{en,dis}able_charging
      power: supply: bq24735: configure the charger as part of enabling it
      power: supply: bq24735: always check for AC adapter presence in probe
      power: supply: bq24735: allow polling even if there is no ac-detect g=
pio
      power: supply: bq24735: bring down the noise level

Quentin Schulz (7):
      power: supply: axp20x_usb_power: use of_device_id data field instead =
of device_is_compatible
      power: supply: axp20x_usb_power: set min voltage and max current from=
 sysfs
      dt-bindings: power: supply: axp20x_usb_power: add axp223 compatible
      power: supply: axp20x_usb_power: add 100mA max current limit for AXP2=
23
      power: supply: axp20x_usb_power: use IIO channels when available
      dt-bindings: power: supply: add AXP20X/AXP22X AC power supply
      power: supply: add AC power supply driver for AXP20X and AXP22X PMICs

Sebastian Reichel (2):
      Merge branch 'psy-mfd-axp288-immutable' into psy-next
      Merge branch 'psy-arm-at91-immutable' into psy-next

Srikant Ritolia (1):
      power: supply: max8997_charger: Using device managed API and remove O=
OM print

Szemz=C5=91 Andr=C3=A1s (1):
      power: reset: at91-reset: add samx7 support

kbuild test robot (1):
      power: supply: max14656: fix platform_no_drv_owner.cocci warnings

 .../bindings/power/supply/axp20x_ac_power.txt      |  22 +
 .../bindings/power/supply/axp20x_usb_power.txt     |   5 +
 .../devicetree/bindings/power/supply/bq27xxx.txt   |  36 +
 .../devicetree/bindings/power/supply/qcom_smbb.txt |  19 +
 .../bindings/power/supply/sbs_sbs-charger.txt      |  23 +
 .../bindings/power/supply/ti,bq24735.txt           |   8 +-
 .../bindings/power/supply/tps65217_charger.txt     |   7 +-
 .../bindings/power_supply/maxim,max14656.txt       |  25 +
 drivers/power/reset/Kconfig                        |   2 +-
 drivers/power/reset/at91-poweroff.c                |  54 +-
 drivers/power/reset/at91-reset.c                   |  18 +-
 drivers/power/reset/at91-sama5d2_shdwc.c           |  49 +-
 drivers/power/supply/Kconfig                       |  36 +-
 drivers/power/supply/Makefile                      |   4 +-
 drivers/power/supply/ab8500_btemp.c                |  16 +-
 drivers/power/supply/axp20x_ac_power.c             | 253 +++++++
 drivers/power/supply/axp20x_usb_power.c            | 187 ++++-
 drivers/power/supply/axp288_charger.c              | 387 +++++-----
 drivers/power/supply/axp288_fuel_gauge.c           | 539 +++-----------
 drivers/power/supply/bq2415x_charger.c             |   5 +
 drivers/power/supply/bq24190_charger.c             | 188 ++---
 drivers/power/supply/bq24735-charger.c             | 108 ++-
 drivers/power/supply/bq27xxx_battery.c             | 356 ++++++++-
 drivers/power/supply/bq27xxx_battery_i2c.c         |  22 +-
 drivers/power/supply/gpio-charger.c                |  84 ++-
 drivers/power/supply/intel_mid_battery.c           | 795 -----------------=
----
 drivers/power/supply/max14656_charger_detector.c   | 327 +++++++++
 drivers/power/supply/max8997_charger.c             |  15 +-
 drivers/power/supply/pcf50633-charger.c            |  13 +-
 drivers/power/supply/qcom_smbb.c                   |  72 +-
 drivers/power/supply/sbs-charger.c                 | 274 +++++++
 drivers/power/supply/tps65217_charger.c            |  99 +--
 drivers/power/supply/wm97xx_battery.c              |   5 -
 include/linux/mfd/axp20x.h                         |  31 +-
 include/linux/power/bq27xxx_battery.h              |  12 +-
 include/soc/at91/at91sam9_ddrsdr.h                 |   3 +
 36 files changed, 2280 insertions(+), 1819 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/axp20x_a=
c_power.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq27xxx.=
txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/sbs_sbs-=
charger.txt
 create mode 100644 Documentation/devicetree/bindings/power_supply/maxim,ma=
x14656.txt
 create mode 100644 drivers/power/supply/axp20x_ac_power.c
 delete mode 100644 drivers/power/supply/intel_mid_battery.c
 create mode 100644 drivers/power/supply/max14656_charger_detector.c
 create mode 100644 drivers/power/supply/sbs-charger.c

--xrdcvtbl3rbss7zh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAliqidkACgkQ2O7X88g7
+ppGEg//YGc7yjkFnyUjFUwk5N2eC5rAwTBXjDrZlznMBytHRGKpNY+P0Ie7xP8Y
2T8GuLI+MABulHCE8oajSkAYBZJNkOshz+gInCEDxK3/u0IAR2PMqUigOH3sS1un
P/pDZM6vEQgnmC/4pIx1VUaZBBioqas9SbHhryNwOsn+Vz2VEX03oc+B9ol/fJc+
coxr4O6CXJ6CCQQIJVRsShdqiHyeK+eULr9ueMBDd71Mk8bRcRN3PUwuh5UVD/fA
F+E1WHukupjWcqR8gTUmDssyx2cGLPJXkAZbstq7yJNnBBxh9jI/uApf8IkMY93R
7TBewpUxuq6gvt0FNMQ+knN7mlGrcBt33u54qMi05LNWIkGCg2p6NmFMJrFByfcB
2KNgyAFiv+eugCMURsbwhCF9t7XsffNNQvsiKiY28Ef6UOGnyAO9r6PEKa37e9jT
qZumDjUS0KvutUICstF78bnTdhLz0oNp2YnmMPHxZ8NjK5UP5Qb8nP52NQUrUhkB
Vzeo8NuBYW0XOj5m2OmrCUqEFWkPIvtNYDp9RomloqV2YsUZGE+w7DYwS43Y92PG
JbhRcKlaXdNaxGR/ylY+1YbUJQl4XgWzY6Wk2zDUvDPjLvsX4kUdGiXgdfyCdg4v
5gOBkYS+KFVGQDjjR18hBn9m0GLPr6fXwubkpoPqZJb/j8sojf8=
=hWsB
-----END PGP SIGNATURE-----

--xrdcvtbl3rbss7zh--
