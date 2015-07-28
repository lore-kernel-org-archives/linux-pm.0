From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v2 2/6] power: bq27x00_battery: Renaming for consistency
Date: Tue, 28 Jul 2015 14:39:09 -0500
Message-ID: <1438112353-19704-3-git-send-email-afd@ti.com>
References: <1438112353-19704-1-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438112353-19704-1-git-send-email-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Murphy <dmurphy@ti.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>
List-Id: linux-pm@vger.kernel.org

Rename functions that are used by multiple devices. New devices
have been added and the function names and driver name are no longer
general enough for the functionality they provide.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 MAINTAINERS                                        |   4 +-
 arch/arm/configs/omap2plus_defconfig               |   2 +-
 arch/unicore32/Kconfig                             |   2 +-
 drivers/power/Kconfig                              |  22 +-
 drivers/power/Makefile                             |   2 +-
 .../power/{bq27x00_battery.c =3D> bq27xxx_battery.c} | 333 +++++++++++=
----------
 drivers/w1/slaves/w1_bq27000.c                     |   4 +-
 .../power/{bq27x00_battery.h =3D> bq27xxx_battery.h} |   4 +-
 8 files changed, 187 insertions(+), 186 deletions(-)
 rename drivers/power/{bq27x00_battery.c =3D> bq27xxx_battery.c} (70%)
 rename include/linux/power/{bq27x00_battery.h =3D> bq27xxx_battery.h} =
(85%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8133cef..8143fa25 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7212,10 +7212,10 @@ NOKIA N900 POWER SUPPLY DRIVERS
 M:	Pali Roh=C3=A1r <pali.rohar@gmail.com>
 S:	Maintained
 F:	include/linux/power/bq2415x_charger.h
-F:	include/linux/power/bq27x00_battery.h
+F:	include/linux/power/bq27xxx_battery.h
 F:	include/linux/power/isp1704_charger.h
 F:	drivers/power/bq2415x_charger.c
-F:	drivers/power/bq27x00_battery.c
+F:	drivers/power/bq27xxx_battery.c
 F:	drivers/power/isp1704_charger.c
 F:	drivers/power/rx51_battery.c
=20
diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/om=
ap2plus_defconfig
index ac521e7..a79232c 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -241,7 +241,7 @@ CONFIG_GPIO_TWL4030=3Dy
 CONFIG_GPIO_PALMAS=3Dy
 CONFIG_W1=3Dm
 CONFIG_HDQ_MASTER_OMAP=3Dm
-CONFIG_BATTERY_BQ27x00=3Dm
+CONFIG_BATTERY_BQ27XXX=3Dm
 CONFIG_CHARGER_ISP1704=3Dm
 CONFIG_CHARGER_TWL4030=3Dm
 CONFIG_CHARGER_BQ2415X=3Dm
diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index 928237a..c9faddc 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -222,7 +222,7 @@ config I2C_BATTERY_BQ27200
 	tristate "I2C Battery BQ27200 Support"
 	select I2C_PUV3
 	select POWER_SUPPLY
-	select BATTERY_BQ27x00
+	select BATTERY_BQ27XXX
=20
 config I2C_EEPROM_AT24
 	tristate "I2C EEPROMs AT24 support"
diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 08beeed..cafcfe2 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -157,26 +157,26 @@ config BATTERY_SBS
 	  Say Y to include support for SBS battery driver for SBS-compliant
 	  gas gauges.
=20
-config BATTERY_BQ27x00
-	tristate "BQ27x00 battery driver"
+config BATTERY_BQ27XXX
+	tristate "BQ27xxx battery driver"
 	depends on I2C || I2C=3Dn
 	help
-	  Say Y here to enable support for batteries with BQ27x00 (I2C/HDQ) c=
hips.
+	  Say Y here to enable support for batteries with BQ27xxx (I2C/HDQ) c=
hips.
=20
-config BATTERY_BQ27X00_I2C
-	bool "BQ27200/BQ27500 support"
-	depends on BATTERY_BQ27x00
+config BATTERY_BQ27XXX_I2C
+	bool "BQ27xxx I2C support"
+	depends on BATTERY_BQ27XXX
 	depends on I2C
 	default y
 	help
-	  Say Y here to enable support for batteries with BQ27x00 (I2C) chips=
=2E
+	  Say Y here to enable support for batteries with BQ27xxx (I2C) chips=
=2E
=20
-config BATTERY_BQ27X00_PLATFORM
-	bool "BQ27000 support"
-	depends on BATTERY_BQ27x00
+config BATTERY_BQ27XXX_PLATFORM
+	bool "BQ27xxx HDQ support"
+	depends on BATTERY_BQ27XXX
 	default y
 	help
-	  Say Y here to enable support for batteries with BQ27000 (HDQ) chips=
=2E
+	  Say Y here to enable support for batteries with BQ27xxx (HDQ) chips=
=2E
=20
 config BATTERY_DA9030
 	tristate "DA9030 battery driver"
diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index 5752ce8..7a5bc96 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -29,7 +29,7 @@ obj-$(CONFIG_BATTERY_COLLIE)	+=3D collie_battery.o
 obj-$(CONFIG_BATTERY_IPAQ_MICRO) +=3D ipaq_micro_battery.o
 obj-$(CONFIG_BATTERY_WM97XX)	+=3D wm97xx_battery.o
 obj-$(CONFIG_BATTERY_SBS)	+=3D sbs-battery.o
-obj-$(CONFIG_BATTERY_BQ27x00)	+=3D bq27x00_battery.o
+obj-$(CONFIG_BATTERY_BQ27XXX)	+=3D bq27xxx_battery.o
 obj-$(CONFIG_BATTERY_DA9030)	+=3D da9030_battery.o
 obj-$(CONFIG_BATTERY_DA9052)	+=3D da9052-battery.o
 obj-$(CONFIG_CHARGER_DA9150)	+=3D da9150-charger.o
diff --git a/drivers/power/bq27x00_battery.c b/drivers/power/bq27xxx_ba=
ttery.c
similarity index 70%
rename from drivers/power/bq27x00_battery.c
rename to drivers/power/bq27xxx_battery.c
index d0b2f3b..e72055c 100644
--- a/drivers/power/bq27x00_battery.c
+++ b/drivers/power/bq27xxx_battery.c
@@ -1,5 +1,5 @@
 /*
- * BQ27x00 battery driver
+ * BQ27xxx battery driver
  *
  * Copyright (C) 2008 Rodolfo Giometti <giometti@linux.it>
  * Copyright (C) 2008 Eurotech S.p.A. <info@eurotech.it>
@@ -37,7 +37,7 @@
 #include <linux/slab.h>
 #include <asm/unaligned.h>
=20
-#include <linux/power/bq27x00_battery.h>
+#include <linux/power/bq27xxx_battery.h>
=20
 #define DRIVER_VERSION		"1.2.0"
=20
@@ -83,17 +83,17 @@
 #define BQ27425_REG_SOC		(0x1C + BQ27425_REG_OFFSET)
 #define BQ27425_REG_DCAP	(0x3C + BQ27425_REG_OFFSET)
=20
-#define BQ27000_RS			20 /* Resistor sense */
-#define BQ27x00_POWER_CONSTANT		(256 * 29200 / 1000)
+#define BQ27XXX_RS			20 /* Resistor sense */
+#define BQ27XXX_POWER_CONSTANT		(256 * 29200 / 1000)
=20
-struct bq27x00_device_info;
-struct bq27x00_access_methods {
-	int (*read)(struct bq27x00_device_info *di, u8 reg, bool single);
+struct bq27xxx_device_info;
+struct bq27xxx_access_methods {
+	int (*read)(struct bq27xxx_device_info *di, u8 reg, bool single);
 };
=20
-enum bq27x00_chip { BQ27000, BQ27500, BQ27425, BQ27742, BQ27510};
+enum bq27xxx_chip { BQ27000, BQ27500, BQ27425, BQ27742, BQ27510};
=20
-struct bq27x00_reg_cache {
+struct bq27xxx_reg_cache {
 	int temperature;
 	int time_to_empty;
 	int time_to_empty_avg;
@@ -107,12 +107,12 @@ struct bq27x00_reg_cache {
 	int health;
 };
=20
-struct bq27x00_device_info {
+struct bq27xxx_device_info {
 	struct device		*dev;
 	int			id;
-	enum bq27x00_chip	chip;
+	enum bq27xxx_chip	chip;
=20
-	struct bq27x00_reg_cache cache;
+	struct bq27xxx_reg_cache cache;
 	int charge_design_full;
=20
 	unsigned long last_update;
@@ -120,7 +120,7 @@ struct bq27x00_device_info {
=20
 	struct power_supply	*bat;
=20
-	struct bq27x00_access_methods bus;
+	struct bq27xxx_access_methods bus;
=20
 	struct mutex lock;
 };
@@ -206,10 +206,10 @@ MODULE_PARM_DESC(poll_interval,
 		 "battery poll interval in seconds - 0 disables polling");
=20
 /*
- * Common code for BQ27x00 devices
+ * Common code for BQ27xxx devices
  */
=20
-static inline int bq27x00_read(struct bq27x00_device_info *di, u8 reg,
+static inline int bq27xxx_read(struct bq27xxx_device_info *di, u8 reg,
 			       bool single)
 {
 	if (di->chip =3D=3D BQ27425)
@@ -222,7 +222,7 @@ static inline int bq27x00_read(struct bq27x00_devic=
e_info *di, u8 reg,
  * differ from BQ27000 and BQ27200 in calculation of certain
  * parameters. Hence we need to check for the chip type.
  */
-static bool bq27xxx_is_chip_version_higher(struct bq27x00_device_info =
*di)
+static bool bq27xxx_is_chip_version_higher(struct bq27xxx_device_info =
*di)
 {
 	if (di->chip =3D=3D BQ27425 || di->chip =3D=3D BQ27500 || di->chip =3D=
=3D BQ27742
 	    || di->chip =3D=3D BQ27510)
@@ -234,18 +234,18 @@ static bool bq27xxx_is_chip_version_higher(struct=
 bq27x00_device_info *di)
  * Return the battery Relative State-of-Charge
  * Or < 0 if something fails.
  */
-static int bq27x00_battery_read_rsoc(struct bq27x00_device_info *di)
+static int bq27xxx_battery_read_rsoc(struct bq27xxx_device_info *di)
 {
 	int rsoc;
=20
 	if (di->chip =3D=3D BQ27500 || di->chip =3D=3D BQ27742)
-		rsoc =3D bq27x00_read(di, BQ27500_REG_SOC, false);
+		rsoc =3D bq27xxx_read(di, BQ27500_REG_SOC, false);
 	else if (di->chip =3D=3D BQ27510)
-		rsoc =3D bq27x00_read(di, BQ27510_REG_SOC, false);
+		rsoc =3D bq27xxx_read(di, BQ27510_REG_SOC, false);
 	else if (di->chip =3D=3D BQ27425)
-		rsoc =3D bq27x00_read(di, BQ27425_REG_SOC, false);
+		rsoc =3D bq27xxx_read(di, BQ27425_REG_SOC, false);
 	else
-		rsoc =3D bq27x00_read(di, BQ27000_REG_RSOC, true);
+		rsoc =3D bq27xxx_read(di, BQ27000_REG_RSOC, true);
=20
 	if (rsoc < 0)
 		dev_dbg(di->dev, "error reading relative State-of-Charge\n");
@@ -257,11 +257,11 @@ static int bq27x00_battery_read_rsoc(struct bq27x=
00_device_info *di)
  * Return a battery charge value in =C2=B5Ah
  * Or < 0 if something fails.
  */
-static int bq27x00_battery_read_charge(struct bq27x00_device_info *di,=
 u8 reg)
+static int bq27xxx_battery_read_charge(struct bq27xxx_device_info *di,=
 u8 reg)
 {
 	int charge;
=20
-	charge =3D bq27x00_read(di, reg, false);
+	charge =3D bq27xxx_read(di, reg, false);
 	if (charge < 0) {
 		dev_dbg(di->dev, "error reading charge register %02x: %d\n",
 			reg, charge);
@@ -271,7 +271,7 @@ static int bq27x00_battery_read_charge(struct bq27x=
00_device_info *di, u8 reg)
 	if (bq27xxx_is_chip_version_higher(di))
 		charge *=3D 1000;
 	else
-		charge =3D charge * 3570 / BQ27000_RS;
+		charge =3D charge * 3570 / BQ27XXX_RS;
=20
 	return charge;
 }
@@ -280,7 +280,7 @@ static int bq27x00_battery_read_charge(struct bq27x=
00_device_info *di, u8 reg)
  * Return the battery Nominal available capaciy in =C2=B5Ah
  * Or < 0 if something fails.
  */
-static inline int bq27x00_battery_read_nac(struct bq27x00_device_info =
*di)
+static inline int bq27xxx_battery_read_nac(struct bq27xxx_device_info =
*di)
 {
 	int flags;
 	bool is_bq27500 =3D di->chip =3D=3D BQ27500;
@@ -288,39 +288,39 @@ static inline int bq27x00_battery_read_nac(struct=
 bq27x00_device_info *di)
 	bool is_higher =3D bq27xxx_is_chip_version_higher(di);
 	bool flags_1b =3D !(is_bq27500 || is_bq27742);
=20
-	flags =3D bq27x00_read(di, BQ27x00_REG_FLAGS, flags_1b);
+	flags =3D bq27xxx_read(di, BQ27x00_REG_FLAGS, flags_1b);
 	if (flags >=3D 0 && !is_higher && (flags & BQ27000_FLAG_CI))
 		return -ENODATA;
=20
-	return bq27x00_battery_read_charge(di, BQ27x00_REG_NAC);
+	return bq27xxx_battery_read_charge(di, BQ27x00_REG_NAC);
 }
=20
 /*
  * Return the battery Last measured discharge in =C2=B5Ah
  * Or < 0 if something fails.
  */
-static inline int bq27x00_battery_read_lmd(struct bq27x00_device_info =
*di)
+static inline int bq27xxx_battery_read_lmd(struct bq27xxx_device_info =
*di)
 {
-	return bq27x00_battery_read_charge(di, BQ27x00_REG_LMD);
+	return bq27xxx_battery_read_charge(di, BQ27x00_REG_LMD);
 }
=20
 /*
  * Return the battery Initial last measured discharge in =C2=B5Ah
  * Or < 0 if something fails.
  */
-static int bq27x00_battery_read_ilmd(struct bq27x00_device_info *di)
+static int bq27xxx_battery_read_ilmd(struct bq27xxx_device_info *di)
 {
 	int ilmd;
=20
 	if (bq27xxx_is_chip_version_higher(di)) {
 		if (di->chip =3D=3D BQ27425)
-			ilmd =3D bq27x00_read(di, BQ27425_REG_DCAP, false);
+			ilmd =3D bq27xxx_read(di, BQ27425_REG_DCAP, false);
 		else if (di->chip =3D=3D BQ27510)
-			ilmd =3D bq27x00_read(di, BQ27510_REG_DCAP, false);
+			ilmd =3D bq27xxx_read(di, BQ27510_REG_DCAP, false);
 		else
-			ilmd =3D bq27x00_read(di, BQ27500_REG_DCAP, false);
+			ilmd =3D bq27xxx_read(di, BQ27500_REG_DCAP, false);
 	} else {
-		ilmd =3D bq27x00_read(di, BQ27000_REG_ILMD, true);
+		ilmd =3D bq27xxx_read(di, BQ27000_REG_ILMD, true);
 	}
=20
 	if (ilmd < 0) {
@@ -331,7 +331,7 @@ static int bq27x00_battery_read_ilmd(struct bq27x00=
_device_info *di)
 	if (bq27xxx_is_chip_version_higher(di))
 		ilmd *=3D 1000;
 	else
-		ilmd =3D ilmd * 256 * 3570 / BQ27000_RS;
+		ilmd =3D ilmd * 256 * 3570 / BQ27XXX_RS;
=20
 	return ilmd;
 }
@@ -340,11 +340,11 @@ static int bq27x00_battery_read_ilmd(struct bq27x=
00_device_info *di)
  * Return the battery Available energy in =C2=B5Wh
  * Or < 0 if something fails.
  */
-static int bq27x00_battery_read_energy(struct bq27x00_device_info *di)
+static int bq27xxx_battery_read_energy(struct bq27xxx_device_info *di)
 {
 	int ae;
=20
-	ae =3D bq27x00_read(di, BQ27x00_REG_AE, false);
+	ae =3D bq27xxx_read(di, BQ27x00_REG_AE, false);
 	if (ae < 0) {
 		dev_dbg(di->dev, "error reading available energy\n");
 		return ae;
@@ -353,7 +353,7 @@ static int bq27x00_battery_read_energy(struct bq27x=
00_device_info *di)
 	if (di->chip =3D=3D BQ27500)
 		ae *=3D 1000;
 	else
-		ae =3D ae * 29200 / BQ27000_RS;
+		ae =3D ae * 29200 / BQ27XXX_RS;
=20
 	return ae;
 }
@@ -362,11 +362,11 @@ static int bq27x00_battery_read_energy(struct bq2=
7x00_device_info *di)
  * Return the battery temperature in tenths of degree Kelvin
  * Or < 0 if something fails.
  */
-static int bq27x00_battery_read_temperature(struct bq27x00_device_info=
 *di)
+static int bq27xxx_battery_read_temperature(struct bq27xxx_device_info=
 *di)
 {
 	int temp;
=20
-	temp =3D bq27x00_read(di, BQ27x00_REG_TEMP, false);
+	temp =3D bq27xxx_read(di, BQ27x00_REG_TEMP, false);
 	if (temp < 0) {
 		dev_err(di->dev, "error reading temperature\n");
 		return temp;
@@ -382,14 +382,14 @@ static int bq27x00_battery_read_temperature(struc=
t bq27x00_device_info *di)
  * Return the battery Cycle count total
  * Or < 0 if something fails.
  */
-static int bq27x00_battery_read_cyct(struct bq27x00_device_info *di)
+static int bq27xxx_battery_read_cyct(struct bq27xxx_device_info *di)
 {
 	int cyct;
=20
 	if (di->chip =3D=3D BQ27510)
-		cyct =3D bq27x00_read(di, BQ27510_REG_CYCT, false);
+		cyct =3D bq27xxx_read(di, BQ27510_REG_CYCT, false);
 	else
-		cyct =3D bq27x00_read(di, BQ27x00_REG_CYCT, false);
+		cyct =3D bq27xxx_read(di, BQ27x00_REG_CYCT, false);
 	if (cyct < 0)
 		dev_err(di->dev, "error reading cycle count total\n");
=20
@@ -400,11 +400,11 @@ static int bq27x00_battery_read_cyct(struct bq27x=
00_device_info *di)
  * Read a time register.
  * Return < 0 if something fails.
  */
-static int bq27x00_battery_read_time(struct bq27x00_device_info *di, u=
8 reg)
+static int bq27xxx_battery_read_time(struct bq27xxx_device_info *di, u=
8 reg)
 {
 	int tval;
=20
-	tval =3D bq27x00_read(di, reg, false);
+	tval =3D bq27xxx_read(di, reg, false);
 	if (tval < 0) {
 		dev_dbg(di->dev, "error reading time register %02x: %d\n",
 			reg, tval);
@@ -421,11 +421,11 @@ static int bq27x00_battery_read_time(struct bq27x=
00_device_info *di, u8 reg)
  * Read a power avg register.
  * Return < 0 if something fails.
  */
-static int bq27x00_battery_read_pwr_avg(struct bq27x00_device_info *di=
, u8 reg)
+static int bq27xxx_battery_read_pwr_avg(struct bq27xxx_device_info *di=
, u8 reg)
 {
 	int tval;
=20
-	tval =3D bq27x00_read(di, reg, false);
+	tval =3D bq27xxx_read(di, reg, false);
 	if (tval < 0) {
 		dev_err(di->dev, "error reading power avg rgister  %02x: %d\n",
 			reg, tval);
@@ -435,18 +435,18 @@ static int bq27x00_battery_read_pwr_avg(struct bq=
27x00_device_info *di, u8 reg)
 	if (di->chip =3D=3D BQ27500)
 		return tval;
 	else
-		return (tval * BQ27x00_POWER_CONSTANT) / BQ27000_RS;
+		return (tval * BQ27XXX_POWER_CONSTANT) / BQ27XXX_RS;
 }
=20
 /*
  * Read flag register.
  * Return < 0 if something fails.
  */
-static int bq27x00_battery_read_health(struct bq27x00_device_info *di)
+static int bq27xxx_battery_read_health(struct bq27xxx_device_info *di)
 {
 	int tval;
=20
-	tval =3D bq27x00_read(di, BQ27x00_REG_FLAGS, false);
+	tval =3D bq27xxx_read(di, BQ27x00_REG_FLAGS, false);
 	if (tval < 0) {
 		dev_err(di->dev, "error reading flag register:%d\n", tval);
 		return tval;
@@ -475,16 +475,16 @@ static int bq27x00_battery_read_health(struct bq2=
7x00_device_info *di)
 	return -1;
 }
=20
-static void bq27x00_update(struct bq27x00_device_info *di)
+static void bq27xxx_battery_update(struct bq27xxx_device_info *di)
 {
-	struct bq27x00_reg_cache cache =3D {0, };
+	struct bq27xxx_reg_cache cache =3D {0, };
 	bool is_bq27500 =3D di->chip =3D=3D BQ27500;
 	bool is_bq27510 =3D di->chip =3D=3D BQ27510;
 	bool is_bq27425 =3D di->chip =3D=3D BQ27425;
 	bool is_bq27742 =3D di->chip =3D=3D BQ27742;
 	bool flags_1b =3D !(is_bq27500 || is_bq27742);
=20
-	cache.flags =3D bq27x00_read(di, BQ27x00_REG_FLAGS, flags_1b);
+	cache.flags =3D bq27xxx_read(di, BQ27x00_REG_FLAGS, flags_1b);
 	if ((cache.flags & 0xff) =3D=3D 0xff)
 		/* read error */
 		cache.flags =3D -1;
@@ -500,41 +500,41 @@ static void bq27x00_update(struct bq27x00_device_=
info *di)
 			cache.charge_full =3D -ENODATA;
 			cache.health =3D -ENODATA;
 		} else {
-			cache.capacity =3D bq27x00_battery_read_rsoc(di);
+			cache.capacity =3D bq27xxx_battery_read_rsoc(di);
 			if (is_bq27742 || is_bq27510)
 				cache.time_to_empty =3D
-					bq27x00_battery_read_time(di,
+					bq27xxx_battery_read_time(di,
 							BQ27x00_REG_TTE);
 			else if (!is_bq27425) {
-				cache.energy =3D bq27x00_battery_read_energy(di);
+				cache.energy =3D bq27xxx_battery_read_energy(di);
 				cache.time_to_empty =3D
-					bq27x00_battery_read_time(di,
+					bq27xxx_battery_read_time(di,
 							BQ27x00_REG_TTE);
 				cache.time_to_empty_avg =3D
-					bq27x00_battery_read_time(di,
+					bq27xxx_battery_read_time(di,
 							BQ27x00_REG_TTECP);
 				cache.time_to_full =3D
-					bq27x00_battery_read_time(di,
+					bq27xxx_battery_read_time(di,
 							BQ27x00_REG_TTF);
 			}
-			cache.charge_full =3D bq27x00_battery_read_lmd(di);
-			cache.health =3D bq27x00_battery_read_health(di);
+			cache.charge_full =3D bq27xxx_battery_read_lmd(di);
+			cache.health =3D bq27xxx_battery_read_health(di);
 		}
-		cache.temperature =3D bq27x00_battery_read_temperature(di);
+		cache.temperature =3D bq27xxx_battery_read_temperature(di);
 		if (!is_bq27425)
-			cache.cycle_count =3D bq27x00_battery_read_cyct(di);
+			cache.cycle_count =3D bq27xxx_battery_read_cyct(di);
 		if (is_bq27742)
 			cache.power_avg =3D
-				bq27x00_battery_read_pwr_avg(di,
+				bq27xxx_battery_read_pwr_avg(di,
 						BQ27742_POWER_AVG);
 		else
 			cache.power_avg =3D
-				bq27x00_battery_read_pwr_avg(di,
+				bq27xxx_battery_read_pwr_avg(di,
 						BQ27x00_POWER_AVG);
=20
 		/* We only have to read charge design full once */
 		if (di->charge_design_full <=3D 0)
-			di->charge_design_full =3D bq27x00_battery_read_ilmd(di);
+			di->charge_design_full =3D bq27xxx_battery_read_ilmd(di);
 	}
=20
 	if (di->cache.capacity !=3D cache.capacity)
@@ -546,12 +546,12 @@ static void bq27x00_update(struct bq27x00_device_=
info *di)
 	di->last_update =3D jiffies;
 }
=20
-static void bq27x00_battery_poll(struct work_struct *work)
+static void bq27xxx_battery_poll(struct work_struct *work)
 {
-	struct bq27x00_device_info *di =3D
-		container_of(work, struct bq27x00_device_info, work.work);
+	struct bq27xxx_device_info *di =3D
+		container_of(work, struct bq27xxx_device_info, work.work);
=20
-	bq27x00_update(di);
+	bq27xxx_battery_update(di);
=20
 	if (poll_interval > 0) {
 		/* The timer does not have to be accurate. */
@@ -565,13 +565,13 @@ static void bq27x00_battery_poll(struct work_stru=
ct *work)
  * Note that current can be negative signed as well
  * Or 0 if something fails.
  */
-static int bq27x00_battery_current(struct bq27x00_device_info *di,
+static int bq27xxx_battery_current(struct bq27xxx_device_info *di,
 				   union power_supply_propval *val)
 {
 	int curr;
 	int flags;
=20
-	curr =3D bq27x00_read(di, BQ27x00_REG_AI, false);
+	curr =3D bq27xxx_read(di, BQ27x00_REG_AI, false);
 	if (curr < 0) {
 		dev_err(di->dev, "error reading current\n");
 		return curr;
@@ -581,19 +581,19 @@ static int bq27x00_battery_current(struct bq27x00=
_device_info *di,
 		/* bq27500 returns signed value */
 		val->intval =3D (int)((s16)curr) * 1000;
 	} else {
-		flags =3D bq27x00_read(di, BQ27x00_REG_FLAGS, false);
+		flags =3D bq27xxx_read(di, BQ27x00_REG_FLAGS, false);
 		if (flags & BQ27000_FLAG_CHGS) {
 			dev_dbg(di->dev, "negative current!\n");
 			curr =3D -curr;
 		}
=20
-		val->intval =3D curr * 3570 / BQ27000_RS;
+		val->intval =3D curr * 3570 / BQ27XXX_RS;
 	}
=20
 	return 0;
 }
=20
-static int bq27x00_battery_status(struct bq27x00_device_info *di,
+static int bq27xxx_battery_status(struct bq27xxx_device_info *di,
 				  union power_supply_propval *val)
 {
 	int status;
@@ -621,7 +621,7 @@ static int bq27x00_battery_status(struct bq27x00_de=
vice_info *di,
 	return 0;
 }
=20
-static int bq27x00_battery_capacity_level(struct bq27x00_device_info *=
di,
+static int bq27xxx_battery_capacity_level(struct bq27xxx_device_info *=
di,
 					  union power_supply_propval *val)
 {
 	int level;
@@ -655,12 +655,12 @@ static int bq27x00_battery_capacity_level(struct =
bq27x00_device_info *di,
  * Return the battery Voltage in millivolts
  * Or < 0 if something fails.
  */
-static int bq27x00_battery_voltage(struct bq27x00_device_info *di,
+static int bq27xxx_battery_voltage(struct bq27xxx_device_info *di,
 				   union power_supply_propval *val)
 {
 	int volt;
=20
-	volt =3D bq27x00_read(di, BQ27x00_REG_VOLT, false);
+	volt =3D bq27xxx_read(di, BQ27x00_REG_VOLT, false);
 	if (volt < 0) {
 		dev_err(di->dev, "error reading voltage\n");
 		return volt;
@@ -671,7 +671,7 @@ static int bq27x00_battery_voltage(struct bq27x00_d=
evice_info *di,
 	return 0;
 }
=20
-static int bq27x00_simple_value(int value,
+static int bq27xxx_simple_value(int value,
 				union power_supply_propval *val)
 {
 	if (value < 0)
@@ -682,17 +682,17 @@ static int bq27x00_simple_value(int value,
 	return 0;
 }
=20
-static int bq27x00_battery_get_property(struct power_supply *psy,
+static int bq27xxx_battery_get_property(struct power_supply *psy,
 					enum power_supply_property psp,
 					union power_supply_propval *val)
 {
 	int ret =3D 0;
-	struct bq27x00_device_info *di =3D power_supply_get_drvdata(psy);
+	struct bq27xxx_device_info *di =3D power_supply_get_drvdata(psy);
=20
 	mutex_lock(&di->lock);
 	if (time_is_before_jiffies(di->last_update + 5 * HZ)) {
 		cancel_delayed_work_sync(&di->work);
-		bq27x00_battery_poll(&di->work.work);
+		bq27xxx_battery_poll(&di->work.work);
 	}
 	mutex_unlock(&di->lock);
=20
@@ -701,60 +701,60 @@ static int bq27x00_battery_get_property(struct po=
wer_supply *psy,
=20
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
-		ret =3D bq27x00_battery_status(di, val);
+		ret =3D bq27xxx_battery_status(di, val);
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-		ret =3D bq27x00_battery_voltage(di, val);
+		ret =3D bq27xxx_battery_voltage(di, val);
 		break;
 	case POWER_SUPPLY_PROP_PRESENT:
 		val->intval =3D di->cache.flags < 0 ? 0 : 1;
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
-		ret =3D bq27x00_battery_current(di, val);
+		ret =3D bq27xxx_battery_current(di, val);
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY:
-		ret =3D bq27x00_simple_value(di->cache.capacity, val);
+		ret =3D bq27xxx_simple_value(di->cache.capacity, val);
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
-		ret =3D bq27x00_battery_capacity_level(di, val);
+		ret =3D bq27xxx_battery_capacity_level(di, val);
 		break;
 	case POWER_SUPPLY_PROP_TEMP:
-		ret =3D bq27x00_simple_value(di->cache.temperature, val);
+		ret =3D bq27xxx_simple_value(di->cache.temperature, val);
 		if (ret =3D=3D 0)
 			val->intval -=3D 2731;
 		break;
 	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
-		ret =3D bq27x00_simple_value(di->cache.time_to_empty, val);
+		ret =3D bq27xxx_simple_value(di->cache.time_to_empty, val);
 		break;
 	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG:
-		ret =3D bq27x00_simple_value(di->cache.time_to_empty_avg, val);
+		ret =3D bq27xxx_simple_value(di->cache.time_to_empty_avg, val);
 		break;
 	case POWER_SUPPLY_PROP_TIME_TO_FULL_NOW:
-		ret =3D bq27x00_simple_value(di->cache.time_to_full, val);
+		ret =3D bq27xxx_simple_value(di->cache.time_to_full, val);
 		break;
 	case POWER_SUPPLY_PROP_TECHNOLOGY:
 		val->intval =3D POWER_SUPPLY_TECHNOLOGY_LION;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
-		ret =3D bq27x00_simple_value(bq27x00_battery_read_nac(di), val);
+		ret =3D bq27xxx_simple_value(bq27xxx_battery_read_nac(di), val);
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
-		ret =3D bq27x00_simple_value(di->cache.charge_full, val);
+		ret =3D bq27xxx_simple_value(di->cache.charge_full, val);
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
-		ret =3D bq27x00_simple_value(di->charge_design_full, val);
+		ret =3D bq27xxx_simple_value(di->charge_design_full, val);
 		break;
 	case POWER_SUPPLY_PROP_CYCLE_COUNT:
-		ret =3D bq27x00_simple_value(di->cache.cycle_count, val);
+		ret =3D bq27xxx_simple_value(di->cache.cycle_count, val);
 		break;
 	case POWER_SUPPLY_PROP_ENERGY_NOW:
-		ret =3D bq27x00_simple_value(di->cache.energy, val);
+		ret =3D bq27xxx_simple_value(di->cache.energy, val);
 		break;
 	case POWER_SUPPLY_PROP_POWER_AVG:
-		ret =3D bq27x00_simple_value(di->cache.power_avg, val);
+		ret =3D bq27xxx_simple_value(di->cache.power_avg, val);
 		break;
 	case POWER_SUPPLY_PROP_HEALTH:
-		ret =3D bq27x00_simple_value(di->cache.health, val);
+		ret =3D bq27xxx_simple_value(di->cache.health, val);
 		break;
 	case POWER_SUPPLY_PROP_MANUFACTURER:
 		val->strval =3D BQ27XXX_MANUFACTURER;
@@ -766,15 +766,15 @@ static int bq27x00_battery_get_property(struct po=
wer_supply *psy,
 	return ret;
 }
=20
-static void bq27x00_external_power_changed(struct power_supply *psy)
+static void bq27xxx_external_power_changed(struct power_supply *psy)
 {
-	struct bq27x00_device_info *di =3D power_supply_get_drvdata(psy);
+	struct bq27xxx_device_info *di =3D power_supply_get_drvdata(psy);
=20
 	cancel_delayed_work_sync(&di->work);
 	schedule_delayed_work(&di->work, 0);
 }
=20
-static int bq27x00_powersupply_init(struct bq27x00_device_info *di,
+static int bq27xxx_powersupply_init(struct bq27xxx_device_info *di,
 				    const char *name)
 {
 	int ret;
@@ -800,10 +800,10 @@ static int bq27x00_powersupply_init(struct bq27x0=
0_device_info *di,
 		psy_desc->properties =3D bq27x00_battery_props;
 		psy_desc->num_properties =3D ARRAY_SIZE(bq27x00_battery_props);
 	}
-	psy_desc->get_property =3D bq27x00_battery_get_property;
-	psy_desc->external_power_changed =3D bq27x00_external_power_changed;
+	psy_desc->get_property =3D bq27xxx_battery_get_property;
+	psy_desc->external_power_changed =3D bq27xxx_external_power_changed;
=20
-	INIT_DELAYED_WORK(&di->work, bq27x00_battery_poll);
+	INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
 	mutex_init(&di->lock);
=20
 	di->bat =3D power_supply_register_no_ws(di->dev, psy_desc, &psy_cfg);
@@ -815,17 +815,17 @@ static int bq27x00_powersupply_init(struct bq27x0=
0_device_info *di,
=20
 	dev_info(di->dev, "support ver. %s enabled\n", DRIVER_VERSION);
=20
-	bq27x00_update(di);
+	bq27xxx_battery_update(di);
=20
 	return 0;
 }
=20
-static void bq27x00_powersupply_unregister(struct bq27x00_device_info =
*di)
+static void bq27xxx_powersupply_unregister(struct bq27xxx_device_info =
*di)
 {
 	/*
-	 * power_supply_unregister call bq27x00_battery_get_property which
-	 * call bq27x00_battery_poll.
-	 * Make sure that bq27x00_battery_poll will not call
+	 * power_supply_unregister call bq27xxx_battery_get_property which
+	 * call bq27xxx_battery_poll.
+	 * Make sure that bq27xxx_battery_poll will not call
 	 * schedule_delayed_work again after unregister (which cause OOPS).
 	 */
 	poll_interval =3D 0;
@@ -838,7 +838,7 @@ static void bq27x00_powersupply_unregister(struct b=
q27x00_device_info *di)
 }
=20
 /* i2c specific code */
-#ifdef CONFIG_BATTERY_BQ27X00_I2C
+#ifdef CONFIG_BATTERY_BQ27XXX_I2C
=20
 /* If the system has several batteries we need a different name for ea=
ch
  * of them...
@@ -846,7 +846,8 @@ static void bq27x00_powersupply_unregister(struct b=
q27x00_device_info *di)
 static DEFINE_IDR(battery_id);
 static DEFINE_MUTEX(battery_mutex);
=20
-static int bq27x00_read_i2c(struct bq27x00_device_info *di, u8 reg, bo=
ol single)
+static int bq27xxx_battery_i2c_read(struct bq27xxx_device_info *di, u8=
 reg,
+				    bool single)
 {
 	struct i2c_client *client =3D to_i2c_client(di->dev);
 	struct i2c_msg msg[2];
@@ -880,11 +881,11 @@ static int bq27x00_read_i2c(struct bq27x00_device=
_info *di, u8 reg, bool single)
 	return ret;
 }
=20
-static int bq27x00_battery_probe(struct i2c_client *client,
-				 const struct i2c_device_id *id)
+static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
+				     const struct i2c_device_id *id)
 {
 	char *name;
-	struct bq27x00_device_info *di;
+	struct bq27xxx_device_info *di;
 	int num;
 	int retval =3D 0;
=20
@@ -910,9 +911,9 @@ static int bq27x00_battery_probe(struct i2c_client =
*client,
 	di->id =3D num;
 	di->dev =3D &client->dev;
 	di->chip =3D id->driver_data;
-	di->bus.read =3D &bq27x00_read_i2c;
+	di->bus.read =3D &bq27xxx_battery_i2c_read;
=20
-	retval =3D bq27x00_powersupply_init(di, name);
+	retval =3D bq27xxx_powersupply_init(di, name);
 	if (retval)
 		goto batt_failed;
=20
@@ -928,11 +929,11 @@ batt_failed:
 	return retval;
 }
=20
-static int bq27x00_battery_remove(struct i2c_client *client)
+static int bq27xxx_battery_i2c_remove(struct i2c_client *client)
 {
-	struct bq27x00_device_info *di =3D i2c_get_clientdata(client);
+	struct bq27xxx_device_info *di =3D i2c_get_clientdata(client);
=20
-	bq27x00_powersupply_unregister(di);
+	bq27xxx_powersupply_unregister(di);
=20
 	mutex_lock(&battery_mutex);
 	idr_remove(&battery_id, di->id);
@@ -941,7 +942,7 @@ static int bq27x00_battery_remove(struct i2c_client=
 *client)
 	return 0;
 }
=20
-static const struct i2c_device_id bq27x00_id[] =3D {
+static const struct i2c_device_id bq27xxx_id[] =3D {
 	{ "bq27200", BQ27000 },	/* bq27200 is same as bq27000, but with i2c *=
/
 	{ "bq27500", BQ27500 },
 	{ "bq27425", BQ27425 },
@@ -949,47 +950,47 @@ static const struct i2c_device_id bq27x00_id[] =3D=
 {
 	{ "bq27510", BQ27510 },
 	{},
 };
-MODULE_DEVICE_TABLE(i2c, bq27x00_id);
+MODULE_DEVICE_TABLE(i2c, bq27xxx_id);
=20
-static struct i2c_driver bq27x00_battery_driver =3D {
+static struct i2c_driver bq27xxx_battery_i2c_driver =3D {
 	.driver =3D {
-		.name =3D "bq27x00-battery",
+		.name =3D "bq27xxx-battery",
 	},
-	.probe =3D bq27x00_battery_probe,
-	.remove =3D bq27x00_battery_remove,
-	.id_table =3D bq27x00_id,
+	.probe =3D bq27xxx_battery_i2c_probe,
+	.remove =3D bq27xxx_battery_i2c_remove,
+	.id_table =3D bq27xxx_id,
 };
=20
-static inline int bq27x00_battery_i2c_init(void)
+static inline int bq27xxx_battery_i2c_init(void)
 {
-	int ret =3D i2c_add_driver(&bq27x00_battery_driver);
+	int ret =3D i2c_add_driver(&bq27xxx_battery_i2c_driver);
=20
 	if (ret)
-		pr_err("Unable to register BQ27x00 i2c driver\n");
+		pr_err("Unable to register BQ27xxx i2c driver\n");
=20
 	return ret;
 }
=20
-static inline void bq27x00_battery_i2c_exit(void)
+static inline void bq27xxx_battery_i2c_exit(void)
 {
-	i2c_del_driver(&bq27x00_battery_driver);
+	i2c_del_driver(&bq27xxx_battery_i2c_driver);
 }
=20
 #else
=20
-static inline int bq27x00_battery_i2c_init(void) { return 0; }
-static inline void bq27x00_battery_i2c_exit(void) {};
+static inline int bq27xxx_battery_i2c_init(void) { return 0; }
+static inline void bq27xxx_battery_i2c_exit(void) {};
=20
 #endif
=20
 /* platform specific code */
-#ifdef CONFIG_BATTERY_BQ27X00_PLATFORM
+#ifdef CONFIG_BATTERY_BQ27XXX_PLATFORM
=20
-static int bq27000_read_platform(struct bq27x00_device_info *di, u8 re=
g,
-				 bool single)
+static int bq27xxx_battery_platform_read(struct bq27xxx_device_info *d=
i, u8 reg,
+					 bool single)
 {
 	struct device *dev =3D di->dev;
-	struct bq27000_platform_data *pdata =3D dev->platform_data;
+	struct bq27xxx_platform_data *pdata =3D dev->platform_data;
 	unsigned int timeout =3D 3;
 	int upper, lower;
 	int temp;
@@ -1019,10 +1020,10 @@ static int bq27000_read_platform(struct bq27x00=
_device_info *di, u8 reg,
 	return pdata->read(dev, reg);
 }
=20
-static int bq27000_battery_probe(struct platform_device *pdev)
+static int bq27xxx_battery_platform_probe(struct platform_device *pdev=
)
 {
-	struct bq27x00_device_info *di;
-	struct bq27000_platform_data *pdata =3D pdev->dev.platform_data;
+	struct bq27xxx_device_info *di;
+	struct bq27xxx_platform_data *pdata =3D pdev->dev.platform_data;
 	const char *name;
=20
 	if (!pdata) {
@@ -1045,47 +1046,47 @@ static int bq27000_battery_probe(struct platfor=
m_device *pdev)
 	di->chip =3D BQ27000;
=20
 	name =3D pdata->name ?: dev_name(&pdev->dev);
-	di->bus.read =3D &bq27000_read_platform;
+	di->bus.read =3D &bq27xxx_battery_platform_read;
=20
-	return bq27x00_powersupply_init(di, name);
+	return bq27xxx_powersupply_init(di, name);
 }
=20
-static int bq27000_battery_remove(struct platform_device *pdev)
+static int bq27xxx_battery_platform_remove(struct platform_device *pde=
v)
 {
-	struct bq27x00_device_info *di =3D platform_get_drvdata(pdev);
+	struct bq27xxx_device_info *di =3D platform_get_drvdata(pdev);
=20
-	bq27x00_powersupply_unregister(di);
+	bq27xxx_powersupply_unregister(di);
=20
 	return 0;
 }
=20
-static struct platform_driver bq27000_battery_driver =3D {
-	.probe	=3D bq27000_battery_probe,
-	.remove =3D bq27000_battery_remove,
+static struct platform_driver bq27xxx_battery_platform_driver =3D {
+	.probe	=3D bq27xxx_battery_platform_probe,
+	.remove =3D bq27xxx_battery_platform_remove,
 	.driver =3D {
 		.name =3D "bq27000-battery",
 	},
 };
=20
-static inline int bq27x00_battery_platform_init(void)
+static inline int bq27xxx_battery_platform_init(void)
 {
-	int ret =3D platform_driver_register(&bq27000_battery_driver);
+	int ret =3D platform_driver_register(&bq27xxx_battery_platform_driver=
);
=20
 	if (ret)
-		pr_err("Unable to register BQ27000 platform driver\n");
+		pr_err("Unable to register BQ27xxx platform driver\n");
=20
 	return ret;
 }
=20
-static inline void bq27x00_battery_platform_exit(void)
+static inline void bq27xxx_battery_platform_exit(void)
 {
-	platform_driver_unregister(&bq27000_battery_driver);
+	platform_driver_unregister(&bq27xxx_battery_platform_driver);
 }
=20
 #else
=20
-static inline int bq27x00_battery_platform_init(void) { return 0; }
-static inline void bq27x00_battery_platform_exit(void) {};
+static inline int bq27xxx_battery_platform_init(void) { return 0; }
+static inline void bq27xxx_battery_platform_exit(void) {};
=20
 #endif
=20
@@ -1093,33 +1094,33 @@ static inline void bq27x00_battery_platform_exi=
t(void) {};
  * Module stuff
  */
=20
-static int __init bq27x00_battery_init(void)
+static int __init bq27xxx_battery_init(void)
 {
 	int ret;
=20
-	ret =3D bq27x00_battery_i2c_init();
+	ret =3D bq27xxx_battery_i2c_init();
 	if (ret)
 		return ret;
=20
-	ret =3D bq27x00_battery_platform_init();
+	ret =3D bq27xxx_battery_platform_init();
 	if (ret)
-		bq27x00_battery_i2c_exit();
+		bq27xxx_battery_i2c_exit();
=20
 	return ret;
 }
-module_init(bq27x00_battery_init);
+module_init(bq27xxx_battery_init);
=20
-static void __exit bq27x00_battery_exit(void)
+static void __exit bq27xxx_battery_exit(void)
 {
-	bq27x00_battery_platform_exit();
-	bq27x00_battery_i2c_exit();
+	bq27xxx_battery_platform_exit();
+	bq27xxx_battery_i2c_exit();
 }
-module_exit(bq27x00_battery_exit);
+module_exit(bq27xxx_battery_exit);
=20
-#ifdef CONFIG_BATTERY_BQ27X00_PLATFORM
+#ifdef CONFIG_BATTERY_BQ27XXX_PLATFORM
 MODULE_ALIAS("platform:bq27000-battery");
 #endif
=20
 MODULE_AUTHOR("Rodolfo Giometti <giometti@linux.it>");
-MODULE_DESCRIPTION("BQ27x00 battery monitor driver");
+MODULE_DESCRIPTION("BQ27xxx battery monitor driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/w1/slaves/w1_bq27000.c b/drivers/w1/slaves/w1_bq27=
000.c
index caafb17..8480531 100644
--- a/drivers/w1/slaves/w1_bq27000.c
+++ b/drivers/w1/slaves/w1_bq27000.c
@@ -15,7 +15,7 @@
 #include <linux/types.h>
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
-#include <linux/power/bq27x00_battery.h>
+#include <linux/power/bq27xxx_battery.h>
=20
 #include "../w1.h"
 #include "../w1_int.h"
@@ -39,7 +39,7 @@ static int w1_bq27000_read(struct device *dev, unsign=
ed int reg)
 	return val;
 }
=20
-static struct bq27000_platform_data bq27000_battery_info =3D {
+static struct bq27xxx_platform_data bq27000_battery_info =3D {
 	.read   =3D w1_bq27000_read,
 	.name   =3D "bq27000-battery",
 };
diff --git a/include/linux/power/bq27x00_battery.h b/include/linux/powe=
r/bq27xxx_battery.h
similarity index 85%
rename from include/linux/power/bq27x00_battery.h
rename to include/linux/power/bq27xxx_battery.h
index a857f71..e70a93a 100644
--- a/include/linux/power/bq27x00_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -2,7 +2,7 @@
 #define __LINUX_BQ27X00_BATTERY_H__
=20
 /**
- * struct bq27000_plaform_data - Platform data for bq27000 devices
+ * struct bq27xxx_plaform_data - Platform data for bq27xxx devices
  * @name: Name of the battery. If NULL the driver will fallback to "bq=
27000".
  * @read: HDQ read callback.
  *	This function should provide access to the HDQ bus the battery is
@@ -11,7 +11,7 @@
  *	register to be read. The return value should either be the content =
of
  *	the passed register or an error value.
  */
-struct bq27000_platform_data {
+struct bq27xxx_platform_data {
 	const char *name;
 	int (*read)(struct device *dev, unsigned int);
 };
--=20
1.9.1
