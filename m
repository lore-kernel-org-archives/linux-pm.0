From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [RFC PATCH 5/7] power: supply: Add type for USB PD PPS chargers
Date: Wed, 1 Nov 2017 17:03:13 +0000
Message-ID: <d1fcc24b60933b590fc6c8e8946e9ccb44364306.1509554370.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1509554370.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1509554370.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Yueyao Zhu <yueyao.zhu@gmail.com>, Rui Miguel Silva <rmfrfs@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, support.opensource@diasemi.com
List-Id: linux-pm@vger.kernel.org

This adds a type to represent USB PPS chargers as defined in the
USB Power Delivery Specification Revision 3.0 V1.1

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
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
