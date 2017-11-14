From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [RFC PATCH v2 5/7] power: supply: Add type for USB PD PPS chargers
Date: Tue, 14 Nov 2017 11:44:46 +0000
Message-ID: <1dda0bc14ac59583f9abd4b1ab3435e71a8672dc.1510657748.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1510657748.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail1.bemta6.messagelabs.com ([193.109.254.107]:20725 "EHLO
        mail1.bemta6.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755201AbdKNLoz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Nov 2017 06:44:55 -0500
In-Reply-To: <cover.1510657748.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Yueyao Zhu <yueyao.zhu@gmail.com>, Rui Miguel Silva <rmfrfs@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, support.opensource@diasemi.com

This adds a type to represent USB PPS chargers as defined in the
USB Power Delivery Specification Revision 3.0 V1.1

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/power/supply/power_supply_sysfs.c | 2 +-
 include/linux/power_supply.h              | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 5204f11..efd2469 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -43,7 +43,7 @@
 static const char * const power_supply_type_text[] = {
 	"Unknown", "Battery", "UPS", "Mains", "USB",
 	"USB_DCP", "USB_CDP", "USB_ACA", "USB_C",
-	"USB_PD", "USB_PD_DRP", "BrickID"
+	"USB_PD", "USB_PD_DRP", "USB_PD_PPS", "BrickID"
 };
 
 static const char * const power_supply_status_text[] = {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 79e90b3..3a79c75 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -167,6 +167,7 @@ enum power_supply_type {
 	POWER_SUPPLY_TYPE_USB_TYPE_C,		/* Type C Port */
 	POWER_SUPPLY_TYPE_USB_PD,		/* Power Delivery Port */
 	POWER_SUPPLY_TYPE_USB_PD_DRP,		/* PD Dual Role Port */
+	POWER_SUPPLY_TYPE_USB_PD_PPS,		/* PD Programmable Power Supply */
 	POWER_SUPPLY_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
 };
 
-- 
1.9.1
