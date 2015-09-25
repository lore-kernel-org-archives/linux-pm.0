From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH v3] drivers: power: twl4030_charger: fix link problems when building as module
Date: Fri, 25 Sep 2015 22:20:45 +0200
Message-ID: <1443212447-5841-1-git-send-email-marek@goldelico.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:33664 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932976AbbIYUVI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Sep 2015 16:21:08 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: neilb@suse.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, hns@goldelico.com, Marek Belisko <marek@goldelico.com>

If either twl4030_charger or twl4030_madc is configured as MODULE,
we get build (link) errors.

To solve, the direct call of twl4030_get_madc_conversion() is replaced
by a call to iio_read_channel_processed().

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Marek Belisko <marek@goldelico.com>
---
changes from v2: make iio propries optional to keep functionality for old DT also
changes from V1: added missing iio_channel_release + document and add new DT bindings
 drivers/power/twl4030_charger.c | 45 ++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
index f4f2c1f..82e2a05 100644
--- a/drivers/power/twl4030_charger.c
+++ b/drivers/power/twl4030_charger.c
@@ -22,7 +22,7 @@
 #include <linux/power_supply.h>
 #include <linux/notifier.h>
 #include <linux/usb/otg.h>
-#include <linux/i2c/twl4030-madc.h>
+#include <linux/iio/consumer.h>
 
 #define TWL4030_BCIMDEN		0x00
 #define TWL4030_BCIMDKEY	0x01
@@ -91,21 +91,23 @@
 #define TWL4030_MSTATEC_COMPLETE1	0x0b
 #define TWL4030_MSTATEC_COMPLETE4	0x0e
 
-#if IS_ENABLED(CONFIG_TWL4030_MADC)
 /*
  * If AC (Accessory Charger) voltage exceeds 4.5V (MADC 11)
  * then AC is available.
  */
-static inline int ac_available(void)
+static inline int ac_available(struct iio_channel *channel_vac)
 {
-	return twl4030_get_madc_conversion(11) > 4500;
-}
-#else
-static inline int ac_available(void)
-{
-	return 0;
+	int val, err;
+
+	if (!channel_vac)
+		return 0;
+
+	err = iio_read_channel_processed(channel_vac, &val);
+	if (err < 0)
+		return 0;
+	return val > 4500;
 }
-#endif
+
 static bool allow_usb;
 module_param(allow_usb, bool, 0644);
 MODULE_PARM_DESC(allow_usb, "Allow USB charge drawing default current");
@@ -128,6 +130,7 @@ struct twl4030_bci {
 	 */
 	unsigned int		ichg_eoc, ichg_lo, ichg_hi;
 	unsigned int		usb_cur, ac_cur;
+	struct iio_channel	*channel_vac;
 	bool			ac_is_active;
 	int			usb_mode, ac_mode; /* charging mode requested */
 #define	CHARGE_OFF	0
@@ -278,7 +281,7 @@ static int twl4030_charger_update_current(struct twl4030_bci *bci)
 	 * If AC (Accessory Charger) voltage exceeds 4.5V (MADC 11)
 	 * and AC is enabled, set current for 'ac'
 	 */
-	if (ac_available()) {
+	if (ac_available(bci->channel_vac)) {
 		cur = bci->ac_cur;
 		bci->ac_is_active = true;
 	} else {
@@ -1048,6 +1051,12 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	bci->channel_vac = iio_channel_get(&pdev->dev, "vac");
+	if (IS_ERR(bci->channel_vac)) {
+		bci->channel_vac = NULL;
+		dev_warn(&pdev->dev, "could not request vac iio channel");
+	}
+
 	INIT_WORK(&bci->work, twl4030_bci_usb_work);
 	INIT_DELAYED_WORK(&bci->current_worker, twl4030_current_worker);
 
@@ -1061,8 +1070,10 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 			bci->transceiver = devm_usb_get_phy_by_node(
 				bci->dev, phynode, &bci->usb_nb);
 			if (IS_ERR(bci->transceiver) &&
-			    PTR_ERR(bci->transceiver) == -EPROBE_DEFER)
-				return -EPROBE_DEFER;
+			    PTR_ERR(bci->transceiver) == -EPROBE_DEFER) {
+				ret = -EPROBE_DEFER;
+				goto fail;
+			}
 		}
 	}
 
@@ -1073,7 +1084,7 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 			       TWL4030_INTERRUPTS_BCIIMR1A);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to unmask interrupts: %d\n", ret);
-		return ret;
+		goto fail;
 	}
 
 	reg = ~(u32)(TWL4030_VBATOV | TWL4030_VBUSOV | TWL4030_ACCHGOV);
@@ -1106,6 +1117,10 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 		twl4030_charger_enable_backup(0, 0);
 
 	return 0;
+fail:
+	iio_channel_release(bci->channel_vac);
+
+	return ret;
 }
 
 static int __exit twl4030_bci_remove(struct platform_device *pdev)
@@ -1116,6 +1131,8 @@ static int __exit twl4030_bci_remove(struct platform_device *pdev)
 	twl4030_charger_enable_usb(bci, false);
 	twl4030_charger_enable_backup(0, 0);
 
+	iio_channel_release(bci->channel_vac);
+
 	device_remove_file(&bci->usb->dev, &dev_attr_max_current);
 	device_remove_file(&bci->usb->dev, &dev_attr_mode);
 	device_remove_file(&bci->ac->dev, &dev_attr_max_current);
-- 
1.9.1

