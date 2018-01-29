From: 0v3rdr0n3@gmail.com
Subject: [PATCH] leds: use QoS to control LED suspend behavior from userspace
Date: Mon, 29 Jan 2018 19:49:47 +0000
Message-ID: <20180129194947.11071-1-0v3rdr0n3@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:36139 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751546AbeA3AuF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jan 2018 19:50:05 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-leds@vger.kernel.org
Cc: samorris@lexmark.com

From: Samuel Morris <samorris@lexmark.com>

Signed-off-by: Samuel Morris <samorris@lexmark.com>
---
 drivers/leds/led-class.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index f2b0a80..9e9e265 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -20,6 +20,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/timer.h>
+#include <linux/pm_qos.h>
 #include <uapi/linux/uleds.h>
 #include "leds.h"
 
@@ -196,6 +197,11 @@ static int led_suspend(struct device *dev)
 {
 	struct led_classdev *led_cdev = dev_get_drvdata(dev);
 
+	if(dev_pm_qos_flags(dev, PM_QOS_FLAG_NO_POWER_OFF) ==
+			PM_QOS_FLAGS_ALL) {
+		return 0;
+	}
+
 	if (led_cdev->flags & LED_CORE_SUSPENDRESUME)
 		led_classdev_suspend(led_cdev);
 
@@ -206,6 +212,11 @@ static int led_resume(struct device *dev)
 {
 	struct led_classdev *led_cdev = dev_get_drvdata(dev);
 
+	if(dev_pm_qos_flags(dev, PM_QOS_FLAG_NO_POWER_OFF) ==
+			PM_QOS_FLAGS_ALL) {
+		return 0;
+	}
+
 	if (led_cdev->flags & LED_CORE_SUSPENDRESUME)
 		led_classdev_resume(led_cdev);
 
@@ -287,6 +298,18 @@ int led_classdev_register(struct device *parent, struct led_classdev *led_cdev)
 	list_add_tail(&led_cdev->node, &leds_list);
 	up_write(&leds_list_lock);
 
+	/* Attempt to let userspace take over the policy. */
+	ret = dev_pm_qos_expose_flags(led_cdev->dev,
+			PM_QOS_FLAG_NO_POWER_OFF);
+	if (ret < 0) {
+		dev_warn(led_cdev->dev, "failed to expose pm_qos_no_poweroff\n");
+		return 0;
+	}
+
+	ret = dev_pm_qos_update_flags(led_cdev->dev,
+			PM_QOS_FLAG_NO_POWER_OFF,
+			0);
+
 	if (!led_cdev->max_brightness)
 		led_cdev->max_brightness = LED_FULL;
 
-- 
1.9.3
