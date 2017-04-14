From: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v2 5/8] gpio: gpio-wcove: use first level PMIC GPIO irq
Date: Fri, 14 Apr 2017 16:25:57 -0700
Message-ID: <cd9ddab845e471758b5553fcdc060d6eecd24e93.1492210847.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <0e4d82ca9cdc41c9d2a8b45258cd72659b4c2063.1492210847.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:29855 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755841AbdDNX3k (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Apr 2017 19:29:40 -0400
In-Reply-To: <0e4d82ca9cdc41c9d2a8b45258cd72659b4c2063.1492210847.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: gnurou@gmail.com, linus.walleij@linaro.org, edubezval@gmail.com, dvhart@infradead.org, rui.zhang@intel.com, lee.jones@linaro.org, andy@infradead.org
Cc: linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, sathyaosid@gmail.com, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

PMIC mfd driver only exports first level irq for GPIO device.
But currently we are reading the irqs from the second level irq
chip, So this patch fixes this issue by adding support to use
first level PMIC GPIO irq.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/gpio/gpio-wcove.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

Changes since v1:
 * used correct mask for GPIO0 and GPIO1 interrupts

diff --git a/drivers/gpio/gpio-wcove.c b/drivers/gpio/gpio-wcove.c
index 97613de..fd7ad85 100644
--- a/drivers/gpio/gpio-wcove.c
+++ b/drivers/gpio/gpio-wcove.c
@@ -51,6 +51,8 @@
 #define GROUP1_NR_IRQS		6
 #define IRQ_MASK_BASE		0x4e19
 #define IRQ_STATUS_BASE		0x4e0b
+#define GPIO_IRQ0_MASK		0x7f
+#define GPIO_IRQ1_MASK		0x3f
 #define UPDATE_IRQ_TYPE		BIT(0)
 #define UPDATE_IRQ_MASK		BIT(1)
 
@@ -399,7 +401,7 @@ static int wcove_gpio_probe(struct platform_device *pdev)
 	if (!wg)
 		return -ENOMEM;
 
-	wg->regmap_irq_chip = pmic->irq_chip_data_level2;
+	wg->regmap_irq_chip = pmic->irq_chip_data;
 
 	platform_set_drvdata(pdev, wg);
 
@@ -447,6 +449,18 @@ static int wcove_gpio_probe(struct platform_device *pdev)
 
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
 
-- 
2.7.4
