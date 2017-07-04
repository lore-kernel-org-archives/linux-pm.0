From: Sebastian Reichel <sre@kernel.org>
Subject: [GIT PULL] power-supply changes for 4.13
Date: Tue, 4 Jul 2017 11:04:42 +0200
Message-ID: <20170704090442.53emuq7mx5rh2352@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zx3blcl7i32op5yt"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752030AbdGDJEp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 4 Jul 2017 05:04:45 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--zx3blcl7i32op5yt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v4.13

for you to fetch changes up to bfa953d336cdd713f6968c85ca820ef22333dc35:

  power: supply: sbs-battery: Don't needlessly set CAPACITY_MODE (2017-06-15 16:52:04 +0200)

----------------------------------------------------------------
power supply and reset changes for the v4.13 series

* New drivers
 - Linear ltc3651 charger driver
 - Motorola CPCAP battery fuel-gauge driver
* New chip/feature support
 - bq27xxx: prepare for chip data setup
 - axp20x_battery: support max charge current setup
* New core features
 - add Apple Brick ID type
 - support "supplied-from" device property for generic ACPI/pdata support
 - support strings for sysfs properties representing enums
 - introduce battery-info (backend is DT only for now)
 - provide reboot-mode header globally
* Misc. fixes

----------------------------------------------------------------
Alexandre Belloni (2):
      power: reset: at91-poweroff: fix clobber list
      power: reset: at91-sama5d2_shdwc: fix clobber list

Andy Shevchenko (1):
      power: supply: twl4030_charger: Use sysfs_match_string() helper

Arvind Yadav (1):
      power: supply: core: constify psy_tcd_ops.

Benson Leung (1):
      power: supply: Add Apple Brick ID power supply type

Bjorn Andersson (1):
      power: reset: reboot-mode: Make include file global

Dan Carpenter (1):
      power: supply: ltc3651-charger: fix some error codes in probe

David Lechner (1):
      power: supply: sysfs: parse string as enum when writing property

Florian Fainelli (2):
      power: reset: Allow selecting POWER_RESET_BRCMSTB on ARM64
      power: reset: Default POWER_RESET_BRCMSTB to BMIPS_GENERIC

H. Nikolaus Schaller (3):
      power: supply: twl4030-charger: remove nonstandard max_current sysfs attribute
      power: supply: twl4030-charger: allocate iio by devm_iio_channel_get() and fix error path
      power: supply: twl4030-charger: move allocation of iio channel to the beginning

Hans de Goede (1):
      power: supply: core: Add support for supplied-from device-property

Julia Lawall (1):
      power: supply: axp20x_usb_power: Drop unnecessary static

Liam Breck (6):
      dt-bindings: power: supply: Add battery.txt with simple-battery binding
      power: supply: core: Add power_supply_battery_info and API
      power: supply: core: Add power_supply_prop_precharge
      dt-bindings: power: supply: bq27xxx: Add monitored-battery documentation
      power: supply: bq27xxx: Add chip data memory read/write support
      power: supply: bq27xxx: Add power_supply_battery_info support

Matt Ranostay (2):
      devicetree: property-units: Add uWh and uAh units
      power: supply: bq27xxx: Add bulk transfer bus methods

Mike Looijmans (2):
      dt-bindings: power: supply: New bindings for ltc3651-charger
      power: supply: Add ltc3651-charger driver

Phil Reid (2):
      power: supply: sbs-battery: remove incorrect le16_to_cpu calls
      power: supply: bq24735: remove incorrect le16_to_cpu calls

Quentin Schulz (2):
      power: supply: axp20x_battery: add support for DT battery
      power: supply: axp20x_battery: add DT support for battery max constant charge current

Sebastian Reichel (3):
      Merge branch 'psy-reboot-mode-immutable' into psy-next
      dt-bindings: power: supply: move maxim,max14656.txt to proper location
      dt-bindings: power: supply: move max8903-charger.txt to proper location

Shawn Nematbakhsh (2):
      power: supply: sbs-battery: Prevent CAPACITY_MODE races
      power: supply: sbs-battery: Don't needlessly set CAPACITY_MODE

Tony Lindgren (6):
      power: supply: cpcap-charger: Update charge current table and add comments
      power: supply: cpcap-charger: Fix charger voltages based on ADC values
      dt-bindings: power: supply: cpcap-battery: Add binding
      power: supply: cpcap-battery: Add a battery driver
      dt-bindings: power: supply: cpcap-battery: Add power-supplies property
      power: supply: cpcap-charger: Add missing power_supply_config

 .../ABI/testing/sysfs-class-power-twl4030          |  17 -
 .../devicetree/bindings/power/supply/battery.txt   |  57 ++
 .../devicetree/bindings/power/supply/bq27xxx.txt   |  31 +-
 .../bindings/power/supply/cpcap-battery.txt        |  31 +
 .../bindings/power/supply/ltc3651-charger.txt      |  27 +
 .../power/{ => supply}/max8903-charger.txt         |   0
 .../supply}/maxim,max14656.txt                     |   0
 .../devicetree/bindings/property-units.txt         |   2 +
 Documentation/power/power_supply_class.txt         |  31 +-
 drivers/power/reset/Kconfig                        |   4 +-
 drivers/power/reset/at91-poweroff.c                |   2 +-
 drivers/power/reset/at91-sama5d2_shdwc.c           |   2 +-
 drivers/power/reset/reboot-mode.c                  |   2 +-
 drivers/power/reset/syscon-reboot-mode.c           |   2 +-
 drivers/power/supply/Kconfig                       |  26 +
 drivers/power/supply/Makefile                      |   2 +
 drivers/power/supply/axp20x_battery.c              |  88 ++-
 drivers/power/supply/axp20x_usb_power.c            |   2 +-
 drivers/power/supply/bq24735-charger.c             |   6 +-
 drivers/power/supply/bq27xxx_battery.c             | 536 +++++++++++++-
 drivers/power/supply/bq27xxx_battery_i2c.c         |  82 ++-
 drivers/power/supply/cpcap-battery.c               | 808 +++++++++++++++++++++
 drivers/power/supply/cpcap-charger.c               |  89 ++-
 drivers/power/supply/ltc3651-charger.c             | 210 ++++++
 drivers/power/supply/power_supply_core.c           |  83 ++-
 drivers/power/supply/power_supply_sysfs.c          | 125 +++-
 drivers/power/supply/sbs-battery.c                 |  29 +-
 drivers/power/supply/twl4030_charger.c             |  97 +--
 include/linux/power/bq27xxx_battery.h              |   6 +
 include/linux/power_supply.h                       |  40 +-
 .../power/reset => include/linux}/reboot-mode.h    |   0
 31 files changed, 2204 insertions(+), 233 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/battery.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/cpcap-battery.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/ltc3651-charger.txt
 rename Documentation/devicetree/bindings/power/{ => supply}/max8903-charger.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/supply}/maxim,max14656.txt (100%)
 create mode 100644 drivers/power/supply/cpcap-battery.c
 create mode 100644 drivers/power/supply/ltc3651-charger.c
 rename {drivers/power/reset => include/linux}/reboot-mode.h (100%)

--zx3blcl7i32op5yt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllbWioACgkQ2O7X88g7
+po4Rw//V1U6u66wPFfXaly3FgFpwmyhCucy4tw1jJmcw+i80GSRDM2SeUb6bE7R
Xn30M0xEbj6kFeotyVP11ANZBNaAy+a+llIdiyaXV2ugisemx4OWPRjCp/74tiGJ
FKaJDXDPrWKyWbW8kByHcQThjMT+P/8j4pCsb5ii5yzbI1T8u/QV8k4mhQ/BR62L
26qOIV6vx98lvngtgzX1wyFOSYYHaJ/oL+48LoqknSxLcIEJroR26abKy2tli1W1
qOGooJVhPB+9P8hwADDDy5fRjt0A7kMv18LknHEh+zEScGPKAM4wxzy6idIBBRr4
3gBwtFuva+mfGvtBPmXykdZz4AfGiwtMyEkQ5d8a/ulEwcDmAH/LNEUkMETNkn3+
eaphLV4fj8hji/qvgQqFKA7kOg6OMlpzgUOfSP51f4Ta9Yxd3QQcRZlcNoKGhVSZ
e9GjZbj5dIQxSRYQv3LzkorTCZhcu9cZb83bwuDNkFmu+ICtx8qQdKj7l//SWL2k
0Brdy5u5ITAbIYFZ5GfRGPOKOPIk2lm/APcH4Aie5NzJ0i7ja8LNNOxceNKVAlRl
UcNTTfSQhPYqsPF9Wnqp4d6K4Te6jFAO64fCg/pGxP2GxX/4EvQYdUYs5tGQU0uZ
FUGSO5BpRTama2DSrnk14Mrqw0W5oeifpcuXVEJx6xdPQOMgDAA=
=Uhxk
-----END PGP SIGNATURE-----

--zx3blcl7i32op5yt--
