From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v2 3/3] power: supply: sbs-battery: Add delay when changing capacity mode bit
Date: Tue, 11 Jul 2017 17:43:43 +0800
Message-ID: <1499766223-130934-4-git-send-email-preid@electromag.com.au>
References: <1499766223-130934-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from anchovy3.45ru.net.au ([203.30.46.155]:45850 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753105AbdGKJnt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2017 05:43:49 -0400
In-Reply-To: <1499766223-130934-1-git-send-email-preid@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, preid@electromag.com.au, linux-pm@vger.kernel.org, posted@heine.so

At least with the Inspired Energy compatible batteries a delay is required
after setting the capacity mode bit from amp to watts or the reverse.
Setting the bit and then immediately pooling the status register results
in an unknown error being returned in the register. Add the delay results
in and ok status being return. This was also seen when reading the charge
and energy registers where the wrong value was returned for the requested
mode.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/power/supply/sbs-battery.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 4594ed1..3473b45 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -14,6 +14,7 @@
  * more details.
  */
 
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
@@ -511,6 +512,8 @@ static enum sbs_battery_mode sbs_set_battery_mode(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
+	usleep_range(1000, 2000);
+
 	return original_val & BATTERY_MODE_MASK;
 }
 
-- 
1.8.3.1
