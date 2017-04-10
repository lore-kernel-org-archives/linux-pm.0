From: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v1 5/7] gpio: gpio-wcove: use first level PMIC GPIO irq
Date: Mon, 10 Apr 2017 11:52:27 -0700
Message-ID: <c9a11d58c5e2db763fa7fcfab831ce01a236741f.1491848776.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <b8e952de94ed1902b922224de11f0814371b08b0.1491848776.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <b8e952de94ed1902b922224de11f0814371b08b0.1491848776.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: gnurou@gmail.com, linus.walleij@linaro.org, edubezval@gmail.com, dvhart@infradead.org, rui.zhang@intel.com, lee.jones@linaro.org, andy@infradead.org, hdegoede@redhat.com
Cc: linux-gpio@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sathyaosid@gmail.com, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

PMIC mfd driver only exports first level irq for GPIO device.
But currently we are reading the irqs from the second level irq
chip, So this patch fixes this issue by adding support to use
first level PMIC GPIO irq.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/gpio/gpio-wcove.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-wcove.c b/drivers/gpio/gpio-wcove.c
index 97613de..0117106 100644
--- a/drivers/gpio/gpio-wcove.c
+++ b/drivers/gpio/gpio-wcove.c
@@ -399,7 +399,7 @@ static int wcove_gpio_probe(struct platform_device *pdev)
 	if (!wg)
 		return -ENOMEM;
 
-	wg->regmap_irq_chip = pmic->irq_chip_data_level2;
+	wg->regmap_irq_chip = pmic->irq_chip_data;
 
 	platform_set_drvdata(pdev, wg);
 
@@ -447,6 +447,16 @@ static int wcove_gpio_probe(struct platform_device *pdev)
 
 	gpiochip_set_nested_irqchip(&wg->chip, &wcove_irqchip, virq);
 
+	/* Enable GPIO0 interrupts */
+	ret = regmap_update_bits(wg->regmap, IRQ_MASK_BASE, 0xff, 0x00);
+	if (ret)
+		return ret;
+
+	/* Enable GPIO1 interrupts */
+	ret = regmap_update_bits(wg->regmap, IRQ_MASK_BASE + 1, 0xff, 0x00);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
-- 
2.7.4
