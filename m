From: Andreas Dannenberg <dannenberg@ti.com>
Subject: [PATCH v5 10/11] power: bq24257: Add various device-specific sysfs properties
Date: Fri, 18 Sep 2015 16:39:58 -0500
Message-ID: <1442612399-341-11-git-send-email-dannenberg@ti.com>
References: <1442612399-341-1-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56817 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754659AbbIRVlE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 18 Sep 2015 17:41:04 -0400
In-Reply-To: <1442612399-341-1-git-send-email-dannenberg@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Andreas Dannenberg <dannenberg@ti.com>

This patch adds support for enabling/disabling optional device specific
features through sysfs properties at runtime.

* High-impedance mode enable/disable
* Sysoff enable/disable

Refer to the respective device datasheets for more information:

http://www.ti.com/product/bq24250
http://www.ti.com/product/bq24251
http://www.ti.com/product/bq24257

Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
---
 drivers/power/bq24257_charger.c | 53 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/power/bq24257_charger.c b/drivers/power/bq24257_charger.c
index 66867d5..a1068291 100644
--- a/drivers/power/bq24257_charger.c
+++ b/drivers/power/bq24257_charger.c
@@ -797,12 +797,65 @@ static ssize_t bq24257_show_in_dpm_voltage(struct device *dev,
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
+	if (strcmp(attr->attr.name, "high_impedance_enable") == 0)
+		ret = bq24257_field_read(bq, F_HZ_MODE);
+	else if (strcmp(attr->attr.name, "sysoff_enable") == 0)
+		ret = bq24257_field_read(bq, F_SYSOFF);
+	else
+		return -EINVAL;
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
+	if (strcmp(attr->attr.name, "high_impedance_enable") == 0)
+		ret = bq24257_field_write(bq, F_HZ_MODE, (bool)val);
+	else if (strcmp(attr->attr.name, "sysoff_enable") == 0)
+		ret = bq24257_field_write(bq, F_SYSOFF, (bool)val);
+	else
+		return -EINVAL;
+
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
 static DEVICE_ATTR(ovp_voltage, S_IRUGO, bq24257_show_ovp_voltage, NULL);
 static DEVICE_ATTR(in_dpm_voltage, S_IRUGO, bq24257_show_in_dpm_voltage, NULL);
+static DEVICE_ATTR(high_impedance_enable, S_IWUSR | S_IRUGO,
+		   bq24257_sysfs_show_enable, bq24257_sysfs_set_enable);
+static DEVICE_ATTR(sysoff_enable, S_IWUSR | S_IRUGO,
+		   bq24257_sysfs_show_enable, bq24257_sysfs_set_enable);
 
 static struct attribute *bq24257_charger_attr[] = {
 	&dev_attr_ovp_voltage.attr,
 	&dev_attr_in_dpm_voltage.attr,
+	&dev_attr_high_impedance_enable.attr,
+	&dev_attr_sysoff_enable.attr,
 	NULL,
 };
 
-- 
1.9.1

