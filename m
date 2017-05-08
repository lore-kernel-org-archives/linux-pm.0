From: Benson Leung <bleung@chromium.org>
Subject: [PATCH] power_supply: Add Apple Brick ID power supply type
Date: Mon,  8 May 2017 15:02:48 -0700
Message-ID: <20170508220248.97372-1-bleung@chromium.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:32985 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751018AbdEHWC5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2017 18:02:57 -0400
Received: by mail-pg0-f54.google.com with SMTP id u187so33568401pgb.0
        for <linux-pm@vger.kernel.org>; Mon, 08 May 2017 15:02:57 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ras@apple.com, tomeu.vizoso@collabora.com, bleung@chromium.org, bleung@google.com

Apple currently supports three very common USB chargers:
https://www.apple.com/power-adapters/

These chargers implement a proprietary Apple method for advertising
1A, 2.1A, and 2.4A at 5V called "Brick ID".
In addition, 3rd parties implement the same charging method in many
charging accessories that work with iOS devices.

Devices that have charger detection chips such as the Pericom PI3USB9281,
eg. Google Chromebook Pixel 2015, are capable of detecting
these chargers, so let's add a type to facilicate passing that info
up to userspace.

This adds a separate power supply type for Apple's proprietary
"Brick ID" charging method.

Signed-off-by: Benson Leung <bleung@chromium.org>
---
 drivers/power/supply/power_supply_sysfs.c |  2 +-
 include/linux/power_supply.h              | 15 ++++++++-------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index bcde8d13476a..07b484f995c1 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -46,7 +46,7 @@ static ssize_t power_supply_show_property(struct device *dev,
 	static char *type_text[] = {
 		"Unknown", "Battery", "UPS", "Mains", "USB",
 		"USB_DCP", "USB_CDP", "USB_ACA", "USB_C",
-		"USB_PD", "USB_PD_DRP"
+		"USB_PD", "USB_PD_DRP", "BrickID"
 	};
 	static char *status_text[] = {
 		"Unknown", "Charging", "Discharging", "Not charging", "Full"
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 3965503315ef..4bd34051995e 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -159,13 +159,14 @@ enum power_supply_type {
 	POWER_SUPPLY_TYPE_BATTERY,
 	POWER_SUPPLY_TYPE_UPS,
 	POWER_SUPPLY_TYPE_MAINS,
-	POWER_SUPPLY_TYPE_USB,		/* Standard Downstream Port */
-	POWER_SUPPLY_TYPE_USB_DCP,	/* Dedicated Charging Port */
-	POWER_SUPPLY_TYPE_USB_CDP,	/* Charging Downstream Port */
-	POWER_SUPPLY_TYPE_USB_ACA,	/* Accessory Charger Adapters */
-	POWER_SUPPLY_TYPE_USB_TYPE_C,	/* Type C Port */
-	POWER_SUPPLY_TYPE_USB_PD,	/* Power Delivery Port */
-	POWER_SUPPLY_TYPE_USB_PD_DRP,	/* PD Dual Role Port */
+	POWER_SUPPLY_TYPE_USB,			/* Standard Downstream Port */
+	POWER_SUPPLY_TYPE_USB_DCP,		/* Dedicated Charging Port */
+	POWER_SUPPLY_TYPE_USB_CDP,		/* Charging Downstream Port */
+	POWER_SUPPLY_TYPE_USB_ACA,		/* Accessory Charger Adapters */
+	POWER_SUPPLY_TYPE_USB_TYPE_C,		/* Type C Port */
+	POWER_SUPPLY_TYPE_USB_PD,		/* Power Delivery Port */
+	POWER_SUPPLY_TYPE_USB_PD_DRP,		/* PD Dual Role Port */
+	POWER_SUPPLY_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
 };
 
 enum power_supply_notifier_events {
-- 
2.13.0.rc1.294.g07d810a77f-goog
