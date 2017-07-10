From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH 2/4] power: supply: sbs-battery: sort includes
Date: Mon, 10 Jul 2017 14:23:18 +0800
Message-ID: <1499667800-69055-3-git-send-email-preid@electromag.com.au>
References: <1499667800-69055-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from anchovy2.45ru.net.au ([203.30.46.146]:47473 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751161AbdGJGaJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jul 2017 02:30:09 -0400
In-Reply-To: <1499667800-69055-1-git-send-email-preid@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, preid@electromag.com.au, linux-pm@vger.kernel.org, posted@heine.so

Sort the header includes prior to adding to the list.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/power/supply/sbs-battery.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 15873df..4594ed1 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -14,19 +14,18 @@
  * more details.
  */
 
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
 #include <linux/err.h>
-#include <linux/power_supply.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
-#include <linux/slab.h>
+#include <linux/init.h>
 #include <linux/interrupt.h>
-#include <linux/gpio/consumer.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of.h>
-#include <linux/stat.h>
-
 #include <linux/power/sbs-battery.h>
+#include <linux/power_supply.h>
+#include <linux/slab.h>
+#include <linux/stat.h>
 
 enum {
 	REG_MANUFACTURER_DATA,
@@ -57,7 +56,7 @@ enum {
 #define BATTERY_MODE_MASK		0x8000
 enum sbs_battery_mode {
 	BATTERY_MODE_AMPS = 0,
-	BATTERY_MODE_WATTS = 0x800
+	BATTERY_MODE_WATTS = 0x8000
 };
 
 /* manufacturer access defines */
-- 
1.8.3.1
