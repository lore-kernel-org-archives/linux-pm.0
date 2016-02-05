From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v1 3/6] power_supply: Add types for USB Type C and PD chargers
Date: Fri,  5 Feb 2016 14:32:58 +0100
Message-ID: <1454679181-8949-4-git-send-email-tomeu.vizoso@collabora.com>
References: <1454679181-8949-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454679181-8949-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Sameer Nanda <snanda@chromium.org>, Benson Leung <bleung@chromium.org>, =?UTF-8?q?Enric=20Balletb=C3=B2?= <enric.balletbo@collabora.co.uk>, Vic Yang <victoryang@chromium.org>, Vincent Palatin <vpalatin@chromium.org>, Randall Spangler <rspangler@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Benson Leung <bleung@chromium.org>

This adds power supply types for USB chargers defined in
the USB Type-C Specification 1.1 and in the
USB Power Delivery Specification Revision 2.0 V1.1.

The following are added :
POWER_SUPPLY_TYPE_USB_TYPE_C,	/* Type C Port */
POWER_SUPPLY_TYPE_USB_PD,	/* Type C Power Delivery Port */
POWER_SUPPLY_TYPE_USB_PD_DRP,	/* Type C PD Dual Role Port */

Signed-off-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Reviewed-by: Alec Berg <alecaberg@chromium.org>
Reviewed-by: Vincent Palatin <vpalatin@chromium.org>
Reviewed-by: Todd Broch <tbroch@chromium.org>
---

 drivers/power/power_supply_sysfs.c | 3 ++-
 include/linux/power_supply.h       | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/power_supply_sysfs.c b/drivers/power/power_supply_sysfs.c
index ed2d7fd0c734..80fed98832f9 100644
--- a/drivers/power/power_supply_sysfs.c
+++ b/drivers/power/power_supply_sysfs.c
@@ -45,7 +45,8 @@ static ssize_t power_supply_show_property(struct device *dev,
 					  char *buf) {
 	static char *type_text[] = {
 		"Unknown", "Battery", "UPS", "Mains", "USB",
-		"USB_DCP", "USB_CDP", "USB_ACA"
+		"USB_DCP", "USB_CDP", "USB_ACA", "USB_C",
+		"USB_PD", "USB_PD_DRP"
 	};
 	static char *status_text[] = {
 		"Unknown", "Charging", "Discharging", "Not charging", "Full"
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index ef9f1592185d..206c3384c6fa 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -163,6 +163,9 @@ enum power_supply_type {
 	POWER_SUPPLY_TYPE_USB_DCP,	/* Dedicated Charging Port */
 	POWER_SUPPLY_TYPE_USB_CDP,	/* Charging Downstream Port */
 	POWER_SUPPLY_TYPE_USB_ACA,	/* Accessory Charger Adapters */
+	POWER_SUPPLY_TYPE_USB_TYPE_C,	/* Type C Port */
+	POWER_SUPPLY_TYPE_USB_PD,	/* Type C Power Delivery Port */
+	POWER_SUPPLY_TYPE_USB_PD_DRP,	/* Type C PD Dual Role Port */
 };
 
 enum power_supply_notifier_events {
-- 
2.5.0
