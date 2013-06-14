From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH] extcon: max77693: Bug fix for irq handler,
 call handler depends on ADC.
Date: Fri, 14 Jun 2013 11:11:48 +0900
Message-ID: <1371175908-3040-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Jonghwa Lee <jonghwa3.lee@samsung.com>
List-Id: linux-pm@vger.kernel.org

Since it has called charger's or adc's handler depends on irq type, sometimes
it failed to call proper handler. For example, during the driver's probing,
it set ADC debouce time to 25ms by default, then it occurs HW interrupt
which is flagged as CHGTYP. In previous irq handler it called charger handler
because CHGTYP irq is classified as a charger's. But it even happens when
other accessories had been connected. So it is better to call seperate handler
depends on ADC's value.

If ADC is 0x1F, it means that charger is possibly connected so charger's
handler might be needed. Otherwise different handler would be called such as
JIG's or DOCK's and so on.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>
---
 drivers/extcon/extcon-max77693.c |   44 +++++++-------------------------------
 1 file changed, 8 insertions(+), 36 deletions(-)

diff --git a/drivers/extcon/extcon-max77693.c b/drivers/extcon/extcon-max77693.c
index b56bdaa..1c50d23 100644
--- a/drivers/extcon/extcon-max77693.c
+++ b/drivers/extcon/extcon-max77693.c
@@ -945,18 +945,14 @@ static void max77693_muic_irq_work(struct work_struct *work)
 {
 	struct max77693_muic_info *info = container_of(work,
 			struct max77693_muic_info, irq_work);
-	int irq_type = -1;
-	int i, ret = 0;
+	int ret = 0;
+	int adc;
 
 	if (!info->edev)
 		return;
 
 	mutex_lock(&info->mutex);
 
-	for (i = 0 ; i < ARRAY_SIZE(muic_irqs) ; i++)
-		if (info->irq == muic_irqs[i].virq)
-			irq_type = muic_irqs[i].irq;
-
 	ret = max77693_bulk_read(info->max77693->regmap_muic,
 			MAX77693_MUIC_REG_STATUS1, 2, info->status);
 	if (ret) {
@@ -965,36 +961,15 @@ static void max77693_muic_irq_work(struct work_struct *work)
 		return;
 	}
 
-	switch (irq_type) {
-	case MAX77693_MUIC_IRQ_INT1_ADC:
-	case MAX77693_MUIC_IRQ_INT1_ADC_LOW:
-	case MAX77693_MUIC_IRQ_INT1_ADC_ERR:
-	case MAX77693_MUIC_IRQ_INT1_ADC1K:
+	adc = info->status[0] & STATUS1_ADC_MASK;
+	adc >>= STATUS1_ADC_SHIFT;
+
+	if (adc == MAX77693_MUIC_ADC_OPEN) {
+		ret = max77693_muic_chg_handler(info);
+	} else {
 		/* Handle all of accessory except for
 		   type of charger accessory */
 		ret = max77693_muic_adc_handler(info);
-		break;
-	case MAX77693_MUIC_IRQ_INT2_CHGTYP:
-	case MAX77693_MUIC_IRQ_INT2_CHGDETREUN:
-	case MAX77693_MUIC_IRQ_INT2_DCDTMR:
-	case MAX77693_MUIC_IRQ_INT2_DXOVP:
-	case MAX77693_MUIC_IRQ_INT2_VBVOLT:
-	case MAX77693_MUIC_IRQ_INT2_VIDRM:
-		/* Handle charger accessory */
-		ret = max77693_muic_chg_handler(info);
-		break;
-	case MAX77693_MUIC_IRQ_INT3_EOC:
-	case MAX77693_MUIC_IRQ_INT3_CGMBC:
-	case MAX77693_MUIC_IRQ_INT3_OVP:
-	case MAX77693_MUIC_IRQ_INT3_MBCCHG_ERR:
-	case MAX77693_MUIC_IRQ_INT3_CHG_ENABLED:
-	case MAX77693_MUIC_IRQ_INT3_BAT_DET:
-		break;
-	default:
-		dev_err(info->dev, "muic interrupt: irq %d occurred\n",
-				irq_type);
-		mutex_unlock(&info->mutex);
-		return;
 	}
 
 	if (ret < 0)
@@ -1245,9 +1220,6 @@ static int max77693_muic_probe(struct platform_device *pdev)
 		delay_jiffies = msecs_to_jiffies(DELAY_MS_DEFAULT);
 	}
 
-	/* Set initial path for UART */
-	 max77693_muic_set_path(info, info->path_uart, true);
-
 	/* Check revision number of MUIC device*/
 	ret = max77693_read_reg(info->max77693->regmap_muic,
 			MAX77693_MUIC_REG_ID, &id);
-- 
1.7.9.5
