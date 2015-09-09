From: Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 10/13] power: bq24257: Add various device-specific sysfs properties
Date: Tue, 8 Sep 2015 19:12:34 -0500
Message-ID: <1441757557-7266-11-git-send-email-dannenberg@ti.com>
References: <1441757557-7266-1-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441757557-7266-1-git-send-email-dannenberg-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This patch adds support to enable/disable some device specific features
through device properties at boot time or sysfs properties at runtime
depending on whether they should be accessible during runtime or not.
The use of those features is be optional however they might be helpful
in certain scenarios:

* High-impedance mode enable/disable (through sysfs r/w)
* Sysoff enable/disable (through sysfs r/w)
* 2X Timer enable/disable (through "ti,safety-timer-2x-enable" dev
  property)

If not explicitly modified those settings are left at their device-
specific power-on defaults. Refer to the respectice device datasheets
for more information:

http://www.ti.com/product/bq24250
http://www.ti.com/product/bq24251
http://www.ti.com/product/bq24257

Signed-off-by: Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>
---
 drivers/power/bq24257_charger.c | 75 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/power/bq24257_charger.c b/drivers/power/bq24257_charger.c
index f0602b3..9a4a7a0 100644
--- a/drivers/power/bq24257_charger.c
+++ b/drivers/power/bq24257_charger.c
@@ -77,6 +77,7 @@ struct bq24257_init_data {
 	u8 in_ilimit;	/* input current limit */
 	u8 vovp;	/* over voltage protection voltage */
 	u8 vindpm;	/* VDMP input threshold voltage */
+	bool timer2x_enable;	/* slow down safety timer by 2x */
 };
 
 struct bq24257_state {
@@ -766,6 +767,7 @@ static int bq24257_hw_init(struct bq24257_device *bq)
 		{F_ITERM, bq->init_data.iterm},
 		{F_VOVP, bq->init_data.vovp},
 		{F_VINDPM, bq->init_data.vindpm},
+		{F_X2_TMR_EN, bq->init_data.timer2x_enable},
 	};
 
 	/*
@@ -860,12 +862,78 @@ static ssize_t bq24257_show_in_dpm_voltage(struct device *dev,
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
 static DEVICE_ATTR(in_dpm_voltage, S_IRUGO, bq24257_show_in_dpm_voltage, NULL);
+static DEVICE_ATTR(high_impedance_enable, S_IWUSR | S_IRUGO,
+		bq24257_sysfs_show_enable, bq24257_sysfs_set_enable);
+static DEVICE_ATTR(sysoff_enable, S_IWUSR | S_IRUGO,
+		bq24257_sysfs_show_enable, bq24257_sysfs_set_enable);
+static DEVICE_ATTR(timer2x_enable, S_IRUGO,
+		bq24257_sysfs_show_enable, NULL);
 
 static struct attribute *bq24257_charger_attr[] = {
 	&dev_attr_ovp_voltage.attr,
 	&dev_attr_in_dpm_voltage.attr,
+	&dev_attr_high_impedance_enable.attr,
+	&dev_attr_sysoff_enable.attr,
+	&dev_attr_timer2x_enable.attr,
 	NULL,
 };
 
@@ -973,6 +1041,13 @@ static int bq24257_fw_probe(struct bq24257_device *bq)
 		bq->init_data.vindpm = bq24257_find_idx(property,
 				bq24257_vindpm_map, BQ24257_VINDPM_MAP_SIZE);
 
+	ret = device_property_read_u32(bq->dev, "ti,safety-timer-2x-enable",
+				       &property);
+	if (ret < 0)
+		bq->init_data.timer2x_enable = false;
+	else
+		bq->init_data.timer2x_enable = property;
+
 	return 0;
 }
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
