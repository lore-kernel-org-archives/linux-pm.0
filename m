From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v3 1/6] power: bq27x00_battery: Remove unneeded i2c MODULE_ALIAS
Date: Wed, 5 Aug 2015 11:05:35 -0500
Message-ID: <1438790740-29856-2-git-send-email-afd@ti.com>
References: <1438790740-29856-1-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46307 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751294AbbHEQHv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 5 Aug 2015 12:07:51 -0400
In-Reply-To: <1438790740-29856-1-git-send-email-afd@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Murphy <dmurphy@ti.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>

The MODULE_DEVICE_TABLE macro automatically adds all needed
i2c MODULE_ALIASes so remove the extra MODULE_ALIAS.

Signed-off-by: Andrew F. Davis <afd@ti.com>
Acked-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 drivers/power/bq27x00_battery.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/power/bq27x00_battery.c b/drivers/power/bq27x00_ba=
ttery.c
index 8287261f..d0b2f3b 100644
--- a/drivers/power/bq27x00_battery.c
+++ b/drivers/power/bq27x00_battery.c
@@ -1120,10 +1120,6 @@ module_exit(bq27x00_battery_exit);
 MODULE_ALIAS("platform:bq27000-battery");
 #endif
=20
-#ifdef CONFIG_BATTERY_BQ27X00_I2C
-MODULE_ALIAS("i2c:bq27000-battery");
-#endif
-
 MODULE_AUTHOR("Rodolfo Giometti <giometti@linux.it>");
 MODULE_DESCRIPTION("BQ27x00 battery monitor driver");
 MODULE_LICENSE("GPL");
--=20
1.9.1

