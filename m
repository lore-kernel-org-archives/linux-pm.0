From: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v6 3/6] mfd: intel_soc_pmic_bxtwc: Remove second level IRQ for gpio device
Date: Mon,  5 Jun 2017 12:08:03 -0700
Message-ID: <36b0102ffea3d762f3ad89d8519fe5ecb23b377b.1496687716.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <CAHp75VcQfSkn7NAWSC2Vq=8RCC0M1p9zvVFjJFLyEo17GDvHsA@mail.gmail.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CAHp75VcQfSkn7NAWSC2Vq=8RCC0M1p9zvVFjJFLyEo17GDvHsA@mail.gmail.com>
In-Reply-To: <cover.1496687716.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1496687716.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: gnurou@gmail.com, heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, linus.walleij@linaro.org, edubezval@gmail.com, dvhart@infradead.org, rui.zhang@intel.com, lee.jones@linaro.org, andy@infradead.org
Cc: platform-driver-x86@vger.kernel.org, linux-gpio@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sathyaosid@gmail.com, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Currently all PMIC GPIO domain IRQs are consumed by the same
device(bxt_wcove_gpio), so there is no need to export them as
separate interrupts. We can just export only the first level
GPIO IRQ(BXTWC_GPIO_LVL1_IRQ) as an IRQ resource and let the
GPIO device driver(bxt_wcove_gpio) handle the GPIO sub domain
IRQs based on status value of GPIO level2 interrupt status
register. Also, just using only the first level IRQ will eliminate
the bug involved in requesting only the second level IRQ and not
explicitly enable the first level IRQ. For more info on this
issue please read the details at,

https://lkml.org/lkml/2017/2/27/148

This patch also makes relevant change in Whiskey cove GPIO driver to
use only first level PMIC GPIO IRQ.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-wcove.c          | 14 +++++++++++++-
 drivers/mfd/intel_soc_pmic_bxtwc.c |  7 +------
 2 files changed, 14 insertions(+), 7 deletions(-)

Changes since v1:
 * None

Changes since v2: 
 * Rebased on top of latest release.

Changes since v3:
 * None

Changes since v5:
 * Squashed gpio driver patch.
 * Changes irq -> IRQ.

diff --git a/drivers/gpio/gpio-wcove.c b/drivers/gpio/gpio-wcove.c
index 7b1bc20..bba7704 100644
--- a/drivers/gpio/gpio-wcove.c
+++ b/drivers/gpio/gpio-wcove.c
@@ -401,7 +401,7 @@ static int wcove_gpio_probe(struct platform_device *pdev)
 	if (!wg)
 		return -ENOMEM;
 
-	wg->regmap_irq_chip = pmic->irq_chip_data_level2;
+	wg->regmap_irq_chip = pmic->irq_chip_data;
 
 	platform_set_drvdata(pdev, wg);
 
@@ -449,6 +449,18 @@ static int wcove_gpio_probe(struct platform_device *pdev)
 
 	gpiochip_set_nested_irqchip(&wg->chip, &wcove_irqchip, virq);
 
+	/* Enable GPIO0 interrupts */
+	ret = regmap_update_bits(wg->regmap, IRQ_MASK_BASE, GPIO_IRQ0_MASK,
+				 0x00);
+	if (ret)
+		return ret;
+
+	/* Enable GPIO1 interrupts */
+	ret = regmap_update_bits(wg->regmap, IRQ_MASK_BASE + 1, GPIO_IRQ1_MASK,
+				 0x00);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index 7c1ed27..af11c43 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -89,8 +89,6 @@ enum bxtwc_irqs_level2 {
 	BXTWC_USBC_IRQ,
 	BXTWC_CHGR0_IRQ,
 	BXTWC_CHGR1_IRQ,
-	BXTWC_GPIO0_IRQ,
-	BXTWC_GPIO1_IRQ,
 	BXTWC_CRIT_IRQ,
 };
 
@@ -116,8 +114,6 @@ static const struct regmap_irq bxtwc_regmap_irqs_level2[] = {
 	REGMAP_IRQ_REG(BXTWC_USBC_IRQ, 2, BIT(5)),
 	REGMAP_IRQ_REG(BXTWC_CHGR0_IRQ, 2, 0x1f),
 	REGMAP_IRQ_REG(BXTWC_CHGR1_IRQ, 3, 0x1f),
-	REGMAP_IRQ_REG(BXTWC_GPIO0_IRQ, 4, 0xff),
-	REGMAP_IRQ_REG(BXTWC_GPIO1_IRQ, 5, 0x3f),
 	REGMAP_IRQ_REG(BXTWC_CRIT_IRQ, 6, 0x03),
 };
 
@@ -153,8 +149,7 @@ static struct regmap_irq_chip bxtwc_regmap_irq_chip_tmu = {
 };
 
 static struct resource gpio_resources[] = {
-	DEFINE_RES_IRQ_NAMED(BXTWC_GPIO0_IRQ, "GPIO0"),
-	DEFINE_RES_IRQ_NAMED(BXTWC_GPIO1_IRQ, "GPIO1"),
+	DEFINE_RES_IRQ_NAMED(BXTWC_GPIO_LVL1_IRQ, "GPIO"),
 };
 
 static struct resource adc_resources[] = {
-- 
2.7.4

