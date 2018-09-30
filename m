From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 05/14] power: supply: lp8788: fix race-condition in sysfs registration
Date: Mon,  1 Oct 2018 00:03:40 +0200
Message-ID: <20180930220349.10515-6-sebastian.reichel@collabora.com>
References: <20180930220349.10515-1-sebastian.reichel@collabora.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180930220349.10515-1-sebastian.reichel@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Milo Kim <milo.kim@ti.com>, Andreas Dannenberg <dannenberg@ti.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Hans de Goede <hdegoede@redhat.com>, Liam Breck <kernel@networkimprov.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.com>
List-Id: linux-pm@vger.kernel.org

This registers custom sysfs properties using the native functionality
of the power-supply framework, which cleans up the code a bit and
fixes a race-condition. Before this patch the sysfs attributes were
not properly registered to udev.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/lp8788-charger.c | 62 ++++++++++++---------------
 1 file changed, 27 insertions(+), 35 deletions(-)

diff --git a/drivers/power/supply/lp8788-charger.c b/drivers/power/supply/lp8788-charger.c
index 0f3432795f3c..309e6efbb8ef 100644
--- a/drivers/power/supply/lp8788-charger.c
+++ b/drivers/power/supply/lp8788-charger.c
@@ -410,30 +410,6 @@ static const struct power_supply_desc lp8788_psy_battery_desc = {
 	.get_property	= lp8788_battery_get_property,
 };
 
-static int lp8788_psy_register(struct platform_device *pdev,
-				struct lp8788_charger *pchg)
-{
-	struct power_supply_config charger_cfg = {};
-
-	charger_cfg.supplied_to = battery_supplied_to;
-	charger_cfg.num_supplicants = ARRAY_SIZE(battery_supplied_to);
-
-	pchg->charger = power_supply_register(&pdev->dev,
-					      &lp8788_psy_charger_desc,
-					      &charger_cfg);
-	if (IS_ERR(pchg->charger))
-		return -EPERM;
-
-	pchg->battery = power_supply_register(&pdev->dev,
-					      &lp8788_psy_battery_desc, NULL);
-	if (IS_ERR(pchg->battery)) {
-		power_supply_unregister(pchg->charger);
-		return -EPERM;
-	}
-
-	return 0;
-}
-
 static void lp8788_psy_unregister(struct lp8788_charger *pchg)
 {
 	power_supply_unregister(pchg->battery);
@@ -690,16 +666,39 @@ static DEVICE_ATTR(charger_status, S_IRUSR, lp8788_show_charger_status, NULL);
 static DEVICE_ATTR(eoc_time, S_IRUSR, lp8788_show_eoc_time, NULL);
 static DEVICE_ATTR(eoc_level, S_IRUSR, lp8788_show_eoc_level, NULL);
 
-static struct attribute *lp8788_charger_attr[] = {
+static struct attribute *lp8788_charger_sysfs_attrs[] = {
 	&dev_attr_charger_status.attr,
 	&dev_attr_eoc_time.attr,
 	&dev_attr_eoc_level.attr,
 	NULL,
 };
 
-static const struct attribute_group lp8788_attr_group = {
-	.attrs = lp8788_charger_attr,
-};
+ATTRIBUTE_GROUPS(lp8788_charger_sysfs);
+
+static int lp8788_psy_register(struct platform_device *pdev,
+				struct lp8788_charger *pchg)
+{
+	struct power_supply_config charger_cfg = {};
+
+	charger_cfg.attr_grp = lp8788_charger_sysfs_groups;
+	charger_cfg.supplied_to = battery_supplied_to;
+	charger_cfg.num_supplicants = ARRAY_SIZE(battery_supplied_to);
+
+	pchg->charger = power_supply_register(&pdev->dev,
+					      &lp8788_psy_charger_desc,
+					      &charger_cfg);
+	if (IS_ERR(pchg->charger))
+		return -EPERM;
+
+	pchg->battery = power_supply_register(&pdev->dev,
+					      &lp8788_psy_battery_desc, NULL);
+	if (IS_ERR(pchg->battery)) {
+		power_supply_unregister(pchg->charger);
+		return -EPERM;
+	}
+
+	return 0;
+}
 
 static int lp8788_charger_probe(struct platform_device *pdev)
 {
@@ -726,12 +725,6 @@ static int lp8788_charger_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = sysfs_create_group(&pdev->dev.kobj, &lp8788_attr_group);
-	if (ret) {
-		lp8788_psy_unregister(pchg);
-		return ret;
-	}
-
 	ret = lp8788_irq_register(pdev, pchg);
 	if (ret)
 		dev_warn(dev, "failed to register charger irq: %d\n", ret);
@@ -745,7 +738,6 @@ static int lp8788_charger_remove(struct platform_device *pdev)
 
 	flush_work(&pchg->charger_work);
 	lp8788_irq_unregister(pdev, pchg);
-	sysfs_remove_group(&pdev->dev.kobj, &lp8788_attr_group);
 	lp8788_psy_unregister(pchg);
 	lp8788_release_adc_channel(pchg);
 
-- 
2.19.0
