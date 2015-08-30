From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH] power: Remove unnecessary MODULE_ALIAS() for I2C drivers
Date: Mon, 31 Aug 2015 01:18:35 +0200
Message-ID: <1440976715-23588-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:32987 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751879AbbH3XSp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 30 Aug 2015 19:18:45 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>

These drivers already have an I2C device id table that is used to create
module aliases and the used MODULE_ALIAS() was either already in the I2C
table so it was redundant or wasn't a valid I2C id so it was never used.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/power/bq24190_charger.c | 1 -
 drivers/power/bq27x00_battery.c | 4 ----
 drivers/power/pm2301_charger.c  | 1 -
 drivers/power/rt9455_charger.c  | 1 -
 drivers/power/smb347-charger.c  | 1 -
 5 files changed, 8 deletions(-)

diff --git a/drivers/power/bq24190_charger.c b/drivers/power/bq24190_charger.c
index 469a452cbe10..f5746b9f4e83 100644
--- a/drivers/power/bq24190_charger.c
+++ b/drivers/power/bq24190_charger.c
@@ -1543,5 +1543,4 @@ module_i2c_driver(bq24190_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Mark A. Greer <mgreer@animalcreek.com>");
-MODULE_ALIAS("i2c:bq24190-charger");
 MODULE_DESCRIPTION("TI BQ24190 Charger Driver");
diff --git a/drivers/power/bq27x00_battery.c b/drivers/power/bq27x00_battery.c
index 8287261fd978..d0b2f3b47b8f 100644
--- a/drivers/power/bq27x00_battery.c
+++ b/drivers/power/bq27x00_battery.c
@@ -1120,10 +1120,6 @@ module_exit(bq27x00_battery_exit);
 MODULE_ALIAS("platform:bq27000-battery");
 #endif
 
-#ifdef CONFIG_BATTERY_BQ27X00_I2C
-MODULE_ALIAS("i2c:bq27000-battery");
-#endif
-
 MODULE_AUTHOR("Rodolfo Giometti <giometti@linux.it>");
 MODULE_DESCRIPTION("BQ27x00 battery monitor driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/power/pm2301_charger.c b/drivers/power/pm2301_charger.c
index 3a45cc0c4dce..8f9bd1d0eeb6 100644
--- a/drivers/power/pm2301_charger.c
+++ b/drivers/power/pm2301_charger.c
@@ -1264,5 +1264,4 @@ module_exit(pm2xxx_charger_exit);
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Rajkumar kasirajan, Olivier Launay");
-MODULE_ALIAS("i2c:pm2xxx-charger");
 MODULE_DESCRIPTION("PM2xxx charger management driver");
diff --git a/drivers/power/rt9455_charger.c b/drivers/power/rt9455_charger.c
index a49a9d44bdda..cfdbde9daf94 100644
--- a/drivers/power/rt9455_charger.c
+++ b/drivers/power/rt9455_charger.c
@@ -1760,5 +1760,4 @@ module_i2c_driver(rt9455_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Anda-Maria Nicolae <anda-maria.nicolae@intel.com>");
-MODULE_ALIAS("i2c:rt9455-charger");
 MODULE_DESCRIPTION("Richtek RT9455 Charger Driver");
diff --git a/drivers/power/smb347-charger.c b/drivers/power/smb347-charger.c
index 0b60a0b5878b..072c5189bd6d 100644
--- a/drivers/power/smb347-charger.c
+++ b/drivers/power/smb347-charger.c
@@ -1332,4 +1332,3 @@ MODULE_AUTHOR("Bruce E. Robertson <bruce.e.robertson@intel.com>");
 MODULE_AUTHOR("Mika Westerberg <mika.westerberg@linux.intel.com>");
 MODULE_DESCRIPTION("SMB347 battery charger driver");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("i2c:smb347");
-- 
2.4.3

