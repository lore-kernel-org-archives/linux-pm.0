From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v4 1/7] power: bq27x00_battery: Remove unneeded i2c MODULE_ALIAS
Date: Mon, 14 Sep 2015 16:26:07 -0500
Message-ID: <1442265973-32261-2-git-send-email-afd@ti.com>
References: <1442265973-32261-1-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45818 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbbINV0q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Sep 2015 17:26:46 -0400
In-Reply-To: <1442265973-32261-1-git-send-email-afd@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Dan Murphy <dmurphy@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>

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

