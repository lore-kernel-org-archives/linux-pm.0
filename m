From: Andi Shyti <andi.shyti@gmail.com>
Subject: [PATCH] power: supply: charger manager: refactor return statements
Date: Thu, 30 Mar 2017 00:13:57 +0900
Message-ID: <20170329151357.1841-1-andi@etezian.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34274 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752108AbdC2POK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Mar 2017 11:14:10 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Jiri Kosina <trivial@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>, Andi Shyti <andi.shyti@samsung.com>

Some trivial improvements on the returning value of the
functions:

 - remove unnecessary goto labels that just return, return
   immediately, instead.

 - do not initialize when not needed.

 - return the value from the calling function that fails instead
   of politically choosing -EINVAL.

Signed-off-by: Andi Shyti <andi@etezian.org>
---
 drivers/power/supply/charger-manager.c | 35 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index e664ca7c0afd..adc3761831e1 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1198,7 +1198,7 @@ static int charger_extcon_notifier(struct notifier_block *self,
 static int charger_extcon_init(struct charger_manager *cm,
 		struct charger_cable *cable)
 {
-	int ret = 0;
+	int ret;
 
 	/*
 	 * Charger manager use Extcon framework to identify
@@ -1232,7 +1232,7 @@ static int charger_manager_register_extcon(struct charger_manager *cm)
 {
 	struct charger_desc *desc = cm->desc;
 	struct charger_regulator *charger;
-	int ret = 0;
+	int ret;
 	int i;
 	int j;
 
@@ -1255,15 +1255,14 @@ static int charger_manager_register_extcon(struct charger_manager *cm)
 			if (ret < 0) {
 				dev_err(cm->dev, "Cannot initialize charger(%s)\n",
 					charger->regulator_name);
-				goto err;
+				return ret;
 			}
 			cable->charger = charger;
 			cable->cm = cm;
 		}
 	}
 
-err:
-	return ret;
+	return 0;
 }
 
 /* help function of sysfs node to control charger(regulator) */
@@ -1372,7 +1371,7 @@ static int charger_manager_register_sysfs(struct charger_manager *cm)
 	int chargers_externally_control = 1;
 	char buf[11];
 	char *str;
-	int ret = 0;
+	int ret;
 	int i;
 
 	/* Create sysfs entry to control charger(regulator) */
@@ -1382,10 +1381,9 @@ static int charger_manager_register_sysfs(struct charger_manager *cm)
 		snprintf(buf, 10, "charger.%d", i);
 		str = devm_kzalloc(cm->dev,
 				sizeof(char) * (strlen(buf) + 1), GFP_KERNEL);
-		if (!str) {
-			ret = -ENOMEM;
-			goto err;
-		}
+		if (!str)
+			return -ENOMEM;
+
 		strcpy(str, buf);
 
 		charger->attrs[0] = &charger->attr_name.attr;
@@ -1426,19 +1424,16 @@ static int charger_manager_register_sysfs(struct charger_manager *cm)
 		if (ret < 0) {
 			dev_err(cm->dev, "Cannot create sysfs entry of %s regulator\n",
 				charger->regulator_name);
-			ret = -EINVAL;
-			goto err;
+			return ret;
 		}
 	}
 
 	if (chargers_externally_control) {
 		dev_err(cm->dev, "Cannot register regulator because charger-manager must need at least one charger for charging battery\n");
-		ret = -EINVAL;
-		goto err;
+		return -EINVAL;
 	}
 
-err:
-	return ret;
+	return 0;
 }
 
 static int cm_init_thermal_data(struct charger_manager *cm,
@@ -1626,7 +1621,7 @@ static int charger_manager_probe(struct platform_device *pdev)
 {
 	struct charger_desc *desc = cm_get_drv_data(pdev);
 	struct charger_manager *cm;
-	int ret = 0, i = 0;
+	int ret, i = 0;
 	int j = 0;
 	union power_supply_propval val;
 	struct power_supply *fuel_gauge;
@@ -1887,14 +1882,12 @@ MODULE_DEVICE_TABLE(platform, charger_manager_id);
 
 static int cm_suspend_noirq(struct device *dev)
 {
-	int ret = 0;
-
 	if (device_may_wakeup(dev)) {
 		device_set_wakeup_capable(dev, false);
-		ret = -EAGAIN;
+		return -EAGAIN;
 	}
 
-	return ret;
+	return 0;
 }
 
 static bool cm_need_to_awake(void)
-- 
2.11.0
