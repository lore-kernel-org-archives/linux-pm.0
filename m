From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH] charger-manager: Fix a bug in checking battery temperature.
Date: Tue, 21 Jan 2014 18:48:52 +0900
Message-ID: <1390297732-2708-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:8220 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754248AbaAUJtL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jan 2014 04:49:11 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MZQ00MD6WLY4A40@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 21 Jan 2014 18:49:10 +0900 (KST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: anton@enomsg.org, dan.carpenter@oracle.com, dwmw2@infradead.org, Jonghwa Lee <jonghwa3.lee@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>

Removing faulty typecast which converts 'int *' to 'unsigned long *'.
It would make unintended result for 64bit machine especially using Big-endian.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 drivers/power/charger-manager.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/power/charger-manager.c b/drivers/power/charger-manager.c
index ec5c140..8f73790 100644
--- a/drivers/power/charger-manager.c
+++ b/drivers/power/charger-manager.c
@@ -560,15 +560,20 @@ static int cm_get_battery_temperature(struct charger_manager *cm,
 		return -ENODEV;
 
 #ifdef CONFIG_THERMAL
-	ret = thermal_zone_get_temp(cm->tzd_batt, (unsigned long *)temp);
-	if (!ret)
-		/* Calibrate temperature unit */
-		*temp /= 100;
-#else
+	if (cm->tzd_batt && !IS_ERR(cm->tzd_batt)) {
+		unsigned long _temp;
+		ret = thermal_zone_get_temp(cm->tzd_batt, &_temp);
+		if (!ret) {
+			/* Calibrate temperature unit */
+			_temp /= 100;
+			*temp = _temp;
+			return 0;
+		}
+	}
+#endif
 	ret = cm->fuel_gauge->get_property(cm->fuel_gauge,
 				POWER_SUPPLY_PROP_TEMP,
 				(union power_supply_propval *)temp);
-#endif
 	return ret;
 }
 
-- 
1.7.9.5

