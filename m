From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH 1/3] charger-manager : Replace kzalloc to devm_kzalloc and
 remove uneccessary code.
Date: Fri, 25 Oct 2013 11:47:31 +0900
Message-ID: <1382669253-23629-2-git-send-email-jonghwa3.lee@samsung.com>
References: <1382669253-23629-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:34857 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754392Ab3JYCru (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Oct 2013 22:47:50 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MV7008YHEDVL540@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Fri, 25 Oct 2013 11:47:48 +0900 (KST)
In-reply-to: <1382669253-23629-1-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: anton@enomsg.org, dwmw2@infradead.org, myungjoo.ham@samsung.com, cw00.choi@samsung.com, Jonghwa Lee <jonghwa3.lee@samsung.com>

Use devm function for dynamic memory allocation.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>
---
 drivers/power/charger-manager.c |   85 +++++++++++++--------------------------
 1 file changed, 27 insertions(+), 58 deletions(-)

diff --git a/drivers/power/charger-manager.c b/drivers/power/charger-manager.c
index e30e847..7287c0e 100644
--- a/drivers/power/charger-manager.c
+++ b/drivers/power/charger-manager.c
@@ -1378,7 +1378,8 @@ static int charger_manager_register_sysfs(struct charger_manager *cm)
 		charger = &desc->charger_regulators[i];
 
 		snprintf(buf, 10, "charger.%d", i);
-		str = kzalloc(sizeof(char) * (strlen(buf) + 1), GFP_KERNEL);
+		str = devm_kzalloc(cm->dev,
+				sizeof(char) * (strlen(buf) + 1), GFP_KERNEL);
 		if (!str) {
 			ret = -ENOMEM;
 			goto err;
@@ -1452,30 +1453,23 @@ static int charger_manager_probe(struct platform_device *pdev)
 			rtc_dev = NULL;
 			dev_err(&pdev->dev, "Cannot get RTC %s\n",
 				g_desc->rtc_name);
-			ret = -ENODEV;
-			goto err_alloc;
+			return -ENODEV;
 		}
 	}
 
 	if (!desc) {
 		dev_err(&pdev->dev, "No platform data (desc) found\n");
-		ret = -ENODEV;
-		goto err_alloc;
+		return -ENODEV;
 	}
 
-	cm = kzalloc(sizeof(struct charger_manager), GFP_KERNEL);
-	if (!cm) {
-		ret = -ENOMEM;
-		goto err_alloc;
-	}
+	cm = devm_kzalloc(&pdev->dev,
+			sizeof(struct charger_manager),	GFP_KERNEL);
+	if (!cm)
+		return -ENOMEM;
 
 	/* Basic Values. Unspecified are Null or 0 */
 	cm->dev = &pdev->dev;
-	cm->desc = kmemdup(desc, sizeof(struct charger_desc), GFP_KERNEL);
-	if (!cm->desc) {
-		ret = -ENOMEM;
-		goto err_alloc_desc;
-	}
+	cm->desc = desc;
 	cm->last_temp_mC = INT_MIN; /* denotes "unmeasured, yet" */
 
 	/*
@@ -1498,27 +1492,23 @@ static int charger_manager_probe(struct platform_device *pdev)
 	}
 
 	if (!desc->charger_regulators || desc->num_charger_regulators < 1) {
-		ret = -EINVAL;
 		dev_err(&pdev->dev, "charger_regulators undefined\n");
-		goto err_no_charger;
+		return -EINVAL;
 	}
 
 	if (!desc->psy_charger_stat || !desc->psy_charger_stat[0]) {
 		dev_err(&pdev->dev, "No power supply defined\n");
-		ret = -EINVAL;
-		goto err_no_charger_stat;
+		return -EINVAL;
 	}
 
 	/* Counting index only */
 	while (desc->psy_charger_stat[i])
 		i++;
 
-	cm->charger_stat = kzalloc(sizeof(struct power_supply *) * (i + 1),
-				   GFP_KERNEL);
-	if (!cm->charger_stat) {
-		ret = -ENOMEM;
-		goto err_no_charger_stat;
-	}
+	cm->charger_stat = devm_kzalloc(&pdev->dev,
+				sizeof(struct power_supply *) * i, GFP_KERNEL);
+	if (!cm->charger_stat)
+		return -ENOMEM;
 
 	for (i = 0; desc->psy_charger_stat[i]; i++) {
 		cm->charger_stat[i] = power_supply_get_by_name(
@@ -1526,8 +1516,7 @@ static int charger_manager_probe(struct platform_device *pdev)
 		if (!cm->charger_stat[i]) {
 			dev_err(&pdev->dev, "Cannot find power supply \"%s\"\n",
 				desc->psy_charger_stat[i]);
-			ret = -ENODEV;
-			goto err_chg_stat;
+			return -ENODEV;
 		}
 	}
 
@@ -1535,21 +1524,18 @@ static int charger_manager_probe(struct platform_device *pdev)
 	if (!cm->fuel_gauge) {
 		dev_err(&pdev->dev, "Cannot find power supply \"%s\"\n",
 			desc->psy_fuel_gauge);
-		ret = -ENODEV;
-		goto err_chg_stat;
+		return -ENODEV;
 	}
 
 	if (desc->polling_interval_ms == 0 ||
 	    msecs_to_jiffies(desc->polling_interval_ms) <= CM_JIFFIES_SMALL) {
 		dev_err(&pdev->dev, "polling_interval_ms is too small\n");
-		ret = -EINVAL;
-		goto err_chg_stat;
+		return -EINVAL;
 	}
 
 	if (!desc->temperature_out_of_range) {
 		dev_err(&pdev->dev, "there is no temperature_out_of_range\n");
-		ret = -EINVAL;
-		goto err_chg_stat;
+		return -EINVAL;
 	}
 
 	if (!desc->charging_max_duration_ms ||
@@ -1570,14 +1556,13 @@ static int charger_manager_probe(struct platform_device *pdev)
 	cm->charger_psy.name = cm->psy_name_buf;
 
 	/* Allocate for psy properties because they may vary */
-	cm->charger_psy.properties = kzalloc(sizeof(enum power_supply_property)
+	cm->charger_psy.properties = devm_kzalloc(&pdev->dev,
+				sizeof(enum power_supply_property)
 				* (ARRAY_SIZE(default_charger_props) +
-				NUM_CHARGER_PSY_OPTIONAL),
-				GFP_KERNEL);
-	if (!cm->charger_psy.properties) {
-		ret = -ENOMEM;
-		goto err_chg_stat;
-	}
+				NUM_CHARGER_PSY_OPTIONAL), GFP_KERNEL);
+	if (!cm->charger_psy.properties)
+		return -ENOMEM;
+
 	memcpy(cm->charger_psy.properties, default_charger_props,
 		sizeof(enum power_supply_property) *
 		ARRAY_SIZE(default_charger_props));
@@ -1614,7 +1599,7 @@ static int charger_manager_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot register charger-manager with name \"%s\"\n",
 			cm->charger_psy.name);
-		goto err_register;
+		return ret;
 	}
 
 	/* Register extcon device for charger cable */
@@ -1655,8 +1640,6 @@ err_reg_sysfs:
 		charger = &desc->charger_regulators[i];
 		sysfs_remove_group(&cm->charger_psy.dev->kobj,
 				&charger->attr_g);
-
-		kfree(charger->attr_g.name);
 	}
 err_reg_extcon:
 	for (i = 0; i < desc->num_charger_regulators; i++) {
@@ -1674,16 +1657,7 @@ err_reg_extcon:
 	}
 
 	power_supply_unregister(&cm->charger_psy);
-err_register:
-	kfree(cm->charger_psy.properties);
-err_chg_stat:
-	kfree(cm->charger_stat);
-err_no_charger_stat:
-err_no_charger:
-	kfree(cm->desc);
-err_alloc_desc:
-	kfree(cm);
-err_alloc:
+
 	return ret;
 }
 
@@ -1718,11 +1692,6 @@ static int charger_manager_remove(struct platform_device *pdev)
 
 	try_charger_enable(cm, false);
 
-	kfree(cm->charger_psy.properties);
-	kfree(cm->charger_stat);
-	kfree(cm->desc);
-	kfree(cm);
-
 	return 0;
 }
 
-- 
1.7.9.5

