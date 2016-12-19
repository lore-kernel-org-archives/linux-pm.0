From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 11/14] power: supply: axp288_charger: Get and process initial hardware-state
Date: Mon, 19 Dec 2016 01:07:28 +0100
Message-ID: <20161219000731.10188-12-hdegoede@redhat.com>
References: <20161219000731.10188-1-hdegoede@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161219000731.10188-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-pm@vger.kernel.org

Do not wait for an extcon notification before processing the cable
states, instead queue the otg / cable work on probe to make sure we
immediately process the initial hardware state.

Note this also requiree moving the getting of the USB_HOST cable state
from the extcon notifier to the workqueue function.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_charger.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index f033a5e..b489289 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -171,7 +171,7 @@ struct axp288_chrg_info {
 	int cv;
 	int max_cc;
 	int max_cv;
-	bool is_charger_enabled;
+	int is_charger_enabled;
 };
 
 static inline int axp288_charger_set_cc(struct axp288_chrg_info *info, int cc)
@@ -300,7 +300,7 @@ static int axp288_charger_enable_charger(struct axp288_chrg_info *info,
 {
 	int ret;
 
-	if (enable == info->is_charger_enabled)
+	if ((int)enable == info->is_charger_enabled)
 		return 0;
 
 	if (enable)
@@ -653,7 +653,17 @@ static void axp288_charger_otg_evt_worker(struct work_struct *work)
 {
 	struct axp288_chrg_info *info =
 	    container_of(work, struct axp288_chrg_info, otg.work);
-	int ret;
+	struct extcon_dev *edev = info->otg.cable;
+	int ret, usb_host = extcon_get_cable_state_(edev, EXTCON_USB_HOST);
+
+	dev_dbg(&info->pdev->dev, "external connector USB-Host is %s\n",
+				usb_host ? "attached" : "detached");
+
+	/*
+	 * Set usb_id_short flag to avoid running charger detection logic
+	 * in case usb host.
+	 */
+	info->otg.id_short = usb_host;
 
 	/* Disable VBUS path before enabling the 5V boost */
 	ret = axp288_charger_vbus_path_select(info, !info->otg.id_short);
@@ -666,17 +676,7 @@ static int axp288_charger_handle_otg_evt(struct notifier_block *nb,
 {
 	struct axp288_chrg_info *info =
 	    container_of(nb, struct axp288_chrg_info, otg.id_nb);
-	struct extcon_dev *edev = info->otg.cable;
-	int usb_host = extcon_get_cable_state_(edev, EXTCON_USB_HOST);
-
-	dev_dbg(&info->pdev->dev, "external connector USB-Host is %s\n",
-				usb_host ? "attached" : "detached");
 
-	/*
-	 * Set usb_id_short flag to avoid running charger detection logic
-	 * in case usb host.
-	 */
-	info->otg.id_short = usb_host;
 	schedule_work(&info->otg.work);
 
 	return NOTIFY_OK;
@@ -807,6 +807,8 @@ static int axp288_charger_probe(struct platform_device *pdev)
 	info->pdev = pdev;
 	info->regmap = axp20x->regmap;
 	info->regmap_irqc = axp20x->regmap_irqc;
+	info->cable.chg_type = -1;
+	info->is_charger_enabled = -1;
 
 	info->cable.edev = extcon_get_extcon_dev(AXP288_EXTCON_DEV_NAME);
 	if (info->cable.edev == NULL) {
@@ -849,6 +851,7 @@ static int axp288_charger_probe(struct platform_device *pdev)
 			return ret;
 		}
 	}
+	schedule_work(&info->cable.work);
 
 	/* Register for OTG notification */
 	INIT_WORK(&info->otg.work, axp288_charger_otg_evt_worker);
@@ -859,8 +862,7 @@ static int axp288_charger_probe(struct platform_device *pdev)
 		dev_err(dev, "failed to register EXTCON_USB_HOST notifier\n");
 		return ret;
 	}
-	info->otg.id_short = extcon_get_cable_state_(info->otg.cable,
-						     EXTCON_USB_HOST);
+	schedule_work(&info->otg.work);
 
 	/* Register charger interrupts */
 	for (i = 0; i < CHRG_INTR_END; i++) {
-- 
2.9.3
