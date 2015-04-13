From: Sebastian Reichel <sre@ring0.de>
Subject: [GIT PULL] power supply changes for 4.1
Date: Mon, 13 Apr 2015 15:35:08 +0200
Message-ID: <20150413133508.GA3377@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.infradead.org/battery-2.6.git tags/for-v4.1

for you to fetch changes up to 5939d9dfe4406a49d8688eb827d88abcaf233c42:

  power: twl4030_madc_battery: Add missing MODULE_ALIAS (2015-04-06 19:39:57 +0200)

----------------------------------------------------------------
power supply and reset changes for the v4.1 series

 * new API for safe access of power supply function attrs
 * devres support for power supply (un)registration
 * new drivers / chips
  - generic syscon based poweroff driver
  - iio & charger driver for da9150
  - fuel gauge driver for axp288
  - bq27x00: add support for bq27510
  - bq2415x: add support for bq24157s
 * twl4030-madc-battery: convert to iio consumer
 * misc fixes

----------------------------------------------------------------
Adam Thomson (5):
      iio: Add support for DA9150 GPADC
      iio: da9150: Add DT binding documentation for GPADC
      power: Add support for DA9150 Charger
      power: da9150: Add DT binding documentation for charger
      MAINTAINERS: Include DA9150 files in Dialog Semiconductor support list.

Alexandre Belloni (1):
      power: bq27x00_battery: add bq27510 support

Anda-Maria Nicolae (2):
      bq2415x_charger: Remove unnecessary else after return
      bq2415x_charger: Add support for bq24157s

Ben Dooks (1):
      power/reset: at91: big endian fixes for atsama5d3x

Beomho Seo (2):
      power: max17042_battery: Use reg type instead of chip type
      power: max17042_battery: add missed blank

Fabian Frederick (1):
      power: constify of_device_id array

Geert Uytterhoeven (1):
      power: Use subdir-ccflags-* to inherit debug flag

Krzysztof Kozlowski (36):
      power_supply: rt5033: Constify struct regmap_config
      power_supply: max77693: Properly handle error conditions
      power_supply: max14577: Don't store charging and battery states for later
      power_supply: max14577: Properly handle error conditions
      power_supply: max17040: Use system efficient workqueues
      power_supply: max17042: Use regmap_update_bits instead read and write
      power_supply: twl4030_madc: Check return value of power_supply_register
      power_supply: ipaq_micro_battery: Fix leaking workqueue
      power_supply: ipaq_micro_battery: Check return values in probe
      power_supply: lp8788-charger: Fix leaked power supply on probe fail
      power_supply: ab8500_fg: Simplify creation and removal of sysfs entries
      compal-laptop: Fix leaking hwmon device
      compal-laptop: Check return value of power_supply_register
      power_supply: Add driver private data
      power_supply: Move run-time configuration to separate structure
      power_supply: Add API for safe access of power supply function attrs
      power_supply: sysfs: Use power_supply_*() API for accessing function attrs
      power_supply: 88pm860x_charger: Use power_supply_*() API for accessing function attrs
      power_supply: ab8500: Use power_supply_*() API for accessing function attrs
      mfd: ab8500: Use power_supply_*() API for accessing function attrs
      power_supply: apm_power: Use power_supply_*() API for accessing function attrs
      power_supply: bq2415x_charger: Use power_supply_*() API for accessing function attrs
      power_supply: charger-manager: Use power_supply_*() API for accessing function attrs
      power_supply: Change ownership from driver to core
      power_supply: Add power_supply_put for decrementing device reference counter
      power_supply: Increment power supply use counter when obtaining references
      power_supply: charger-manager: Decrement the power supply's device reference counter
      x86/olpc/xo1/sci: Use newly added power_supply_put API
      x86/olpc/xo15/sci: Use newly added power_supply_put API
      power_supply: 88pm860x_charger: Decrement the power supply's device reference counter
      power_supply: bq2415x_charger: Decrement the power supply's device reference counter
      mfd: ab8500: Decrement the power supply's device reference counter
      arm: mach-pxa: Decrement the power supply's device reference counter
      power_supply: 88pm860x_charger: Fix possible NULL pointer dereference and use of initialized variable
      HID: input: Fix NULL pointer dereference when power_supply_register fails
      power_supply: charger-manager: Fix dereferencing of ERR_PTR

Marek Belisko (2):
      power: twl4030-madc-battery: Convert to iio consumer.
      power: twl4030_madc_battery: Add missing MODULE_ALIAS

Mike Looijmans (2):
      power: ltc2941-battery-gauge: Fix typo in conversion formula (58 instead of 85)
      power: ltc2941-battery-gauge: Fix typo in conversion formula (58 instead of 85)

Moritz Fischer (2):
      power: reset: Add generic SYSCON register mapped poweroff.
      dt: power: Add docs for generic SYSCON poweroff driver.

NeilBrown (2):
      bq27x00_battery: register as non-wakeup power supply.
      power_supply core: support use of devres to register/unregister a power supply.

Nicholas Mc Guire (2):
      ab8500_fg: match return type of wait_for_completion_timeout
      ab8500_fg: use jiffies_to_msecs for jiffies conversion

Nicolas Saenz Julienne (1):
      power: generic-adc-battery: Fix power_supply_property returned value

Pavel Machek (1):
      bq2415x_charger, bq27x00_battery.c: comment cleanups

Richard Weinberger (1):
      power/reset/rmobile-reset.c: Fix !HAS_IOMEM build

Sebastian Reichel (2):
      Merge branch 'da9150-charger-fuelgauge' into next
      Merge branch 'fixes' into next

Todd Brandt (2):
      mfd/axp20x: change battery cell name to fuel gauge
      X-Power AXP288 PMIC Fuel Gauge Driver

Valentin Rothberg (2):
      power/smb347-charger.c: set IRQF_ONESHOT flag to ensure IRQ request
      ab8500_fg.c: only request threaded IRQs when necessary

 Documentation/devicetree/bindings/iio/adc/da9150-gpadc.txt        |   16 ++
 Documentation/devicetree/bindings/power/da9150-charger.txt        |   26 +++
 Documentation/devicetree/bindings/power/reset/syscon-poweroff.txt |   23 +++
 MAINTAINERS                                                       |    4 +
 arch/arm/mach-pxa/raumfeld.c                                      |    4 +-
 arch/x86/platform/olpc/olpc-xo1-sci.c                             |    4 +-
 arch/x86/platform/olpc/olpc-xo15-sci.c                            |    4 +-
 drivers/acpi/ac.c                                                 |   32 +--
 drivers/acpi/battery.c                                            |   54 ++---
 drivers/acpi/sbs.c                                                |   68 ++++---
 drivers/hid/hid-input.c                                           |   53 +++--
 drivers/hid/hid-sony.c                                            |   43 ++--
 drivers/hid/hid-wiimote-modules.c                                 |   41 ++--
 drivers/hid/hid-wiimote.h                                         |    3 +-
 drivers/hid/wacom.h                                               |    8 +-
 drivers/hid/wacom_sys.c                                           |   70 ++++---
 drivers/iio/adc/Kconfig                                           |    9 +
 drivers/iio/adc/Makefile                                          |    1 +
 drivers/iio/adc/da9150-gpadc.c                                    |  407 ++++++++++++++++++++++++++++++++++++
 drivers/mfd/ab8500-sysctrl.c                                      |    9 +-
 drivers/mfd/axp20x.c                                              |    8 +-
 drivers/platform/x86/compal-laptop.c                              |   35 ++--
 drivers/power/88pm860x_battery.c                                  |   40 ++--
 drivers/power/88pm860x_charger.c                                  |   66 +++---
 drivers/power/Kconfig                                             |   21 ++
 drivers/power/Makefile                                            |    4 +-
 drivers/power/ab8500_btemp.c                                      |   75 ++++---
 drivers/power/ab8500_charger.c                                    |  139 +++++++------
 drivers/power/ab8500_fg.c                                         |  205 +++++++++----------
 drivers/power/abx500_chargalg.c                                   |   98 ++++-----
 drivers/power/apm_power.c                                         |    6 +-
 drivers/power/axp288_fuel_gauge.c                                 | 1154 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/power/bq2415x_charger.c                                   |  147 +++++++------
 drivers/power/bq24190_charger.c                                   |  103 +++++-----
 drivers/power/bq24735-charger.c                                   |   53 ++---
 drivers/power/bq27x00_battery.c                                   |  123 +++++++----
 drivers/power/charger-manager.c                                   |  161 +++++++++------
 drivers/power/collie_battery.c                                    |   75 ++++---
 drivers/power/da9030_battery.c                                    |   33 +--
 drivers/power/da9052-battery.c                                    |   25 ++-
 drivers/power/da9150-charger.c                                    |  694 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/power/ds2760_battery.c                                    |   56 ++---
 drivers/power/ds2780_battery.c                                    |   45 ++--
 drivers/power/ds2781_battery.c                                    |   47 +++--
 drivers/power/ds2782_battery.c                                    |   30 +--
 drivers/power/generic-adc-battery.c                               |   56 ++---
 drivers/power/goldfish_battery.c                                  |   63 +++---
 drivers/power/gpio-charger.c                                      |   42 ++--
 drivers/power/intel_mid_battery.c                                 |   57 +++---
 drivers/power/ipaq_micro_battery.c                                |   46 ++++-
 drivers/power/isp1704_charger.c                                   |   49 +++--
 drivers/power/jz4740-battery.c                                    |   37 ++--
 drivers/power/lp8727_charger.c                                    |   94 +++++----
 drivers/power/lp8788-charger.c                                    |   62 +++---
 drivers/power/ltc2941-battery-gauge.c                             |   53 ++---
 drivers/power/max14577_charger.c                                  |  148 +++++++++-----
 drivers/power/max17040_battery.c                                  |   40 ++--
 drivers/power/max17042_battery.c                                  |   90 ++++----
 drivers/power/max77693_charger.c                                  |  131 ++++++------
 drivers/power/max8903_charger.c                                   |   52 ++---
 drivers/power/max8925_power.c                                     |   98 +++++----
 drivers/power/max8997_charger.c                                   |   31 +--
 drivers/power/max8998_charger.c                                   |   32 +--
 drivers/power/olpc_battery.c                                      |   54 ++---
 drivers/power/pcf50633-charger.c                                  |  105 +++++-----
 drivers/power/pda_power.c                                         |   66 +++---
 drivers/power/pm2301_charger.c                                    |   48 +++--
 drivers/power/pm2301_charger.h                                    |    1 +
 drivers/power/pmu_battery.c                                       |   42 ++--
 drivers/power/power_supply_core.c                                 |  353 ++++++++++++++++++++++++++------
 drivers/power/power_supply_leds.c                                 |   25 +--
 drivers/power/power_supply_sysfs.c                                |   24 +--
 drivers/power/reset/Kconfig                                       |    8 +
 drivers/power/reset/Makefile                                      |    1 +
 drivers/power/reset/at91-poweroff.c                               |    2 +-
 drivers/power/reset/at91-reset.c                                  |   12 +-
 drivers/power/reset/hisi-reboot.c                                 |    2 +-
 drivers/power/reset/keystone-reset.c                              |    2 +-
 drivers/power/reset/st-poweroff.c                                 |    2 +-
 drivers/power/reset/syscon-poweroff.c                             |  102 ++++++++++
 drivers/power/reset/syscon-reboot.c                               |    2 +-
 drivers/power/reset/vexpress-poweroff.c                           |    2 +-
 drivers/power/reset/xgene-reboot.c                                |    2 +-
 drivers/power/rt5033_battery.c                                    |   29 +--
 drivers/power/rx51_battery.c                                      |   27 ++-
 drivers/power/s3c_adc_battery.c                                   |   77 +++----
 drivers/power/sbs-battery.c                                       |   71 +++----
 drivers/power/smb347-charger.c                                    |  111 +++++-----
 drivers/power/test_power.c                                        |   53 +++--
 drivers/power/tosa_battery.c                                      |  112 ++++++----
 drivers/power/tps65090-charger.c                                  |   45 ++--
 drivers/power/twl4030_charger.c                                   |   65 +++---
 drivers/power/twl4030_madc_battery.c                              |  135 +++++++-----
 drivers/power/wm831x_backup.c                                     |   26 ++-
 drivers/power/wm831x_power.c                                      |   95 +++++----
 drivers/power/wm8350_power.c                                      |   89 ++++----
 drivers/power/wm97xx_battery.c                                    |   37 ++--
 drivers/power/z2_battery.c                                        |   60 +++---
 drivers/staging/nvec/nvec_power.c                                 |   34 ++--
 include/linux/hid.h                                               |    6 +-
 include/linux/mfd/abx500/ux500_chargalg.h                         |   11 +-
 include/linux/mfd/rt5033.h                                        |    2 +-
 include/linux/mfd/wm8350/supply.h                                 |    6 +-
 include/linux/power/charger-manager.h                             |    3 +-
 include/linux/power/max17042_battery.h                            |    9 +-
 include/linux/power_supply.h                                      |   78 +++++--
 106 files changed, 5435 insertions(+), 2104 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/da9150-gpadc.txt
 create mode 100644 Documentation/devicetree/bindings/power/da9150-charger.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-poweroff.txt
 create mode 100644 drivers/iio/adc/da9150-gpadc.c
 create mode 100644 drivers/power/axp288_fuel_gauge.c
 create mode 100644 drivers/power/da9150-charger.c
 create mode 100644 drivers/power/reset/syscon-poweroff.c

-- Sebastian

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVK8YJAAoJENju1/PIO/qa5/AQAI++Wz5Ux3dlU+p9xWJQuW/r
tp6E5NIJ3xtt1zST6vpo2deG73cMGamMnUCPo1KnU+wkerLZ3lfYXVynZUt029D1
RG7FMPd8L0xdZaaKy++XQRlmfmIX5YPh5SysTEj48UAZdlrwYQyybFaQlpGXMInQ
eEq7wJ1o3Mxz2bnh1QMXaL6fzSfl24w4RdYD/1D4OTfqPz/3CjASyxKrZM8xnfrK
L7qZzqeQNzZ/xm6HmZUyidP/yjuiyIePng+ooDpanrmCja9ctpr8uK3y2BXYiehO
Wu5TUkjs9HZhCKLYN1sxt1dbjapN3cX3AQNA8stUv85kQyVow637KPB5liaLh5U8
de/zJNTW2m93YupL1CGqauXM4L7EjMNE033oyAWRcYQ0gPT0Rmp/nknbpNfDQ5u6
BHGUHPP4bW3bRoLWtANvHnJzTQZ1uPjyaeesSvvJlxtip3VdWqBxGWy2+uBgZDeS
SxJoFLUWjTwmWeJRBnKixuPHtZQ7Z6a28s/or9y6sajmZfUy3Vq7JB5EmavzK4yf
iS+Hcb5aVPY64qh73+Ljxdui3uEJoLHfWLv2tszVi25DrnjIbvZh5DPUA+UwJ5fg
B3t5Q+fVHPtcH97ZPkn4TKXRanALBtlckjvLW/iiIE842kbdCoNT2Xkxa3YLApAr
/yk40zAe/7pxbIMtqSOY
=7M1z
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
