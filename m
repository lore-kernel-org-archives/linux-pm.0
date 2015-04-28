From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH] power: bq27x00_battery: Add missing MODULE_ALIAS
Date: Tue, 28 Apr 2015 22:23:06 +0200
Message-ID: <1430252586-5104-1-git-send-email-marek@goldelico.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35614 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965298AbbD1UXU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Apr 2015 16:23:20 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, hns@goldelico.com, Marek Belisko <marek@goldelico.com>

Without MODULE_ALIAS bq27x00_battery module won't get loaded automatically.

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 drivers/power/bq27x00_battery.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/power/bq27x00_battery.c b/drivers/power/bq27x00_battery.c
index a57433d..542927e 100644
--- a/drivers/power/bq27x00_battery.c
+++ b/drivers/power/bq27x00_battery.c
@@ -1109,6 +1109,12 @@ static void __exit bq27x00_battery_exit(void)
 }
 module_exit(bq27x00_battery_exit);
 
+#ifdef CONFIG_BATTERY_BQ27X00_PLATFORM
+MODULE_ALIAS("platform:bq27000-battery");
+#else
+MODULE_ALIAS("i2c:bq27000-battery");
+#endif
+
 MODULE_AUTHOR("Rodolfo Giometti <giometti@linux.it>");
 MODULE_DESCRIPTION("BQ27x00 battery monitor driver");
 MODULE_LICENSE("GPL");
-- 
1.9.1

