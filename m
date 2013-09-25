From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 3/6] ideapad_laptop: introduce struct acpi_device pointer to ideapad_private structure
Date: Wed, 25 Sep 2013 20:39:47 +0800
Message-ID: <1380112790-2321-4-git-send-email-rui.zhang@intel.com>
References: <1380112790-2321-1-git-send-email-rui.zhang@intel.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1380112790-2321-1-git-send-email-rui.zhang@intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <matthew.garrett@nebula.com>, Ike Panhc <ike.pan@canonical.com>, platform-driver-x86@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Introduce struct acpi_device pointer to ideapad_private structure.
At the same time, replace all adevice with adev to be short and consistent.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
CC: Matthew Garrett <matthew.garrett@nebula.com>
CC: Ike Panhc <ike.pan@canonical.com>
CC: platform-driver-x86@vger.kernel.org
---
 drivers/platform/x86/ideapad-laptop.c |   48 +++++++++++++++++----------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 5021c55..edd3656 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -73,6 +73,7 @@ enum {
 };
 
 struct ideapad_private {
+	struct acpi_device *adev;
 	struct rfkill *rfk[IDEAPAD_RFKILL_DEV_NUM];
 	struct platform_device *platform_device;
 	struct input_dev *inputdev;
@@ -468,9 +469,9 @@ static void ideapad_sync_rfk_state(struct ideapad_private *priv)
 			rfkill_set_hw_state(priv->rfk[i], hw_blocked);
 }
 
-static int ideapad_register_rfkill(struct acpi_device *adevice, int dev)
+static int ideapad_register_rfkill(struct acpi_device *adev, int dev)
 {
-	struct ideapad_private *priv = dev_get_drvdata(&adevice->dev);
+	struct ideapad_private *priv = dev_get_drvdata(&adev->dev);
 	int ret;
 	unsigned long sw_blocked;
 
@@ -482,7 +483,7 @@ static int ideapad_register_rfkill(struct acpi_device *adevice, int dev)
 		return 0;
 	}
 
-	priv->rfk[dev] = rfkill_alloc(ideapad_rfk_data[dev].name, &adevice->dev,
+	priv->rfk[dev] = rfkill_alloc(ideapad_rfk_data[dev].name, &adev->dev,
 				      ideapad_rfk_data[dev].type, &ideapad_rfk_ops,
 				      (void *)(long)dev);
 	if (!priv->rfk[dev])
@@ -504,9 +505,9 @@ static int ideapad_register_rfkill(struct acpi_device *adevice, int dev)
 	return 0;
 }
 
-static void ideapad_unregister_rfkill(struct acpi_device *adevice, int dev)
+static void ideapad_unregister_rfkill(struct acpi_device *adev, int dev)
 {
-	struct ideapad_private *priv = dev_get_drvdata(&adevice->dev);
+	struct ideapad_private *priv = dev_get_drvdata(&adev->dev);
 
 	if (!priv->rfk[dev])
 		return;
@@ -761,13 +762,13 @@ static const struct acpi_device_id ideapad_device_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, ideapad_device_ids);
 
-static void ideapad_sync_touchpad_state(struct acpi_device *adevice)
+static void ideapad_sync_touchpad_state(struct acpi_device *adev)
 {
-	struct ideapad_private *priv = dev_get_drvdata(&adevice->dev);
+	struct ideapad_private *priv = dev_get_drvdata(&adev->dev);
 	unsigned long value;
 
 	/* Without reading from EC touchpad LED doesn't switch state */
-	if (!read_ec_data(adevice->handle, VPCCMD_R_TOUCHPAD, &value)) {
+	if (!read_ec_data(adev->handle, VPCCMD_R_TOUCHPAD, &value)) {
 		/* Some IdeaPads don't really turn off touchpad - they only
 		 * switch the LED state. We (de)activate KBC AUX port to turn
 		 * touchpad off and on. We send KEY_TOUCHPAD_OFF and
@@ -779,22 +780,23 @@ static void ideapad_sync_touchpad_state(struct acpi_device *adevice)
 	}
 }
 
-static int ideapad_acpi_add(struct acpi_device *adevice)
+static int ideapad_acpi_add(struct acpi_device *adev)
 {
 	int ret, i;
 	int cfg;
 	struct ideapad_private *priv;
 
-	if (read_method_int(adevice->handle, "_CFG", &cfg))
+	if (read_method_int(adev->handle, "_CFG", &cfg))
 		return -ENODEV;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
-	dev_set_drvdata(&adevice->dev, priv);
+	dev_set_drvdata(&adev->dev, priv);
 	ideapad_priv = priv;
-	ideapad_handle = adevice->handle;
+	ideapad_handle = adev->handle;
 	priv->cfg = cfg;
+	priv->adev = adev;
 
 	ret = ideapad_platform_init(priv);
 	if (ret)
@@ -810,12 +812,12 @@ static int ideapad_acpi_add(struct acpi_device *adevice)
 
 	for (i = 0; i < IDEAPAD_RFKILL_DEV_NUM; i++) {
 		if (test_bit(ideapad_rfk_data[i].cfgbit, &priv->cfg))
-			ideapad_register_rfkill(adevice, i);
+			ideapad_register_rfkill(adev, i);
 		else
 			priv->rfk[i] = NULL;
 	}
 	ideapad_sync_rfk_state(priv);
-	ideapad_sync_touchpad_state(adevice);
+	ideapad_sync_touchpad_state(adev);
 
 	if (!acpi_video_backlight_support()) {
 		ret = ideapad_backlight_init(priv);
@@ -827,7 +829,7 @@ static int ideapad_acpi_add(struct acpi_device *adevice)
 
 backlight_failed:
 	for (i = 0; i < IDEAPAD_RFKILL_DEV_NUM; i++)
-		ideapad_unregister_rfkill(adevice, i);
+		ideapad_unregister_rfkill(adev, i);
 	ideapad_input_exit(priv);
 input_failed:
 	ideapad_debugfs_exit(priv);
@@ -838,27 +840,27 @@ static int ideapad_acpi_add(struct acpi_device *adevice)
 	return ret;
 }
 
-static int ideapad_acpi_remove(struct acpi_device *adevice)
+static int ideapad_acpi_remove(struct acpi_device *adev)
 {
-	struct ideapad_private *priv = dev_get_drvdata(&adevice->dev);
+	struct ideapad_private *priv = dev_get_drvdata(&adev->dev);
 	int i;
 
 	ideapad_backlight_exit(priv);
 	for (i = 0; i < IDEAPAD_RFKILL_DEV_NUM; i++)
-		ideapad_unregister_rfkill(adevice, i);
+		ideapad_unregister_rfkill(adev, i);
 	ideapad_input_exit(priv);
 	ideapad_debugfs_exit(priv);
 	ideapad_platform_exit(priv);
-	dev_set_drvdata(&adevice->dev, NULL);
+	dev_set_drvdata(&adev->dev, NULL);
 	kfree(priv);
 
 	return 0;
 }
 
-static void ideapad_acpi_notify(struct acpi_device *adevice, u32 event)
+static void ideapad_acpi_notify(struct acpi_device *adev, u32 event)
 {
-	struct ideapad_private *priv = dev_get_drvdata(&adevice->dev);
-	acpi_handle handle = adevice->handle;
+	struct ideapad_private *priv = dev_get_drvdata(&adev->dev);
+	acpi_handle handle = adev->handle;
 	unsigned long vpc1, vpc2, vpc_bit;
 
 	if (read_ec_data(handle, VPCCMD_R_VPC1, &vpc1))
@@ -880,7 +882,7 @@ static void ideapad_acpi_notify(struct acpi_device *adevice, u32 event)
 				ideapad_input_report(priv, vpc_bit);
 				break;
 			case 5:
-				ideapad_sync_touchpad_state(adevice);
+				ideapad_sync_touchpad_state(adev);
 				break;
 			case 4:
 				ideapad_backlight_notify_brightness(priv);
-- 
1.7.9.5
