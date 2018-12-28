From: Sebastian Reichel <sre@kernel.org>
Subject: [GIT PULL] power-supply changes for 4.21
Date: Fri, 28 Dec 2018 14:08:52 +0100
Message-ID: <20181228130852.vqihu6gdyzczddq3@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e5yo3s6z6ptxm3x4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--e5yo3s6z6ptxm3x4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

All changes have been in linux-next for multiple weeks, no issues
were reported to me. I don't expect any problems during or after
merging this pull request. Happy New Year!

-- Sebastian

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-su=
pply.git tags/for-v4.21

for you to fetch changes up to 9580913966488dc78d8d2893c7427d0a84124e74:

  power: supply: bq25890: fix BAT_COMP field definition (2018-12-18 00:21:1=
6 +0100)

----------------------------------------------------------------
power supply and reset changes for the v4.21 series

* New core support
 - battery internal resistance
 - battery OCV capacity lookup table
 - support for custom sysfs attributes
* Convert all drivers to use power-supply core support for custom sysfs att=
ributes
* bq24190-charger: bq24196 support
* axp20x-charger: AXP813 support
* sc27xx-battery: new fuel gauge driver
* gpio-poweroff: support for specific active and inactive delays
* Misc fixes

----------------------------------------------------------------
Alexandre Belloni (1):
      power: reset: ocelot: switch the SI to boot mode

Baolin Wang (16):
      dt-bindings: power: Introduce one property to present the battery int=
ernal resistance
      power: supply: core: Add one field to present the battery internal re=
sistance
      dt-bindings: power: Introduce properties to present the battery OCV c=
apacity table
      power: supply: core: Add some helpers to use the battery OCV capacity=
 table
      dt-bindings: power: Add Spreadtrum SC27XX fuel gauge unit documentati=
on
      power: supply: Add Spreadtrum SC27XX fuel gauge unit driver
      power: supply: charger-manager: Remove unused index counting
      power: supply: charger-manager: Fix some misspelled words
      power: supply: charger-manager: Fix incorrect return value
      power: supply: charger-manager: Make code more readable
      power: supply: sc2731_charger: Add one work to charge/discharge
      power: supply: sc2731_charger: Add charger status detection
      power: supply: sc2731_charger: Avoid repeated charge/discharge
      power: supply: sc2731_charger: Free battery information
      dt-bindings: power: supply: Add nvmem properties to calibrate FGU
      power: supply: sc27xx: Add fuel gauge calibration

Brian Masney (2):
      dt-bindings: power: supply: bq24190_charger: add bq24192 and usb-otg-=
vbus
      power: supply: bq24190_charger: add extcon support for USB OTG

Claudiu Beznea (1):
      power: reset: at91-poweroff: move shdwc related data to one structure

Claudiu.Beznea@microchip.com (2):
      power: reset: at91-poweroff: use one poweroff function for at91-power=
off
      power: reset: at91-poweroff: remove at91_ramc_of_match

Colin Ian King (2):
      power: supply: cpcap-battery: make array cpcap_battery_irqs static, s=
hrinks object size
      power: supply: cpcap-charger: clean an indentation issue, remove tab

Heiko Stuebner (2):
      power: reset: gpio-poweroff: add ability to specific active and inact=
ive delays
      power: supply: bq24190_charger: add support for bq24196 variant

Jonathan Marek (2):
      power: supply: bq24190_charger: add support for bq24192 variant
      power: supply: bq24190_charger: add of_match for usb-otg-vbus regulat=
or

Lubomir Rintel (1):
      power: supply: olpc_battery: correct the temperature units

Micha=C5=82 Miros=C5=82aw (1):
      power: supply: bq25890: fix BAT_COMP field definition

Olliver Schinagl (2):
      power: supply: axp20x: add missing include bitops.h
      power: supply: axp288: use the BIT() macro

Oskari Lemmela (2):
      dt-bindings: power: supply: axp20x: add AXP813 AC power DT binding
      power: supply: add AC power supply driver for AXP813

Randy Dunlap (1):
      power/supply: fix sc27xx_fuel_gauge build errors

Sebastian Reichel (16):
      Merge tag 'psy-mfd-axp813-immutable-for-v4.21-signed' into psy-next
      power: supply: core: add support for custom sysfs attributes
      power: supply: bq2415x: fix race-condition in sysfs registration
      power: supply: ds2780: fix race-condition in sysfs registration
      power: supply: ds2781: fix race-condition in sysfs registration
      power: supply: lp8788: fix race-condition in sysfs registration
      power: supply: bq24190_charger: fix race-condition in sysfs registrat=
ion
      power: supply: bq24257: fix race-condition in sysfs registration
      power: supply: charger-manager: simplify generation of sysfs attribut=
e group name
      power: supply: charger-manager: fix race-condition in sysfs registrat=
ion
      power: supply: pcf50633: fix race-condition in sysfs registration
      power: supply: ds2780: fix race-condition in bin attribute registrati=
on
      power: supply: ds2781: fix race-condition in bin attribute registrati=
on
      power: supply: ds2780: switch to devm_power_supply_register
      power: supply: ds2781: switch to devm_power_supply_register
      power: supply: gpio-charger: Do not use deprecated POWER_SUPPLY_TYPE_=
USB_*

Yuanjiang Yu (3):
      power: supply: sc27xx: Add fuel gauge low voltage alarm
      power: supply: sc27xx: Add suspend/resume interfaces
      power: supply: sc27xx: Save last battery capacity

 .../bindings/power/reset/gpio-poweroff.txt         |    2 +
 .../bindings/power/supply/axp20x_ac_power.txt      |    3 +
 .../devicetree/bindings/power/supply/battery.txt   |   17 +
 .../devicetree/bindings/power/supply/bq24190.txt   |   10 +
 .../devicetree/bindings/power/supply/sc27xx-fg.txt |   56 +
 drivers/power/reset/at91-poweroff.c                |   86 +-
 drivers/power/reset/gpio-poweroff.c                |   10 +-
 drivers/power/reset/ocelot-reset.c                 |   12 +
 drivers/power/supply/Kconfig                       |    8 +
 drivers/power/supply/Makefile                      |    1 +
 drivers/power/supply/axp20x_ac_power.c             |   94 ++
 drivers/power/supply/axp20x_usb_power.c            |    1 +
 drivers/power/supply/axp288_charger.c              |   35 +-
 drivers/power/supply/bq2415x_charger.c             |  119 +--
 drivers/power/supply/bq24190_charger.c             |   91 +-
 drivers/power/supply/bq24257_charger.c             |   15 +-
 drivers/power/supply/bq25890_charger.c             |    2 +-
 drivers/power/supply/charger-manager.c             |   89 +-
 drivers/power/supply/cpcap-battery.c               |    2 +-
 drivers/power/supply/cpcap-charger.c               |    2 +-
 drivers/power/supply/ds2780_battery.c              |   87 +-
 drivers/power/supply/ds2781_battery.c              |   82 +-
 drivers/power/supply/gpio-charger.c                |    6 +-
 drivers/power/supply/lp8788-charger.c              |   62 +-
 drivers/power/supply/olpc_battery.c                |    4 +-
 drivers/power/supply/pcf50633-charger.c            |   17 +-
 drivers/power/supply/power_supply_core.c           |  141 ++-
 drivers/power/supply/sc2731_charger.c              |   54 +-
 drivers/power/supply/sc27xx_fuel_gauge.c           | 1075 ++++++++++++++++=
++++
 include/linux/mfd/axp20x.h                         |    1 +
 include/linux/power/charger-manager.h              |    3 +-
 include/linux/power_supply.h                       |   23 +
 32 files changed, 1791 insertions(+), 419 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/sc27xx-f=
g.txt
 create mode 100644 drivers/power/supply/sc27xx_fuel_gauge.c

--e5yo3s6z6ptxm3x4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwmIGEACgkQ2O7X88g7
+pr/Ww//cwqCHaYZtf1eRiwgH/3KtCinNgkGqupO/PK+8+C+jB13xVq0tLtRzS3Y
cbOnZRgrooMKWRXOXs+rJYVZUT8MG7mZaC9GJl08uPGctXiz5g7q96PlA8TddBzn
3tobShRjDnTv092d0NUyKgr6KI0iFEE7TpL2g3Rf5BlSz2/JF6A9PjJaRoe/6jmZ
lemUddJBHq8sZw9hfTAM9XRwtVXjZpakVk6Zo4sL0ELkSsEP6sq9QyncAe28o6x/
s9WXQnRXF5KEFtSd7T4LqPqPBxGBoEQNDK5qWndyASqzEOvHeGHvrB7AD00mbheU
tuN5peyHQ5nAmRZ/1SAO+BerVVRPmYBZnqqvrXBNzckr7Gp9W43faerMaNwXN4y3
piEv+DYdT+y7tTD8U8fnTWUu4k5FuJoNKZMzeDEG8VezE72HKrdHPPvT0aEwnfhp
m9ev/dBh+jAu4zAJaAWClTYbenPCom8Xg0FQyOxf4jYz0gXWH3NbS4wmYt1iQFzB
Uoz8ab9YWyvxX4zMhghMvZLnuO4PN4/tTBVmiaB65K1VouYJMbVjt2qT6WJVnPZi
kjzPsiPr5sskwi/dJaYZuYm/K9U88jrtbIshTffBUoNyqyLt5WBcNpNa3H2fn6Rh
YhQX72XTIorUAhyVVZZZBjcesGe60OpyCSpTI3+RgiplP+PJnxQ=
=8jNx
-----END PGP SIGNATURE-----

--e5yo3s6z6ptxm3x4--
