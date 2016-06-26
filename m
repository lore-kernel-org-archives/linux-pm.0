From: Stephen Boyd <stephen.boyd@linaro.org>
Subject: [PATCH] power: qcom_smbb: Make an extcon for usb cable detection
Date: Sat, 25 Jun 2016 22:54:37 -0700
Message-ID: <20160626055437.18516-1-stephen.boyd@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

On these PMICs the usb cable connection/disconnection is
indicated by the usb-valid interrupt being high or low
respectively. Let's make an extcon for that, so we can notify usb
drivers of the cable state.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/power/qcom_smbb.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/power/qcom_smbb.c b/drivers/power/qcom_smbb.c
index 5eb1e9e543e2..b5896ba2a602 100644
--- a/drivers/power/qcom_smbb.c
+++ b/drivers/power/qcom_smbb.c
@@ -34,6 +34,7 @@
 #include <linux/power_supply.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/extcon.h>
 
 #define SMBB_CHG_VMAX		0x040
 #define SMBB_CHG_VSAFE		0x041
@@ -111,6 +112,7 @@ struct smbb_charger {
 	unsigned int revision;
 	unsigned int addr;
 	struct device *dev;
+	struct extcon_dev *edev;
 
 	bool dc_disabled;
 	bool jeita_ext_temp;
@@ -125,6 +127,11 @@ struct smbb_charger {
 	struct regmap *regmap;
 };
 
+static const unsigned int smbb_usb_extcon_cable[] = {
+	EXTCON_USB,
+	EXTCON_NONE,
+};
+
 static int smbb_vbat_weak_fn(unsigned int index)
 {
 	return 2100000 + index * 100000;
@@ -371,6 +378,8 @@ static irqreturn_t smbb_usb_valid_handler(int irq, void *_data)
 	struct smbb_charger *chg = _data;
 
 	smbb_set_line_flag(chg, irq, STATUS_USBIN_VALID);
+	extcon_set_cable_state_(chg->edev, EXTCON_USB,
+				chg->status & STATUS_USBIN_VALID);
 	power_supply_changed(chg->usb_psy);
 
 	return IRQ_HANDLED;
@@ -849,6 +858,18 @@ static int smbb_charger_probe(struct platform_device *pdev)
 		return PTR_ERR(chg->usb_psy);
 	}
 
+	chg->edev = devm_extcon_dev_allocate(&pdev->dev, smbb_usb_extcon_cable);
+	if (IS_ERR(chg->edev)) {
+		dev_err(&pdev->dev, "failed to allocate extcon device\n");
+		return -ENOMEM;
+	}
+
+	rc = devm_extcon_dev_register(&pdev->dev, chg->edev);
+	if (rc < 0) {
+		dev_err(&pdev->dev, "failed to register extcon device\n");
+		return rc;
+	}
+
 	if (!chg->dc_disabled) {
 		dc_cfg.drv_data = chg;
 		dc_cfg.supplied_to = smbb_bif;
-- 
2.9.0.rc2.8.ga28705d
