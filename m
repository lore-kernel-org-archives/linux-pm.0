From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: [RFC PATCH v4 01/10] mfd: bd718x7.h split to ROHM common and bd718x7
 specific parts
Date: Thu, 31 Jan 2019 14:02:24 +0200
Message-ID: <0f5a3b94f936556c1ad05da58bfb35182ae20a96.1548935790.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1548935790.git.matti.vaittinen@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1548935790.git.matti.vaittinen@fi.rohmeurope.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Cc: heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it, alexandre.belloni@bootlin.com, wim@linux-watchdog.org, linux@roeck-us.net, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Split the bd718x7.h to ROHM common and bd718x7 specific parts
so that we do not need to add same things in every new ROHM
PMIC header. Please note that this change requires changes also
in bd718x7 sub-device drivers for regulators and clk.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/mfd/rohm-bd718x7.c       | 23 ++++++++++++-----------
 include/linux/mfd/rohm-bd718x7.h | 22 ++++++++--------------
 include/linux/mfd/rohm-generic.h | 20 ++++++++++++++++++++
 3 files changed, 40 insertions(+), 25 deletions(-)
 create mode 100644 include/linux/mfd/rohm-generic.h

diff --git a/drivers/mfd/rohm-bd718x7.c b/drivers/mfd/rohm-bd718x7.c
index a29d529a96f4..7beb444a57cb 100644
--- a/drivers/mfd/rohm-bd718x7.c
+++ b/drivers/mfd/rohm-bd718x7.c
@@ -98,18 +98,19 @@ static int bd718xx_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	bd718xx->chip_irq = i2c->irq;
-	bd718xx->chip_type = (unsigned int)(uintptr_t)
+	bd718xx->chip.chip_type = (unsigned int)(uintptr_t)
 				of_device_get_match_data(&i2c->dev);
-	bd718xx->dev = &i2c->dev;
+	bd718xx->chip.dev = &i2c->dev;
 	dev_set_drvdata(&i2c->dev, bd718xx);
 
-	bd718xx->regmap = devm_regmap_init_i2c(i2c, &bd718xx_regmap_config);
-	if (IS_ERR(bd718xx->regmap)) {
+	bd718xx->chip.regmap = devm_regmap_init_i2c(i2c,
+						    &bd718xx_regmap_config);
+	if (IS_ERR(bd718xx->chip.regmap)) {
 		dev_err(&i2c->dev, "regmap initialization failed\n");
-		return PTR_ERR(bd718xx->regmap);
+		return PTR_ERR(bd718xx->chip.regmap);
 	}
 
-	ret = devm_regmap_add_irq_chip(&i2c->dev, bd718xx->regmap,
+	ret = devm_regmap_add_irq_chip(&i2c->dev, bd718xx->chip.regmap,
 				       bd718xx->chip_irq, IRQF_ONESHOT, 0,
 				       &bd718xx_irq_chip, &bd718xx->irq_data);
 	if (ret) {
@@ -118,7 +119,7 @@ static int bd718xx_i2c_probe(struct i2c_client *i2c,
 	}
 
 	/* Configure short press to 10 milliseconds */
-	ret = regmap_update_bits(bd718xx->regmap,
+	ret = regmap_update_bits(bd718xx->chip.regmap,
 				 BD718XX_REG_PWRONCONFIG0,
 				 BD718XX_PWRBTN_PRESS_DURATION_MASK,
 				 BD718XX_PWRBTN_SHORT_PRESS_10MS);
@@ -129,7 +130,7 @@ static int bd718xx_i2c_probe(struct i2c_client *i2c,
 	}
 
 	/* Configure long press to 10 seconds */
-	ret = regmap_update_bits(bd718xx->regmap,
+	ret = regmap_update_bits(bd718xx->chip.regmap,
 				 BD718XX_REG_PWRONCONFIG1,
 				 BD718XX_PWRBTN_PRESS_DURATION_MASK,
 				 BD718XX_PWRBTN_LONG_PRESS_10S);
@@ -149,7 +150,7 @@ static int bd718xx_i2c_probe(struct i2c_client *i2c,
 
 	button.irq = ret;
 
-	ret = devm_mfd_add_devices(bd718xx->dev, PLATFORM_DEVID_AUTO,
+	ret = devm_mfd_add_devices(bd718xx->chip.dev, PLATFORM_DEVID_AUTO,
 				   bd718xx_mfd_cells,
 				   ARRAY_SIZE(bd718xx_mfd_cells), NULL, 0,
 				   regmap_irq_get_domain(bd718xx->irq_data));
@@ -162,11 +163,11 @@ static int bd718xx_i2c_probe(struct i2c_client *i2c,
 static const struct of_device_id bd718xx_of_match[] = {
 	{
 		.compatible = "rohm,bd71837",
-		.data = (void *)BD718XX_TYPE_BD71837,
+		.data = (void *)ROHM_CHIP_TYPE_BD71837,
 	},
 	{
 		.compatible = "rohm,bd71847",
-		.data = (void *)BD718XX_TYPE_BD71847,
+		.data = (void *)ROHM_CHIP_TYPE_BD71847,
 	},
 	{ }
 };
diff --git a/include/linux/mfd/rohm-bd718x7.h b/include/linux/mfd/rohm-bd718x7.h
index fd194bfc836f..7f2dbde402a1 100644
--- a/include/linux/mfd/rohm-bd718x7.h
+++ b/include/linux/mfd/rohm-bd718x7.h
@@ -4,14 +4,9 @@
 #ifndef __LINUX_MFD_BD718XX_H__
 #define __LINUX_MFD_BD718XX_H__
 
+#include <linux/mfd/rohm-generic.h>
 #include <linux/regmap.h>
 
-enum {
-	BD718XX_TYPE_BD71837 = 0,
-	BD718XX_TYPE_BD71847,
-	BD718XX_TYPE_AMOUNT
-};
-
 enum {
 	BD718XX_BUCK1 = 0,
 	BD718XX_BUCK2,
@@ -321,18 +316,17 @@ enum {
 	BD718XX_PWRBTN_LONG_PRESS_15S
 };
 
-struct bd718xx_clk;
-
 struct bd718xx {
-	unsigned int chip_type;
-	struct device *dev;
-	struct regmap *regmap;
-	unsigned long int id;
+	/*
+	 * Please keep this as the first member here as some
+	 * drivers (clk) supporting more than one chip may only know this
+	 * generic struct 'struct rohm_regmap_dev' and assume it is
+	 * the first chunk of parent device's private data.
+	 */
+	struct rohm_regmap_dev chip;
 
 	int chip_irq;
 	struct regmap_irq_chip_data *irq_data;
-
-	struct bd718xx_clk *clk;
 };
 
 #endif /* __LINUX_MFD_BD718XX_H__ */
diff --git a/include/linux/mfd/rohm-generic.h b/include/linux/mfd/rohm-generic.h
new file mode 100644
index 000000000000..bff15ac26f2c
--- /dev/null
+++ b/include/linux/mfd/rohm-generic.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright (C) 2018 ROHM Semiconductors */
+
+#ifndef __LINUX_MFD_ROHM_H__
+#define __LINUX_MFD_ROHM_H__
+
+enum {
+	ROHM_CHIP_TYPE_BD71837 = 0,
+	ROHM_CHIP_TYPE_BD71847,
+	ROHM_CHIP_TYPE_BD70528,
+	ROHM_CHIP_TYPE_AMOUNT
+};
+
+struct rohm_regmap_dev {
+	unsigned int chip_type;
+	struct device *dev;
+	struct regmap *regmap;
+};
+
+#endif
-- 
2.14.3


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
