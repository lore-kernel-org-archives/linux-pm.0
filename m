From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 11/14] power: supply: ds2780: fix race-condition in bin attribute registration
Date: Mon,  1 Oct 2018 00:03:46 +0200
Message-ID: <20180930220349.10515-12-sebastian.reichel@collabora.com>
References: <20180930220349.10515-1-sebastian.reichel@collabora.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180930220349.10515-1-sebastian.reichel@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Milo Kim <milo.kim@ti.com>, Andreas Dannenberg <dannenberg@ti.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Hans de Goede <hdegoede@redhat.com>, Liam Breck <kernel@networkimprov.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.com>
List-Id: linux-pm@vger.kernel.org

This is a follow-up patch to the previous one, which fixed a
race-condition during registration of the attribute group.
This fixes the same issue for the binary attributes by adding
them to the properly registered group. As a side effect the
code is further cleaned up.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/ds2780_battery.c | 55 ++++++++++-----------------
 1 file changed, 20 insertions(+), 35 deletions(-)

diff --git a/drivers/power/supply/ds2780_battery.c b/drivers/power/supply/ds2780_battery.c
index fa015787d58d..d8be8c236029 100644
--- a/drivers/power/supply/ds2780_battery.c
+++ b/drivers/power/supply/ds2780_battery.c
@@ -658,7 +658,7 @@ static ssize_t ds2780_write_param_eeprom_bin(struct file *filp,
 	return count;
 }
 
-static const struct bin_attribute ds2780_param_eeprom_bin_attr = {
+static struct bin_attribute ds2780_param_eeprom_bin_attr = {
 	.attr = {
 		.name = "param_eeprom",
 		.mode = S_IRUGO | S_IWUSR,
@@ -703,7 +703,7 @@ static ssize_t ds2780_write_user_eeprom_bin(struct file *filp,
 	return count;
 }
 
-static const struct bin_attribute ds2780_user_eeprom_bin_attr = {
+static struct bin_attribute ds2780_user_eeprom_bin_attr = {
 	.attr = {
 		.name = "user_eeprom",
 		.mode = S_IRUGO | S_IWUSR,
@@ -722,7 +722,6 @@ static DEVICE_ATTR(rsgain_setting, S_IRUGO | S_IWUSR, ds2780_get_rsgain_setting,
 static DEVICE_ATTR(pio_pin, S_IRUGO | S_IWUSR, ds2780_get_pio_pin,
 	ds2780_set_pio_pin);
 
-
 static struct attribute *ds2780_sysfs_attrs[] = {
 	&dev_attr_pmod_enabled.attr,
 	&dev_attr_sense_resistor_value.attr,
@@ -731,19 +730,30 @@ static struct attribute *ds2780_sysfs_attrs[] = {
 	NULL
 };
 
-ATTRIBUTE_GROUPS(ds2780_sysfs);
+static struct bin_attribute *ds2780_sysfs_bin_attrs[] = {
+	&ds2780_param_eeprom_bin_attr,
+	&ds2780_user_eeprom_bin_attr,
+	NULL
+};
+
+static const struct attribute_group ds2780_sysfs_group = {
+	.attrs = ds2780_sysfs_attrs,
+	.bin_attrs = ds2780_sysfs_bin_attrs,
+};
+
+static const struct attribute_group *ds2780_sysfs_groups[] = {
+	&ds2780_sysfs_group,
+	NULL,
+};
 
 static int ds2780_battery_probe(struct platform_device *pdev)
 {
 	struct power_supply_config psy_cfg = {};
-	int ret = 0;
 	struct ds2780_device_info *dev_info;
 
 	dev_info = devm_kzalloc(&pdev->dev, sizeof(*dev_info), GFP_KERNEL);
-	if (!dev_info) {
-		ret = -ENOMEM;
-		goto fail;
-	}
+	if (!dev_info)
+		return -ENOMEM;
 
 	platform_set_drvdata(pdev, dev_info);
 
@@ -762,35 +772,10 @@ static int ds2780_battery_probe(struct platform_device *pdev)
 					      &psy_cfg);
 	if (IS_ERR(dev_info->bat)) {
 		dev_err(dev_info->dev, "failed to register battery\n");
-		ret = PTR_ERR(dev_info->bat);
-		goto fail;
-	}
-
-	ret = sysfs_create_bin_file(&dev_info->bat->dev.kobj,
-					&ds2780_param_eeprom_bin_attr);
-	if (ret) {
-		dev_err(dev_info->dev,
-				"failed to create param eeprom bin file");
-		goto fail_unregister;
-	}
-
-	ret = sysfs_create_bin_file(&dev_info->bat->dev.kobj,
-					&ds2780_user_eeprom_bin_attr);
-	if (ret) {
-		dev_err(dev_info->dev,
-				"failed to create user eeprom bin file");
-		goto fail_remove_bin_file;
+		return PTR_ERR(dev_info->bat);
 	}
 
 	return 0;
-
-fail_remove_bin_file:
-	sysfs_remove_bin_file(&dev_info->bat->dev.kobj,
-				&ds2780_param_eeprom_bin_attr);
-fail_unregister:
-	power_supply_unregister(dev_info->bat);
-fail:
-	return ret;
 }
 
 static int ds2780_battery_remove(struct platform_device *pdev)
-- 
2.19.0
