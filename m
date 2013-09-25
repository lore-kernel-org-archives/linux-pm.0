From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 6/6] ideapad_laptop: convert ideapad device/driver to platform bus
Date: Wed, 25 Sep 2013 20:39:50 +0800
Message-ID: <1380112790-2321-7-git-send-email-rui.zhang@intel.com>
References: <1380112790-2321-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:44043 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755111Ab3IYMkW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 25 Sep 2013 08:40:22 -0400
In-Reply-To: <1380112790-2321-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <matthew.garrett@nebula.com>, Ike Panhc <ike.pan@canonical.com>, platform-driver-x86@vger.kernel.org

This patch does two things,
1. enumerate the ideapad device node to platform bus.
2. convert the current driver from ACPI bus to platform bus.

Note, with this patch, the platform device node created by ACPI,
with the name VPC2004:00, is used as the parent device of
the input, backlight, rfkill sysfs class device.
Plus the ideapad_platform private sysfs attributes,
i.e. camera_power and fan_mode, are also moved to the new
platform device node. The previous platform device node "ideapad" is removed.
I'm not sure if there is any userspace stuff depends on this or not.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
CC: Matthew Garrett <matthew.garrett@nebula.com>
CC: Ike Panhc <ike.pan@canonical.com>
CC: platform-driver-x86@vger.kernel.org
---
 drivers/acpi/acpi_platform.c          |    2 +-
 drivers/platform/x86/ideapad-laptop.c |  194 ++++++++++++++++-----------------
 2 files changed, 93 insertions(+), 103 deletions(-)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 6259bc2..c20b02b 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -30,7 +30,7 @@ static const struct acpi_device_id acpi_platform_device_ids[] = {
 
 	{ "PNP0D40" },
 	{ "ACPI0003" },
-
+	{ "VPC2004" },
 	{ }
 };
 
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index cad48b5..6788acc 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -500,7 +500,7 @@ static int ideapad_register_rfkill(struct ideapad_private *priv, int dev)
 	priv->rfk_priv[dev].priv = priv;
 
 	priv->rfk[dev] = rfkill_alloc(ideapad_rfk_data[dev].name,
-				      &priv->adev->dev,
+				      &priv->platform_device->dev,
 				      ideapad_rfk_data[dev].type,
 				      &ideapad_rfk_ops,
 				      &priv->rfk_priv[dev]);
@@ -535,37 +535,16 @@ static void ideapad_unregister_rfkill(struct ideapad_private *priv, int dev)
 /*
  * Platform device
  */
-static int ideapad_platform_init(struct ideapad_private *priv)
+static int ideapad_sysfs_init(struct ideapad_private *priv)
 {
-	int result;
-
-	priv->platform_device = platform_device_alloc("ideapad", -1);
-	if (!priv->platform_device)
-		return -ENOMEM;
-	platform_set_drvdata(priv->platform_device, priv);
-
-	result = platform_device_add(priv->platform_device);
-	if (result)
-		goto fail_platform_device;
-
-	result = sysfs_create_group(&priv->platform_device->dev.kobj,
+	return sysfs_create_group(&priv->platform_device->dev.kobj,
 				    &ideapad_attribute_group);
-	if (result)
-		goto fail_sysfs;
-	return 0;
-
-fail_sysfs:
-	platform_device_del(priv->platform_device);
-fail_platform_device:
-	platform_device_put(priv->platform_device);
-	return result;
 }
 
-static void ideapad_platform_exit(struct ideapad_private *priv)
+static void ideapad_sysfs_exit(struct ideapad_private *priv)
 {
 	sysfs_remove_group(&priv->platform_device->dev.kobj,
 			   &ideapad_attribute_group);
-	platform_device_unregister(priv->platform_device);
 }
 
 /*
@@ -781,12 +760,6 @@ static void ideapad_backlight_notify_brightness(struct ideapad_private *priv)
 /*
  * module init/exit
  */
-static const struct acpi_device_id ideapad_device_ids[] = {
-	{ "VPC2004", 0},
-	{ "", 0},
-};
-MODULE_DEVICE_TABLE(acpi, ideapad_device_ids);
-
 static void ideapad_sync_touchpad_state(struct ideapad_private *priv)
 {
 	unsigned long value;
@@ -804,11 +777,61 @@ static void ideapad_sync_touchpad_state(struct ideapad_private *priv)
 	}
 }
 
-static int ideapad_acpi_add(struct acpi_device *adev)
+static void ideapad_acpi_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct ideapad_private *priv = data;
+	unsigned long vpc1, vpc2, vpc_bit;
+
+	if (read_ec_data(handle, VPCCMD_R_VPC1, &vpc1))
+		return;
+	if (read_ec_data(handle, VPCCMD_R_VPC2, &vpc2))
+		return;
+
+	vpc1 = (vpc2 << 8) | vpc1;
+	for (vpc_bit = 0; vpc_bit < 16; vpc_bit++) {
+		if (test_bit(vpc_bit, &vpc1)) {
+			switch (vpc_bit) {
+			case 9:
+				ideapad_sync_rfk_state(priv);
+				break;
+			case 13:
+			case 11:
+			case 7:
+			case 6:
+				ideapad_input_report(priv, vpc_bit);
+				break;
+			case 5:
+				ideapad_sync_touchpad_state(priv);
+				break;
+			case 4:
+				ideapad_backlight_notify_brightness(priv);
+				break;
+			case 3:
+				ideapad_input_novokey(priv);
+				break;
+			case 2:
+				ideapad_backlight_notify_power(priv);
+				break;
+			case 0:
+				ideapad_check_special_buttons(priv);
+				break;
+			default:
+				pr_info("Unknown event: %lu\n", vpc_bit);
+			}
+		}
+	}
+}
+
+static int ideapad_acpi_add(struct platform_device *pdev)
 {
 	int ret, i;
 	int cfg;
 	struct ideapad_private *priv;
+	struct acpi_device *adev;
+
+	ret = acpi_bus_get_device(ACPI_HANDLE(&pdev->dev), &adev);
+	if (ret)
+		return -ENODEV;
 
 	if (read_method_int(adev->handle, "_CFG", &cfg))
 		return -ENODEV;
@@ -816,13 +839,15 @@ static int ideapad_acpi_add(struct acpi_device *adev)
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
-	dev_set_drvdata(&adev->dev, priv);
+
+	dev_set_drvdata(&pdev->dev, priv);
 	priv->cfg = cfg;
 	priv->adev = adev;
+	priv->platform_device = pdev;
 
-	ret = ideapad_platform_init(priv);
+	ret = ideapad_sysfs_init(priv);
 	if (ret)
-		goto platform_failed;
+		goto sysfs_failed;
 
 	ret = ideapad_debugfs_init(priv);
 	if (ret)
@@ -846,9 +871,14 @@ static int ideapad_acpi_add(struct acpi_device *adev)
 		if (ret && ret != -ENODEV)
 			goto backlight_failed;
 	}
+	ret = acpi_install_notify_handler(adev->handle,
+		ACPI_DEVICE_NOTIFY, ideapad_acpi_notify, priv);
+	if (ret)
+		goto notification_failed;
 
 	return 0;
-
+notification_failed:
+	ideapad_backlight_exit(priv);
 backlight_failed:
 	for (i = 0; i < IDEAPAD_RFKILL_DEV_NUM; i++)
 		ideapad_unregister_rfkill(priv, i);
@@ -856,75 +886,31 @@ static int ideapad_acpi_add(struct acpi_device *adev)
 input_failed:
 	ideapad_debugfs_exit(priv);
 debugfs_failed:
-	ideapad_platform_exit(priv);
-platform_failed:
+	ideapad_sysfs_exit(priv);
+sysfs_failed:
 	kfree(priv);
 	return ret;
 }
 
-static int ideapad_acpi_remove(struct acpi_device *adev)
+static int ideapad_acpi_remove(struct platform_device *pdev)
 {
-	struct ideapad_private *priv = dev_get_drvdata(&adev->dev);
+	struct ideapad_private *priv = dev_get_drvdata(&pdev->dev);
 	int i;
 
+	acpi_remove_notify_handler(priv->adev->handle,
+		ACPI_DEVICE_NOTIFY, ideapad_acpi_notify);
 	ideapad_backlight_exit(priv);
 	for (i = 0; i < IDEAPAD_RFKILL_DEV_NUM; i++)
 		ideapad_unregister_rfkill(priv, i);
 	ideapad_input_exit(priv);
 	ideapad_debugfs_exit(priv);
-	ideapad_platform_exit(priv);
-	dev_set_drvdata(&adev->dev, NULL);
+	ideapad_sysfs_exit(priv);
+	dev_set_drvdata(&pdev->dev, NULL);
 	kfree(priv);
 
 	return 0;
 }
 
-static void ideapad_acpi_notify(struct acpi_device *adev, u32 event)
-{
-	struct ideapad_private *priv = dev_get_drvdata(&adev->dev);
-	acpi_handle handle = adev->handle;
-	unsigned long vpc1, vpc2, vpc_bit;
-
-	if (read_ec_data(handle, VPCCMD_R_VPC1, &vpc1))
-		return;
-	if (read_ec_data(handle, VPCCMD_R_VPC2, &vpc2))
-		return;
-
-	vpc1 = (vpc2 << 8) | vpc1;
-	for (vpc_bit = 0; vpc_bit < 16; vpc_bit++) {
-		if (test_bit(vpc_bit, &vpc1)) {
-			switch (vpc_bit) {
-			case 9:
-				ideapad_sync_rfk_state(priv);
-				break;
-			case 13:
-			case 11:
-			case 7:
-			case 6:
-				ideapad_input_report(priv, vpc_bit);
-				break;
-			case 5:
-				ideapad_sync_touchpad_state(priv);
-				break;
-			case 4:
-				ideapad_backlight_notify_brightness(priv);
-				break;
-			case 3:
-				ideapad_input_novokey(priv);
-				break;
-			case 2:
-				ideapad_backlight_notify_power(priv);
-				break;
-			case 0:
-				ideapad_check_special_buttons(priv);
-				break;
-			default:
-				pr_info("Unknown event: %lu\n", vpc_bit);
-			}
-		}
-	}
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int ideapad_acpi_resume(struct device *device)
 {
@@ -938,23 +924,27 @@ static int ideapad_acpi_resume(struct device *device)
 	ideapad_sync_touchpad_state(priv);
 	return 0;
 }
-
-static SIMPLE_DEV_PM_OPS(ideapad_pm, NULL, ideapad_acpi_resume);
 #endif
+static SIMPLE_DEV_PM_OPS(ideapad_pm, NULL, ideapad_acpi_resume);
 
-static struct acpi_driver ideapad_acpi_driver = {
-	.name = "ideapad_acpi",
-	.class = "IdeaPad",
-	.ids = ideapad_device_ids,
-	.ops.add = ideapad_acpi_add,
-	.ops.remove = ideapad_acpi_remove,
-	.ops.notify = ideapad_acpi_notify,
-#ifdef CONFIG_PM_SLEEP
-	.drv.pm = &ideapad_pm,
-#endif
-	.owner = THIS_MODULE,
+static const struct acpi_device_id ideapad_device_ids[] = {
+	{ "VPC2004", 0},
+	{ "", 0},
 };
-module_acpi_driver(ideapad_acpi_driver);
+MODULE_DEVICE_TABLE(acpi, ideapad_device_ids);
+
+static struct platform_driver ideapad_acpi_driver = {
+	.probe = ideapad_acpi_add,
+	.remove = ideapad_acpi_remove,
+	.driver = {
+		.name   = "ideapad_acpi",
+		.owner  = THIS_MODULE,
+		.pm     = &ideapad_pm,
+		.acpi_match_table = ACPI_PTR(ideapad_device_ids),
+	},
+};
+
+module_platform_driver(ideapad_acpi_driver);
 
 MODULE_AUTHOR("David Woodhouse <dwmw2@infradead.org>");
 MODULE_DESCRIPTION("IdeaPad ACPI Extras");
-- 
1.7.9.5

