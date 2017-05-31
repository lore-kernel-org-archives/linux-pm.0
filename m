From: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v5 5/8] gpio: gpio-wcove: Use first level PMIC GPIO irq
Date: Wed, 31 May 2017 15:37:13 -0700
Message-ID: <5490d3e89249bfa9edc219ff83055ab457c8b6ea.1496266871.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20170531070225.bymdhhpclidwwtpt@dell>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170531070225.bymdhhpclidwwtpt@dell>
In-Reply-To: <cover.1496266871.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1496266871.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gnurou@gmail.com, heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, linus.walleij@linaro.org, edubezval@gmail.com, dvhart@infradead.org, rui.zhang@intel.com, lee.jones@linaro.org, andy@infradead.org
Cc: linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, sathyaosid@gmail.com, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

PMIC mfd driver only exports first level irq for GPIO device.
But currently we are reading the irqs from the second level irq
chip, So this patch fixes this issue by adding support to use
first level PMIC GPIO irq.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-wcove.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

Changes since v1:
 * used correct mask for GPIO0 and GPIO1 interrupts

Changes since v2: 
 * Rebased on top of latest release.
 * Removed IRQ0 and IRQ1 mask defines.

Changes since v3:
 * None

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
 
-- 
2.7.4
