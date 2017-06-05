From: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v6 2/6] mfd: intel_soc_pmic_bxtwc: Remove thermal second level IRQs
Date: Mon,  5 Jun 2017 12:08:02 -0700
Message-ID: <443019afb5ffaa2a666da3832293bda609a6f0a7.1496687716.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <CAHp75VcQfSkn7NAWSC2Vq=8RCC0M1p9zvVFjJFLyEo17GDvHsA@mail.gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VcQfSkn7NAWSC2Vq=8RCC0M1p9zvVFjJFLyEo17GDvHsA@mail.gmail.com>
In-Reply-To: <cover.1496687716.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1496687716.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gnurou@gmail.com, heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, linus.walleij@linaro.org, edubezval@gmail.com, dvhart@infradead.org, rui.zhang@intel.com, lee.jones@linaro.org, andy@infradead.org
Cc: platform-driver-x86@vger.kernel.org, linux-gpio@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sathyaosid@gmail.com, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Since all second level thermal IRQs are consumed by the same
device(bxt_wcove_thermal), there is no need to expose them as separate
interrupts. We can just export only the first level IRQs for thermal and
let the device(bxt_wcove_thermal) driver handle the second level IRQs
based on thermal interrupt status register. Also, just using only the
first level IRQ will eliminate the bug involved in requesting only the
second level IRQ and not explicitly enable the first level IRQ. For
more info on this issue please read the details at,

https://lkml.org/lkml/2017/2/27/148

This patch also makes relevant change in bxt_wcove_thermal driver to use
only first level PMIC thermal IRQ.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/mfd/intel_soc_pmic_bxtwc.c       | 32 ++++++++++++--------------------
 drivers/thermal/intel_bxt_pmic_thermal.c |  2 +-
 2 files changed, 13 insertions(+), 21 deletions(-)

Changes since v1:
 * None

Changes since v2: 
 * Rebased on top of latest release.

Changes since v3:
 * Rebased on top of latest release.

Changes since v5:
 * Squashed intel_bxt_pmic_thermal driver patch.
 * Changed irq -> IRQ


diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index 7cbaf1e..7c1ed27 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -84,10 +84,7 @@ enum bxtwc_irqs {
 
 enum bxtwc_irqs_level2 {
 	/* Level 2 */
-	BXTWC_THRM0_IRQ = 0,
-	BXTWC_THRM1_IRQ,
-	BXTWC_THRM2_IRQ,
-	BXTWC_BCU_IRQ,
+	BXTWC_BCU_IRQ = 0,
 	BXTWC_ADC_IRQ,
 	BXTWC_USBC_IRQ,
 	BXTWC_CHGR0_IRQ,
@@ -114,17 +111,14 @@ static const struct regmap_irq bxtwc_regmap_irqs[] = {
 };
 
 static const struct regmap_irq bxtwc_regmap_irqs_level2[] = {
-	REGMAP_IRQ_REG(BXTWC_THRM0_IRQ, 0, 0xff),
-	REGMAP_IRQ_REG(BXTWC_THRM1_IRQ, 1, 0xbf),
-	REGMAP_IRQ_REG(BXTWC_THRM2_IRQ, 2, 0xff),
-	REGMAP_IRQ_REG(BXTWC_BCU_IRQ, 3, 0x1f),
-	REGMAP_IRQ_REG(BXTWC_ADC_IRQ, 4, 0xff),
-	REGMAP_IRQ_REG(BXTWC_USBC_IRQ, 5, BIT(5)),
-	REGMAP_IRQ_REG(BXTWC_CHGR0_IRQ, 5, 0x1f),
-	REGMAP_IRQ_REG(BXTWC_CHGR1_IRQ, 6, 0x1f),
-	REGMAP_IRQ_REG(BXTWC_GPIO0_IRQ, 7, 0xff),
-	REGMAP_IRQ_REG(BXTWC_GPIO1_IRQ, 8, 0x3f),
-	REGMAP_IRQ_REG(BXTWC_CRIT_IRQ, 9, 0x03),
+	REGMAP_IRQ_REG(BXTWC_BCU_IRQ, 0, 0x1f),
+	REGMAP_IRQ_REG(BXTWC_ADC_IRQ, 1, 0xff),
+	REGMAP_IRQ_REG(BXTWC_USBC_IRQ, 2, BIT(5)),
+	REGMAP_IRQ_REG(BXTWC_CHGR0_IRQ, 2, 0x1f),
+	REGMAP_IRQ_REG(BXTWC_CHGR1_IRQ, 3, 0x1f),
+	REGMAP_IRQ_REG(BXTWC_GPIO0_IRQ, 4, 0xff),
+	REGMAP_IRQ_REG(BXTWC_GPIO1_IRQ, 5, 0x3f),
+	REGMAP_IRQ_REG(BXTWC_CRIT_IRQ, 6, 0x03),
 };
 
 static const struct regmap_irq bxtwc_regmap_irqs_tmu[] = {
@@ -142,8 +136,8 @@ static struct regmap_irq_chip bxtwc_regmap_irq_chip = {
 
 static struct regmap_irq_chip bxtwc_regmap_irq_chip_level2 = {
 	.name = "bxtwc_irq_chip_level2",
-	.status_base = BXTWC_THRM0IRQ,
-	.mask_base = BXTWC_MTHRM0IRQ,
+	.status_base = BXTWC_BCUIRQ,
+	.mask_base = BXTWC_MBCUIRQ,
 	.irqs = bxtwc_regmap_irqs_level2,
 	.num_irqs = ARRAY_SIZE(bxtwc_regmap_irqs_level2),
 	.num_regs = 10,
@@ -177,9 +171,7 @@ static struct resource charger_resources[] = {
 };
 
 static struct resource thermal_resources[] = {
-	DEFINE_RES_IRQ(BXTWC_THRM0_IRQ),
-	DEFINE_RES_IRQ(BXTWC_THRM1_IRQ),
-	DEFINE_RES_IRQ(BXTWC_THRM2_IRQ),
+	DEFINE_RES_IRQ(BXTWC_THRM_LVL1_IRQ),
 };
 
 static struct resource bcu_resources[] = {
diff --git a/drivers/thermal/intel_bxt_pmic_thermal.c b/drivers/thermal/intel_bxt_pmic_thermal.c
index 0f19a39..ef6b322 100644
--- a/drivers/thermal/intel_bxt_pmic_thermal.c
+++ b/drivers/thermal/intel_bxt_pmic_thermal.c
@@ -241,7 +241,7 @@ static int pmic_thermal_probe(struct platform_device *pdev)
 	}
 
 	regmap = pmic->regmap;
-	regmap_irq_chip = pmic->irq_chip_data_level2;
+	regmap_irq_chip = pmic->irq_chip_data;
 
 	pmic_irq_count = 0;
 	while ((irq = platform_get_irq(pdev, pmic_irq_count)) != -ENXIO) {
-- 
2.7.4
