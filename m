From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v2 1/6] power: bq27x00_battery: Remove unneeded i2c MODULE_ALIAS
Date: Tue, 28 Jul 2015 14:39:08 -0500
Message-ID: <1438112353-19704-2-git-send-email-afd@ti.com>
References: <1438112353-19704-1-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438112353-19704-1-git-send-email-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Murphy <dmurphy@ti.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>
List-Id: linux-pm@vger.kernel.org

The MODULE_DEVICE_TABLE macro automatically adds all needed
i2c MODULE_ALIASes so remove the extra MODULE_ALIAS.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/power/bq27x00_battery.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/power/bq27x00_battery.c b/drivers/power/bq27x00_battery.c
index 8287261f..d0b2f3b 100644
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
-- 
1.9.1
