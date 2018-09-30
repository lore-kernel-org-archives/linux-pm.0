From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 04/14] power: supply: ds2781: fix race-condition in sysfs registration
Date: Mon,  1 Oct 2018 00:03:39 +0200
Message-ID: <20180930220349.10515-5-sebastian.reichel@collabora.com>
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
 drivers/power/supply/ds2781_battery.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/power/supply/ds2781_battery.c b/drivers/power/supply/ds2781_battery.c
index d1b5a19aae7c..5bfd4c77eb89 100644
--- a/drivers/power/supply/ds2781_battery.c
+++ b/drivers/power/supply/ds2781_battery.c
@@ -726,7 +726,7 @@ static DEVICE_ATTR(pio_pin, S_IRUGO | S_IWUSR, ds2781_get_pio_pin,
 	ds2781_set_pio_pin);
 
 
-static struct attribute *ds2781_attributes[] = {
+static struct attribute *ds2781_sysfs_attrs[] = {
 	&dev_attr_pmod_enabled.attr,
 	&dev_attr_sense_resistor_value.attr,
 	&dev_attr_rsgain_setting.attr,
@@ -734,9 +734,7 @@ static struct attribute *ds2781_attributes[] = {
 	NULL
 };
 
-static const struct attribute_group ds2781_attr_group = {
-	.attrs = ds2781_attributes,
-};
+ATTRIBUTE_GROUPS(ds2781_sysfs);
 
 static int ds2781_battery_probe(struct platform_device *pdev)
 {
@@ -759,6 +757,7 @@ static int ds2781_battery_probe(struct platform_device *pdev)
 	dev_info->bat_desc.get_property	= ds2781_battery_get_property;
 
 	psy_cfg.drv_data		= dev_info;
+	psy_cfg.attr_grp		= ds2781_sysfs_groups;
 
 	dev_info->bat = power_supply_register(&pdev->dev, &dev_info->bat_desc,
 						&psy_cfg);
@@ -768,18 +767,12 @@ static int ds2781_battery_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	ret = sysfs_create_group(&dev_info->bat->dev.kobj, &ds2781_attr_group);
-	if (ret) {
-		dev_err(dev_info->dev, "failed to create sysfs group\n");
-		goto fail_unregister;
-	}
-
 	ret = sysfs_create_bin_file(&dev_info->bat->dev.kobj,
 					&ds2781_param_eeprom_bin_attr);
 	if (ret) {
 		dev_err(dev_info->dev,
 				"failed to create param eeprom bin file");
-		goto fail_remove_group;
+		goto fail_unregister;
 	}
 
 	ret = sysfs_create_bin_file(&dev_info->bat->dev.kobj,
@@ -795,8 +788,6 @@ static int ds2781_battery_probe(struct platform_device *pdev)
 fail_remove_bin_file:
 	sysfs_remove_bin_file(&dev_info->bat->dev.kobj,
 				&ds2781_param_eeprom_bin_attr);
-fail_remove_group:
-	sysfs_remove_group(&dev_info->bat->dev.kobj, &ds2781_attr_group);
 fail_unregister:
 	power_supply_unregister(dev_info->bat);
 fail:
@@ -807,12 +798,6 @@ static int ds2781_battery_remove(struct platform_device *pdev)
 {
 	struct ds2781_device_info *dev_info = platform_get_drvdata(pdev);
 
-	/*
-	 * Remove attributes before unregistering power supply
-	 * because 'bat' will be freed on power_supply_unregister() call.
-	 */
-	sysfs_remove_group(&dev_info->bat->dev.kobj, &ds2781_attr_group);
-
 	power_supply_unregister(dev_info->bat);
 
 	return 0;
-- 
2.19.0
