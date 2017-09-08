From: Sebastian Reichel <sre@kernel.org>
Subject: [GIT PULL] power-supply changes for 4.14
Date: Sat, 9 Sep 2017 01:13:29 +0200
Message-ID: <20170908231328.xfgimag2blzutfvn@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rvwbe3cos7w6fbea"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757173AbdIHXNe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 Sep 2017 19:13:34 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--rvwbe3cos7w6fbea
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 520eccdfe187591a51ea9ab4c1a024ae4d0f68d9:

  Linux 4.13-rc2 (2017-07-23 16:15:17 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v4.14

for you to fetch changes up to 5d01fd38a3b01ca2112a689d70f7ecec40d952ee:

  power: supply: bq27xxx: enable writing capacity values for bq27421 (2017-08-31 10:25:24 +0200)

----------------------------------------------------------------
power supply and reset changes for the v4.14 series

* New chip/feature support
 - bq27xxx: support updating battery config from DT
 - bq24190: support loading battery charge info from DT
 - LTC2941: add LTC2942/LTC2944 support
 - max17042: add ACPI support
 - max1721x: new driver
* Misc
 - Move bq27xxx w1 driver from w1 into power-supply subsystem
 - Introduce power_supply_set_input_current_limit_from_supplier
 - constify stuff
 - some minor fixes

----------------------------------------------------------------
Alex A. Mihaylov (1):
      power: supply: Add support for MAX1721x standalone fuel gauge

Andrew F. Davis (2):
      power: supply: move HDQ interface for bq27xxx from w1 to power/supply
      power: supply: bq27xxx: move platform driver code into bq27xxx_battery_hdq.c

Arnd Bergmann (1):
      power: supply: cpcap-charger: add OMAP_USB2 dependency

Arvind Yadav (1):
      power: supply: constify attribute_group structures.

Bhumika Goyal (2):
      power: supply: add const to bin_attribute structures
      power: supply: make device_attribute const

Christophe JAILLET (3):
      power: supply: charger-manager: Fix a NULL pointer dereference in 'charger_manager_probe()'
      power: supply: charger-manager: Fix a comment
      power: supply: charger-manager: Slighly simplify code

Colin Ian King (1):
      power: supply: lp8788: Make several arrays static const * const

Dragos Bogdan (1):
      power: supply: ltc2941-battery-gauge: Add LTC2944 support

H. Nikolaus Schaller (1):
      power: supply: bq27xxx: enable writing capacity values for bq27421

Hans de Goede (8):
      power: supply: Fix power_supply_am_i_supplied to return -ENODEV when apropriate
      power: supply: max17042_battery: Add support for ACPI enumeration
      power: supply: max17042_battery: Fix ACPI interrupt issues
      power: supply: max17042_battery: Fix compiler warning
      power: supply: Add power_supply_set_input_current_limit_from_supplier helper
      power: supply: bq24190_charger: Add input_current_limit property
      power: supply: bq24190_charger: Export 5V boost converter as regulator
      power: supply: bq24190_charger: Get input_current_limit from our supplier

Ladislav Michl (2):
      power: supply: ltc2941-battery-gauge: Prepare for LTC2942 and LTC2944
      power: supply: ltc2941-battery-gauge: Add LTC2942 support

Liam Breck (9):
      power: supply: bq24190_charger: Add ti,bq24192i to devicetree table
      power: supply: bq27xxx: Create single chip data table
      power: supply: bq27xxx: Add chip IDs for previously shadowed chips
      power: supply: bq27xxx: Enable data memory update for certain chips
      power: supply: bq27xxx: Remove duplicate chip data arrays
      dt-bindings: power: supply: Add docs for TI BQ24190 battery charger
      power: supply: bq24190_charger: Enable devicetree config
      power: supply: bq24190_charger: Add property system-minimum-microvolt
      power: supply: bq24190_charger: Add power_supply_battery_info support

Markus Elfring (1):
      power: supply: core: Delete two error messages for a failed memory allocation in power_supply_check_supplies()

Michael Heinemann (1):
      power: supply: sbs-battery: correct capacity mode selection bits

Phil Reid (3):
      power: supply: sbs-battery: Remove FSF mailing address from comments
      power: supply: sbs-battery: sort includes
      power: supply: sbs-battery: Add delay when changing capacity mode bit

Rob Herring (1):
      power: reset: Convert to using %pOF instead of full_name

Sebastian Reichel (2):
      Merge branch 'fixes' into for-next
      Merge branch 'psy-w1-for-v4.14-immutable' into for-next

Sergei Shtylyov (1):
      power: supply: act8945a_charger: fix of_irq_get() error check

 .../devicetree/bindings/power/supply/bq24190.txt   |  51 ++
 .../devicetree/bindings/power/supply/ltc2941.txt   |  15 +-
 drivers/power/reset/at91-sama5d2_shdwc.c           |   4 +-
 drivers/power/supply/Kconfig                       |  23 +
 drivers/power/supply/Makefile                      |   2 +
 drivers/power/supply/act8945a_charger.c            |   4 +-
 drivers/power/supply/bq24190_charger.c             | 346 ++++++++++++-
 drivers/power/supply/bq27xxx_battery.c             | 575 ++++++++-------------
 drivers/power/supply/bq27xxx_battery_hdq.c         | 135 +++++
 drivers/power/supply/bq27xxx_battery_i2c.c         |  16 +-
 drivers/power/supply/charger-manager.c             |   9 +-
 drivers/power/supply/ds2780_battery.c              |   4 +-
 drivers/power/supply/ds2781_battery.c              |   4 +-
 drivers/power/supply/lp8788-charger.c              |  18 +-
 drivers/power/supply/ltc2941-battery-gauge.c       | 156 ++++--
 drivers/power/supply/max17042_battery.c            |  42 +-
 drivers/power/supply/max1721x_battery.c            | 448 ++++++++++++++++
 drivers/power/supply/olpc_battery.c                |   4 +-
 drivers/power/supply/pcf50633-charger.c            |   2 +-
 drivers/power/supply/power_supply_core.c           |  54 +-
 drivers/power/supply/sbs-battery.c                 |  26 +-
 drivers/w1/slaves/Kconfig                          |   6 -
 drivers/w1/slaves/Makefile                         |   1 -
 drivers/w1/slaves/w1_bq27000.c                     | 117 -----
 include/linux/power/bq24190_charger.h              |  18 +
 include/linux/power/bq27xxx_battery.h              |  27 +-
 include/linux/power_supply.h                       |   2 +
 27 files changed, 1471 insertions(+), 638 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq24190.txt
 create mode 100644 drivers/power/supply/bq27xxx_battery_hdq.c
 create mode 100644 drivers/power/supply/max1721x_battery.c
 delete mode 100644 drivers/w1/slaves/w1_bq27000.c
 create mode 100644 include/linux/power/bq24190_charger.h

--rvwbe3cos7w6fbea
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmzJBYACgkQ2O7X88g7
+pqz8g//Q88WgWZRJM2yP1KX1bU0HVfA3lXIekZsMXAaVBQ/NNm8AxTyIgmA2oaE
GARj2IBCSW1lKLzbKjtySyMNEKuaLDANbymouC4nnr/Ms6jyvYeXEKswGcmadGDQ
XyhZFvqIBqIIL6LEgGZtBrXDFvwGcaj0d3kNil27hT3QeVCPqznYseEchBIu3PNl
h6F/BBmi4aUWdnf9xTe+qRRscZoboq3aohirzcMOFpmHndEx+xUsNjjQwT15+Wp8
bbB0ri4OVisSNeKdekpXvGzOGfSNAP3fs+UHntbn9gr3+YXCsa35scNfWEUguKny
iT6DXwWGlcOwf6p7ykRhV7p0tMpuZiD8qdTSVneaDogAOhbTHO2L/v+8MN3GsPnG
TmKYKW9ZEZGVNAvhkxoDd/YSO5pm4sFBh96jMmgwyuOkcXdafTI4uMepv9dlnzVM
XBaq8gb3zerol9T2KOB9JYYAWqxj7DxEpGFVcXzJtlhzm77OXJL7xMXrHL6cy9wX
NGhlq/PfUXBbA2QPjIEJVpILElI3GMvlfuTmE41usucOQZf8j0AYCCdvX5wuUH+M
z0gIggFD5C6d+MhBec3Er9MMNpi4TSr6VX+xrpKbcRD1R8TpCajHtjlxfSyNWMtA
B3Ad0sH6KydCIdN6tavW97igRImuSIDXhBVQxT3hM7+orbPrxjA=
=LPYH
-----END PGP SIGNATURE-----

--rvwbe3cos7w6fbea--
