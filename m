From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 4/6] ideapad_laptop: convert internal function calls to use ideapad_private as parameter
Date: Mon, 23 Sep 2013 15:50:49 +0800
Message-ID: <1379922651-5578-5-git-send-email-rui.zhang@intel.com>
References: <1379922651-5578-1-git-send-email-rui.zhang@intel.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1379922651-5578-1-git-send-email-rui.zhang@intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <matthew.garrett@nebula.com>, Ike Panhc <ike.pan@canonical.com>, platform-driver-x86@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

As struct ideapad_private has all the information needed for any operations,
convert ideapad_register_rfkill()/ideapad_unregister_rfkill() and
ideapad_sync_touchpad_state() to use struct ideapad_private as the parameter,
to be consistent with the others.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
CC: Matthew Garrett <matthew.garrett@nebula.com>
CC: Ike Panhc <ike.pan@canonical.com>
CC: platform-driver-x86@vger.kernel.org
---
 drivers/platform/x86/ideapad-laptop.c |   38 ++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index edd3656..70fb5ba 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -469,9 +469,8 @@ static void ideapad_sync_rfk_state(struct ideapad_private *priv)
 			rfkill_set_hw_state(priv->rfk[i], hw_blocked);
 }
 
-static int ideapad_register_rfkill(struct acpi_device *adev, int dev)
+static int ideapad_register_rfkill(struct ideapad_private *priv, int dev)
 {
-	struct ideapad_private *priv = dev_get_drvdata(&adev->dev);
 	int ret;
 	unsigned long sw_blocked;
 
@@ -483,8 +482,10 @@ static int ideapad_register_rfkill(struct acpi_device *adev, int dev)
 		return 0;
 	}
 
-	priv->rfk[dev] = rfkill_alloc(ideapad_rfk_data[dev].name, &adev->dev,
-				      ideapad_rfk_data[dev].type, &ideapad_rfk_ops,
+	priv->rfk[dev] = rfkill_alloc(ideapad_rfk_data[dev].name,
+				      &priv->adev->dev,
+				      ideapad_rfk_data[dev].type,
+				      &ideapad_rfk_ops,
 				      (void *)(long)dev);
 	if (!priv->rfk[dev])
 		return -ENOMEM;
@@ -505,10 +506,8 @@ static int ideapad_register_rfkill(struct acpi_device *adev, int dev)
 	return 0;
 }
 
-static void ideapad_unregister_rfkill(struct acpi_device *adev, int dev)
+static void ideapad_unregister_rfkill(struct ideapad_private *priv, int dev)
 {
-	struct ideapad_private *priv = dev_get_drvdata(&adev->dev);
-
 	if (!priv->rfk[dev])
 		return;
 
@@ -762,13 +761,12 @@ static const struct acpi_device_id ideapad_device_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, ideapad_device_ids);
 
-static void ideapad_sync_touchpad_state(struct acpi_device *adev)
+static void ideapad_sync_touchpad_state(struct ideapad_private *priv)
 {
-	struct ideapad_private *priv = dev_get_drvdata(&adev->dev);
 	unsigned long value;
 
 	/* Without reading from EC touchpad LED doesn't switch state */
-	if (!read_ec_data(adev->handle, VPCCMD_R_TOUCHPAD, &value)) {
+	if (!read_ec_data(priv->adev->handle, VPCCMD_R_TOUCHPAD, &value)) {
 		/* Some IdeaPads don't really turn off touchpad - they only
 		 * switch the LED state. We (de)activate KBC AUX port to turn
 		 * touchpad off and on. We send KEY_TOUCHPAD_OFF and
@@ -812,12 +810,12 @@ static int ideapad_acpi_add(struct acpi_device *adev)
 
 	for (i = 0; i < IDEAPAD_RFKILL_DEV_NUM; i++) {
 		if (test_bit(ideapad_rfk_data[i].cfgbit, &priv->cfg))
-			ideapad_register_rfkill(adev, i);
+			ideapad_register_rfkill(priv, i);
 		else
 			priv->rfk[i] = NULL;
 	}
 	ideapad_sync_rfk_state(priv);
-	ideapad_sync_touchpad_state(adev);
+	ideapad_sync_touchpad_state(priv);
 
 	if (!acpi_video_backlight_support()) {
 		ret = ideapad_backlight_init(priv);
@@ -829,7 +827,7 @@ static int ideapad_acpi_add(struct acpi_device *adev)
 
 backlight_failed:
 	for (i = 0; i < IDEAPAD_RFKILL_DEV_NUM; i++)
-		ideapad_unregister_rfkill(adev, i);
+		ideapad_unregister_rfkill(priv, i);
 	ideapad_input_exit(priv);
 input_failed:
 	ideapad_debugfs_exit(priv);
@@ -847,7 +845,7 @@ static int ideapad_acpi_remove(struct acpi_device *adev)
 
 	ideapad_backlight_exit(priv);
 	for (i = 0; i < IDEAPAD_RFKILL_DEV_NUM; i++)
-		ideapad_unregister_rfkill(adev, i);
+		ideapad_unregister_rfkill(priv, i);
 	ideapad_input_exit(priv);
 	ideapad_debugfs_exit(priv);
 	ideapad_platform_exit(priv);
@@ -882,7 +880,7 @@ static void ideapad_acpi_notify(struct acpi_device *adev, u32 event)
 				ideapad_input_report(priv, vpc_bit);
 				break;
 			case 5:
-				ideapad_sync_touchpad_state(adev);
+				ideapad_sync_touchpad_state(priv);
 				break;
 			case 4:
 				ideapad_backlight_notify_brightness(priv);
@@ -906,8 +904,14 @@ static void ideapad_acpi_notify(struct acpi_device *adev, u32 event)
 #ifdef CONFIG_PM_SLEEP
 static int ideapad_acpi_resume(struct device *device)
 {
-	ideapad_sync_rfk_state(ideapad_priv);
-	ideapad_sync_touchpad_state(to_acpi_device(device));
+	struct ideapad_private *priv;
+
+	if (!device)
+		return -EINVAL;
+	priv = dev_get_drvdata(device);
+
+	ideapad_sync_rfk_state(priv);
+	ideapad_sync_touchpad_state(priv);
 	return 0;
 }
 
-- 
1.7.9.5
