From: Sebastian Reichel <sre@kernel.org>
Subject: [GIT PULL] power-supply changes for 4.9
Date: Thu, 6 Oct 2016 18:28:28 +0200
Message-ID: <20161006162827.nrtcxrn3pkhj7jlq@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xhlgiimvd62vql4r"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S942180AbcJFQ2h (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 6 Oct 2016 12:28:37 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--xhlgiimvd62vql4r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v4.9

for you to fetch changes up to 1d72706f0485b58e151b5a7584c4c65d66670587:

  power: supply: bq27xxx_battery: allow kernel poll_interval parameter runtime update (2016-09-21 02:08:04 +0200)

----------------------------------------------------------------
power supply and reset changes for the v4.9 series

 * move power supply drivers to drivers/power/supply
 * unify location of power supply DT documentation
 * tps65217-charger: IRQ support
 * act8945a-charger: misc. cleanups & improvements
 * sbs-battery cleanup
 * fix use of deprecated create_singlethread_workqueue()
 * misc fixes.

----------------------------------------------------------------
Andy Yan (1):
      power: reset: reboot-mode: fix build error of missing ioremap/iounmap on UM

Arnd Bergmann (1):
      power: supply: sbs-battery: simplify DT parsing

Arvind Yadav (3):
      power: reset: hisi-reboot: Unmap region obtained by of_iomap
      power: reset: xgene-reboot: Unmap region obtained by of_iomap
      power: reset: zx-reboot: Unmap region obtained by of_iomap

Bhaktipriya Shridhar (8):
      power: abx500_chargalg: Remove deprecated create_singlethread_workqueue
      power: ab8500_btemp: Remove deprecated create_singlethread_workqueue
      power: pm2301_charger: Remove deprecated create_singlethread_workqueue
      power: intel_mid_battery: Remove deprecated create_singlethread_workqueue
      power: ab8500_charger: Remove deprecated create_singlethread_workqueue
      power: ipaq_micro_battery: Remove deprecated create_singlethread_workqueue
      power: ab8500_fg: Remove deprecated create_singlethread_workqueue
      power: ds2760_battery: Remove deprecated create_singlethread_workqueue

Bjorn Andersson (2):
      power: reset: reboot-mode: Add managed resource API
      power: reset: syscon-reboot-mode: Use managed resource API

Colin Ian King (1):
      power: reset: add in missing white space in error message text

Georges Savoundararadj (1):
      power: bq24257: Fix use of uninitialized pointer bq->charger

Guenter Roeck (1):
      sbs-battery: make writes to ManufacturerAccess optional

H. Nikolaus Schaller (1):
      power:bq27xxx: 27000/10 read FLAGS register as single

Joshua Clayton (1):
      sbs-battery: add ability to get battery capacity

Krzysztof Kozlowski (1):
      power: supply: Change Krzysztof Kozlowski's email to kernel.org

Marcin Niestroj (1):
      power_supply: tps65217-charger: Add support for IRQs

Masahiro Yamada (1):
      power: supply: ab8500: cleanup with list_first_entry_or_null()

Matt Ranostay (1):
      power: supply: bq27xxx_battery: allow kernel poll_interval parameter runtime update

Paul Kocialkowski (2):
      power: bq24735-charger: Assume not charging when charger is missing
      power: supply: bq24735-charger: Request status GPIO with initial input setup

Peter Griffin (2):
      power: reset: st-poweroff: Remove obsolete platforms.
      power: reset: st: Remove obsolete platforms from dt doc

Phil Reid (5):
      power: sbs-battery: Use devm_kzalloc to alloc data
      power: sbs-battery: Request threaded irq and fix dev callback cookie
      power: sbs-battery: Use devm_power_supply_register
      power: supply: sbs-battery: Use gpio_desc and sleeping calls for battery detect
      power: supply: sbs-battery: Cleanup removal of chip->pdata

Sebastian Reichel (5):
      power: move power supply drivers to power/supply
      power/supply: unify DT documentation
      Merge tag 'for-v4.8-rc' into psy-next
      MAINTAINERS: update power-supply git-tree
      MAINTAINERS: Remove power-supply co-maintainers

Sven Van Asbroeck (1):
      power: supply: max17042_battery: fix model download bug.

Wei Yongjun (4):
      power_supply: tps65217-charger: fix missing platform_set_drvdata()
      power: z2_battery: remove .owner field for driver
      power: axp288_fuel_gauge: remove duplicated include from axp288_fuel_gauge.c
      power: axp288_charger: remove duplicated include from axp288_charger.c

Wenyou Yang (8):
      power: supply: act8945a_charger: Achieve properties from its node
      power: supply: act8945a_charger: Remove "battery_temperature"
      power: supply: act8945a_charger: Improve state handling
      power: supply: act8945a_charger: Add status change update support
      power: supply: act8945a_charger: Fix the power supply type
      doc: bindings: power: act8945a-charger: Update properties.
      power: supply: act8945a_charger: Add capacity level property
      power: supply: act8945a_charger: Add max current property

 CREDITS                                            |   4 +
 Documentation/ABI/testing/sysfs-class-power        |   8 +-
 .../devicetree/bindings/power/act8945a-charger.txt |  35 --
 .../{power_supply => power/reset}/axxia-reset.txt  |   0
 .../reset}/imx-snvs-poweroff.txt                   |   0
 .../{power_supply => power/reset}/msm-poweroff.txt |   0
 .../reset}/qnap-poweroff.txt                       |   0
 .../reset}/restart-poweroff.txt                    |   0
 .../devicetree/bindings/power/reset/st-reset.txt   |   7 +-
 .../supply}/ab8500/btemp.txt                       |   0
 .../supply}/ab8500/chargalg.txt                    |   0
 .../supply}/ab8500/charger.txt                     |   0
 .../{power_supply => power/supply}/ab8500/fg.txt   |   0
 .../bindings/power/supply/act8945a-charger.txt     |  48 ++
 .../supply}/axp20x_usb_power.txt                   |   0
 .../bindings/power/{ => supply}/bq2415x.txt        |   0
 .../bindings/power/{ => supply}/bq24257.txt        |   0
 .../bindings/power/{ => supply}/bq25890.txt        |   0
 .../supply}/charger-manager.txt                    |   0
 .../bindings/power/{ => supply}/da9150-charger.txt |   0
 .../bindings/power/{ => supply}/da9150-fg.txt      |   0
 .../supply}/gpio-charger.txt                       |   0
 .../bindings/power/{ => supply}/isp1704.txt        |   0
 .../supply}/lp8727_charger.txt                     |   0
 .../bindings/power/{ => supply}/ltc2941.txt        |   0
 .../supply}/max17042_battery.txt                   |   0
 .../supply}/max8925_batter.txt                     |   0
 .../supply}/olpc_battery.txt                       |   0
 .../supply}/power_supply.txt                       |   0
 .../power/{ => supply}/qcom,coincell-charger.txt   |   0
 .../{power_supply => power/supply}/qcom_smbb.txt   |   0
 .../bindings/power/{ => supply}/rt9455_charger.txt |   0
 .../bindings/power/{ => supply}/rx51-battery.txt   |   0
 .../supply}/sbs_sbs-battery.txt                    |   0
 .../{power_supply => power/supply}/ti,bq24735.txt  |   0
 .../{power_supply => power/supply}/tps65090.txt    |   0
 .../supply}/tps65217_charger.txt                   |   0
 .../bindings/power/{ => supply}/twl-charger.txt    |   0
 Documentation/driver-model/devres.txt              |   4 +
 Documentation/power/power_supply_class.txt         |   4 +-
 MAINTAINERS                                        |  46 +-
 drivers/power/Kconfig                              | 518 +---------------
 drivers/power/Makefile                             |  75 +--
 drivers/power/act8945a_charger.c                   | 359 -----------
 drivers/power/reset/Kconfig                        |   2 +-
 drivers/power/reset/hisi-reboot.c                  |   5 +-
 drivers/power/reset/keystone-reset.c               |   2 +-
 drivers/power/reset/reboot-mode.c                  |  59 ++
 drivers/power/reset/reboot-mode.h                  |   4 +
 drivers/power/reset/st-poweroff.c                  |  41 --
 drivers/power/reset/syscon-reboot-mode.c           |  12 +-
 drivers/power/reset/xgene-reboot.c                 |   4 +-
 drivers/power/reset/zx-reboot.c                    |   5 +-
 drivers/power/{ => supply}/88pm860x_battery.c      |   0
 drivers/power/{ => supply}/88pm860x_charger.c      |   0
 drivers/power/supply/Kconfig                       | 514 ++++++++++++++++
 drivers/power/supply/Makefile                      |  74 +++
 drivers/power/{ => supply}/ab8500_bmdata.c         |   0
 drivers/power/{ => supply}/ab8500_btemp.c          |   2 +-
 drivers/power/{ => supply}/ab8500_charger.c        |   4 +-
 drivers/power/{ => supply}/ab8500_fg.c             |  11 +-
 drivers/power/{ => supply}/abx500_chargalg.c       |   4 +-
 drivers/power/supply/act8945a_charger.c            | 666 +++++++++++++++++++++
 drivers/power/{ => supply}/apm_power.c             |   0
 drivers/power/{ => supply}/axp20x_usb_power.c      |   0
 drivers/power/{ => supply}/axp288_charger.c        |   1 -
 drivers/power/{ => supply}/axp288_fuel_gauge.c     |   1 -
 drivers/power/{ => supply}/bq2415x_charger.c       |   0
 drivers/power/{ => supply}/bq24190_charger.c       |   0
 drivers/power/{ => supply}/bq24257_charger.c       |  12 +-
 drivers/power/{ => supply}/bq24735-charger.c       |  45 +-
 drivers/power/{ => supply}/bq25890_charger.c       |   0
 drivers/power/{ => supply}/bq27xxx_battery.c       |  43 +-
 drivers/power/{ => supply}/bq27xxx_battery_i2c.c   |   0
 drivers/power/{ => supply}/charger-manager.c       |   0
 drivers/power/{ => supply}/collie_battery.c        |   0
 drivers/power/{ => supply}/da9030_battery.c        |   0
 drivers/power/{ => supply}/da9052-battery.c        |   0
 drivers/power/{ => supply}/da9150-charger.c        |   0
 drivers/power/{ => supply}/da9150-fg.c             |   0
 drivers/power/{ => supply}/ds2760_battery.c        |   7 +-
 drivers/power/{ => supply}/ds2780_battery.c        |   4 +-
 drivers/power/{ => supply}/ds2781_battery.c        |   4 +-
 drivers/power/{ => supply}/ds2782_battery.c        |   0
 drivers/power/{ => supply}/generic-adc-battery.c   |   0
 drivers/power/{ => supply}/goldfish_battery.c      |   0
 drivers/power/{ => supply}/gpio-charger.c          |   0
 drivers/power/{ => supply}/intel_mid_battery.c     |   3 +-
 drivers/power/{ => supply}/ipaq_micro_battery.c    |   2 +-
 drivers/power/{ => supply}/isp1704_charger.c       |   0
 drivers/power/{ => supply}/jz4740-battery.c        |   0
 drivers/power/{ => supply}/lp8727_charger.c        |   0
 drivers/power/{ => supply}/lp8788-charger.c        |   0
 drivers/power/{ => supply}/ltc2941-battery-gauge.c |   0
 drivers/power/{ => supply}/max14577_charger.c      |   4 +-
 drivers/power/{ => supply}/max17040_battery.c      |   0
 drivers/power/{ => supply}/max17042_battery.c      |  15 +-
 drivers/power/{ => supply}/max77693_charger.c      |   4 +-
 drivers/power/{ => supply}/max8903_charger.c       |   0
 drivers/power/{ => supply}/max8925_power.c         |   0
 drivers/power/{ => supply}/max8997_charger.c       |   0
 drivers/power/{ => supply}/max8998_charger.c       |   0
 drivers/power/{ => supply}/olpc_battery.c          |   0
 drivers/power/{ => supply}/pcf50633-charger.c      |   0
 drivers/power/{ => supply}/pda_power.c             |   0
 drivers/power/{ => supply}/pm2301_charger.c        |   3 +-
 drivers/power/{ => supply}/pm2301_charger.h        |   0
 drivers/power/{ => supply}/pmu_battery.c           |   0
 drivers/power/{ => supply}/power_supply.h          |   0
 drivers/power/{ => supply}/power_supply_core.c     |   0
 drivers/power/{ => supply}/power_supply_leds.c     |   0
 drivers/power/{ => supply}/power_supply_sysfs.c    |   0
 drivers/power/{ => supply}/qcom_smbb.c             |   0
 drivers/power/{ => supply}/rt5033_battery.c        |   0
 drivers/power/{ => supply}/rt9455_charger.c        |   0
 drivers/power/{ => supply}/rx51_battery.c          |   0
 drivers/power/{ => supply}/s3c_adc_battery.c       |   0
 drivers/power/{ => supply}/sbs-battery.c           | 254 +++-----
 drivers/power/{ => supply}/smb347-charger.c        |   0
 drivers/power/{ => supply}/test_power.c            |   0
 drivers/power/{ => supply}/tosa_battery.c          |   0
 drivers/power/{ => supply}/tps65090-charger.c      |   0
 drivers/power/{ => supply}/tps65217_charger.c      |  41 +-
 drivers/power/{ => supply}/twl4030_charger.c       |   0
 drivers/power/{ => supply}/twl4030_madc_battery.c  |   0
 drivers/power/{ => supply}/wm831x_backup.c         |   0
 drivers/power/{ => supply}/wm831x_power.c          |   0
 drivers/power/{ => supply}/wm8350_power.c          |   0
 drivers/power/{ => supply}/wm97xx_battery.c        |   2 -
 drivers/power/{ => supply}/z2_battery.c            |   1 -
 include/linux/power/bq24735-charger.h              |   4 -
 include/linux/power/bq27xxx_battery.h              |   1 +
 include/linux/power/sbs-battery.h                  |   8 +-
 133 files changed, 1653 insertions(+), 1323 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/act8945a-charger.txt
 rename Documentation/devicetree/bindings/{power_supply => power/reset}/axxia-reset.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/reset}/imx-snvs-poweroff.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/reset}/msm-poweroff.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/reset}/qnap-poweroff.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/reset}/restart-poweroff.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/supply}/ab8500/btemp.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/supply}/ab8500/chargalg.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/supply}/ab8500/charger.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/supply}/ab8500/fg.txt (100%)
 create mode 100644 Documentation/devicetree/bindings/power/supply/act8945a-charger.txt
 rename Documentation/devicetree/bindings/{power_supply => power/supply}/axp20x_usb_power.txt (100%)
 rename Documentation/devicetree/bindings/power/{ => supply}/bq2415x.txt (100%)
 rename Documentation/devicetree/bindings/power/{ => supply}/bq24257.txt (100%)
 rename Documentation/devicetree/bindings/power/{ => supply}/bq25890.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/supply}/charger-manager.txt (100%)
 rename Documentation/devicetree/bindings/power/{ => supply}/da9150-charger.txt (100%)
 rename Documentation/devicetree/bindings/power/{ => supply}/da9150-fg.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/supply}/gpio-charger.txt (100%)
 rename Documentation/devicetree/bindings/power/{ => supply}/isp1704.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/supply}/lp8727_charger.txt (100%)
 rename Documentation/devicetree/bindings/power/{ => supply}/ltc2941.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/supply}/max17042_battery.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/supply}/max8925_batter.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/supply}/olpc_battery.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/supply}/power_supply.txt (100%)
 rename Documentation/devicetree/bindings/power/{ => supply}/qcom,coincell-charger.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/supply}/qcom_smbb.txt (100%)
 rename Documentation/devicetree/bindings/power/{ => supply}/rt9455_charger.txt (100%)
 rename Documentation/devicetree/bindings/power/{ => supply}/rx51-battery.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/supply}/sbs_sbs-battery.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/supply}/ti,bq24735.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/supply}/tps65090.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/supply}/tps65217_charger.txt (100%)
 rename Documentation/devicetree/bindings/power/{ => supply}/twl-charger.txt (100%)
 delete mode 100644 drivers/power/act8945a_charger.c
 rename drivers/power/{ => supply}/88pm860x_battery.c (100%)
 rename drivers/power/{ => supply}/88pm860x_charger.c (100%)
 create mode 100644 drivers/power/supply/Kconfig
 create mode 100644 drivers/power/supply/Makefile
 rename drivers/power/{ => supply}/ab8500_bmdata.c (100%)
 rename drivers/power/{ => supply}/ab8500_btemp.c (99%)
 rename drivers/power/{ => supply}/ab8500_charger.c (99%)
 rename drivers/power/{ => supply}/ab8500_fg.c (99%)
 rename drivers/power/{ => supply}/abx500_chargalg.c (99%)
 create mode 100644 drivers/power/supply/act8945a_charger.c
 rename drivers/power/{ => supply}/apm_power.c (100%)
 rename drivers/power/{ => supply}/axp20x_usb_power.c (100%)
 rename drivers/power/{ => supply}/axp288_charger.c (99%)
 rename drivers/power/{ => supply}/axp288_fuel_gauge.c (99%)
 rename drivers/power/{ => supply}/bq2415x_charger.c (100%)
 rename drivers/power/{ => supply}/bq24190_charger.c (100%)
 rename drivers/power/{ => supply}/bq24257_charger.c (100%)
 rename drivers/power/{ => supply}/bq24735-charger.c (92%)
 rename drivers/power/{ => supply}/bq25890_charger.c (100%)
 rename drivers/power/{ => supply}/bq27xxx_battery.c (96%)
 rename drivers/power/{ => supply}/bq27xxx_battery_i2c.c (100%)
 rename drivers/power/{ => supply}/charger-manager.c (100%)
 rename drivers/power/{ => supply}/collie_battery.c (100%)
 rename drivers/power/{ => supply}/da9030_battery.c (100%)
 rename drivers/power/{ => supply}/da9052-battery.c (100%)
 rename drivers/power/{ => supply}/da9150-charger.c (100%)
 rename drivers/power/{ => supply}/da9150-fg.c (100%)
 rename drivers/power/{ => supply}/ds2760_battery.c (99%)
 rename drivers/power/{ => supply}/ds2780_battery.c (99%)
 rename drivers/power/{ => supply}/ds2781_battery.c (99%)
 rename drivers/power/{ => supply}/ds2782_battery.c (100%)
 rename drivers/power/{ => supply}/generic-adc-battery.c (100%)
 rename drivers/power/{ => supply}/goldfish_battery.c (100%)
 rename drivers/power/{ => supply}/gpio-charger.c (100%)
 rename drivers/power/{ => supply}/intel_mid_battery.c (99%)
 rename drivers/power/{ => supply}/ipaq_micro_battery.c (99%)
 rename drivers/power/{ => supply}/isp1704_charger.c (100%)
 rename drivers/power/{ => supply}/jz4740-battery.c (100%)
 rename drivers/power/{ => supply}/lp8727_charger.c (100%)
 rename drivers/power/{ => supply}/lp8788-charger.c (100%)
 rename drivers/power/{ => supply}/ltc2941-battery-gauge.c (100%)
 rename drivers/power/{ => supply}/max14577_charger.c (99%)
 rename drivers/power/{ => supply}/max17040_battery.c (100%)
 rename drivers/power/{ => supply}/max17042_battery.c (99%)
 rename drivers/power/{ => supply}/max77693_charger.c (99%)
 rename drivers/power/{ => supply}/max8903_charger.c (100%)
 rename drivers/power/{ => supply}/max8925_power.c (100%)
 rename drivers/power/{ => supply}/max8997_charger.c (100%)
 rename drivers/power/{ => supply}/max8998_charger.c (100%)
 rename drivers/power/{ => supply}/olpc_battery.c (100%)
 rename drivers/power/{ => supply}/pcf50633-charger.c (100%)
 rename drivers/power/{ => supply}/pda_power.c (100%)
 rename drivers/power/{ => supply}/pm2301_charger.c (99%)
 rename drivers/power/{ => supply}/pm2301_charger.h (100%)
 rename drivers/power/{ => supply}/pmu_battery.c (100%)
 rename drivers/power/{ => supply}/power_supply.h (100%)
 rename drivers/power/{ => supply}/power_supply_core.c (100%)
 rename drivers/power/{ => supply}/power_supply_leds.c (100%)
 rename drivers/power/{ => supply}/power_supply_sysfs.c (100%)
 rename drivers/power/{ => supply}/qcom_smbb.c (100%)
 rename drivers/power/{ => supply}/rt5033_battery.c (100%)
 rename drivers/power/{ => supply}/rt9455_charger.c (100%)
 rename drivers/power/{ => supply}/rx51_battery.c (100%)
 rename drivers/power/{ => supply}/s3c_adc_battery.c (100%)
 rename drivers/power/{ => supply}/sbs-battery.c (83%)
 rename drivers/power/{ => supply}/smb347-charger.c (100%)
 rename drivers/power/{ => supply}/test_power.c (100%)
 rename drivers/power/{ => supply}/tosa_battery.c (100%)
 rename drivers/power/{ => supply}/tps65090-charger.c (100%)
 rename drivers/power/{ => supply}/tps65217_charger.c (88%)
 rename drivers/power/{ => supply}/twl4030_charger.c (100%)
 rename drivers/power/{ => supply}/twl4030_madc_battery.c (100%)
 rename drivers/power/{ => supply}/wm831x_backup.c (100%)
 rename drivers/power/{ => supply}/wm831x_power.c (100%)
 rename drivers/power/{ => supply}/wm8350_power.c (100%)
 rename drivers/power/{ => supply}/wm97xx_battery.c (99%)
 rename drivers/power/{ => supply}/z2_battery.c (99%)

--xhlgiimvd62vql4r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJX9nunAAoJENju1/PIO/qaxSsP/RL4CGeve/1/yW8cyFAMeJoo
27I7/Vg9as328ThFvCd9kBC3MsCOAfeT9DAEhhZjOXyUv6yGCt4VDryDTxgSivYM
oDHLV5XLLFKEg2Fw23R7a57paeISJGYWOimEt4RNdWWgpUXYszxI5BXjpiPg9AIQ
hPOR1sfZTJVQ/36bFtDbePLQHg57DBPCrkxXJ75JyArjDxuZZ/ZhvcxaflGnlYE4
x2WyT28/HNG3h126cSe2nIMnh+JSYbuF0C226pToZ62Z8LrKHAXboeFKL7vHjtdN
26ssCe4ir4vXdnvJXhx4coyXV9JXt5HGBZAOVdmVjLNeiaGCnPIXZHKFZ84yPJLa
j3FnP9sbzm3jpYBGGVsnndp8w2iAd0EsOeWhPcRyvSvv1i/b3XQzWpX4c84HWqTF
7osp+LTU5fo9Fw9QR+tACpVLzv+7jovYnJAZX29l7p3i07RPd5SnVkyIk+VdpMtm
h0knVYCHMxBPKK/fUsYS8T1IdATTql4U5M2SnZINDKE1D/iUUGN1iM0ZJKcCEh5K
xHsFw5qvVdNjoZ5vpuwMmwI1L0JJLwhf3JGAU5tn9XUGem8bjmzdgw6+5zx1nN/n
T2XP4BRO/18VsCAOGwzDwpaImjKYLElETBQCqqqFStK/39aeAd/VLkHSg06L1ypU
FiSXOKHceVBmVXs2lHi9
=GEmA
-----END PGP SIGNATURE-----

--xhlgiimvd62vql4r--
