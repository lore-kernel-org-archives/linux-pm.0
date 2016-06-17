From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 0/2] Move power supply subsystem to drivers/power/supply
Date: Fri, 17 Jun 2016 15:25:30 +0200
Message-ID: <1466169932-28031-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

More people are interested in using the drivers/power/ directory,
see for example pwrseq (https://patchwork.kernel.org/patch/9146309/).
Make it more appealing to do so by moving the power supply
subsystem into drivers/power/supply.

While at it also clean up the DT binding documentation
mess for the power supply subsystem.

-- Sebastian

Sebastian Reichel (2):
  power: move power supply drivers to power/supply
  power/supply: unify DT documentation

 .../{power_supply => power/reset}/axxia-reset.txt  |   0
 .../reset}/imx-snvs-poweroff.txt                   |   0
 .../{power_supply => power/reset}/msm-poweroff.txt |   0
 .../reset}/qnap-poweroff.txt                       |   0
 .../reset}/restart-poweroff.txt                    |   0
 .../supply}/ab8500/btemp.txt                       |   0
 .../supply}/ab8500/chargalg.txt                    |   0
 .../supply}/ab8500/charger.txt                     |   0
 .../{power_supply => power/supply}/ab8500/fg.txt   |   0
 .../power/{ => supply}/act8945a-charger.txt        |   0
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
 Documentation/power/power_supply_class.txt         |   4 +-
 MAINTAINERS                                        |  44 +-
 drivers/power/Kconfig                              | 516 +--------------------
 drivers/power/Makefile                             |  75 +--
 drivers/power/{ => supply}/88pm860x_battery.c      |   0
 drivers/power/{ => supply}/88pm860x_charger.c      |   0
 drivers/power/supply/Kconfig                       | 512 ++++++++++++++++++++
 drivers/power/supply/Makefile                      |  74 +++
 drivers/power/{ => supply}/ab8500_bmdata.c         |   0
 drivers/power/{ => supply}/ab8500_btemp.c          |   0
 drivers/power/{ => supply}/ab8500_charger.c        |   0
 drivers/power/{ => supply}/ab8500_fg.c             |   0
 drivers/power/{ => supply}/abx500_chargalg.c       |   0
 drivers/power/{ => supply}/act8945a_charger.c      |   0
 drivers/power/{ => supply}/apm_power.c             |   0
 drivers/power/{ => supply}/axp20x_usb_power.c      |   0
 drivers/power/{ => supply}/axp288_charger.c        |   0
 drivers/power/{ => supply}/axp288_fuel_gauge.c     |   0
 drivers/power/{ => supply}/bq2415x_charger.c       |   0
 drivers/power/{ => supply}/bq24190_charger.c       |   0
 drivers/power/{ => supply}/bq24257_charger.c       |   0
 drivers/power/{ => supply}/bq24735-charger.c       |   0
 drivers/power/{ => supply}/bq25890_charger.c       |   0
 drivers/power/{ => supply}/bq27xxx_battery.c       |   0
 drivers/power/{ => supply}/bq27xxx_battery_i2c.c   |   0
 drivers/power/{ => supply}/charger-manager.c       |   0
 drivers/power/{ => supply}/collie_battery.c        |   0
 drivers/power/{ => supply}/da9030_battery.c        |   0
 drivers/power/{ => supply}/da9052-battery.c        |   0
 drivers/power/{ => supply}/da9150-charger.c        |   0
 drivers/power/{ => supply}/da9150-fg.c             |   0
 drivers/power/{ => supply}/ds2760_battery.c        |   4 +-
 drivers/power/{ => supply}/ds2780_battery.c        |   4 +-
 drivers/power/{ => supply}/ds2781_battery.c        |   4 +-
 drivers/power/{ => supply}/ds2782_battery.c        |   0
 drivers/power/{ => supply}/generic-adc-battery.c   |   0
 drivers/power/{ => supply}/goldfish_battery.c      |   0
 drivers/power/{ => supply}/gpio-charger.c          |   0
 drivers/power/{ => supply}/intel_mid_battery.c     |   0
 drivers/power/{ => supply}/ipaq_micro_battery.c    |   0
 drivers/power/{ => supply}/isp1704_charger.c       |   0
 drivers/power/{ => supply}/jz4740-battery.c        |   0
 drivers/power/{ => supply}/lp8727_charger.c        |   0
 drivers/power/{ => supply}/lp8788-charger.c        |   0
 drivers/power/{ => supply}/ltc2941-battery-gauge.c |   0
 drivers/power/{ => supply}/max14577_charger.c      |   0
 drivers/power/{ => supply}/max17040_battery.c      |   0
 drivers/power/{ => supply}/max17042_battery.c      |   0
 drivers/power/{ => supply}/max77693_charger.c      |   0
 drivers/power/{ => supply}/max8903_charger.c       |   0
 drivers/power/{ => supply}/max8925_power.c         |   0
 drivers/power/{ => supply}/max8997_charger.c       |   0
 drivers/power/{ => supply}/max8998_charger.c       |   0
 drivers/power/{ => supply}/olpc_battery.c          |   0
 drivers/power/{ => supply}/pcf50633-charger.c      |   0
 drivers/power/{ => supply}/pda_power.c             |   0
 drivers/power/{ => supply}/pm2301_charger.c        |   0
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
 drivers/power/{ => supply}/sbs-battery.c           |   0
 drivers/power/{ => supply}/smb347-charger.c        |   0
 drivers/power/{ => supply}/test_power.c            |   0
 drivers/power/{ => supply}/tosa_battery.c          |   0
 drivers/power/{ => supply}/tps65090-charger.c      |   0
 drivers/power/{ => supply}/tps65217_charger.c      |   0
 drivers/power/{ => supply}/twl4030_charger.c       |   0
 drivers/power/{ => supply}/twl4030_madc_battery.c  |   0
 drivers/power/{ => supply}/wm831x_backup.c         |   0
 drivers/power/{ => supply}/wm831x_power.c          |   0
 drivers/power/{ => supply}/wm8350_power.c          |   0
 drivers/power/{ => supply}/wm97xx_battery.c        |   2 -
 drivers/power/{ => supply}/z2_battery.c            |   0
 115 files changed, 623 insertions(+), 616 deletions(-)
 rename Documentation/devicetree/bindings/{power_supply => power/reset}/axxia-reset.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/reset}/imx-snvs-poweroff.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/reset}/msm-poweroff.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/reset}/qnap-poweroff.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/reset}/restart-poweroff.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/supply}/ab8500/btemp.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/supply}/ab8500/chargalg.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/supply}/ab8500/charger.txt (100%)
 rename Documentation/devicetree/bindings/{power_supply => power/supply}/ab8500/fg.txt (100%)
 rename Documentation/devicetree/bindings/power/{ => supply}/act8945a-charger.txt (100%)
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
 rename drivers/power/{ => supply}/88pm860x_battery.c (100%)
 rename drivers/power/{ => supply}/88pm860x_charger.c (100%)
 create mode 100644 drivers/power/supply/Kconfig
 create mode 100644 drivers/power/supply/Makefile
 rename drivers/power/{ => supply}/ab8500_bmdata.c (100%)
 rename drivers/power/{ => supply}/ab8500_btemp.c (100%)
 rename drivers/power/{ => supply}/ab8500_charger.c (100%)
 rename drivers/power/{ => supply}/ab8500_fg.c (100%)
 rename drivers/power/{ => supply}/abx500_chargalg.c (100%)
 rename drivers/power/{ => supply}/act8945a_charger.c (100%)
 rename drivers/power/{ => supply}/apm_power.c (100%)
 rename drivers/power/{ => supply}/axp20x_usb_power.c (100%)
 rename drivers/power/{ => supply}/axp288_charger.c (100%)
 rename drivers/power/{ => supply}/axp288_fuel_gauge.c (100%)
 rename drivers/power/{ => supply}/bq2415x_charger.c (100%)
 rename drivers/power/{ => supply}/bq24190_charger.c (100%)
 rename drivers/power/{ => supply}/bq24257_charger.c (100%)
 rename drivers/power/{ => supply}/bq24735-charger.c (100%)
 rename drivers/power/{ => supply}/bq25890_charger.c (100%)
 rename drivers/power/{ => supply}/bq27xxx_battery.c (100%)
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
 rename drivers/power/{ => supply}/intel_mid_battery.c (100%)
 rename drivers/power/{ => supply}/ipaq_micro_battery.c (100%)
 rename drivers/power/{ => supply}/isp1704_charger.c (100%)
 rename drivers/power/{ => supply}/jz4740-battery.c (100%)
 rename drivers/power/{ => supply}/lp8727_charger.c (100%)
 rename drivers/power/{ => supply}/lp8788-charger.c (100%)
 rename drivers/power/{ => supply}/ltc2941-battery-gauge.c (100%)
 rename drivers/power/{ => supply}/max14577_charger.c (100%)
 rename drivers/power/{ => supply}/max17040_battery.c (100%)
 rename drivers/power/{ => supply}/max17042_battery.c (100%)
 rename drivers/power/{ => supply}/max77693_charger.c (100%)
 rename drivers/power/{ => supply}/max8903_charger.c (100%)
 rename drivers/power/{ => supply}/max8925_power.c (100%)
 rename drivers/power/{ => supply}/max8997_charger.c (100%)
 rename drivers/power/{ => supply}/max8998_charger.c (100%)
 rename drivers/power/{ => supply}/olpc_battery.c (100%)
 rename drivers/power/{ => supply}/pcf50633-charger.c (100%)
 rename drivers/power/{ => supply}/pda_power.c (100%)
 rename drivers/power/{ => supply}/pm2301_charger.c (100%)
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
 rename drivers/power/{ => supply}/sbs-battery.c (100%)
 rename drivers/power/{ => supply}/smb347-charger.c (100%)
 rename drivers/power/{ => supply}/test_power.c (100%)
 rename drivers/power/{ => supply}/tosa_battery.c (100%)
 rename drivers/power/{ => supply}/tps65090-charger.c (100%)
 rename drivers/power/{ => supply}/tps65217_charger.c (100%)
 rename drivers/power/{ => supply}/twl4030_charger.c (100%)
 rename drivers/power/{ => supply}/twl4030_madc_battery.c (100%)
 rename drivers/power/{ => supply}/wm831x_backup.c (100%)
 rename drivers/power/{ => supply}/wm831x_power.c (100%)
 rename drivers/power/{ => supply}/wm8350_power.c (100%)
 rename drivers/power/{ => supply}/wm97xx_battery.c (99%)
 rename drivers/power/{ => supply}/z2_battery.c (100%)

-- 
2.8.1
