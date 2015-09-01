From: Andreas Dannenberg <dannenberg@ti.com>
Subject: [PATCH 11/13] power: bq24257: Add various device-specific sysfs properties
Date: Mon, 31 Aug 2015 21:10:33 -0500
Message-ID: <1441073435-12349-12-git-send-email-dannenberg@ti.com>
References: <1441073435-12349-1-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57551 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754794AbbIACL6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 31 Aug 2015 22:11:58 -0400
In-Reply-To: <1441073435-12349-1-git-send-email-dannenberg@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Andreas Dannenberg <dannenberg@ti.com>

This patch adds support to enable/disable some device specific features
through device properties at boot time or sysfs properties at runtime
depending on whether they should be accessible during runtime or not.
The use of those features is be optional however they might be helpful
in certain scenarios:

* High-impedance mode enable/disable (through sysfs r/w)
* Sysoff enable/disable (through sysfs r/w)
* 2X Timer enable/disable (through "ti,timer-2x-enable" dev property)

If not explicitly modified those settings are left at their device-
specific power-on defaults. Refer to the respectice device datasheets
for more information:

http://www.ti.com/product/bq24250
http://www.ti.com/product/bq24251
http://www.ti.com/product/bq24257

Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
---
 drivers/power/bq24257_charger.c | 75 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 2 deletions(-)

diff --git a/drivers/power/bq24257_charger.c b/drivers/power/bq24257_charger.c
index 42cc6fe..d95ca46 100644
--- a/drivers/power/bq24257_charger.c
+++ b/drivers/power/bq24257_charger.c
@@ -72,7 +72,8 @@ struct bq24257_init_data {
 	u8 vovp;	/* over voltage protection voltage */
 	u8 vindpm;	/* VDMP input threshold voltage */
 	bool in_ilimit_autoset_disable;	/* auto-detect of input current limit */
-	bool pg_gpio_disable; /* use of a dedicated pin for Power Good */
+	bool pg_gpio_disable;	     /* use of a dedicated pin for Power Good */
+	bool timer2x_enable;		       /* slow down safety time by 2x */
 };
 
 struct bq24257_state {
@@ -766,7 +767,8 @@ static int bq24257_hw_init(struct bq24257_device *bq)
 		{F_VBAT, bq->init_data.vbat},
 		{F_ITERM, bq->init_data.iterm},
 		{F_VOVP, bq->init_data.vovp},
-		{F_VINDPM, bq->init_data.vindpm}
+		{F_VINDPM, bq->init_data.vindpm},
+		{F_X2_TMR_EN, bq->init_data.timer2x_enable}
 	};
 
 	/*
@@ -861,12 +863,78 @@ static ssize_t bq24257_show_vindpm_voltage(struct device *dev,
 			bq24257_vindpm_map[bq->init_data.vindpm]);
 }
 
+static ssize_t bq24257_sysfs_show_enable(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct bq24257_device *bq = power_supply_get_drvdata(psy);
+	int ret;
+
+	mutex_lock(&bq->lock);
+
+	if (strcmp(attr->attr.name, "high_impedance_enable") == 0)
+		ret = bq24257_field_read(bq, F_HZ_MODE);
+	else if (strcmp(attr->attr.name, "sysoff_enable") == 0)
+		ret = bq24257_field_read(bq, F_SYSOFF);
+	else if (strcmp(attr->attr.name, "timer2x_enable") == 0)
+		ret = bq->init_data.timer2x_enable;
+	else
+		ret = -EINVAL;
+
+	mutex_unlock(&bq->lock);
+
+	if (ret < 0)
+		return ret;
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", ret);
+}
+
+static ssize_t bq24257_sysfs_set_enable(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf,
+					size_t count)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct bq24257_device *bq = power_supply_get_drvdata(psy);
+	long val;
+	int ret;
+
+	if (kstrtol(buf, 10, &val) < 0)
+		return -EINVAL;
+
+	mutex_lock(&bq->lock);
+
+	if (strcmp(attr->attr.name, "high_impedance_enable") == 0)
+		ret = bq24257_field_write(bq, F_HZ_MODE, val);
+	else if (strcmp(attr->attr.name, "sysoff_enable") == 0)
+		ret = bq24257_field_write(bq, F_SYSOFF, val);
+	else
+		ret = -EINVAL;
+
+	mutex_unlock(&bq->lock);
+
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
 static DEVICE_ATTR(ovp_voltage, S_IRUGO, bq24257_show_ovp_voltage, NULL);
 static DEVICE_ATTR(vindpm_voltage, S_IRUGO, bq24257_show_vindpm_voltage, NULL);
+static DEVICE_ATTR(high_impedance_enable, S_IWUSR | S_IRUGO,
+		bq24257_sysfs_show_enable, bq24257_sysfs_set_enable);
+static DEVICE_ATTR(sysoff_enable, S_IWUSR | S_IRUGO,
+		bq24257_sysfs_show_enable, bq24257_sysfs_set_enable);
+static DEVICE_ATTR(timer2x_enable, S_IRUGO,
+		bq24257_sysfs_show_enable, NULL);
 
 static struct attribute *bq24257_charger_attr[] = {
 	&dev_attr_ovp_voltage.attr,
 	&dev_attr_vindpm_voltage.attr,
+	&dev_attr_high_impedance_enable.attr,
+	&dev_attr_sysoff_enable.attr,
+	&dev_attr_timer2x_enable.attr,
 	NULL,
 };
 
@@ -973,6 +1041,9 @@ static int bq24257_fw_probe(struct bq24257_device *bq)
 	bq->init_data.pg_gpio_disable = device_property_read_bool(
 			bq->dev, "ti,pg-gpio-disable");
 
+	bq->init_data.timer2x_enable = device_property_read_bool(
+			bq->dev, "ti,timer-2x-enable");
+
 	return 0;
 }
 
-- 
1.9.1

