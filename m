From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 06/12] power: supply: axp288_charger: Actually get and use the USB_HOST extcon device
Date: Wed, 21 Dec 2016 15:36:51 +0100
Message-ID: <20161221143657.322-7-hdegoede@redhat.com>
References: <20161221143657.322-1-hdegoede@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161221143657.322-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-pm@vger.kernel.org

Nothing was setting info->otg.cable, so the extcon_get_cable_state_
calls on it would always return -EINVAL.

This commit fixes this by actually setting info->otg.cable using the new
extcon_get_extcon_dev_by_cable_id function.

This commit also makes failing to register the extcon notifier for the
USB_HOST cable an error rather then a warning, because we MUST have this
notfier to properly disable the VBUS path when in host mode so that we're
not drawing current from the 5V boost converter which is supplying power
to the otg port when in host mode.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Use extcon_get_extcon_dev instead of the new extcon_get_extcon_dev_by_id
 which was not accepted by the extcon upstream maintainer
---
 drivers/power/supply/axp288_charger.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index 1588efd..4443f11 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -127,6 +127,7 @@
 #define ILIM_3000MA			3000	/* 3000mA */
 
 #define AXP288_EXTCON_DEV_NAME		"axp288_extcon"
+#define USB_HOST_EXTCON_DEV_NAME	"INT3496:00"
 
 enum {
 	VBUS_OV_IRQ = 0,
@@ -833,6 +834,12 @@ static int axp288_charger_probe(struct platform_device *pdev)
 		return -EPROBE_DEFER;
 	}
 
+	info->otg.cable = extcon_get_extcon_dev(USB_HOST_EXTCON_DEV_NAME);
+	if (info->otg.cable == NULL) {
+		dev_dbg(dev, "EXTCON_USB_HOST is not ready, probe deferred\n");
+		return -EPROBE_DEFER;
+	}
+
 	platform_set_drvdata(pdev, info);
 	mutex_init(&info->lock);
 
@@ -868,12 +875,12 @@ static int axp288_charger_probe(struct platform_device *pdev)
 	info->otg.id_nb.notifier_call = axp288_charger_handle_otg_evt;
 	ret = devm_extcon_register_notifier(&pdev->dev, info->otg.cable,
 					EXTCON_USB_HOST, &info->otg.id_nb);
-	if (ret)
-		dev_warn(&pdev->dev, "failed to register otg notifier\n");
-
-	if (info->otg.cable)
-		info->otg.id_short = extcon_get_state(
-					info->otg.cable, EXTCON_USB_HOST);
+	if (ret) {
+		dev_err(dev, "failed to register EXTCON_USB_HOST notifier\n");
+		return ret;
+	}
+	info->otg.id_short = extcon_get_cable_state_(info->otg.cable,
+						     EXTCON_USB_HOST);
 
 	/* Register charger interrupts */
 	for (i = 0; i < CHRG_INTR_END; i++) {
-- 
2.9.3
