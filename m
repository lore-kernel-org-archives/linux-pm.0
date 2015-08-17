From: Petr Cvek <petr.cvek@tul.cz>
Subject: [PATCH v2 18/21] mfd: htc-pasic3: Prepare driver for leds-pasic3
Date: Tue, 18 Aug 2015 00:05:48 +0200
Message-ID: <55D25ABC.1000405@tul.cz>
References: <cover.1439843482.git.petr.cvek@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <cover.1439843482.git.petr.cvek@tul.cz>
Sender: linux-leds-owner@vger.kernel.org
To: robert.jarzmik@free.fr, philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Fix register definitions and prepare structures for new leds-pasic3
driver.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 drivers/mfd/htc-pasic3.c       | 54 ++++++++++++++++-----------
 include/linux/mfd/htc-pasic3.h | 85 +++++++++++++++++++++++++++++++-----------
 2 files changed, 97 insertions(+), 42 deletions(-)

diff --git a/drivers/mfd/htc-pasic3.c b/drivers/mfd/htc-pasic3.c
index e88d4f6..16e156d 100644
--- a/drivers/mfd/htc-pasic3.c
+++ b/drivers/mfd/htc-pasic3.c
@@ -3,6 +3,9 @@
  *
  * Copyright (C) 2006 Philipp Zabel <philipp.zabel@gmail.com>
  *
+ * 2015:	Added registers for LED and RESET, see htc-pasic3.h
+ *		-- Petr Cvek
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; version 2 of the License.
@@ -21,15 +24,10 @@
 #include <linux/mfd/htc-pasic3.h>
 #include <linux/slab.h>
 
-struct pasic3_data {
-	void __iomem *mapping;
-	unsigned int bus_shift;
-};
-
 #define REG_ADDR  5
 #define REG_DATA  6
 
-#define READ_MODE 0x80
+#define READ_MODE BIT(7)
 
 /*
  * write to a secondary register on the PASIC3
@@ -76,24 +74,36 @@ static struct mfd_cell led_cell __initdata = {
 static int ds1wm_enable(struct platform_device *pdev)
 {
 	struct device *dev = pdev->dev.parent;
-	int c;
+	struct pasic3_data *asic = platform_get_drvdata(pdev);
+	unsigned long flags;
+	u8 c;
+
+	spin_lock_irqsave(&asic->lock, flags);
+
+	c = pasic3_read_register(dev, PASIC3_GPIO);
+	pasic3_write_register(dev, PASIC3_GPIO, c & ~DS1WM_NEN);
 
-	c = pasic3_read_register(dev, 0x28);
-	pasic3_write_register(dev, 0x28, c & 0x7f);
+	spin_unlock_irqrestore(&asic->lock, flags);
 
-	dev_dbg(dev, "DS1WM OWM_EN low (active) %02x\n", c & 0x7f);
+	dev_dbg(dev, "DS1WM OWM_EN low (active) %02lx\n", c & ~DS1WM_NEN);
 	return 0;
 }
 
 static int ds1wm_disable(struct platform_device *pdev)
 {
 	struct device *dev = pdev->dev.parent;
-	int c;
+	struct pasic3_data *asic = platform_get_drvdata(pdev);
+	unsigned long flags;
+	u8 c;
+
+	spin_lock_irqsave(&asic->lock, flags);
+
+	c = pasic3_read_register(dev, PASIC3_GPIO);
+	pasic3_write_register(dev, PASIC3_GPIO, c | DS1WM_NEN);
 
-	c = pasic3_read_register(dev, 0x28);
-	pasic3_write_register(dev, 0x28, c | 0x80);
+	spin_unlock_irqrestore(&asic->lock, flags);
 
-	dev_dbg(dev, "DS1WM OWM_EN high (inactive) %02x\n", c | 0x80);
+	dev_dbg(dev, "DS1WM OWM_EN high (inactive) %02lx\n", c | DS1WM_NEN);
 	return 0;
 }
 
@@ -130,6 +140,7 @@ static int __init pasic3_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct pasic3_data *asic;
 	struct resource *r;
+	struct pasic3_leds_pdata *leds_pdata;
 	int ret;
 	int irq = 0;
 
@@ -162,6 +173,8 @@ static int __init pasic3_probe(struct platform_device *pdev)
 	/* calculate bus shift from mem resource */
 	asic->bus_shift = (resource_size(r) - 5) >> 3;
 
+	spin_lock_init(&asic->lock);
+
 	if (pdata && pdata->clock_rate) {
 		ds1wm_pdata.clock_rate = pdata->clock_rate;
 		/* the first 5 PASIC3 registers control the DS1WM */
@@ -172,13 +185,12 @@ static int __init pasic3_probe(struct platform_device *pdev)
 			dev_warn(dev, "failed to register DS1WM\n");
 	}
 
-	if (pdata && pdata->led_pdata) {
-		led_cell.platform_data = pdata->led_pdata;
-		led_cell.pdata_size = sizeof(struct pasic3_leds_machinfo);
-		ret = mfd_add_devices(&pdev->dev, pdev->id, &led_cell, 1, r,
-				      0, NULL);
-		if (ret < 0)
-			dev_warn(dev, "failed to register LED device\n");
+	if (pdata && pdata->pasic3_leds) {
+		leds_pdata = dev_get_platdata(&pdata->pasic3_leds->dev);
+		if (leds_pdata) {
+			leds_pdata->mfd_dev = dev;
+			platform_device_register(pdata->pasic3_leds);
+		}
 	}
 
 	return 0;
diff --git a/include/linux/mfd/htc-pasic3.h b/include/linux/mfd/htc-pasic3.h
index 3d3ed67..91a27b6 100644
--- a/include/linux/mfd/htc-pasic3.h
+++ b/include/linux/mfd/htc-pasic3.h
@@ -2,6 +2,7 @@
  * HTC PASIC3 driver - LEDs and DS1WM
  *
  * Copyright (c) 2007 Philipp Zabel <philipp.zabel@gmail.com>
+ * Copyright (c) 2015 Petr Cvek <petr.cvek@tul.cz>
  *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file COPYING in the main directory of this archive for
@@ -18,37 +19,79 @@
 extern void pasic3_write_register(struct device *dev, u32 reg, u8 val);
 extern u8 pasic3_read_register(struct device *dev, u32 reg);
 
-/*
- * mask for registers 0x20,0x21,0x22
- */
-#define PASIC3_MASK_LED0 0x04
-#define PASIC3_MASK_LED1 0x08
-#define PASIC3_MASK_LED2 0x40
+#define PASIC3_CH0_DELAY_ON	0x00
+#define PASIC3_CH0_DELAY_OFF	0x01
+#define PASIC3_CH1_DELAY_ON	0x02
+#define PASIC3_CH1_DELAY_OFF	0x03
+#define PASIC3_CH2_DELAY_ON	0x04
+#define PASIC3_CH2_DELAY_OFF	0x05
+#define PASIC3_DELAY_MASK	0x7f
+
+#define PASIC3_CH_CONTROL	0x06
+#define		R06_CH0_EN		BIT(0)
+#define		R06_CH1_EN		BIT(1)
+#define		R06_CH2_EN		BIT(2)
+#define		R06_CH0_FORCE_ON	BIT(3)
+#define		R06_CH1_FORCE_ON	BIT(4)
+#define		R06_CH2_FORCE_ON	BIT(5)
 
 /*
- * bits in register 0x06
+ * pwm_ch0_out | force_on | (bit0 & bit1 & bit2)
+ * pwm_ch1_out | force_on | (bit0 & bit1 & bit2)
+ * pwm_ch2_out | force_on | (bit2?bit0:(bit0 & ! bit1))
  */
-#define PASIC3_BIT2_LED0 0x08
-#define PASIC3_BIT2_LED1 0x10
-#define PASIC3_BIT2_LED2 0x20
+
+#define PASIC3_MASK_A	0x20
+#define PASIC3_MASK_B	0x21
+#define PASIC3_MASK_C	0x22
+#define		MASK_CH0	BIT(2)
+#define		MASK_CH1	BIT(3)
+#define		MASK_CH2	BIT(6)
+#define PASIC3_GPIO	0x28
+#define		DS1WM_NEN	BIT(7)
+#define PASIC3_SYS	0x2a
+
+/* NORMAL_RST, CAM_PWR_RST and UNKNOWN will autoclear, set STATUS */
+#define		NORMAL_RST	BIT(0)
+#define		CAM_PWR_RST	BIT(1)
+#define		UNKNOWN	BIT(2)
+#define		STATUS_NORMAL_RST	BIT(4)
+#define		STATUS_CAM_PWR_RST	BIT(5)
+#define		STATUS_UNKNOWN		BIT(6)
+
+/* FIXME/TODO reset sources */
+#define PASIC3_RST_EN	0x2c
+#define		EN_NORMAL_RST	0x40
+#define		EN_DOOR_RST	0x42
 
 struct pasic3_led {
-	struct led_classdev         led;
-	unsigned int                hw_num;
-	unsigned int                bit2;
-	unsigned int                mask;
-	struct pasic3_leds_machinfo *pdata;
+	char	name[24];
+	char	default_trigger[80];
+	int	hw_num;
+	u8	bit_blink_en;
+	u8	bit_force_on;
+	u8	bit_mask;
+	u8	reg_delay_on;
+	u8	reg_delay_off;
 };
 
-struct pasic3_leds_machinfo {
-	unsigned int      num_leds;
-	unsigned int      power_gpio;
+struct pasic3_leds_pdata {
 	struct pasic3_led *leds;
+	int num_leds;
+	int power_gpio;
+	int power_gpio_users;
+	struct device *mfd_dev;
 };
 
-struct pasic3_platform_data {
-	struct pasic3_leds_machinfo *led_pdata;
-	unsigned int                 clock_rate;
+struct pasic3_data {
+	void __iomem *mapping;
+	unsigned int bus_shift;
+	spinlock_t lock;
 };
 
+struct pasic3_platform_data {
+	unsigned int clock_rate;
+	struct pasic3_led *leds;
+	struct platform_device *pasic3_leds;
+};
 #endif
-- 
1.7.12.1
