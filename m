From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 5/6] ideapad_laptop: remove ideapad_handle and ideapad_priv
Date: Wed, 25 Sep 2013 20:39:49 +0800
Message-ID: <1380112790-2321-6-git-send-email-rui.zhang@intel.com>
References: <1380112790-2321-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:44043 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755111Ab3IYMkS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 25 Sep 2013 08:40:18 -0400
In-Reply-To: <1380112790-2321-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <matthew.garrett@nebula.com>, Ike Panhc <ike.pan@canonical.com>, platform-driver-x86@vger.kernel.org

The current code use ideapad_handle and ideapad_priv to store
some information for the ideapad device.
But as they are global/static variables, the driver will be broken
if there are more than one ideapad ACPI device node on a platform.
Although this does not happen for now and may not happen in the future,
but still, this is a software bug.

Remove these two variables in this patch.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
CC: Matthew Garrett <matthew.garrett@nebula.com>
CC: Ike Panhc <ike.pan@canonical.com>
CC: platform-driver-x86@vger.kernel.org
---
 drivers/platform/x86/ideapad-laptop.c |  114 ++++++++++++++++++++-------------
 1 file changed, 69 insertions(+), 45 deletions(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 70fb5ba..cad48b5 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -72,9 +72,15 @@ enum {
 	VPCCMD_W_BL_POWER = 0x33,
 };
 
+struct ideapad_rfk_priv {
+	int dev;
+	struct ideapad_private *priv;
+};
+
 struct ideapad_private {
 	struct acpi_device *adev;
 	struct rfkill *rfk[IDEAPAD_RFKILL_DEV_NUM];
+	struct ideapad_rfk_priv rfk_priv[IDEAPAD_RFKILL_DEV_NUM];
 	struct platform_device *platform_device;
 	struct input_dev *inputdev;
 	struct backlight_device *blightdev;
@@ -82,8 +88,6 @@ struct ideapad_private {
 	unsigned long cfg;
 };
 
-static acpi_handle ideapad_handle;
-static struct ideapad_private *ideapad_priv;
 static bool no_bt_rfkill;
 module_param(no_bt_rfkill, bool, 0444);
 MODULE_PARM_DESC(no_bt_rfkill, "No rfkill for bluetooth.");
@@ -201,34 +205,38 @@ static int write_ec_cmd(acpi_handle handle, int cmd, unsigned long data)
  */
 static int debugfs_status_show(struct seq_file *s, void *data)
 {
+	struct ideapad_private *priv = s->private;
 	unsigned long value;
 
-	if (!read_ec_data(ideapad_handle, VPCCMD_R_BL_MAX, &value))
+	if (!priv)
+		return -EINVAL;
+
+	if (!read_ec_data(priv->adev->handle, VPCCMD_R_BL_MAX, &value))
 		seq_printf(s, "Backlight max:\t%lu\n", value);
-	if (!read_ec_data(ideapad_handle, VPCCMD_R_BL, &value))
+	if (!read_ec_data(priv->adev->handle, VPCCMD_R_BL, &value))
 		seq_printf(s, "Backlight now:\t%lu\n", value);
-	if (!read_ec_data(ideapad_handle, VPCCMD_R_BL_POWER, &value))
+	if (!read_ec_data(priv->adev->handle, VPCCMD_R_BL_POWER, &value))
 		seq_printf(s, "BL power value:\t%s\n", value ? "On" : "Off");
 	seq_printf(s, "=====================\n");
 
-	if (!read_ec_data(ideapad_handle, VPCCMD_R_RF, &value))
+	if (!read_ec_data(priv->adev->handle, VPCCMD_R_RF, &value))
 		seq_printf(s, "Radio status:\t%s(%lu)\n",
 			   value ? "On" : "Off", value);
-	if (!read_ec_data(ideapad_handle, VPCCMD_R_WIFI, &value))
+	if (!read_ec_data(priv->adev->handle, VPCCMD_R_WIFI, &value))
 		seq_printf(s, "Wifi status:\t%s(%lu)\n",
 			   value ? "On" : "Off", value);
-	if (!read_ec_data(ideapad_handle, VPCCMD_R_BT, &value))
+	if (!read_ec_data(priv->adev->handle, VPCCMD_R_BT, &value))
 		seq_printf(s, "BT status:\t%s(%lu)\n",
 			   value ? "On" : "Off", value);
-	if (!read_ec_data(ideapad_handle, VPCCMD_R_3G, &value))
+	if (!read_ec_data(priv->adev->handle, VPCCMD_R_3G, &value))
 		seq_printf(s, "3G status:\t%s(%lu)\n",
 			   value ? "On" : "Off", value);
 	seq_printf(s, "=====================\n");
 
-	if (!read_ec_data(ideapad_handle, VPCCMD_R_TOUCHPAD, &value))
+	if (!read_ec_data(priv->adev->handle, VPCCMD_R_TOUCHPAD, &value))
 		seq_printf(s, "Touchpad status:%s(%lu)\n",
 			   value ? "On" : "Off", value);
-	if (!read_ec_data(ideapad_handle, VPCCMD_R_CAMERA, &value))
+	if (!read_ec_data(priv->adev->handle, VPCCMD_R_CAMERA, &value))
 		seq_printf(s, "Camera status:\t%s(%lu)\n",
 			   value ? "On" : "Off", value);
 
@@ -237,7 +245,7 @@ static int debugfs_status_show(struct seq_file *s, void *data)
 
 static int debugfs_status_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, debugfs_status_show, NULL);
+	return single_open(file, debugfs_status_show, inode->i_private);
 }
 
 static const struct file_operations debugfs_status_fops = {
@@ -250,21 +258,23 @@ static const struct file_operations debugfs_status_fops = {
 
 static int debugfs_cfg_show(struct seq_file *s, void *data)
 {
-	if (!ideapad_priv) {
+	struct ideapad_private *priv = s->private;
+
+	if (!priv) {
 		seq_printf(s, "cfg: N/A\n");
 	} else {
 		seq_printf(s, "cfg: 0x%.8lX\n\nCapability: ",
-			   ideapad_priv->cfg);
-		if (test_bit(CFG_BT_BIT, &ideapad_priv->cfg))
+			   priv->cfg);
+		if (test_bit(CFG_BT_BIT, &priv->cfg))
 			seq_printf(s, "Bluetooth ");
-		if (test_bit(CFG_3G_BIT, &ideapad_priv->cfg))
+		if (test_bit(CFG_3G_BIT, &priv->cfg))
 			seq_printf(s, "3G ");
-		if (test_bit(CFG_WIFI_BIT, &ideapad_priv->cfg))
+		if (test_bit(CFG_WIFI_BIT, &priv->cfg))
 			seq_printf(s, "Wireless ");
-		if (test_bit(CFG_CAMERA_BIT, &ideapad_priv->cfg))
+		if (test_bit(CFG_CAMERA_BIT, &priv->cfg))
 			seq_printf(s, "Camera ");
 		seq_printf(s, "\nGraphic: ");
-		switch ((ideapad_priv->cfg)&0x700) {
+		switch ((priv->cfg)&0x700) {
 		case 0x100:
 			seq_printf(s, "Intel");
 			break;
@@ -288,7 +298,7 @@ static int debugfs_cfg_show(struct seq_file *s, void *data)
 
 static int debugfs_cfg_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, debugfs_cfg_show, NULL);
+	return single_open(file, debugfs_cfg_show, inode->i_private);
 }
 
 static const struct file_operations debugfs_cfg_fops = {
@@ -309,14 +319,14 @@ static int ideapad_debugfs_init(struct ideapad_private *priv)
 		goto errout;
 	}
 
-	node = debugfs_create_file("cfg", S_IRUGO, priv->debug, NULL,
+	node = debugfs_create_file("cfg", S_IRUGO, priv->debug, priv,
 				   &debugfs_cfg_fops);
 	if (!node) {
 		pr_err("failed to create cfg in debugfs");
 		goto errout;
 	}
 
-	node = debugfs_create_file("status", S_IRUGO, priv->debug, NULL,
+	node = debugfs_create_file("status", S_IRUGO, priv->debug, priv,
 				   &debugfs_status_fops);
 	if (!node) {
 		pr_err("failed to create status in debugfs");
@@ -343,8 +353,9 @@ static ssize_t show_ideapad_cam(struct device *dev,
 				char *buf)
 {
 	unsigned long result;
+	struct ideapad_private *priv = dev_get_drvdata(dev);
 
-	if (read_ec_data(ideapad_handle, VPCCMD_R_CAMERA, &result))
+	if (read_ec_data(priv->adev->handle, VPCCMD_R_CAMERA, &result))
 		return sprintf(buf, "-1\n");
 	return sprintf(buf, "%lu\n", result);
 }
@@ -354,12 +365,13 @@ static ssize_t store_ideapad_cam(struct device *dev,
 				 const char *buf, size_t count)
 {
 	int ret, state;
+	struct ideapad_private *priv = dev_get_drvdata(dev);
 
 	if (!count)
 		return 0;
 	if (sscanf(buf, "%i", &state) != 1)
 		return -EINVAL;
-	ret = write_ec_cmd(ideapad_handle, VPCCMD_W_CAMERA, state);
+	ret = write_ec_cmd(priv->adev->handle, VPCCMD_W_CAMERA, state);
 	if (ret < 0)
 		return -EIO;
 	return count;
@@ -372,8 +384,9 @@ static ssize_t show_ideapad_fan(struct device *dev,
 				char *buf)
 {
 	unsigned long result;
+	struct ideapad_private *priv = dev_get_drvdata(dev);
 
-	if (read_ec_data(ideapad_handle, VPCCMD_R_FAN, &result))
+	if (read_ec_data(priv->adev->handle, VPCCMD_R_FAN, &result))
 		return sprintf(buf, "-1\n");
 	return sprintf(buf, "%lu\n", result);
 }
@@ -383,6 +396,7 @@ static ssize_t store_ideapad_fan(struct device *dev,
 				 const char *buf, size_t count)
 {
 	int ret, state;
+	struct ideapad_private *priv = dev_get_drvdata(dev);
 
 	if (!count)
 		return 0;
@@ -390,7 +404,7 @@ static ssize_t store_ideapad_fan(struct device *dev,
 		return -EINVAL;
 	if (state < 0 || state > 4 || state == 3)
 		return -EINVAL;
-	ret = write_ec_cmd(ideapad_handle, VPCCMD_W_FAN, state);
+	ret = write_ec_cmd(priv->adev->handle, VPCCMD_W_FAN, state);
 	if (ret < 0)
 		return -EIO;
 	return count;
@@ -416,7 +430,8 @@ static umode_t ideapad_is_visible(struct kobject *kobj,
 		supported = test_bit(CFG_CAMERA_BIT, &(priv->cfg));
 	else if (attr == &dev_attr_fan_mode.attr) {
 		unsigned long value;
-		supported = !read_ec_data(ideapad_handle, VPCCMD_R_FAN, &value);
+		supported = !read_ec_data(priv->adev->handle, VPCCMD_R_FAN,
+					  &value);
 	} else
 		supported = true;
 
@@ -446,9 +461,9 @@ const struct ideapad_rfk_data ideapad_rfk_data[] = {
 
 static int ideapad_rfk_set(void *data, bool blocked)
 {
-	unsigned long opcode = (unsigned long)data;
+	struct ideapad_rfk_priv *priv = data;
 
-	return write_ec_cmd(ideapad_handle, opcode, !blocked);
+	return write_ec_cmd(priv->priv->adev->handle, priv->dev, !blocked);
 }
 
 static struct rfkill_ops ideapad_rfk_ops = {
@@ -460,7 +475,7 @@ static void ideapad_sync_rfk_state(struct ideapad_private *priv)
 	unsigned long hw_blocked;
 	int i;
 
-	if (read_ec_data(ideapad_handle, VPCCMD_R_RF, &hw_blocked))
+	if (read_ec_data(priv->adev->handle, VPCCMD_R_RF, &hw_blocked))
 		return;
 	hw_blocked = !hw_blocked;
 
@@ -477,20 +492,22 @@ static int ideapad_register_rfkill(struct ideapad_private *priv, int dev)
 	if (no_bt_rfkill &&
 	    (ideapad_rfk_data[dev].type == RFKILL_TYPE_BLUETOOTH)) {
 		/* Force to enable bluetooth when no_bt_rfkill=1 */
-		write_ec_cmd(ideapad_handle,
+		write_ec_cmd(priv->adev->handle,
 			     ideapad_rfk_data[dev].opcode, 1);
 		return 0;
 	}
+	priv->rfk_priv[dev].dev = dev;
+	priv->rfk_priv[dev].priv = priv;
 
 	priv->rfk[dev] = rfkill_alloc(ideapad_rfk_data[dev].name,
 				      &priv->adev->dev,
 				      ideapad_rfk_data[dev].type,
 				      &ideapad_rfk_ops,
-				      (void *)(long)dev);
+				      &priv->rfk_priv[dev]);
 	if (!priv->rfk[dev])
 		return -ENOMEM;
 
-	if (read_ec_data(ideapad_handle, ideapad_rfk_data[dev].opcode-1,
+	if (read_ec_data(priv->adev->handle, ideapad_rfk_data[dev].opcode-1,
 			 &sw_blocked)) {
 		rfkill_init_sw_state(priv->rfk[dev], 0);
 	} else {
@@ -623,7 +640,7 @@ static void ideapad_input_novokey(struct ideapad_private *priv)
 {
 	unsigned long long_pressed;
 
-	if (read_ec_data(ideapad_handle, VPCCMD_R_NOVO, &long_pressed))
+	if (read_ec_data(priv->adev->handle, VPCCMD_R_NOVO, &long_pressed))
 		return;
 	if (long_pressed)
 		ideapad_input_report(priv, 17);
@@ -635,7 +652,7 @@ static void ideapad_check_special_buttons(struct ideapad_private *priv)
 {
 	unsigned long bit, value;
 
-	read_ec_data(ideapad_handle, VPCCMD_R_SPECIAL_BUTTONS, &value);
+	read_ec_data(priv->adev->handle, VPCCMD_R_SPECIAL_BUTTONS, &value);
 
 	for (bit = 0; bit < 16; bit++) {
 		if (test_bit(bit, &value)) {
@@ -662,19 +679,28 @@ static void ideapad_check_special_buttons(struct ideapad_private *priv)
  */
 static int ideapad_backlight_get_brightness(struct backlight_device *blightdev)
 {
+	struct ideapad_private *priv = bl_get_data(blightdev);
 	unsigned long now;
 
-	if (read_ec_data(ideapad_handle, VPCCMD_R_BL, &now))
+	if (!priv)
+		return -EINVAL;
+
+	if (read_ec_data(priv->adev->handle, VPCCMD_R_BL, &now))
 		return -EIO;
 	return now;
 }
 
 static int ideapad_backlight_update_status(struct backlight_device *blightdev)
 {
-	if (write_ec_cmd(ideapad_handle, VPCCMD_W_BL,
+	struct ideapad_private *priv = bl_get_data(blightdev);
+
+	if (!priv)
+		return -EINVAL;
+
+	if (write_ec_cmd(priv->adev->handle, VPCCMD_W_BL,
 			 blightdev->props.brightness))
 		return -EIO;
-	if (write_ec_cmd(ideapad_handle, VPCCMD_W_BL_POWER,
+	if (write_ec_cmd(priv->adev->handle, VPCCMD_W_BL_POWER,
 			 blightdev->props.power == FB_BLANK_POWERDOWN ? 0 : 1))
 		return -EIO;
 
@@ -692,11 +718,11 @@ static int ideapad_backlight_init(struct ideapad_private *priv)
 	struct backlight_properties props;
 	unsigned long max, now, power;
 
-	if (read_ec_data(ideapad_handle, VPCCMD_R_BL_MAX, &max))
+	if (read_ec_data(priv->adev->handle, VPCCMD_R_BL_MAX, &max))
 		return -EIO;
-	if (read_ec_data(ideapad_handle, VPCCMD_R_BL, &now))
+	if (read_ec_data(priv->adev->handle, VPCCMD_R_BL, &now))
 		return -EIO;
-	if (read_ec_data(ideapad_handle, VPCCMD_R_BL_POWER, &power))
+	if (read_ec_data(priv->adev->handle, VPCCMD_R_BL_POWER, &power))
 		return -EIO;
 
 	memset(&props, 0, sizeof(struct backlight_properties));
@@ -734,7 +760,7 @@ static void ideapad_backlight_notify_power(struct ideapad_private *priv)
 
 	if (!blightdev)
 		return;
-	if (read_ec_data(ideapad_handle, VPCCMD_R_BL_POWER, &power))
+	if (read_ec_data(priv->adev->handle, VPCCMD_R_BL_POWER, &power))
 		return;
 	blightdev->props.power = power ? FB_BLANK_UNBLANK : FB_BLANK_POWERDOWN;
 }
@@ -745,7 +771,7 @@ static void ideapad_backlight_notify_brightness(struct ideapad_private *priv)
 
 	/* if we control brightness via acpi video driver */
 	if (priv->blightdev == NULL) {
-		read_ec_data(ideapad_handle, VPCCMD_R_BL, &now);
+		read_ec_data(priv->adev->handle, VPCCMD_R_BL, &now);
 		return;
 	}
 
@@ -791,8 +817,6 @@ static int ideapad_acpi_add(struct acpi_device *adev)
 	if (!priv)
 		return -ENOMEM;
 	dev_set_drvdata(&adev->dev, priv);
-	ideapad_priv = priv;
-	ideapad_handle = adev->handle;
 	priv->cfg = cfg;
 	priv->adev = adev;
 
-- 
1.7.9.5

