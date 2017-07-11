From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v2 2/3] power: supply: sbs-battery: sort includes
Date: Tue, 11 Jul 2017 17:43:42 +0800
Message-ID: <1499766223-130934-3-git-send-email-preid@electromag.com.au>
References: <1499766223-130934-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from anchovy2.45ru.net.au ([203.30.46.146]:37237 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752299AbdGKJns (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2017 05:43:48 -0400
In-Reply-To: <1499766223-130934-1-git-send-email-preid@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, preid@electromag.com.au, linux-pm@vger.kernel.org, posted@heine.so

Sort the header includes prior to adding to the list.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/power/supply/sbs-battery.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index d06c4ac..4594ed1 100644
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
-- 
1.8.3.1
