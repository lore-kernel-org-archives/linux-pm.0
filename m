From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH] power: bq27x00_battery: Add missing MODULE_ALIAS
Date: Thu, 30 Apr 2015 22:05:58 +0200
Message-ID: <1430424358-30244-1-git-send-email-marek@goldelico.com>
References: <1430252586-5104-1-git-send-email-marek@goldelico.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:35795 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbbD3UGI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Apr 2015 16:06:08 -0400
In-Reply-To: <1430252586-5104-1-git-send-email-marek@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, hns@goldelico.com, Marek Belisko <marek@goldelico.com>

Without MODULE_ALIAS bq27x00_battery module won't get loaded automatically.

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 drivers/power/bq27x00_battery.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/power/bq27x00_battery.c b/drivers/power/bq27x00_battery.c
index a57433d..b6b9837 100644
--- a/drivers/power/bq27x00_battery.c
+++ b/drivers/power/bq27x00_battery.c
@@ -1109,6 +1109,14 @@ static void __exit bq27x00_battery_exit(void)
 }
 module_exit(bq27x00_battery_exit);
 
+#ifdef CONFIG_BATTERY_BQ27X00_PLATFORM
+MODULE_ALIAS("platform:bq27000-battery");
+#endif
+
+#ifdef CONFIG_BATTERY_BQ27X00_I2C
+MODULE_ALIAS("i2c:bq27000-battery");
+#endif
+
 MODULE_AUTHOR("Rodolfo Giometti <giometti@linux.it>");
 MODULE_DESCRIPTION("BQ27x00 battery monitor driver");
 MODULE_LICENSE("GPL");
-- 
1.9.1

