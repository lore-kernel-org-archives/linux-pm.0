From: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v4 7/9] mfd: intel_soc_pmic_bxtwc: use chained irqs for second level irq chips
Date: Tue, 30 May 2017 22:19:56 -0700
Message-ID: <d6418d7560f6e1faaa346317db26f9e6ef7649c9.1496206507.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1496206507.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1496206507.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gnurou@gmail.com, heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, linus.walleij@linaro.org, edubezval@gmail.com, dvhart@infradead.org, rui.zhang@intel.com, lee.jones@linaro.org, andy@infradead.org
Cc: linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, platform-driver-x86@vger.kernel.org, sathyaosid@gmail.com, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Whishkey cove PMIC has support to mask/unmask interrupts at two levels.
At first level we can mask/unmask interrupt domains like TMU, GPIO, ADC,
CHGR, BCU THERMAL and PWRBTN and at second level, it provides facility
to mask/unmask individual interrupts belong each of this domain. For
example, in case of TMU, at first level we have TMU interrupt domain,
and at second level we have two interrupts, wake alarm, system alarm that
belong to the TMU interrupt domain.

Currently, in this driver all first level irqs are registered as part of
irq chip(bxtwc_regmap_irq_chip). By default, after you register the irq
chip from your driver, all irqs in that chip will masked and can only be
enabled if that irq is requested using request_irq call. This is the
default Linux irq behavior model. And whenever a dependent device that
belongs to PMIC requests only the second level irq and not explicitly
unmask the first level irq, then in essence the second level irq will
still be disabled. For example, if TMU device driver request wake_alarm
irq and not explicitly unmask TMU level 1 irq then according to the default
Linux irq model,  wake_alarm irq will still be disabled. So the proper
solution to fix this issue is to use the chained irq chip concept. We
should chain all the second level chip irqs to the corresponding first
level irq. To do this, we need to create separate irq chips for every
group of second level irqs.

In case of TMU, when adding second level irq chip, instead of using pmic
irq we should use the corresponding first level irq. So the following
code will change from

ret = regmap_add_irq_chip(pmic->regmap, pmic->irq, ...)

to,

virq = regmap_irq_get_virq(&pmic->irq_chip_data, BXTWC_TMU_LVL1_IRQ);

ret = regmap_add_irq_chip(pmic->regmap, virq, ...)

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/intel_soc_pmic_bxtwc.c | 174 +++++++++++++++++++++++++++++--------
 include/linux/mfd/intel_soc_pmic.h |   5 +-
 2 files changed, 144 insertions(+), 35 deletions(-)

Changes since v1:
 * Rebased on top of dev_* cleanup patch.
 * Fixed style & grammer issues reported by Lee Jones

Changes since v2:
 * Rebased on top of latest release.

Changes since v3:
 * None

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index feeda6e..bd78bef 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -82,18 +82,26 @@ enum bxtwc_irqs {
 	BXTWC_PWRBTN_IRQ,
 };
 
-enum bxtwc_irqs_level2 {
-	/* Level 2 */
+enum bxtwc_irqs_tmu {
+	BXTWC_TMU_IRQ = 0,
+};
+
+enum bxtwc_irqs_bcu {
 	BXTWC_BCU_IRQ = 0,
-	BXTWC_ADC_IRQ,
-	BXTWC_USBC_IRQ,
+};
+
+enum bxtwc_irqs_adc {
+	BXTWC_ADC_IRQ = 0,
+};
+
+enum bxtwc_irqs_chgr {
+	BXTWC_USBC_IRQ = 0,
 	BXTWC_CHGR0_IRQ,
 	BXTWC_CHGR1_IRQ,
-	BXTWC_CRIT_IRQ,
 };
 
-enum bxtwc_irqs_tmu {
-	BXTWC_TMU_IRQ = 0,
+enum bxtwc_irqs_crit {
+	BXTWC_CRIT_IRQ = 0,
 };
 
 static const struct regmap_irq bxtwc_regmap_irqs[] = {
@@ -108,17 +116,26 @@ static const struct regmap_irq bxtwc_regmap_irqs[] = {
 	REGMAP_IRQ_REG(BXTWC_PWRBTN_IRQ, 1, 0x03),
 };
 
-static const struct regmap_irq bxtwc_regmap_irqs_level2[] = {
+static const struct regmap_irq bxtwc_regmap_irqs_tmu[] = {
+	REGMAP_IRQ_REG(BXTWC_TMU_IRQ, 0, 0x06),
+};
+
+static const struct regmap_irq bxtwc_regmap_irqs_bcu[] = {
 	REGMAP_IRQ_REG(BXTWC_BCU_IRQ, 0, 0x1f),
-	REGMAP_IRQ_REG(BXTWC_ADC_IRQ, 1, 0xff),
-	REGMAP_IRQ_REG(BXTWC_USBC_IRQ, 2, BIT(5)),
-	REGMAP_IRQ_REG(BXTWC_CHGR0_IRQ, 2, 0x1f),
-	REGMAP_IRQ_REG(BXTWC_CHGR1_IRQ, 3, 0x1f),
-	REGMAP_IRQ_REG(BXTWC_CRIT_IRQ, 6, 0x03),
 };
 
-static const struct regmap_irq bxtwc_regmap_irqs_tmu[] = {
-	REGMAP_IRQ_REG(BXTWC_TMU_IRQ, 0, 0x06),
+static const struct regmap_irq bxtwc_regmap_irqs_adc[] = {
+	REGMAP_IRQ_REG(BXTWC_ADC_IRQ, 0, 0xff),
+};
+
+static const struct regmap_irq bxtwc_regmap_irqs_chgr[] = {
+	REGMAP_IRQ_REG(BXTWC_USBC_IRQ, 0, BIT(5)),
+	REGMAP_IRQ_REG(BXTWC_CHGR0_IRQ, 0, 0x1f),
+	REGMAP_IRQ_REG(BXTWC_CHGR1_IRQ, 1, 0x1f),
+};
+
+static const struct regmap_irq bxtwc_regmap_irqs_crit[] = {
+	REGMAP_IRQ_REG(BXTWC_CRIT_IRQ, 0, 0x03),
 };
 
 static struct regmap_irq_chip bxtwc_regmap_irq_chip = {
@@ -130,15 +147,6 @@ static struct regmap_irq_chip bxtwc_regmap_irq_chip = {
 	.num_regs = 2,
 };
 
-static struct regmap_irq_chip bxtwc_regmap_irq_chip_level2 = {
-	.name = "bxtwc_irq_chip_level2",
-	.status_base = BXTWC_BCUIRQ,
-	.mask_base = BXTWC_MBCUIRQ,
-	.irqs = bxtwc_regmap_irqs_level2,
-	.num_irqs = ARRAY_SIZE(bxtwc_regmap_irqs_level2),
-	.num_regs = 10,
-};
-
 static struct regmap_irq_chip bxtwc_regmap_irq_chip_tmu = {
 	.name = "bxtwc_irq_chip_tmu",
 	.status_base = BXTWC_TMUIRQ,
@@ -148,6 +156,42 @@ static struct regmap_irq_chip bxtwc_regmap_irq_chip_tmu = {
 	.num_regs = 1,
 };
 
+static struct regmap_irq_chip bxtwc_regmap_irq_chip_bcu = {
+	.name = "bxtwc_irq_chip_bcu",
+	.status_base = BXTWC_BCUIRQ,
+	.mask_base = BXTWC_MBCUIRQ,
+	.irqs = bxtwc_regmap_irqs_bcu,
+	.num_irqs = ARRAY_SIZE(bxtwc_regmap_irqs_bcu),
+	.num_regs = 1,
+};
+
+static struct regmap_irq_chip bxtwc_regmap_irq_chip_adc = {
+	.name = "bxtwc_irq_chip_adc",
+	.status_base = BXTWC_ADCIRQ,
+	.mask_base = BXTWC_MADCIRQ,
+	.irqs = bxtwc_regmap_irqs_adc,
+	.num_irqs = ARRAY_SIZE(bxtwc_regmap_irqs_adc),
+	.num_regs = 1,
+};
+
+static struct regmap_irq_chip bxtwc_regmap_irq_chip_chgr = {
+	.name = "bxtwc_irq_chip_chgr",
+	.status_base = BXTWC_CHGR0IRQ,
+	.mask_base = BXTWC_MCHGR0IRQ,
+	.irqs = bxtwc_regmap_irqs_chgr,
+	.num_irqs = ARRAY_SIZE(bxtwc_regmap_irqs_chgr),
+	.num_regs = 2,
+};
+
+static struct regmap_irq_chip bxtwc_regmap_irq_chip_crit = {
+	.name = "bxtwc_irq_chip_crit",
+	.status_base = BXTWC_CRITIRQ,
+	.mask_base = BXTWC_MCRITIRQ,
+	.irqs = bxtwc_regmap_irqs_crit,
+	.num_irqs = ARRAY_SIZE(bxtwc_regmap_irqs_crit),
+	.num_regs = 1,
+};
+
 static struct resource gpio_resources[] = {
 	DEFINE_RES_IRQ_NAMED(BXTWC_GPIO_LVL1_IRQ, "GPIO"),
 };
@@ -357,6 +401,24 @@ static const struct regmap_config bxtwc_regmap_config = {
 	.reg_read = regmap_ipc_byte_reg_read,
 };
 
+static int bxtwc_add_chained_irq_chip(struct intel_soc_pmic *pmic,
+				struct regmap_irq_chip_data *pdata,
+				int pirq, int irq_flags,
+				const struct regmap_irq_chip *chip,
+				struct regmap_irq_chip_data **data)
+{
+	int irq;
+
+	irq = regmap_irq_get_virq(pdata, pirq);
+	if (irq < 0) {
+		dev_err(pmic->dev, "failed to get virtual interrupt:%d\n", irq);
+		return irq;
+	}
+
+	return devm_regmap_add_irq_chip(pmic->dev, pmic->regmap, irq, irq_flags,
+					0, chip, data);
+}
+
 static int bxtwc_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -408,21 +470,65 @@ static int bxtwc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = devm_regmap_add_irq_chip(&pdev->dev, pmic->regmap, pmic->irq,
-				       IRQF_ONESHOT | IRQF_SHARED,
-				       0, &bxtwc_regmap_irq_chip_level2,
-				       &pmic->irq_chip_data_level2);
+	ret = bxtwc_add_chained_irq_chip(pmic, pmic->irq_chip_data,
+					 BXTWC_TMU_LVL1_IRQ,
+					 IRQF_ONESHOT,
+					 &bxtwc_regmap_irq_chip_tmu,
+					 &pmic->irq_chip_data_tmu);
 	if (ret) {
-		dev_err(&pdev->dev, "Failed to add secondary IRQ chip\n");
+		dev_err(&pdev->dev, "Failed to add TMU IRQ chip\n");
 		return ret;
 	}
 
-	ret = devm_regmap_add_irq_chip(&pdev->dev, pmic->regmap, pmic->irq,
-				       IRQF_ONESHOT | IRQF_SHARED,
-				       0, &bxtwc_regmap_irq_chip_tmu,
-				       &pmic->irq_chip_data_tmu);
+	/* Add chained IRQ handler for BCU IRQs */
+	ret = bxtwc_add_chained_irq_chip(pmic, pmic->irq_chip_data,
+					 BXTWC_BCU_LVL1_IRQ,
+					 IRQF_ONESHOT,
+					 &bxtwc_regmap_irq_chip_bcu,
+					 &pmic->irq_chip_data_bcu);
+
+
 	if (ret) {
-		dev_err(&pdev->dev, "Failed to add TMU IRQ chip\n");
+		dev_err(&pdev->dev, "Failed to add BUC IRQ chip\n");
+		return ret;
+	}
+
+	/* Add chained IRQ handler for ADC IRQs */
+	ret = bxtwc_add_chained_irq_chip(pmic, pmic->irq_chip_data,
+					 BXTWC_ADC_LVL1_IRQ,
+					 IRQF_ONESHOT,
+					 &bxtwc_regmap_irq_chip_adc,
+					 &pmic->irq_chip_data_adc);
+
+
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to add ADC IRQ chip\n");
+		return ret;
+	}
+
+	/* Add chained IRQ handler for CHGR IRQs */
+	ret = bxtwc_add_chained_irq_chip(pmic, pmic->irq_chip_data,
+					 BXTWC_CHGR_LVL1_IRQ,
+					 IRQF_ONESHOT,
+					 &bxtwc_regmap_irq_chip_chgr,
+					 &pmic->irq_chip_data_chgr);
+
+
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to add CHGR IRQ chip\n");
+		return ret;
+	}
+
+	/* Add chained IRQ handler for CRIT IRQs */
+	ret = bxtwc_add_chained_irq_chip(pmic, pmic->irq_chip_data,
+					 BXTWC_CRIT_LVL1_IRQ,
+					 IRQF_ONESHOT,
+					 &bxtwc_regmap_irq_chip_crit,
+					 &pmic->irq_chip_data_crit);
+
+
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to add CRIT IRQ chip\n");
 		return ret;
 	}
 
diff --git a/include/linux/mfd/intel_soc_pmic.h b/include/linux/mfd/intel_soc_pmic.h
index 956caa0..5aacdb0 100644
--- a/include/linux/mfd/intel_soc_pmic.h
+++ b/include/linux/mfd/intel_soc_pmic.h
@@ -25,8 +25,11 @@ struct intel_soc_pmic {
 	int irq;
 	struct regmap *regmap;
 	struct regmap_irq_chip_data *irq_chip_data;
-	struct regmap_irq_chip_data *irq_chip_data_level2;
 	struct regmap_irq_chip_data *irq_chip_data_tmu;
+	struct regmap_irq_chip_data *irq_chip_data_bcu;
+	struct regmap_irq_chip_data *irq_chip_data_adc;
+	struct regmap_irq_chip_data *irq_chip_data_chgr;
+	struct regmap_irq_chip_data *irq_chip_data_crit;
 	struct device *dev;
 };
 
-- 
2.7.4
