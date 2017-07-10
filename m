From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH 4/4] power: supply: sbs-battery: Don't reset mode in get_battery_capacity
Date: Mon, 10 Jul 2017 14:23:20 +0800
Message-ID: <1499667800-69055-5-git-send-email-preid@electromag.com.au>
References: <1499667800-69055-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from anchovy1.45ru.net.au ([203.30.46.145]:51831 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751161AbdGJGaO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jul 2017 02:30:14 -0400
In-Reply-To: <1499667800-69055-1-git-send-email-preid@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, preid@electromag.com.au, linux-pm@vger.kernel.org, posted@heine.so

There seems little point in resetting the capacity mode bit when
reading a capacity register that is affected by this bit. The
next call to the register read will set the bit if it's not in
the correct mode.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/power/supply/sbs-battery.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 3473b45..441a576 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -491,22 +491,19 @@ static void  sbs_unit_adjustment(struct i2c_client *client,
 	}
 }
 
-static enum sbs_battery_mode sbs_set_battery_mode(struct i2c_client *client,
+static int sbs_set_battery_mode(struct i2c_client *client,
 	enum sbs_battery_mode mode)
 {
-	int ret, original_val;
+	int ret;
 
-	original_val = sbs_read_word_data(client, BATTERY_MODE_OFFSET);
-	if (original_val < 0)
-		return original_val;
+	ret = sbs_read_word_data(client, BATTERY_MODE_OFFSET);
+	if (ret < 0)
+		return ret;
 
-	if ((original_val & BATTERY_MODE_MASK) == mode)
-		return mode;
+	if ((ret & BATTERY_MODE_MASK) == mode)
+		return 0;
 
-	if (mode == BATTERY_MODE_AMPS)
-		ret = original_val & ~BATTERY_MODE_MASK;
-	else
-		ret = original_val | BATTERY_MODE_MASK;
+	ret = (ret & ~BATTERY_MODE_MASK) | mode;
 
 	ret = sbs_write_word_data(client, BATTERY_MODE_OFFSET, ret);
 	if (ret < 0)
@@ -514,7 +511,7 @@ static enum sbs_battery_mode sbs_set_battery_mode(struct i2c_client *client,
 
 	usleep_range(1000, 2000);
 
-	return original_val & BATTERY_MODE_MASK;
+	return 0;
 }
 
 static int sbs_get_battery_capacity(struct i2c_client *client,
@@ -527,9 +524,9 @@ static int sbs_get_battery_capacity(struct i2c_client *client,
 	if (power_supply_is_amp_property(psp))
 		mode = BATTERY_MODE_AMPS;
 
-	mode = sbs_set_battery_mode(client, mode);
-	if (mode < 0)
-		return mode;
+	ret = sbs_set_battery_mode(client, mode);
+	if (ret < 0)
+		return ret;
 
 	ret = sbs_read_word_data(client, sbs_data[reg_offset].addr);
 	if (ret < 0)
@@ -542,10 +539,6 @@ static int sbs_get_battery_capacity(struct i2c_client *client,
 	} else
 		val->intval = ret;
 
-	ret = sbs_set_battery_mode(client, mode);
-	if (ret < 0)
-		return ret;
-
 	return 0;
 }
 
-- 
1.8.3.1
