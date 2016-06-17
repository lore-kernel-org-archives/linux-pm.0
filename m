From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 1/2] power: move power supply drivers to power/supply
Date: Fri, 17 Jun 2016 15:25:31 +0200
Message-ID: <1466169932-28031-2-git-send-email-sre@kernel.org>
References: <1466169932-28031-1-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466169932-28031-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This moves all power supply drivers from drivers/power/
to drivers/power/supply/. The intention is a cleaner
source tree, since drivers/power/ also contains frameworks
unrelated to power supply, like adaptive voltage scaling.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 Documentation/power/power_supply_class.txt         |   4 +-
 MAINTAINERS                                        |  41 +-
 drivers/power/Kconfig                              | 516 +------------=
--------
 drivers/power/Makefile                             |  75 +--
 drivers/power/{ =3D> supply}/88pm860x_battery.c      |   0
 drivers/power/{ =3D> supply}/88pm860x_charger.c      |   0
 drivers/power/supply/Kconfig                       | 512 +++++++++++++=
+++++++
 drivers/power/supply/Makefile                      |  74 +++
 drivers/power/{ =3D> supply}/ab8500_bmdata.c         |   0
 drivers/power/{ =3D> supply}/ab8500_btemp.c          |   0
 drivers/power/{ =3D> supply}/ab8500_charger.c        |   0
 drivers/power/{ =3D> supply}/ab8500_fg.c             |   0
 drivers/power/{ =3D> supply}/abx500_chargalg.c       |   0
 drivers/power/{ =3D> supply}/act8945a_charger.c      |   0
 drivers/power/{ =3D> supply}/apm_power.c             |   0
 drivers/power/{ =3D> supply}/axp20x_usb_power.c      |   0
 drivers/power/{ =3D> supply}/axp288_charger.c        |   0
 drivers/power/{ =3D> supply}/axp288_fuel_gauge.c     |   0
 drivers/power/{ =3D> supply}/bq2415x_charger.c       |   0
 drivers/power/{ =3D> supply}/bq24190_charger.c       |   0
 drivers/power/{ =3D> supply}/bq24257_charger.c       |   0
 drivers/power/{ =3D> supply}/bq24735-charger.c       |   0
 drivers/power/{ =3D> supply}/bq25890_charger.c       |   0
 drivers/power/{ =3D> supply}/bq27xxx_battery.c       |   0
 drivers/power/{ =3D> supply}/bq27xxx_battery_i2c.c   |   0
 drivers/power/{ =3D> supply}/charger-manager.c       |   0
 drivers/power/{ =3D> supply}/collie_battery.c        |   0
 drivers/power/{ =3D> supply}/da9030_battery.c        |   0
 drivers/power/{ =3D> supply}/da9052-battery.c        |   0
 drivers/power/{ =3D> supply}/da9150-charger.c        |   0
 drivers/power/{ =3D> supply}/da9150-fg.c             |   0
 drivers/power/{ =3D> supply}/ds2760_battery.c        |   4 +-
 drivers/power/{ =3D> supply}/ds2780_battery.c        |   4 +-
 drivers/power/{ =3D> supply}/ds2781_battery.c        |   4 +-
 drivers/power/{ =3D> supply}/ds2782_battery.c        |   0
 drivers/power/{ =3D> supply}/generic-adc-battery.c   |   0
 drivers/power/{ =3D> supply}/goldfish_battery.c      |   0
 drivers/power/{ =3D> supply}/gpio-charger.c          |   0
 drivers/power/{ =3D> supply}/intel_mid_battery.c     |   0
 drivers/power/{ =3D> supply}/ipaq_micro_battery.c    |   0
 drivers/power/{ =3D> supply}/isp1704_charger.c       |   0
 drivers/power/{ =3D> supply}/jz4740-battery.c        |   0
 drivers/power/{ =3D> supply}/lp8727_charger.c        |   0
 drivers/power/{ =3D> supply}/lp8788-charger.c        |   0
 drivers/power/{ =3D> supply}/ltc2941-battery-gauge.c |   0
 drivers/power/{ =3D> supply}/max14577_charger.c      |   0
 drivers/power/{ =3D> supply}/max17040_battery.c      |   0
 drivers/power/{ =3D> supply}/max17042_battery.c      |   0
 drivers/power/{ =3D> supply}/max77693_charger.c      |   0
 drivers/power/{ =3D> supply}/max8903_charger.c       |   0
 drivers/power/{ =3D> supply}/max8925_power.c         |   0
 drivers/power/{ =3D> supply}/max8997_charger.c       |   0
 drivers/power/{ =3D> supply}/max8998_charger.c       |   0
 drivers/power/{ =3D> supply}/olpc_battery.c          |   0
 drivers/power/{ =3D> supply}/pcf50633-charger.c      |   0
 drivers/power/{ =3D> supply}/pda_power.c             |   0
 drivers/power/{ =3D> supply}/pm2301_charger.c        |   0
 drivers/power/{ =3D> supply}/pm2301_charger.h        |   0
 drivers/power/{ =3D> supply}/pmu_battery.c           |   0
 drivers/power/{ =3D> supply}/power_supply.h          |   0
 drivers/power/{ =3D> supply}/power_supply_core.c     |   0
 drivers/power/{ =3D> supply}/power_supply_leds.c     |   0
 drivers/power/{ =3D> supply}/power_supply_sysfs.c    |   0
 drivers/power/{ =3D> supply}/qcom_smbb.c             |   0
 drivers/power/{ =3D> supply}/rt5033_battery.c        |   0
 drivers/power/{ =3D> supply}/rt9455_charger.c        |   0
 drivers/power/{ =3D> supply}/rx51_battery.c          |   0
 drivers/power/{ =3D> supply}/s3c_adc_battery.c       |   0
 drivers/power/{ =3D> supply}/sbs-battery.c           |   0
 drivers/power/{ =3D> supply}/smb347-charger.c        |   0
 drivers/power/{ =3D> supply}/test_power.c            |   0
 drivers/power/{ =3D> supply}/tosa_battery.c          |   0
 drivers/power/{ =3D> supply}/tps65090-charger.c      |   0
 drivers/power/{ =3D> supply}/tps65217_charger.c      |   0
 drivers/power/{ =3D> supply}/twl4030_charger.c       |   0
 drivers/power/{ =3D> supply}/twl4030_madc_battery.c  |   0
 drivers/power/{ =3D> supply}/wm831x_backup.c         |   0
 drivers/power/{ =3D> supply}/wm831x_power.c          |   0
 drivers/power/{ =3D> supply}/wm8350_power.c          |   0
 drivers/power/{ =3D> supply}/wm97xx_battery.c        |   2 -
 drivers/power/{ =3D> supply}/z2_battery.c            |   0
 81 files changed, 622 insertions(+), 614 deletions(-)
 rename drivers/power/{ =3D> supply}/88pm860x_battery.c (100%)
 rename drivers/power/{ =3D> supply}/88pm860x_charger.c (100%)
 create mode 100644 drivers/power/supply/Kconfig
 create mode 100644 drivers/power/supply/Makefile
 rename drivers/power/{ =3D> supply}/ab8500_bmdata.c (100%)
 rename drivers/power/{ =3D> supply}/ab8500_btemp.c (100%)
 rename drivers/power/{ =3D> supply}/ab8500_charger.c (100%)
 rename drivers/power/{ =3D> supply}/ab8500_fg.c (100%)
 rename drivers/power/{ =3D> supply}/abx500_chargalg.c (100%)
 rename drivers/power/{ =3D> supply}/act8945a_charger.c (100%)
 rename drivers/power/{ =3D> supply}/apm_power.c (100%)
 rename drivers/power/{ =3D> supply}/axp20x_usb_power.c (100%)
 rename drivers/power/{ =3D> supply}/axp288_charger.c (100%)
 rename drivers/power/{ =3D> supply}/axp288_fuel_gauge.c (100%)
 rename drivers/power/{ =3D> supply}/bq2415x_charger.c (100%)
 rename drivers/power/{ =3D> supply}/bq24190_charger.c (100%)
 rename drivers/power/{ =3D> supply}/bq24257_charger.c (100%)
 rename drivers/power/{ =3D> supply}/bq24735-charger.c (100%)
 rename drivers/power/{ =3D> supply}/bq25890_charger.c (100%)
 rename drivers/power/{ =3D> supply}/bq27xxx_battery.c (100%)
 rename drivers/power/{ =3D> supply}/bq27xxx_battery_i2c.c (100%)
 rename drivers/power/{ =3D> supply}/charger-manager.c (100%)
 rename drivers/power/{ =3D> supply}/collie_battery.c (100%)
 rename drivers/power/{ =3D> supply}/da9030_battery.c (100%)
 rename drivers/power/{ =3D> supply}/da9052-battery.c (100%)
 rename drivers/power/{ =3D> supply}/da9150-charger.c (100%)
 rename drivers/power/{ =3D> supply}/da9150-fg.c (100%)
 rename drivers/power/{ =3D> supply}/ds2760_battery.c (99%)
 rename drivers/power/{ =3D> supply}/ds2780_battery.c (99%)
 rename drivers/power/{ =3D> supply}/ds2781_battery.c (99%)
 rename drivers/power/{ =3D> supply}/ds2782_battery.c (100%)
 rename drivers/power/{ =3D> supply}/generic-adc-battery.c (100%)
 rename drivers/power/{ =3D> supply}/goldfish_battery.c (100%)
 rename drivers/power/{ =3D> supply}/gpio-charger.c (100%)
 rename drivers/power/{ =3D> supply}/intel_mid_battery.c (100%)
 rename drivers/power/{ =3D> supply}/ipaq_micro_battery.c (100%)
 rename drivers/power/{ =3D> supply}/isp1704_charger.c (100%)
 rename drivers/power/{ =3D> supply}/jz4740-battery.c (100%)
 rename drivers/power/{ =3D> supply}/lp8727_charger.c (100%)
 rename drivers/power/{ =3D> supply}/lp8788-charger.c (100%)
 rename drivers/power/{ =3D> supply}/ltc2941-battery-gauge.c (100%)
 rename drivers/power/{ =3D> supply}/max14577_charger.c (100%)
 rename drivers/power/{ =3D> supply}/max17040_battery.c (100%)
 rename drivers/power/{ =3D> supply}/max17042_battery.c (100%)
 rename drivers/power/{ =3D> supply}/max77693_charger.c (100%)
 rename drivers/power/{ =3D> supply}/max8903_charger.c (100%)
 rename drivers/power/{ =3D> supply}/max8925_power.c (100%)
 rename drivers/power/{ =3D> supply}/max8997_charger.c (100%)
 rename drivers/power/{ =3D> supply}/max8998_charger.c (100%)
 rename drivers/power/{ =3D> supply}/olpc_battery.c (100%)
 rename drivers/power/{ =3D> supply}/pcf50633-charger.c (100%)
 rename drivers/power/{ =3D> supply}/pda_power.c (100%)
 rename drivers/power/{ =3D> supply}/pm2301_charger.c (100%)
 rename drivers/power/{ =3D> supply}/pm2301_charger.h (100%)
 rename drivers/power/{ =3D> supply}/pmu_battery.c (100%)
 rename drivers/power/{ =3D> supply}/power_supply.h (100%)
 rename drivers/power/{ =3D> supply}/power_supply_core.c (100%)
 rename drivers/power/{ =3D> supply}/power_supply_leds.c (100%)
 rename drivers/power/{ =3D> supply}/power_supply_sysfs.c (100%)
 rename drivers/power/{ =3D> supply}/qcom_smbb.c (100%)
 rename drivers/power/{ =3D> supply}/rt5033_battery.c (100%)
 rename drivers/power/{ =3D> supply}/rt9455_charger.c (100%)
 rename drivers/power/{ =3D> supply}/rx51_battery.c (100%)
 rename drivers/power/{ =3D> supply}/s3c_adc_battery.c (100%)
 rename drivers/power/{ =3D> supply}/sbs-battery.c (100%)
 rename drivers/power/{ =3D> supply}/smb347-charger.c (100%)
 rename drivers/power/{ =3D> supply}/test_power.c (100%)
 rename drivers/power/{ =3D> supply}/tosa_battery.c (100%)
 rename drivers/power/{ =3D> supply}/tps65090-charger.c (100%)
 rename drivers/power/{ =3D> supply}/tps65217_charger.c (100%)
 rename drivers/power/{ =3D> supply}/twl4030_charger.c (100%)
 rename drivers/power/{ =3D> supply}/twl4030_madc_battery.c (100%)
 rename drivers/power/{ =3D> supply}/wm831x_backup.c (100%)
 rename drivers/power/{ =3D> supply}/wm831x_power.c (100%)
 rename drivers/power/{ =3D> supply}/wm8350_power.c (100%)
 rename drivers/power/{ =3D> supply}/wm97xx_battery.c (99%)
 rename drivers/power/{ =3D> supply}/z2_battery.c (100%)

diff --git a/Documentation/power/power_supply_class.txt b/Documentation=
/power/power_supply_class.txt
index 82dacc06e355..0c72588bd967 100644
--- a/Documentation/power/power_supply_class.txt
+++ b/Documentation/power/power_supply_class.txt
@@ -39,8 +39,8 @@ kind of power supply, and can process/present them to=
 a user in consistent
 manner. Results for different power supplies and machines are also dir=
ectly
 comparable.
=20
-See drivers/power/ds2760_battery.c and drivers/power/pda_power.c for t=
he
-example how to declare and handle attributes.
+See drivers/power/supply/ds2760_battery.c and drivers/power/supply/pda=
_power.c
+for the example how to declare and handle attributes.
=20
=20
 Units
diff --git a/MAINTAINERS b/MAINTAINERS
index c96354e04275..a5a6705f34e7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3679,8 +3679,8 @@ F:	drivers/leds/leds-da90??.c
 F:	drivers/mfd/da903x.c
 F:	drivers/mfd/da90??-*.c
 F:	drivers/mfd/da91??-*.c
-F:	drivers/power/da9052-battery.c
-F:	drivers/power/da91??-*.c
+F:	drivers/power/supply/da9052-battery.c
+F:	drivers/power/supply/da91??-*.c
 F:	drivers/regulator/da903x.c
 F:	drivers/regulator/da9???-regulator.[ch]
 F:	drivers/rtc/rtc-da90??.c
@@ -7257,8 +7257,8 @@ MAXIM MUIC CHARGER DRIVERS FOR EXYNOS BASED BOARD=
S
 M:	Krzysztof Kozlowski <k.kozlowski@samsung.com>
 L:	linux-pm@vger.kernel.org
 S:	Supported
-F:	drivers/power/max14577_charger.c
-F:	drivers/power/max77693_charger.c
+F:	drivers/power/supply/max14577_charger.c
+F:	drivers/power/supply/max77693_charger.c
=20
 MAXIM MAX77802 MULTIFUNCTION PMIC DEVICE DRIVERS
 M:	Javier Martinez Canillas <javier@osg.samsung.com>
@@ -8092,11 +8092,11 @@ R:	Pali Roh=C3=A1r <pali.rohar@gmail.com>
 F:	include/linux/power/bq2415x_charger.h
 F:	include/linux/power/bq27xxx_battery.h
 F:	include/linux/power/isp1704_charger.h
-F:	drivers/power/bq2415x_charger.c
-F:	drivers/power/bq27xxx_battery.c
-F:	drivers/power/bq27xxx_battery_i2c.c
-F:	drivers/power/isp1704_charger.c
-F:	drivers/power/rx51_battery.c
+F:	drivers/power/supply/bq2415x_charger.c
+F:	drivers/power/supply/bq27xxx_battery.c
+F:	drivers/power/supply/bq27xxx_battery_i2c.c
+F:	drivers/power/supply/isp1704_charger.c
+F:	drivers/power/supply/rx51_battery.c
=20
 NTB DRIVER CORE
 M:	Jon Mason <jdmason@kudzu.us>
@@ -9069,8 +9069,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/power/
 F:	Documentation/devicetree/bindings/power_supply/
 F:	include/linux/power_supply.h
-F:	drivers/power/
-X:	drivers/power/avs/
+F:	drivers/power/supply/
=20
 POWER STATE COORDINATION INTERFACE (PSCI)
 M:	Mark Rutland <mark.rutland@arm.com>
@@ -10032,8 +10031,8 @@ F:	drivers/thunderbolt/
 TI BQ27XXX POWER SUPPLY DRIVER
 R:	Andrew F. Davis <afd@ti.com>
 F:	include/linux/power/bq27xxx_battery.h
-F:	drivers/power/bq27xxx_battery.c
-F:	drivers/power/bq27xxx_battery_i2c.c
+F:	drivers/power/supply/bq27xxx_battery.c
+F:	drivers/power/supply/bq27xxx_battery_i2c.c
=20
 TIMEKEEPING, CLOCKSOURCE CORE, NTP, ALARMTIMER
 M:	John Stultz <john.stultz@linaro.org>
@@ -11028,6 +11027,16 @@ T:	git git://git.kernel.org/pub/scm/linux/kern=
el/git/lee/mfd.git
 S:	Supported
 F:	drivers/mfd/syscon.c
=20
+SYSTEM RESET/SHUTDOWN DRIVERS
+M:	Sebastian Reichel <sre@kernel.org>
+M:	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
+M:	David Woodhouse <dwmw2@infradead.org>
+L:	linux-pm@vger.kernel.org
+T:	git git://git.infradead.org/battery-2.6.git
+S:	Maintained
+F:	Documentation/devicetree/bindings/power/reset/
+F:	drivers/power/reset/
+
 SYSV FILESYSTEM
 M:	Christoph Hellwig <hch@infradead.org>
 S:	Maintained
@@ -11379,7 +11388,7 @@ F:	include/linux/platform_data/lp855x.h
 TI LP8727 CHARGER DRIVER
 M:	Milo Kim <milo.kim@ti.com>
 S:	Maintained
-F:	drivers/power/lp8727_charger.c
+F:	drivers/power/supply/lp8727_charger.c
 F:	include/linux/platform_data/lp8727.h
=20
 TI LP8788 MFD DRIVER
@@ -11388,7 +11397,7 @@ S:	Maintained
 F:	drivers/iio/adc/lp8788_adc.c
 F:	drivers/leds/leds-lp8788.c
 F:	drivers/mfd/lp8788*.c
-F:	drivers/power/lp8788-charger.c
+F:	drivers/power/supply/lp8788-charger.c
 F:	drivers/regulator/lp8788-*.c
 F:	include/linux/mfd/lp8788*.h
=20
@@ -12442,7 +12451,7 @@ F:	drivers/input/touchscreen/wm97*.c
 F:	drivers/mfd/arizona*
 F:	drivers/mfd/wm*.c
 F:	drivers/mfd/cs47l24*
-F:	drivers/power/wm83*.c
+F:	drivers/power/supply/wm83*.c
 F:	drivers/rtc/rtc-wm83*.c
 F:	drivers/regulator/wm8*.c
 F:	drivers/video/backlight/wm83*_bl.c
diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 421770ddafa3..63454b5cac27 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -1,515 +1,3 @@
-menuconfig POWER_SUPPLY
-	bool "Power supply class support"
-	help
-	  Say Y here to enable power supply class support. This allows
-	  power supply (batteries, AC, USB) monitoring by userspace
-	  via sysfs and uevent (if available) and/or APM kernel interface
-	  (if selected below).
-
-if POWER_SUPPLY
-
-config POWER_SUPPLY_DEBUG
-	bool "Power supply debug"
-	help
-	  Say Y here to enable debugging messages for power supply class
-	  and drivers.
-
-config PDA_POWER
-	tristate "Generic PDA/phone power driver"
-	depends on !S390
-	help
-	  Say Y here to enable generic power driver for PDAs and phones with
-	  one or two external power supplies (AC/USB) connected to main and
-	  backup batteries, and optional builtin charger.
-
-config APM_POWER
-	tristate "APM emulation for class batteries"
-	depends on APM_EMULATION
-	help
-	  Say Y here to enable support APM status emulation using
-	  battery class devices.
-
-config GENERIC_ADC_BATTERY
-	tristate "Generic battery support using IIO"
-	depends on IIO
-	help
-	  Say Y here to enable support for the generic battery driver
-	  which uses IIO framework to read adc.
-
-config MAX8925_POWER
-	tristate "MAX8925 battery charger support"
-	depends on MFD_MAX8925
-	help
-	  Say Y here to enable support for the battery charger in the Maxim
-	  MAX8925 PMIC.
-
-config WM831X_BACKUP
-	tristate "WM831X backup battery charger support"
-	depends on MFD_WM831X
-	help
-	  Say Y here to enable support for the backup battery charger
-	  in the Wolfson Microelectronics WM831x PMICs.
-
-config WM831X_POWER
-	tristate "WM831X PMU support"
-	depends on MFD_WM831X
-	help
-	  Say Y here to enable support for the power management unit
-	  provided by Wolfson Microelectronics WM831x PMICs.
-
-config WM8350_POWER
-        tristate "WM8350 PMU support"
-        depends on MFD_WM8350
-        help
-          Say Y here to enable support for the power management unit
-	  provided by the Wolfson Microelectronics WM8350 PMIC.
-
-config TEST_POWER
-	tristate "Test power driver"
-	help
-	  This driver is used for testing. It's safe to say M here.
-
-config BATTERY_88PM860X
-	tristate "Marvell 88PM860x battery driver"
-	depends on MFD_88PM860X
-	help
-	  Say Y here to enable battery monitor for Marvell 88PM860x chip.
-
-config BATTERY_ACT8945A
-	tristate "Active-semi ACT8945A charger driver"
-	depends on MFD_ACT8945A || COMPILE_TEST
-	help
-	  Say Y here to enable support for power supply provided by
-	  Active-semi ActivePath ACT8945A charger.
-
-config BATTERY_DS2760
-	tristate "DS2760 battery driver (HP iPAQ & others)"
-	depends on W1 && W1_SLAVE_DS2760
-	help
-	  Say Y here to enable support for batteries with ds2760 chip.
-
-config BATTERY_DS2780
-	tristate "DS2780 battery driver"
-	depends on HAS_IOMEM
-	select W1
-	select W1_SLAVE_DS2780
-	help
-	  Say Y here to enable support for batteries with ds2780 chip.
-
-config BATTERY_DS2781
-	tristate "DS2781 battery driver"
-	depends on HAS_IOMEM
-	select W1
-	select W1_SLAVE_DS2781
-	help
-	  If you enable this you will have the DS2781 battery driver support.
-
-	  The battery monitor chip is used in many batteries/devices
-	  as the one who is responsible for charging/discharging/monitoring
-	  Li+ batteries.
-
-	  If you are unsure, say N.
-
-config BATTERY_DS2782
-	tristate "DS2782/DS2786 standalone gas-gauge"
-	depends on I2C
-	help
-	  Say Y here to enable support for the DS2782/DS2786 standalone batte=
ry
-	  gas-gauge.
-
-config BATTERY_PMU
-	tristate "Apple PMU battery"
-	depends on PPC32 && ADB_PMU
-	help
-	  Say Y here to expose battery information on Apple machines
-	  through the generic battery class.
-
-config BATTERY_OLPC
-	tristate "One Laptop Per Child battery"
-	depends on X86_32 && OLPC
-	help
-	  Say Y to enable support for the battery on the OLPC laptop.
-
-config BATTERY_TOSA
-	tristate "Sharp SL-6000 (tosa) battery"
-	depends on MACH_TOSA && MFD_TC6393XB && TOUCHSCREEN_WM97XX
-	help
-	  Say Y to enable support for the battery on the Sharp Zaurus
-	  SL-6000 (tosa) models.
-
-config BATTERY_COLLIE
-	tristate "Sharp SL-5500 (collie) battery"
-	depends on SA1100_COLLIE && MCP_UCB1200
-	help
-	  Say Y to enable support for the battery on the Sharp Zaurus
-	  SL-5500 (collie) models.
-
-config BATTERY_IPAQ_MICRO
-	tristate "iPAQ Atmel Micro ASIC battery driver"
-	depends on MFD_IPAQ_MICRO
-	help
-	  Choose this option if you want to monitor battery status on
-	  Compaq/HP iPAQ h3100 and h3600.
-
-config BATTERY_WM97XX
-	bool "WM97xx generic battery driver"
-	depends on TOUCHSCREEN_WM97XX=3Dy
-	help
-	  Say Y to enable support for battery measured by WM97xx aux port.
-
-config BATTERY_SBS
-        tristate "SBS Compliant gas gauge"
-        depends on I2C
-        help
-	  Say Y to include support for SBS battery driver for SBS-compliant
-	  gas gauges.
-
-config BATTERY_BQ27XXX
-	tristate "BQ27xxx battery driver"
-	help
-	  Say Y here to enable support for batteries with BQ27xxx chips.
-
-config BATTERY_BQ27XXX_I2C
-	tristate "BQ27xxx I2C support"
-	depends on BATTERY_BQ27XXX
-	depends on I2C
-	default y
-	help
-	  Say Y here to enable support for batteries with BQ27xxx chips
-	  connected over an I2C bus.
-
-config BATTERY_DA9030
-	tristate "DA9030 battery driver"
-	depends on PMIC_DA903X
-	help
-	  Say Y here to enable support for batteries charger integrated into
-	  DA9030 PMIC.
-
-config BATTERY_DA9052
-	tristate "Dialog DA9052 Battery"
-	depends on PMIC_DA9052
-	help
-	  Say Y here to enable support for batteries charger integrated into
-	  DA9052 PMIC.
-
-config CHARGER_DA9150
-	tristate "Dialog Semiconductor DA9150 Charger support"
-	depends on MFD_DA9150
-	depends on DA9150_GPADC
-	depends on IIO
-	help
-	  Say Y here to enable support for charger unit of the DA9150
-	  Integrated Charger & Fuel-Gauge IC.
-
-	  This driver can also be built as a module. If so, the module will b=
e
-	  called da9150-charger.
-
-config BATTERY_DA9150
-	tristate "Dialog Semiconductor DA9150 Fuel Gauge support"
-	depends on MFD_DA9150
-	help
-	  Say Y here to enable support for the Fuel-Gauge unit of the DA9150
-	  Integrated Charger & Fuel-Gauge IC
-
-	  This driver can also be built as a module. If so, the module will b=
e
-	  called da9150-fg.
-
-config AXP288_CHARGER
-	tristate "X-Powers AXP288 Charger"
-	depends on MFD_AXP20X && EXTCON_AXP288
-	help
-	  Say yes here to have support X-Power AXP288 power management IC (PM=
IC)
-	  integrated charger.
-
-config AXP288_FUEL_GAUGE
-	tristate "X-Powers AXP288 Fuel Gauge"
-	depends on MFD_AXP20X && IIO
-	help
-	  Say yes here to have support for X-Power power management IC (PMIC)
-	  Fuel Gauge. The device provides battery statistics and status
-	  monitoring as well as alerts for battery over/under voltage and
-	  over/under temperature.
-
-config BATTERY_MAX17040
-	tristate "Maxim MAX17040 Fuel Gauge"
-	depends on I2C
-	help
-	  MAX17040 is fuel-gauge systems for lithium-ion (Li+) batteries
-	  in handheld and portable equipment. The MAX17040 is configured
-	  to operate with a single lithium cell
-
-config BATTERY_MAX17042
-	tristate "Maxim MAX17042/17047/17050/8997/8966 Fuel Gauge"
-	depends on I2C
-	select REGMAP_I2C
-	help
-	  MAX17042 is fuel-gauge systems for lithium-ion (Li+) batteries
-	  in handheld and portable equipment. The MAX17042 is configured
-	  to operate with a single lithium cell. MAX8997 and MAX8966 are
-	  multi-function devices that include fuel gauages that are compatibl=
e
-	  with MAX17042. This driver also supports max17047/50 chips which ar=
e
-	  improved version of max17042.
-
-config BATTERY_Z2
-	tristate "Z2 battery driver"
-	depends on I2C && MACH_ZIPIT2
-	help
-	  Say Y to include support for the battery on the Zipit Z2.
-
-config BATTERY_S3C_ADC
-	tristate "Battery driver for Samsung ADC based monitoring"
-	depends on S3C_ADC
-	help
-	  Say Y here to enable support for iPAQ h1930/h1940/rx1950 battery
-
-config BATTERY_TWL4030_MADC
-	tristate "TWL4030 MADC battery driver"
-	depends on TWL4030_MADC
-	help
-	  Say Y here to enable this dumb driver for batteries managed
-	  through the TWL4030 MADC.
-
-config CHARGER_88PM860X
-	tristate "Marvell 88PM860x Charger driver"
-	depends on MFD_88PM860X && BATTERY_88PM860X
-	help
-	  Say Y here to enable charger for Marvell 88PM860x chip.
-
-config CHARGER_PCF50633
-	tristate "NXP PCF50633 MBC"
-	depends on MFD_PCF50633
-	help
-	 Say Y to include support for NXP PCF50633 Main Battery Charger.
-
-config BATTERY_JZ4740
-	tristate "Ingenic JZ4740 battery"
-	depends on MACH_JZ4740
-	depends on MFD_JZ4740_ADC
-	help
-	  Say Y to enable support for the battery on Ingenic JZ4740 based
-	  boards.
-
-	  This driver can be build as a module. If so, the module will be
-	  called jz4740-battery.
-
-config BATTERY_INTEL_MID
-	tristate "Battery driver for Intel MID platforms"
-	depends on INTEL_SCU_IPC && SPI
-	help
-	  Say Y here to enable the battery driver on Intel MID
-	  platforms.
-
-config BATTERY_RX51
-	tristate "Nokia RX-51 (N900) battery driver"
-	depends on TWL4030_MADC
-	help
-	  Say Y here to enable support for battery information on Nokia
-	  RX-51, also known as N900 tablet.
-
-config CHARGER_ISP1704
-	tristate "ISP1704 USB Charger Detection"
-	depends on USB_PHY
-	help
-	  Say Y to enable support for USB Charger Detection with
-	  ISP1707/ISP1704 USB transceivers.
-
-config CHARGER_MAX8903
-	tristate "MAX8903 Battery DC-DC Charger for USB and Adapter Power"
-	help
-	  Say Y to enable support for the MAX8903 DC-DC charger and sysfs.
-	  The driver supports controlling charger-enable and current-limit
-	  pins based on the status of charger connections with interrupt
-	  handlers.
-
-config CHARGER_TWL4030
-	tristate "OMAP TWL4030 BCI charger driver"
-	depends on IIO && TWL4030_CORE
-	help
-	  Say Y here to enable support for TWL4030 Battery Charge Interface.
-
-config CHARGER_LP8727
-	tristate "TI/National Semiconductor LP8727 charger driver"
-	depends on I2C
-	help
-	  Say Y here to enable support for LP8727 Charger Driver.
-
-config CHARGER_LP8788
-	tristate "TI LP8788 charger driver"
-	depends on MFD_LP8788
-	depends on LP8788_ADC
-	depends on IIO
-	help
-	  Say Y to enable support for the LP8788 linear charger.
-
-config CHARGER_GPIO
-	tristate "GPIO charger"
-	depends on GPIOLIB || COMPILE_TEST
-	help
-	  Say Y to include support for chargers which report their online sta=
tus
-	  through a GPIO pin.
-
-	  This driver can be build as a module. If so, the module will be
-	  called gpio-charger.
-
-config CHARGER_MANAGER
-	bool "Battery charger manager for multiple chargers"
-	depends on REGULATOR
-	select EXTCON
-	help
-          Say Y to enable charger-manager support, which allows multip=
le
-          chargers attached to a battery and multiple batteries attach=
ed to a
-          system. The charger-manager also can monitor charging status=
 in
-          runtime and in suspend-to-RAM by waking up the system period=
ically
-          with help of suspend_again support.
-
-config CHARGER_MAX14577
-	tristate "Maxim MAX14577/77836 battery charger driver"
-	depends on MFD_MAX14577
-	help
-	  Say Y to enable support for the battery charger control sysfs and
-	  platform data of MAX14577/77836 MUICs.
-
-config CHARGER_MAX77693
-	tristate "Maxim MAX77693 battery charger driver"
-	depends on MFD_MAX77693
-	help
-	  Say Y to enable support for the Maxim MAX77693 battery charger.
-
-config CHARGER_MAX8997
-	tristate "Maxim MAX8997/MAX8966 PMIC battery charger driver"
-	depends on MFD_MAX8997 && REGULATOR_MAX8997
-	help
-	  Say Y to enable support for the battery charger control sysfs and
-	  platform data of MAX8997/LP3974 PMICs.
-
-config CHARGER_MAX8998
-	tristate "Maxim MAX8998/LP3974 PMIC battery charger driver"
-	depends on MFD_MAX8998 && REGULATOR_MAX8998
-	help
-	  Say Y to enable support for the battery charger control sysfs and
-	  platform data of MAX8998/LP3974 PMICs.
-
-config CHARGER_QCOM_SMBB
-	tristate "Qualcomm Switch-Mode Battery Charger and Boost"
-	depends on MFD_SPMI_PMIC || COMPILE_TEST
-	depends on OF
-	help
-	  Say Y to include support for the Switch-Mode Battery Charger and
-	  Boost (SMBB) hardware found in Qualcomm PM8941 PMICs.  The charger
-	  is an integrated, single-cell lithium-ion battery charger.  DT
-	  configuration is required for loading, see the devicetree
-	  documentation for more detail.  The base name for this driver is
-	  'pm8941_charger'.
-
-config CHARGER_BQ2415X
-	tristate "TI BQ2415x battery charger driver"
-	depends on I2C
-	help
-	  Say Y to enable support for the TI BQ2415x battery charger
-	  PMICs.
-
-	  You'll need this driver to charge batteries on e.g. Nokia
-	  RX-51/N900.
-
-config CHARGER_BQ24190
-	tristate "TI BQ24190 battery charger driver"
-	depends on I2C
-	depends on GPIOLIB || COMPILE_TEST
-	help
-	  Say Y to enable support for the TI BQ24190 battery charger.
-
-config CHARGER_BQ24257
-	tristate "TI BQ24250/24251/24257 battery charger driver"
-	depends on I2C
-	depends on GPIOLIB || COMPILE_TEST
-	depends on REGMAP_I2C
-	help
-	  Say Y to enable support for the TI BQ24250, BQ24251, and BQ24257 ba=
ttery
-	  chargers.
-
-config CHARGER_BQ24735
-	tristate "TI BQ24735 battery charger support"
-	depends on I2C
-	depends on GPIOLIB || COMPILE_TEST
-	help
-	  Say Y to enable support for the TI BQ24735 battery charger.
-
-config CHARGER_BQ25890
-	tristate "TI BQ25890 battery charger driver"
-	depends on I2C
-	depends on GPIOLIB || COMPILE_TEST
-	select REGMAP_I2C
-	help
-	  Say Y to enable support for the TI BQ25890 battery charger.
-
-config CHARGER_SMB347
-	tristate "Summit Microelectronics SMB347 Battery Charger"
-	depends on I2C
-	select REGMAP_I2C
-	help
-	  Say Y to include support for Summit Microelectronics SMB347
-	  Battery Charger.
-
-config CHARGER_TPS65090
-	tristate "TPS65090 battery charger driver"
-	depends on MFD_TPS65090
-	help
-	 Say Y here to enable support for battery charging with TPS65090
-	 PMIC chips.
-
-config CHARGER_TPS65217
-	tristate "TPS65217 battery charger driver"
-	depends on MFD_TPS65217
-	help
-	 Say Y here to enable support for battery charging with TPS65217
-	 PMIC chips.
-
-config BATTERY_GAUGE_LTC2941
-	tristate "LTC2941/LTC2943 Battery Gauge Driver"
-	depends on I2C
-	help
-	  Say Y here to include support for LTC2941 and LTC2943 Battery
-	  Gauge IC. The driver reports the charge count continuously, and
-	  measures the voltage and temperature every 10 seconds.
-
-config AB8500_BM
-	bool "AB8500 Battery Management Driver"
-	depends on AB8500_CORE && AB8500_GPADC
-	help
-	  Say Y to include support for AB8500 battery management.
-
-config BATTERY_GOLDFISH
-	tristate "Goldfish battery driver"
-	depends on GOLDFISH || COMPILE_TEST
-	depends on HAS_IOMEM
-	help
-	  Say Y to enable support for the battery and AC power in the
-	  Goldfish emulator.
-
-config BATTERY_RT5033
-	tristate "RT5033 fuel gauge support"
-	depends on MFD_RT5033
-	help
-	  This adds support for battery fuel gauge in Richtek RT5033 PMIC.
-	  The fuelgauge calculates and determines the battery state of charge
-	  according to battery open circuit voltage.
-
-config CHARGER_RT9455
-	tristate "Richtek RT9455 battery charger driver"
-	depends on I2C
-	depends on GPIOLIB || COMPILE_TEST
-	select REGMAP_I2C
-	help
-	  Say Y to enable support for Richtek RT9455 battery charger.
-
-config AXP20X_POWER
-	tristate "AXP20x power supply driver"
-	depends on MFD_AXP20X
-	help
-	  This driver provides support for the power supply features of
-	  AXP20x PMIC.
-
-endif # POWER_SUPPLY
-
-source "drivers/power/reset/Kconfig"
 source "drivers/power/avs/Kconfig"
+source "drivers/power/reset/Kconfig"
+source "drivers/power/supply/Kconfig"
diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index e46b75d448a5..ff35c712d824 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -1,76 +1,3 @@
-subdir-ccflags-$(CONFIG_POWER_SUPPLY_DEBUG) :=3D -DDEBUG
-
-power_supply-y				:=3D power_supply_core.o
-power_supply-$(CONFIG_SYSFS)		+=3D power_supply_sysfs.o
-power_supply-$(CONFIG_LEDS_TRIGGERS)	+=3D power_supply_leds.o
-
-obj-$(CONFIG_POWER_SUPPLY)	+=3D power_supply.o
-obj-$(CONFIG_GENERIC_ADC_BATTERY)	+=3D generic-adc-battery.o
-
-obj-$(CONFIG_PDA_POWER)		+=3D pda_power.o
-obj-$(CONFIG_APM_POWER)		+=3D apm_power.o
-obj-$(CONFIG_AXP20X_POWER)	+=3D axp20x_usb_power.o
-obj-$(CONFIG_MAX8925_POWER)	+=3D max8925_power.o
-obj-$(CONFIG_WM831X_BACKUP)	+=3D wm831x_backup.o
-obj-$(CONFIG_WM831X_POWER)	+=3D wm831x_power.o
-obj-$(CONFIG_WM8350_POWER)	+=3D wm8350_power.o
-obj-$(CONFIG_TEST_POWER)	+=3D test_power.o
-
-obj-$(CONFIG_BATTERY_88PM860X)	+=3D 88pm860x_battery.o
-obj-$(CONFIG_BATTERY_ACT8945A)	+=3D act8945a_charger.o
-obj-$(CONFIG_BATTERY_DS2760)	+=3D ds2760_battery.o
-obj-$(CONFIG_BATTERY_DS2780)	+=3D ds2780_battery.o
-obj-$(CONFIG_BATTERY_DS2781)	+=3D ds2781_battery.o
-obj-$(CONFIG_BATTERY_DS2782)	+=3D ds2782_battery.o
-obj-$(CONFIG_BATTERY_GAUGE_LTC2941)	+=3D ltc2941-battery-gauge.o
-obj-$(CONFIG_BATTERY_GOLDFISH)	+=3D goldfish_battery.o
-obj-$(CONFIG_BATTERY_PMU)	+=3D pmu_battery.o
-obj-$(CONFIG_BATTERY_OLPC)	+=3D olpc_battery.o
-obj-$(CONFIG_BATTERY_TOSA)	+=3D tosa_battery.o
-obj-$(CONFIG_BATTERY_COLLIE)	+=3D collie_battery.o
-obj-$(CONFIG_BATTERY_IPAQ_MICRO) +=3D ipaq_micro_battery.o
-obj-$(CONFIG_BATTERY_WM97XX)	+=3D wm97xx_battery.o
-obj-$(CONFIG_BATTERY_SBS)	+=3D sbs-battery.o
-obj-$(CONFIG_BATTERY_BQ27XXX)	+=3D bq27xxx_battery.o
-obj-$(CONFIG_BATTERY_BQ27XXX_I2C) +=3D bq27xxx_battery_i2c.o
-obj-$(CONFIG_BATTERY_DA9030)	+=3D da9030_battery.o
-obj-$(CONFIG_BATTERY_DA9052)	+=3D da9052-battery.o
-obj-$(CONFIG_CHARGER_DA9150)	+=3D da9150-charger.o
-obj-$(CONFIG_BATTERY_DA9150)	+=3D da9150-fg.o
-obj-$(CONFIG_BATTERY_MAX17040)	+=3D max17040_battery.o
-obj-$(CONFIG_BATTERY_MAX17042)	+=3D max17042_battery.o
-obj-$(CONFIG_BATTERY_Z2)	+=3D z2_battery.o
-obj-$(CONFIG_BATTERY_RT5033)	+=3D rt5033_battery.o
-obj-$(CONFIG_CHARGER_RT9455)	+=3D rt9455_charger.o
-obj-$(CONFIG_BATTERY_S3C_ADC)	+=3D s3c_adc_battery.o
-obj-$(CONFIG_BATTERY_TWL4030_MADC)	+=3D twl4030_madc_battery.o
-obj-$(CONFIG_CHARGER_88PM860X)	+=3D 88pm860x_charger.o
-obj-$(CONFIG_CHARGER_PCF50633)	+=3D pcf50633-charger.o
-obj-$(CONFIG_BATTERY_JZ4740)	+=3D jz4740-battery.o
-obj-$(CONFIG_BATTERY_INTEL_MID)	+=3D intel_mid_battery.o
-obj-$(CONFIG_BATTERY_RX51)	+=3D rx51_battery.o
-obj-$(CONFIG_AB8500_BM)		+=3D ab8500_bmdata.o ab8500_charger.o ab8500_=
fg.o ab8500_btemp.o abx500_chargalg.o pm2301_charger.o
-obj-$(CONFIG_CHARGER_ISP1704)	+=3D isp1704_charger.o
-obj-$(CONFIG_CHARGER_MAX8903)	+=3D max8903_charger.o
-obj-$(CONFIG_CHARGER_TWL4030)	+=3D twl4030_charger.o
-obj-$(CONFIG_CHARGER_LP8727)	+=3D lp8727_charger.o
-obj-$(CONFIG_CHARGER_LP8788)	+=3D lp8788-charger.o
-obj-$(CONFIG_CHARGER_GPIO)	+=3D gpio-charger.o
-obj-$(CONFIG_CHARGER_MANAGER)	+=3D charger-manager.o
-obj-$(CONFIG_CHARGER_MAX14577)	+=3D max14577_charger.o
-obj-$(CONFIG_CHARGER_MAX77693)	+=3D max77693_charger.o
-obj-$(CONFIG_CHARGER_MAX8997)	+=3D max8997_charger.o
-obj-$(CONFIG_CHARGER_MAX8998)	+=3D max8998_charger.o
-obj-$(CONFIG_CHARGER_QCOM_SMBB)	+=3D qcom_smbb.o
-obj-$(CONFIG_CHARGER_BQ2415X)	+=3D bq2415x_charger.o
-obj-$(CONFIG_CHARGER_BQ24190)	+=3D bq24190_charger.o
-obj-$(CONFIG_CHARGER_BQ24257)	+=3D bq24257_charger.o
-obj-$(CONFIG_CHARGER_BQ24735)	+=3D bq24735-charger.o
-obj-$(CONFIG_CHARGER_BQ25890)	+=3D bq25890_charger.o
 obj-$(CONFIG_POWER_AVS)		+=3D avs/
-obj-$(CONFIG_CHARGER_SMB347)	+=3D smb347-charger.o
-obj-$(CONFIG_CHARGER_TPS65090)	+=3D tps65090-charger.o
-obj-$(CONFIG_CHARGER_TPS65217)	+=3D tps65217_charger.o
 obj-$(CONFIG_POWER_RESET)	+=3D reset/
-obj-$(CONFIG_AXP288_FUEL_GAUGE) +=3D axp288_fuel_gauge.o
-obj-$(CONFIG_AXP288_CHARGER)	+=3D axp288_charger.o
+obj-$(CONFIG_POWER_SUPPLY)	+=3D supply/
diff --git a/drivers/power/88pm860x_battery.c b/drivers/power/supply/88=
pm860x_battery.c
similarity index 100%
rename from drivers/power/88pm860x_battery.c
rename to drivers/power/supply/88pm860x_battery.c
diff --git a/drivers/power/88pm860x_charger.c b/drivers/power/supply/88=
pm860x_charger.c
similarity index 100%
rename from drivers/power/88pm860x_charger.c
rename to drivers/power/supply/88pm860x_charger.c
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfi=
g
new file mode 100644
index 000000000000..264c39d3b43b
--- /dev/null
+++ b/drivers/power/supply/Kconfig
@@ -0,0 +1,512 @@
+menuconfig POWER_SUPPLY
+	bool "Power supply class support"
+	help
+	  Say Y here to enable power supply class support. This allows
+	  power supply (batteries, AC, USB) monitoring by userspace
+	  via sysfs and uevent (if available) and/or APM kernel interface
+	  (if selected below).
+
+if POWER_SUPPLY
+
+config POWER_SUPPLY_DEBUG
+	bool "Power supply debug"
+	help
+	  Say Y here to enable debugging messages for power supply class
+	  and drivers.
+
+config PDA_POWER
+	tristate "Generic PDA/phone power driver"
+	depends on !S390
+	help
+	  Say Y here to enable generic power driver for PDAs and phones with
+	  one or two external power supplies (AC/USB) connected to main and
+	  backup batteries, and optional builtin charger.
+
+config APM_POWER
+	tristate "APM emulation for class batteries"
+	depends on APM_EMULATION
+	help
+	  Say Y here to enable support APM status emulation using
+	  battery class devices.
+
+config GENERIC_ADC_BATTERY
+	tristate "Generic battery support using IIO"
+	depends on IIO
+	help
+	  Say Y here to enable support for the generic battery driver
+	  which uses IIO framework to read adc.
+
+config MAX8925_POWER
+	tristate "MAX8925 battery charger support"
+	depends on MFD_MAX8925
+	help
+	  Say Y here to enable support for the battery charger in the Maxim
+	  MAX8925 PMIC.
+
+config WM831X_BACKUP
+	tristate "WM831X backup battery charger support"
+	depends on MFD_WM831X
+	help
+	  Say Y here to enable support for the backup battery charger
+	  in the Wolfson Microelectronics WM831x PMICs.
+
+config WM831X_POWER
+	tristate "WM831X PMU support"
+	depends on MFD_WM831X
+	help
+	  Say Y here to enable support for the power management unit
+	  provided by Wolfson Microelectronics WM831x PMICs.
+
+config WM8350_POWER
+        tristate "WM8350 PMU support"
+        depends on MFD_WM8350
+        help
+          Say Y here to enable support for the power management unit
+	  provided by the Wolfson Microelectronics WM8350 PMIC.
+
+config TEST_POWER
+	tristate "Test power driver"
+	help
+	  This driver is used for testing. It's safe to say M here.
+
+config BATTERY_88PM860X
+	tristate "Marvell 88PM860x battery driver"
+	depends on MFD_88PM860X
+	help
+	  Say Y here to enable battery monitor for Marvell 88PM860x chip.
+
+config BATTERY_ACT8945A
+	tristate "Active-semi ACT8945A charger driver"
+	depends on MFD_ACT8945A || COMPILE_TEST
+	help
+	  Say Y here to enable support for power supply provided by
+	  Active-semi ActivePath ACT8945A charger.
+
+config BATTERY_DS2760
+	tristate "DS2760 battery driver (HP iPAQ & others)"
+	depends on W1 && W1_SLAVE_DS2760
+	help
+	  Say Y here to enable support for batteries with ds2760 chip.
+
+config BATTERY_DS2780
+	tristate "DS2780 battery driver"
+	depends on HAS_IOMEM
+	select W1
+	select W1_SLAVE_DS2780
+	help
+	  Say Y here to enable support for batteries with ds2780 chip.
+
+config BATTERY_DS2781
+	tristate "DS2781 battery driver"
+	depends on HAS_IOMEM
+	select W1
+	select W1_SLAVE_DS2781
+	help
+	  If you enable this you will have the DS2781 battery driver support.
+
+	  The battery monitor chip is used in many batteries/devices
+	  as the one who is responsible for charging/discharging/monitoring
+	  Li+ batteries.
+
+	  If you are unsure, say N.
+
+config BATTERY_DS2782
+	tristate "DS2782/DS2786 standalone gas-gauge"
+	depends on I2C
+	help
+	  Say Y here to enable support for the DS2782/DS2786 standalone batte=
ry
+	  gas-gauge.
+
+config BATTERY_PMU
+	tristate "Apple PMU battery"
+	depends on PPC32 && ADB_PMU
+	help
+	  Say Y here to expose battery information on Apple machines
+	  through the generic battery class.
+
+config BATTERY_OLPC
+	tristate "One Laptop Per Child battery"
+	depends on X86_32 && OLPC
+	help
+	  Say Y to enable support for the battery on the OLPC laptop.
+
+config BATTERY_TOSA
+	tristate "Sharp SL-6000 (tosa) battery"
+	depends on MACH_TOSA && MFD_TC6393XB && TOUCHSCREEN_WM97XX
+	help
+	  Say Y to enable support for the battery on the Sharp Zaurus
+	  SL-6000 (tosa) models.
+
+config BATTERY_COLLIE
+	tristate "Sharp SL-5500 (collie) battery"
+	depends on SA1100_COLLIE && MCP_UCB1200
+	help
+	  Say Y to enable support for the battery on the Sharp Zaurus
+	  SL-5500 (collie) models.
+
+config BATTERY_IPAQ_MICRO
+	tristate "iPAQ Atmel Micro ASIC battery driver"
+	depends on MFD_IPAQ_MICRO
+	help
+	  Choose this option if you want to monitor battery status on
+	  Compaq/HP iPAQ h3100 and h3600.
+
+config BATTERY_WM97XX
+	bool "WM97xx generic battery driver"
+	depends on TOUCHSCREEN_WM97XX=3Dy
+	help
+	  Say Y to enable support for battery measured by WM97xx aux port.
+
+config BATTERY_SBS
+        tristate "SBS Compliant gas gauge"
+        depends on I2C
+        help
+	  Say Y to include support for SBS battery driver for SBS-compliant
+	  gas gauges.
+
+config BATTERY_BQ27XXX
+	tristate "BQ27xxx battery driver"
+	help
+	  Say Y here to enable support for batteries with BQ27xxx chips.
+
+config BATTERY_BQ27XXX_I2C
+	tristate "BQ27xxx I2C support"
+	depends on BATTERY_BQ27XXX
+	depends on I2C
+	default y
+	help
+	  Say Y here to enable support for batteries with BQ27xxx chips
+	  connected over an I2C bus.
+
+config BATTERY_DA9030
+	tristate "DA9030 battery driver"
+	depends on PMIC_DA903X
+	help
+	  Say Y here to enable support for batteries charger integrated into
+	  DA9030 PMIC.
+
+config BATTERY_DA9052
+	tristate "Dialog DA9052 Battery"
+	depends on PMIC_DA9052
+	help
+	  Say Y here to enable support for batteries charger integrated into
+	  DA9052 PMIC.
+
+config CHARGER_DA9150
+	tristate "Dialog Semiconductor DA9150 Charger support"
+	depends on MFD_DA9150
+	depends on DA9150_GPADC
+	depends on IIO
+	help
+	  Say Y here to enable support for charger unit of the DA9150
+	  Integrated Charger & Fuel-Gauge IC.
+
+	  This driver can also be built as a module. If so, the module will b=
e
+	  called da9150-charger.
+
+config BATTERY_DA9150
+	tristate "Dialog Semiconductor DA9150 Fuel Gauge support"
+	depends on MFD_DA9150
+	help
+	  Say Y here to enable support for the Fuel-Gauge unit of the DA9150
+	  Integrated Charger & Fuel-Gauge IC
+
+	  This driver can also be built as a module. If so, the module will b=
e
+	  called da9150-fg.
+
+config AXP288_CHARGER
+	tristate "X-Powers AXP288 Charger"
+	depends on MFD_AXP20X && EXTCON_AXP288
+	help
+	  Say yes here to have support X-Power AXP288 power management IC (PM=
IC)
+	  integrated charger.
+
+config AXP288_FUEL_GAUGE
+	tristate "X-Powers AXP288 Fuel Gauge"
+	depends on MFD_AXP20X && IIO
+	help
+	  Say yes here to have support for X-Power power management IC (PMIC)
+	  Fuel Gauge. The device provides battery statistics and status
+	  monitoring as well as alerts for battery over/under voltage and
+	  over/under temperature.
+
+config BATTERY_MAX17040
+	tristate "Maxim MAX17040 Fuel Gauge"
+	depends on I2C
+	help
+	  MAX17040 is fuel-gauge systems for lithium-ion (Li+) batteries
+	  in handheld and portable equipment. The MAX17040 is configured
+	  to operate with a single lithium cell
+
+config BATTERY_MAX17042
+	tristate "Maxim MAX17042/17047/17050/8997/8966 Fuel Gauge"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  MAX17042 is fuel-gauge systems for lithium-ion (Li+) batteries
+	  in handheld and portable equipment. The MAX17042 is configured
+	  to operate with a single lithium cell. MAX8997 and MAX8966 are
+	  multi-function devices that include fuel gauages that are compatibl=
e
+	  with MAX17042. This driver also supports max17047/50 chips which ar=
e
+	  improved version of max17042.
+
+config BATTERY_Z2
+	tristate "Z2 battery driver"
+	depends on I2C && MACH_ZIPIT2
+	help
+	  Say Y to include support for the battery on the Zipit Z2.
+
+config BATTERY_S3C_ADC
+	tristate "Battery driver for Samsung ADC based monitoring"
+	depends on S3C_ADC
+	help
+	  Say Y here to enable support for iPAQ h1930/h1940/rx1950 battery
+
+config BATTERY_TWL4030_MADC
+	tristate "TWL4030 MADC battery driver"
+	depends on TWL4030_MADC
+	help
+	  Say Y here to enable this dumb driver for batteries managed
+	  through the TWL4030 MADC.
+
+config CHARGER_88PM860X
+	tristate "Marvell 88PM860x Charger driver"
+	depends on MFD_88PM860X && BATTERY_88PM860X
+	help
+	  Say Y here to enable charger for Marvell 88PM860x chip.
+
+config CHARGER_PCF50633
+	tristate "NXP PCF50633 MBC"
+	depends on MFD_PCF50633
+	help
+	 Say Y to include support for NXP PCF50633 Main Battery Charger.
+
+config BATTERY_JZ4740
+	tristate "Ingenic JZ4740 battery"
+	depends on MACH_JZ4740
+	depends on MFD_JZ4740_ADC
+	help
+	  Say Y to enable support for the battery on Ingenic JZ4740 based
+	  boards.
+
+	  This driver can be build as a module. If so, the module will be
+	  called jz4740-battery.
+
+config BATTERY_INTEL_MID
+	tristate "Battery driver for Intel MID platforms"
+	depends on INTEL_SCU_IPC && SPI
+	help
+	  Say Y here to enable the battery driver on Intel MID
+	  platforms.
+
+config BATTERY_RX51
+	tristate "Nokia RX-51 (N900) battery driver"
+	depends on TWL4030_MADC
+	help
+	  Say Y here to enable support for battery information on Nokia
+	  RX-51, also known as N900 tablet.
+
+config CHARGER_ISP1704
+	tristate "ISP1704 USB Charger Detection"
+	depends on USB_PHY
+	help
+	  Say Y to enable support for USB Charger Detection with
+	  ISP1707/ISP1704 USB transceivers.
+
+config CHARGER_MAX8903
+	tristate "MAX8903 Battery DC-DC Charger for USB and Adapter Power"
+	help
+	  Say Y to enable support for the MAX8903 DC-DC charger and sysfs.
+	  The driver supports controlling charger-enable and current-limit
+	  pins based on the status of charger connections with interrupt
+	  handlers.
+
+config CHARGER_TWL4030
+	tristate "OMAP TWL4030 BCI charger driver"
+	depends on IIO && TWL4030_CORE
+	help
+	  Say Y here to enable support for TWL4030 Battery Charge Interface.
+
+config CHARGER_LP8727
+	tristate "TI/National Semiconductor LP8727 charger driver"
+	depends on I2C
+	help
+	  Say Y here to enable support for LP8727 Charger Driver.
+
+config CHARGER_LP8788
+	tristate "TI LP8788 charger driver"
+	depends on MFD_LP8788
+	depends on LP8788_ADC
+	depends on IIO
+	help
+	  Say Y to enable support for the LP8788 linear charger.
+
+config CHARGER_GPIO
+	tristate "GPIO charger"
+	depends on GPIOLIB || COMPILE_TEST
+	help
+	  Say Y to include support for chargers which report their online sta=
tus
+	  through a GPIO pin.
+
+	  This driver can be build as a module. If so, the module will be
+	  called gpio-charger.
+
+config CHARGER_MANAGER
+	bool "Battery charger manager for multiple chargers"
+	depends on REGULATOR
+	select EXTCON
+	help
+          Say Y to enable charger-manager support, which allows multip=
le
+          chargers attached to a battery and multiple batteries attach=
ed to a
+          system. The charger-manager also can monitor charging status=
 in
+          runtime and in suspend-to-RAM by waking up the system period=
ically
+          with help of suspend_again support.
+
+config CHARGER_MAX14577
+	tristate "Maxim MAX14577/77836 battery charger driver"
+	depends on MFD_MAX14577
+	help
+	  Say Y to enable support for the battery charger control sysfs and
+	  platform data of MAX14577/77836 MUICs.
+
+config CHARGER_MAX77693
+	tristate "Maxim MAX77693 battery charger driver"
+	depends on MFD_MAX77693
+	help
+	  Say Y to enable support for the Maxim MAX77693 battery charger.
+
+config CHARGER_MAX8997
+	tristate "Maxim MAX8997/MAX8966 PMIC battery charger driver"
+	depends on MFD_MAX8997 && REGULATOR_MAX8997
+	help
+	  Say Y to enable support for the battery charger control sysfs and
+	  platform data of MAX8997/LP3974 PMICs.
+
+config CHARGER_MAX8998
+	tristate "Maxim MAX8998/LP3974 PMIC battery charger driver"
+	depends on MFD_MAX8998 && REGULATOR_MAX8998
+	help
+	  Say Y to enable support for the battery charger control sysfs and
+	  platform data of MAX8998/LP3974 PMICs.
+
+config CHARGER_QCOM_SMBB
+	tristate "Qualcomm Switch-Mode Battery Charger and Boost"
+	depends on MFD_SPMI_PMIC || COMPILE_TEST
+	depends on OF
+	help
+	  Say Y to include support for the Switch-Mode Battery Charger and
+	  Boost (SMBB) hardware found in Qualcomm PM8941 PMICs.  The charger
+	  is an integrated, single-cell lithium-ion battery charger.  DT
+	  configuration is required for loading, see the devicetree
+	  documentation for more detail.  The base name for this driver is
+	  'pm8941_charger'.
+
+config CHARGER_BQ2415X
+	tristate "TI BQ2415x battery charger driver"
+	depends on I2C
+	help
+	  Say Y to enable support for the TI BQ2415x battery charger
+	  PMICs.
+
+	  You'll need this driver to charge batteries on e.g. Nokia
+	  RX-51/N900.
+
+config CHARGER_BQ24190
+	tristate "TI BQ24190 battery charger driver"
+	depends on I2C
+	depends on GPIOLIB || COMPILE_TEST
+	help
+	  Say Y to enable support for the TI BQ24190 battery charger.
+
+config CHARGER_BQ24257
+	tristate "TI BQ24250/24251/24257 battery charger driver"
+	depends on I2C
+	depends on GPIOLIB || COMPILE_TEST
+	depends on REGMAP_I2C
+	help
+	  Say Y to enable support for the TI BQ24250, BQ24251, and BQ24257 ba=
ttery
+	  chargers.
+
+config CHARGER_BQ24735
+	tristate "TI BQ24735 battery charger support"
+	depends on I2C
+	depends on GPIOLIB || COMPILE_TEST
+	help
+	  Say Y to enable support for the TI BQ24735 battery charger.
+
+config CHARGER_BQ25890
+	tristate "TI BQ25890 battery charger driver"
+	depends on I2C
+	depends on GPIOLIB || COMPILE_TEST
+	select REGMAP_I2C
+	help
+	  Say Y to enable support for the TI BQ25890 battery charger.
+
+config CHARGER_SMB347
+	tristate "Summit Microelectronics SMB347 Battery Charger"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say Y to include support for Summit Microelectronics SMB347
+	  Battery Charger.
+
+config CHARGER_TPS65090
+	tristate "TPS65090 battery charger driver"
+	depends on MFD_TPS65090
+	help
+	 Say Y here to enable support for battery charging with TPS65090
+	 PMIC chips.
+
+config CHARGER_TPS65217
+	tristate "TPS65217 battery charger driver"
+	depends on MFD_TPS65217
+	help
+	 Say Y here to enable support for battery charging with TPS65217
+	 PMIC chips.
+
+config BATTERY_GAUGE_LTC2941
+	tristate "LTC2941/LTC2943 Battery Gauge Driver"
+	depends on I2C
+	help
+	  Say Y here to include support for LTC2941 and LTC2943 Battery
+	  Gauge IC. The driver reports the charge count continuously, and
+	  measures the voltage and temperature every 10 seconds.
+
+config AB8500_BM
+	bool "AB8500 Battery Management Driver"
+	depends on AB8500_CORE && AB8500_GPADC
+	help
+	  Say Y to include support for AB8500 battery management.
+
+config BATTERY_GOLDFISH
+	tristate "Goldfish battery driver"
+	depends on GOLDFISH || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  Say Y to enable support for the battery and AC power in the
+	  Goldfish emulator.
+
+config BATTERY_RT5033
+	tristate "RT5033 fuel gauge support"
+	depends on MFD_RT5033
+	help
+	  This adds support for battery fuel gauge in Richtek RT5033 PMIC.
+	  The fuelgauge calculates and determines the battery state of charge
+	  according to battery open circuit voltage.
+
+config CHARGER_RT9455
+	tristate "Richtek RT9455 battery charger driver"
+	depends on I2C
+	depends on GPIOLIB || COMPILE_TEST
+	select REGMAP_I2C
+	help
+	  Say Y to enable support for Richtek RT9455 battery charger.
+
+config AXP20X_POWER
+	tristate "AXP20x power supply driver"
+	depends on MFD_AXP20X
+	help
+	  This driver provides support for the power supply features of
+	  AXP20x PMIC.
+
+endif # POWER_SUPPLY
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makef=
ile
new file mode 100644
index 000000000000..36c599d9a495
--- /dev/null
+++ b/drivers/power/supply/Makefile
@@ -0,0 +1,74 @@
+subdir-ccflags-$(CONFIG_POWER_SUPPLY_DEBUG) :=3D -DDEBUG
+
+power_supply-y				:=3D power_supply_core.o
+power_supply-$(CONFIG_SYSFS)		+=3D power_supply_sysfs.o
+power_supply-$(CONFIG_LEDS_TRIGGERS)	+=3D power_supply_leds.o
+
+obj-$(CONFIG_POWER_SUPPLY)	+=3D power_supply.o
+obj-$(CONFIG_GENERIC_ADC_BATTERY)	+=3D generic-adc-battery.o
+
+obj-$(CONFIG_PDA_POWER)		+=3D pda_power.o
+obj-$(CONFIG_APM_POWER)		+=3D apm_power.o
+obj-$(CONFIG_AXP20X_POWER)	+=3D axp20x_usb_power.o
+obj-$(CONFIG_MAX8925_POWER)	+=3D max8925_power.o
+obj-$(CONFIG_WM831X_BACKUP)	+=3D wm831x_backup.o
+obj-$(CONFIG_WM831X_POWER)	+=3D wm831x_power.o
+obj-$(CONFIG_WM8350_POWER)	+=3D wm8350_power.o
+obj-$(CONFIG_TEST_POWER)	+=3D test_power.o
+
+obj-$(CONFIG_BATTERY_88PM860X)	+=3D 88pm860x_battery.o
+obj-$(CONFIG_BATTERY_ACT8945A)	+=3D act8945a_charger.o
+obj-$(CONFIG_BATTERY_DS2760)	+=3D ds2760_battery.o
+obj-$(CONFIG_BATTERY_DS2780)	+=3D ds2780_battery.o
+obj-$(CONFIG_BATTERY_DS2781)	+=3D ds2781_battery.o
+obj-$(CONFIG_BATTERY_DS2782)	+=3D ds2782_battery.o
+obj-$(CONFIG_BATTERY_GAUGE_LTC2941)	+=3D ltc2941-battery-gauge.o
+obj-$(CONFIG_BATTERY_GOLDFISH)	+=3D goldfish_battery.o
+obj-$(CONFIG_BATTERY_PMU)	+=3D pmu_battery.o
+obj-$(CONFIG_BATTERY_OLPC)	+=3D olpc_battery.o
+obj-$(CONFIG_BATTERY_TOSA)	+=3D tosa_battery.o
+obj-$(CONFIG_BATTERY_COLLIE)	+=3D collie_battery.o
+obj-$(CONFIG_BATTERY_IPAQ_MICRO) +=3D ipaq_micro_battery.o
+obj-$(CONFIG_BATTERY_WM97XX)	+=3D wm97xx_battery.o
+obj-$(CONFIG_BATTERY_SBS)	+=3D sbs-battery.o
+obj-$(CONFIG_BATTERY_BQ27XXX)	+=3D bq27xxx_battery.o
+obj-$(CONFIG_BATTERY_BQ27XXX_I2C) +=3D bq27xxx_battery_i2c.o
+obj-$(CONFIG_BATTERY_DA9030)	+=3D da9030_battery.o
+obj-$(CONFIG_BATTERY_DA9052)	+=3D da9052-battery.o
+obj-$(CONFIG_CHARGER_DA9150)	+=3D da9150-charger.o
+obj-$(CONFIG_BATTERY_DA9150)	+=3D da9150-fg.o
+obj-$(CONFIG_BATTERY_MAX17040)	+=3D max17040_battery.o
+obj-$(CONFIG_BATTERY_MAX17042)	+=3D max17042_battery.o
+obj-$(CONFIG_BATTERY_Z2)	+=3D z2_battery.o
+obj-$(CONFIG_BATTERY_RT5033)	+=3D rt5033_battery.o
+obj-$(CONFIG_CHARGER_RT9455)	+=3D rt9455_charger.o
+obj-$(CONFIG_BATTERY_S3C_ADC)	+=3D s3c_adc_battery.o
+obj-$(CONFIG_BATTERY_TWL4030_MADC)	+=3D twl4030_madc_battery.o
+obj-$(CONFIG_CHARGER_88PM860X)	+=3D 88pm860x_charger.o
+obj-$(CONFIG_CHARGER_PCF50633)	+=3D pcf50633-charger.o
+obj-$(CONFIG_BATTERY_JZ4740)	+=3D jz4740-battery.o
+obj-$(CONFIG_BATTERY_INTEL_MID)	+=3D intel_mid_battery.o
+obj-$(CONFIG_BATTERY_RX51)	+=3D rx51_battery.o
+obj-$(CONFIG_AB8500_BM)		+=3D ab8500_bmdata.o ab8500_charger.o ab8500_=
fg.o ab8500_btemp.o abx500_chargalg.o pm2301_charger.o
+obj-$(CONFIG_CHARGER_ISP1704)	+=3D isp1704_charger.o
+obj-$(CONFIG_CHARGER_MAX8903)	+=3D max8903_charger.o
+obj-$(CONFIG_CHARGER_TWL4030)	+=3D twl4030_charger.o
+obj-$(CONFIG_CHARGER_LP8727)	+=3D lp8727_charger.o
+obj-$(CONFIG_CHARGER_LP8788)	+=3D lp8788-charger.o
+obj-$(CONFIG_CHARGER_GPIO)	+=3D gpio-charger.o
+obj-$(CONFIG_CHARGER_MANAGER)	+=3D charger-manager.o
+obj-$(CONFIG_CHARGER_MAX14577)	+=3D max14577_charger.o
+obj-$(CONFIG_CHARGER_MAX77693)	+=3D max77693_charger.o
+obj-$(CONFIG_CHARGER_MAX8997)	+=3D max8997_charger.o
+obj-$(CONFIG_CHARGER_MAX8998)	+=3D max8998_charger.o
+obj-$(CONFIG_CHARGER_QCOM_SMBB)	+=3D qcom_smbb.o
+obj-$(CONFIG_CHARGER_BQ2415X)	+=3D bq2415x_charger.o
+obj-$(CONFIG_CHARGER_BQ24190)	+=3D bq24190_charger.o
+obj-$(CONFIG_CHARGER_BQ24257)	+=3D bq24257_charger.o
+obj-$(CONFIG_CHARGER_BQ24735)	+=3D bq24735-charger.o
+obj-$(CONFIG_CHARGER_BQ25890)	+=3D bq25890_charger.o
+obj-$(CONFIG_CHARGER_SMB347)	+=3D smb347-charger.o
+obj-$(CONFIG_CHARGER_TPS65090)	+=3D tps65090-charger.o
+obj-$(CONFIG_CHARGER_TPS65217)	+=3D tps65217_charger.o
+obj-$(CONFIG_AXP288_FUEL_GAUGE) +=3D axp288_fuel_gauge.o
+obj-$(CONFIG_AXP288_CHARGER)	+=3D axp288_charger.o
diff --git a/drivers/power/ab8500_bmdata.c b/drivers/power/supply/ab850=
0_bmdata.c
similarity index 100%
rename from drivers/power/ab8500_bmdata.c
rename to drivers/power/supply/ab8500_bmdata.c
diff --git a/drivers/power/ab8500_btemp.c b/drivers/power/supply/ab8500=
_btemp.c
similarity index 100%
rename from drivers/power/ab8500_btemp.c
rename to drivers/power/supply/ab8500_btemp.c
diff --git a/drivers/power/ab8500_charger.c b/drivers/power/supply/ab85=
00_charger.c
similarity index 100%
rename from drivers/power/ab8500_charger.c
rename to drivers/power/supply/ab8500_charger.c
diff --git a/drivers/power/ab8500_fg.c b/drivers/power/supply/ab8500_fg=
=2Ec
similarity index 100%
rename from drivers/power/ab8500_fg.c
rename to drivers/power/supply/ab8500_fg.c
diff --git a/drivers/power/abx500_chargalg.c b/drivers/power/supply/abx=
500_chargalg.c
similarity index 100%
rename from drivers/power/abx500_chargalg.c
rename to drivers/power/supply/abx500_chargalg.c
diff --git a/drivers/power/act8945a_charger.c b/drivers/power/supply/ac=
t8945a_charger.c
similarity index 100%
rename from drivers/power/act8945a_charger.c
rename to drivers/power/supply/act8945a_charger.c
diff --git a/drivers/power/apm_power.c b/drivers/power/supply/apm_power=
=2Ec
similarity index 100%
rename from drivers/power/apm_power.c
rename to drivers/power/supply/apm_power.c
diff --git a/drivers/power/axp20x_usb_power.c b/drivers/power/supply/ax=
p20x_usb_power.c
similarity index 100%
rename from drivers/power/axp20x_usb_power.c
rename to drivers/power/supply/axp20x_usb_power.c
diff --git a/drivers/power/axp288_charger.c b/drivers/power/supply/axp2=
88_charger.c
similarity index 100%
rename from drivers/power/axp288_charger.c
rename to drivers/power/supply/axp288_charger.c
diff --git a/drivers/power/axp288_fuel_gauge.c b/drivers/power/supply/a=
xp288_fuel_gauge.c
similarity index 100%
rename from drivers/power/axp288_fuel_gauge.c
rename to drivers/power/supply/axp288_fuel_gauge.c
diff --git a/drivers/power/bq2415x_charger.c b/drivers/power/supply/bq2=
415x_charger.c
similarity index 100%
rename from drivers/power/bq2415x_charger.c
rename to drivers/power/supply/bq2415x_charger.c
diff --git a/drivers/power/bq24190_charger.c b/drivers/power/supply/bq2=
4190_charger.c
similarity index 100%
rename from drivers/power/bq24190_charger.c
rename to drivers/power/supply/bq24190_charger.c
diff --git a/drivers/power/bq24257_charger.c b/drivers/power/supply/bq2=
4257_charger.c
similarity index 100%
rename from drivers/power/bq24257_charger.c
rename to drivers/power/supply/bq24257_charger.c
diff --git a/drivers/power/bq24735-charger.c b/drivers/power/supply/bq2=
4735-charger.c
similarity index 100%
rename from drivers/power/bq24735-charger.c
rename to drivers/power/supply/bq24735-charger.c
diff --git a/drivers/power/bq25890_charger.c b/drivers/power/supply/bq2=
5890_charger.c
similarity index 100%
rename from drivers/power/bq25890_charger.c
rename to drivers/power/supply/bq25890_charger.c
diff --git a/drivers/power/bq27xxx_battery.c b/drivers/power/supply/bq2=
7xxx_battery.c
similarity index 100%
rename from drivers/power/bq27xxx_battery.c
rename to drivers/power/supply/bq27xxx_battery.c
diff --git a/drivers/power/bq27xxx_battery_i2c.c b/drivers/power/supply=
/bq27xxx_battery_i2c.c
similarity index 100%
rename from drivers/power/bq27xxx_battery_i2c.c
rename to drivers/power/supply/bq27xxx_battery_i2c.c
diff --git a/drivers/power/charger-manager.c b/drivers/power/supply/cha=
rger-manager.c
similarity index 100%
rename from drivers/power/charger-manager.c
rename to drivers/power/supply/charger-manager.c
diff --git a/drivers/power/collie_battery.c b/drivers/power/supply/coll=
ie_battery.c
similarity index 100%
rename from drivers/power/collie_battery.c
rename to drivers/power/supply/collie_battery.c
diff --git a/drivers/power/da9030_battery.c b/drivers/power/supply/da90=
30_battery.c
similarity index 100%
rename from drivers/power/da9030_battery.c
rename to drivers/power/supply/da9030_battery.c
diff --git a/drivers/power/da9052-battery.c b/drivers/power/supply/da90=
52-battery.c
similarity index 100%
rename from drivers/power/da9052-battery.c
rename to drivers/power/supply/da9052-battery.c
diff --git a/drivers/power/da9150-charger.c b/drivers/power/supply/da91=
50-charger.c
similarity index 100%
rename from drivers/power/da9150-charger.c
rename to drivers/power/supply/da9150-charger.c
diff --git a/drivers/power/da9150-fg.c b/drivers/power/supply/da9150-fg=
=2Ec
similarity index 100%
rename from drivers/power/da9150-fg.c
rename to drivers/power/supply/da9150-fg.c
diff --git a/drivers/power/ds2760_battery.c b/drivers/power/supply/ds27=
60_battery.c
similarity index 99%
rename from drivers/power/ds2760_battery.c
rename to drivers/power/supply/ds2760_battery.c
index 80f73ccb77ab..369ab00bf453 100644
--- a/drivers/power/ds2760_battery.c
+++ b/drivers/power/supply/ds2760_battery.c
@@ -28,8 +28,8 @@
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
=20
-#include "../w1/w1.h"
-#include "../w1/slaves/w1_ds2760.h"
+#include "../../w1/w1.h"
+#include "../../w1/slaves/w1_ds2760.h"
=20
 struct ds2760_device_info {
 	struct device *dev;
diff --git a/drivers/power/ds2780_battery.c b/drivers/power/supply/ds27=
80_battery.c
similarity index 99%
rename from drivers/power/ds2780_battery.c
rename to drivers/power/supply/ds2780_battery.c
index d3743d0ad55b..1b3b6fa89c28 100644
--- a/drivers/power/ds2780_battery.c
+++ b/drivers/power/supply/ds2780_battery.c
@@ -21,8 +21,8 @@
 #include <linux/power_supply.h>
 #include <linux/idr.h>
=20
-#include "../w1/w1.h"
-#include "../w1/slaves/w1_ds2780.h"
+#include "../../w1/w1.h"
+#include "../../w1/slaves/w1_ds2780.h"
=20
 /* Current unit measurement in uA for a 1 milli-ohm sense resistor */
 #define DS2780_CURRENT_UNITS	1563
diff --git a/drivers/power/ds2781_battery.c b/drivers/power/supply/ds27=
81_battery.c
similarity index 99%
rename from drivers/power/ds2781_battery.c
rename to drivers/power/supply/ds2781_battery.c
index c3680024f399..cc0149131f89 100644
--- a/drivers/power/ds2781_battery.c
+++ b/drivers/power/supply/ds2781_battery.c
@@ -19,8 +19,8 @@
 #include <linux/power_supply.h>
 #include <linux/idr.h>
=20
-#include "../w1/w1.h"
-#include "../w1/slaves/w1_ds2781.h"
+#include "../../w1/w1.h"
+#include "../../w1/slaves/w1_ds2781.h"
=20
 /* Current unit measurement in uA for a 1 milli-ohm sense resistor */
 #define DS2781_CURRENT_UNITS	1563
diff --git a/drivers/power/ds2782_battery.c b/drivers/power/supply/ds27=
82_battery.c
similarity index 100%
rename from drivers/power/ds2782_battery.c
rename to drivers/power/supply/ds2782_battery.c
diff --git a/drivers/power/generic-adc-battery.c b/drivers/power/supply=
/generic-adc-battery.c
similarity index 100%
rename from drivers/power/generic-adc-battery.c
rename to drivers/power/supply/generic-adc-battery.c
diff --git a/drivers/power/goldfish_battery.c b/drivers/power/supply/go=
ldfish_battery.c
similarity index 100%
rename from drivers/power/goldfish_battery.c
rename to drivers/power/supply/goldfish_battery.c
diff --git a/drivers/power/gpio-charger.c b/drivers/power/supply/gpio-c=
harger.c
similarity index 100%
rename from drivers/power/gpio-charger.c
rename to drivers/power/supply/gpio-charger.c
diff --git a/drivers/power/intel_mid_battery.c b/drivers/power/supply/i=
ntel_mid_battery.c
similarity index 100%
rename from drivers/power/intel_mid_battery.c
rename to drivers/power/supply/intel_mid_battery.c
diff --git a/drivers/power/ipaq_micro_battery.c b/drivers/power/supply/=
ipaq_micro_battery.c
similarity index 100%
rename from drivers/power/ipaq_micro_battery.c
rename to drivers/power/supply/ipaq_micro_battery.c
diff --git a/drivers/power/isp1704_charger.c b/drivers/power/supply/isp=
1704_charger.c
similarity index 100%
rename from drivers/power/isp1704_charger.c
rename to drivers/power/supply/isp1704_charger.c
diff --git a/drivers/power/jz4740-battery.c b/drivers/power/supply/jz47=
40-battery.c
similarity index 100%
rename from drivers/power/jz4740-battery.c
rename to drivers/power/supply/jz4740-battery.c
diff --git a/drivers/power/lp8727_charger.c b/drivers/power/supply/lp87=
27_charger.c
similarity index 100%
rename from drivers/power/lp8727_charger.c
rename to drivers/power/supply/lp8727_charger.c
diff --git a/drivers/power/lp8788-charger.c b/drivers/power/supply/lp87=
88-charger.c
similarity index 100%
rename from drivers/power/lp8788-charger.c
rename to drivers/power/supply/lp8788-charger.c
diff --git a/drivers/power/ltc2941-battery-gauge.c b/drivers/power/supp=
ly/ltc2941-battery-gauge.c
similarity index 100%
rename from drivers/power/ltc2941-battery-gauge.c
rename to drivers/power/supply/ltc2941-battery-gauge.c
diff --git a/drivers/power/max14577_charger.c b/drivers/power/supply/ma=
x14577_charger.c
similarity index 100%
rename from drivers/power/max14577_charger.c
rename to drivers/power/supply/max14577_charger.c
diff --git a/drivers/power/max17040_battery.c b/drivers/power/supply/ma=
x17040_battery.c
similarity index 100%
rename from drivers/power/max17040_battery.c
rename to drivers/power/supply/max17040_battery.c
diff --git a/drivers/power/max17042_battery.c b/drivers/power/supply/ma=
x17042_battery.c
similarity index 100%
rename from drivers/power/max17042_battery.c
rename to drivers/power/supply/max17042_battery.c
diff --git a/drivers/power/max77693_charger.c b/drivers/power/supply/ma=
x77693_charger.c
similarity index 100%
rename from drivers/power/max77693_charger.c
rename to drivers/power/supply/max77693_charger.c
diff --git a/drivers/power/max8903_charger.c b/drivers/power/supply/max=
8903_charger.c
similarity index 100%
rename from drivers/power/max8903_charger.c
rename to drivers/power/supply/max8903_charger.c
diff --git a/drivers/power/max8925_power.c b/drivers/power/supply/max89=
25_power.c
similarity index 100%
rename from drivers/power/max8925_power.c
rename to drivers/power/supply/max8925_power.c
diff --git a/drivers/power/max8997_charger.c b/drivers/power/supply/max=
8997_charger.c
similarity index 100%
rename from drivers/power/max8997_charger.c
rename to drivers/power/supply/max8997_charger.c
diff --git a/drivers/power/max8998_charger.c b/drivers/power/supply/max=
8998_charger.c
similarity index 100%
rename from drivers/power/max8998_charger.c
rename to drivers/power/supply/max8998_charger.c
diff --git a/drivers/power/olpc_battery.c b/drivers/power/supply/olpc_b=
attery.c
similarity index 100%
rename from drivers/power/olpc_battery.c
rename to drivers/power/supply/olpc_battery.c
diff --git a/drivers/power/pcf50633-charger.c b/drivers/power/supply/pc=
f50633-charger.c
similarity index 100%
rename from drivers/power/pcf50633-charger.c
rename to drivers/power/supply/pcf50633-charger.c
diff --git a/drivers/power/pda_power.c b/drivers/power/supply/pda_power=
=2Ec
similarity index 100%
rename from drivers/power/pda_power.c
rename to drivers/power/supply/pda_power.c
diff --git a/drivers/power/pm2301_charger.c b/drivers/power/supply/pm23=
01_charger.c
similarity index 100%
rename from drivers/power/pm2301_charger.c
rename to drivers/power/supply/pm2301_charger.c
diff --git a/drivers/power/pm2301_charger.h b/drivers/power/supply/pm23=
01_charger.h
similarity index 100%
rename from drivers/power/pm2301_charger.h
rename to drivers/power/supply/pm2301_charger.h
diff --git a/drivers/power/pmu_battery.c b/drivers/power/supply/pmu_bat=
tery.c
similarity index 100%
rename from drivers/power/pmu_battery.c
rename to drivers/power/supply/pmu_battery.c
diff --git a/drivers/power/power_supply.h b/drivers/power/supply/power_=
supply.h
similarity index 100%
rename from drivers/power/power_supply.h
rename to drivers/power/supply/power_supply.h
diff --git a/drivers/power/power_supply_core.c b/drivers/power/supply/p=
ower_supply_core.c
similarity index 100%
rename from drivers/power/power_supply_core.c
rename to drivers/power/supply/power_supply_core.c
diff --git a/drivers/power/power_supply_leds.c b/drivers/power/supply/p=
ower_supply_leds.c
similarity index 100%
rename from drivers/power/power_supply_leds.c
rename to drivers/power/supply/power_supply_leds.c
diff --git a/drivers/power/power_supply_sysfs.c b/drivers/power/supply/=
power_supply_sysfs.c
similarity index 100%
rename from drivers/power/power_supply_sysfs.c
rename to drivers/power/supply/power_supply_sysfs.c
diff --git a/drivers/power/qcom_smbb.c b/drivers/power/supply/qcom_smbb=
=2Ec
similarity index 100%
rename from drivers/power/qcom_smbb.c
rename to drivers/power/supply/qcom_smbb.c
diff --git a/drivers/power/rt5033_battery.c b/drivers/power/supply/rt50=
33_battery.c
similarity index 100%
rename from drivers/power/rt5033_battery.c
rename to drivers/power/supply/rt5033_battery.c
diff --git a/drivers/power/rt9455_charger.c b/drivers/power/supply/rt94=
55_charger.c
similarity index 100%
rename from drivers/power/rt9455_charger.c
rename to drivers/power/supply/rt9455_charger.c
diff --git a/drivers/power/rx51_battery.c b/drivers/power/supply/rx51_b=
attery.c
similarity index 100%
rename from drivers/power/rx51_battery.c
rename to drivers/power/supply/rx51_battery.c
diff --git a/drivers/power/s3c_adc_battery.c b/drivers/power/supply/s3c=
_adc_battery.c
similarity index 100%
rename from drivers/power/s3c_adc_battery.c
rename to drivers/power/supply/s3c_adc_battery.c
diff --git a/drivers/power/sbs-battery.c b/drivers/power/supply/sbs-bat=
tery.c
similarity index 100%
rename from drivers/power/sbs-battery.c
rename to drivers/power/supply/sbs-battery.c
diff --git a/drivers/power/smb347-charger.c b/drivers/power/supply/smb3=
47-charger.c
similarity index 100%
rename from drivers/power/smb347-charger.c
rename to drivers/power/supply/smb347-charger.c
diff --git a/drivers/power/test_power.c b/drivers/power/supply/test_pow=
er.c
similarity index 100%
rename from drivers/power/test_power.c
rename to drivers/power/supply/test_power.c
diff --git a/drivers/power/tosa_battery.c b/drivers/power/supply/tosa_b=
attery.c
similarity index 100%
rename from drivers/power/tosa_battery.c
rename to drivers/power/supply/tosa_battery.c
diff --git a/drivers/power/tps65090-charger.c b/drivers/power/supply/tp=
s65090-charger.c
similarity index 100%
rename from drivers/power/tps65090-charger.c
rename to drivers/power/supply/tps65090-charger.c
diff --git a/drivers/power/tps65217_charger.c b/drivers/power/supply/tp=
s65217_charger.c
similarity index 100%
rename from drivers/power/tps65217_charger.c
rename to drivers/power/supply/tps65217_charger.c
diff --git a/drivers/power/twl4030_charger.c b/drivers/power/supply/twl=
4030_charger.c
similarity index 100%
rename from drivers/power/twl4030_charger.c
rename to drivers/power/supply/twl4030_charger.c
diff --git a/drivers/power/twl4030_madc_battery.c b/drivers/power/suppl=
y/twl4030_madc_battery.c
similarity index 100%
rename from drivers/power/twl4030_madc_battery.c
rename to drivers/power/supply/twl4030_madc_battery.c
diff --git a/drivers/power/wm831x_backup.c b/drivers/power/supply/wm831=
x_backup.c
similarity index 100%
rename from drivers/power/wm831x_backup.c
rename to drivers/power/supply/wm831x_backup.c
diff --git a/drivers/power/wm831x_power.c b/drivers/power/supply/wm831x=
_power.c
similarity index 100%
rename from drivers/power/wm831x_power.c
rename to drivers/power/supply/wm831x_power.c
diff --git a/drivers/power/wm8350_power.c b/drivers/power/supply/wm8350=
_power.c
similarity index 100%
rename from drivers/power/wm8350_power.c
rename to drivers/power/supply/wm8350_power.c
diff --git a/drivers/power/wm97xx_battery.c b/drivers/power/supply/wm97=
xx_battery.c
similarity index 99%
rename from drivers/power/wm97xx_battery.c
rename to drivers/power/supply/wm97xx_battery.c
index c2f09ed35050..6285626d142a 100644
--- a/drivers/power/wm97xx_battery.c
+++ b/drivers/power/supply/wm97xx_battery.c
@@ -1,6 +1,4 @@
 /*
- * linux/drivers/power/wm97xx_battery.c
- *
  * Battery measurement code for WM97xx
  *
  * based on tosa_battery.c
diff --git a/drivers/power/z2_battery.c b/drivers/power/supply/z2_batte=
ry.c
similarity index 100%
rename from drivers/power/z2_battery.c
rename to drivers/power/supply/z2_battery.c
--=20
2.8.1
