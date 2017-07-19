From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v2 1/2] power: supply: move HDQ interface for bq27xxx from w1 to power/supply
Date: Wed, 19 Jul 2017 12:04:06 -0500
Message-ID: <20170719170407.14005-2-afd@ti.com>
References: <20170719170407.14005-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:26642 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755101AbdGSRE7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jul 2017 13:04:59 -0400
In-Reply-To: <20170719170407.14005-1-afd@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Evgeniy Polyakov <zbr@ioremap.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>

The HDQ interface driver should be in this folder just like the I2C
interface driver. Move this driver out of drivers/w1/slave and into
drivers/power/supply.

Signed-off-by: Andrew F. Davis <afd@ti.com>
Acked-by: Pali Rohár <pali.rohar@gmail.com>
Acked-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/power/supply/Kconfig                                     | 9 +++++++++
 drivers/power/supply/Makefile                                    | 1 +
 .../slaves/w1_bq27000.c => power/supply/bq27xxx_battery_hdq.c}   | 2 --
 drivers/w1/slaves/Kconfig                                        | 6 ------
 drivers/w1/slaves/Makefile                                       | 1 -
 5 files changed, 10 insertions(+), 9 deletions(-)
 rename drivers/{w1/slaves/w1_bq27000.c => power/supply/bq27xxx_battery_hdq.c} (98%)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 969f5005669c..af6397224a82 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -198,6 +198,15 @@ config BATTERY_BQ27XXX_I2C
 	  Say Y here to enable support for batteries with BQ27xxx chips
 	  connected over an I2C bus.
 
+config BATTERY_BQ27XXX_HDQ
+	tristate "BQ27xxx HDQ support"
+	depends on BATTERY_BQ27XXX
+	depends on W1
+	default y
+	help
+	  Say Y here to enable support for batteries with BQ27xxx chips
+	  connected over an HDQ bus.
+
 config BATTERY_BQ27XXX_DT_UPDATES_NVM
 	bool "BQ27xxx support for update of NVM/flash data memory"
 	depends on BATTERY_BQ27XXX_I2C
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index a41f40957847..946a5e6be860 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_BATTERY_SBS)	+= sbs-battery.o
 obj-$(CONFIG_CHARGER_SBS)	+= sbs-charger.o
 obj-$(CONFIG_BATTERY_BQ27XXX)	+= bq27xxx_battery.o
 obj-$(CONFIG_BATTERY_BQ27XXX_I2C) += bq27xxx_battery_i2c.o
+obj-$(CONFIG_BATTERY_BQ27XXX_HDQ) += bq27xxx_battery_hdq.o
 obj-$(CONFIG_BATTERY_DA9030)	+= da9030_battery.o
 obj-$(CONFIG_BATTERY_DA9052)	+= da9052-battery.o
 obj-$(CONFIG_CHARGER_DA9150)	+= da9150-charger.o
diff --git a/drivers/w1/slaves/w1_bq27000.c b/drivers/power/supply/bq27xxx_battery_hdq.c
similarity index 98%
rename from drivers/w1/slaves/w1_bq27000.c
rename to drivers/power/supply/bq27xxx_battery_hdq.c
index 8046ac45381a..f4df67eb9d2c 100644
--- a/drivers/w1/slaves/w1_bq27000.c
+++ b/drivers/power/supply/bq27xxx_battery_hdq.c
@@ -1,6 +1,4 @@
 /*
- * drivers/w1/slaves/w1_bq27000.c
- *
  * Copyright (C) 2007 Texas Instruments, Inc.
  *
  * This file is licensed under the terms of the GNU General Public License
diff --git a/drivers/w1/slaves/Kconfig b/drivers/w1/slaves/Kconfig
index fb68465908f2..dc4437683956 100644
--- a/drivers/w1/slaves/Kconfig
+++ b/drivers/w1/slaves/Kconfig
@@ -140,10 +140,4 @@ config W1_SLAVE_DS28E04
 
 	  If you are unsure, say N.
 
-config W1_SLAVE_BQ27000
-	tristate "BQ27000 slave support"
-	help
-	  Say Y here if you want to use a hdq
-	  bq27000 slave support.
-
 endmenu
diff --git a/drivers/w1/slaves/Makefile b/drivers/w1/slaves/Makefile
index 54c63e420302..e59441a5e157 100644
--- a/drivers/w1/slaves/Makefile
+++ b/drivers/w1/slaves/Makefile
@@ -15,5 +15,4 @@ obj-$(CONFIG_W1_SLAVE_DS2438)	+= w1_ds2438.o
 obj-$(CONFIG_W1_SLAVE_DS2760)	+= w1_ds2760.o
 obj-$(CONFIG_W1_SLAVE_DS2780)	+= w1_ds2780.o
 obj-$(CONFIG_W1_SLAVE_DS2781)	+= w1_ds2781.o
-obj-$(CONFIG_W1_SLAVE_BQ27000)	+= w1_bq27000.o
 obj-$(CONFIG_W1_SLAVE_DS28E04)	+= w1_ds28e04.o
-- 
2.13.0
