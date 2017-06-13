From: Shawn Nematbakhsh <shawnn@chromium.org>
Subject: [PATCH 2/2] power: supply: sbs-battery: Don't needlessly set CAPACITY_MODE
Date: Tue, 13 Jun 2017 10:53:26 -0700
Message-ID: <1497376406-86470-2-git-send-email-shawnn@chromium.org>
References: <1497376406-86470-1-git-send-email-shawnn@chromium.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36171 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753761AbdFMRx7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jun 2017 13:53:59 -0400
Received: by mail-pf0-f173.google.com with SMTP id x63so71365723pff.3
        for <linux-pm@vger.kernel.org>; Tue, 13 Jun 2017 10:53:59 -0700 (PDT)
In-Reply-To: <1497376406-86470-1-git-send-email-shawnn@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: shawnn@chromium.org
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, groeck@chromium.org

According to the smart battery spec (1), the CAPACITY_MODE bit does not
influence the value read from RelativeStateOfCharge(), so don't bother
changing CAPACITY_MODE when doing such a read.

(1) - Smart Battery Data Specification, Rev 1.1, Dec. 11, 1998

Signed-off-by: Shawn Nematbakhsh <shawnn@chromium.org>
---
 drivers/power/supply/sbs-battery.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index d7e68fd97099..4bae210d5a8a 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -439,6 +439,11 @@ static int sbs_get_battery_property(struct i2c_client *client,
 	} else {
 		if (psp == POWER_SUPPLY_PROP_STATUS)
 			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
+		else if (psp == POWER_SUPPLY_PROP_CAPACITY)
+			/* sbs spec says that this can be >100 %
+			 * even if max value is 100 %
+			 */
+			val->intval = min(ret, 100);
 		else
 			val->intval = 0;
 	}
@@ -549,12 +554,7 @@ static int sbs_get_battery_capacity(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
-	if (psp == POWER_SUPPLY_PROP_CAPACITY) {
-		/* sbs spec says that this can be >100 %
-		* even if max value is 100 % */
-		val->intval = min(ret, 100);
-	} else
-		val->intval = ret;
+	val->intval = ret;
 
 	ret = sbs_set_battery_mode(client, mode);
 	if (ret < 0)
@@ -619,7 +619,6 @@ static int sbs_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
 	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
-	case POWER_SUPPLY_PROP_CAPACITY:
 		ret = sbs_get_property_index(client, psp);
 		if (ret < 0)
 			break;
@@ -647,6 +646,7 @@ static int sbs_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_TIME_TO_FULL_AVG:
 	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
 	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
+	case POWER_SUPPLY_PROP_CAPACITY:
 		ret = sbs_get_property_index(client, psp);
 		if (ret < 0)
 			break;
-- 
2.13.1.508.gb3defc5cc-goog
