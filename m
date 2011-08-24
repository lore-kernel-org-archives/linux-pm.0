From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: [PATCH v2] Add regulator driver for the bq2407x family
	of charger ICs.
Date: Wed, 24 Aug 2011 20:48:26 +0200
Message-ID: <201108242048.27461.heiko@sntech.de>
References: <201108202224.52250.heiko@sntech.de>
	<201108232215.08788.heiko@sntech.de>
	<20110824090746.GP9232@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110824090746.GP9232@opensource.wolfsonmicro.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-pm@lists.linux-foundation.org, Liam Girdwood <lrg@ti.com>
List-Id: linux-pm@vger.kernel.org

This driver controls a TI bq2407x charger attached via GPIOs.
The provided current regulator can enable/disable charging and
select between 100 mA, 500 mA and a machine specific current limit.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>

---
Changes since v1:
 - add private struct to keep track of gpio states
 - get max_uA from regulator_init_data
   (no need to define it twice)
 - disallow setting current limix below 100mA

 drivers/regulator/Kconfig         |    8 +
 drivers/regulator/Makefile        |    1 +
 drivers/regulator/bq2407x.c       |  264 +++++++++++++++++++++++++++++++++++++
 include/linux/regulator/bq2407x.h |   35 +++++
 4 files changed, 308 insertions(+), 0 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index c7fd2c0..921e271 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -72,6 +72,14 @@ config REGULATOR_BQ24022
 	  charging select between 100 mA and 500 mA charging current
 	  limit.
 
+config REGULATOR_BQ2407x
+	tristate "TI bq2407x Li-Ion Charger IC"
+	help
+	  This driver controls a TI bq2407x Charger attached via
+	  GPIOs. The provided current regulator can enable/disable
+	  charging select between 100 mA, 500 mA and a machine specific
+	  charging current limit.
+
 config REGULATOR_MAX1586
 	tristate "Maxim 1586/1587 voltage regulator"
 	depends on I2C
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 040d5aa..ce65493 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_REGULATOR_USERSPACE_CONSUMER) += userspace-consumer.o
 
 obj-$(CONFIG_REGULATOR_AD5398) += ad5398.o
 obj-$(CONFIG_REGULATOR_BQ24022) += bq24022.o
+obj-$(CONFIG_REGULATOR_BQ2407x) += bq2407x.o
 obj-$(CONFIG_REGULATOR_LP3971) += lp3971.o
 obj-$(CONFIG_REGULATOR_LP3972) += lp3972.o
 obj-$(CONFIG_REGULATOR_MAX1586) += max1586.o
diff --git a/drivers/regulator/bq2407x.c b/drivers/regulator/bq2407x.c
new file mode 100644
index 0000000..a8221d5
--- /dev/null
+++ b/drivers/regulator/bq2407x.c
@@ -0,0 +1,264 @@
+/*
+ * Support for TI bq2407x USB-friendly
+ * Li-Ion Charger connected via GPIOs.
+ *
+ * Copyright (c) 2011 Heiko Stuebner
+ *
+ * based on the bq24022 driver
+ * Copyright (c) 2008 Philipp Zabel
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/gpio.h>
+#include <linux/regulator/bq2407x.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+
+struct bq2407x {
+	struct regulator_dev	*rdev;
+
+	int gpio_nce;
+	int gpio_en2;
+	int gpio_en1;
+
+	int state_nce;
+	int state_en2;
+	int state_en1;
+
+	int max_uA;
+};
+
+
+static int bq2407x_set_current_limit(struct regulator_dev *rdev,
+					int min_uA, int max_uA)
+{
+	struct bq2407x *bq = rdev_get_drvdata(rdev);
+
+	if (bq->max_uA && bq->max_uA > 500000
+			      && max_uA >= bq->max_uA) {
+		dev_dbg(rdev_get_dev(rdev),
+			"setting current limit to %d mA\n",
+			bq->max_uA / 1000);
+		gpio_set_value(bq->gpio_en2, 1);
+		bq->state_en2 = 1;
+		gpio_set_value(bq->gpio_en1, 0);
+		bq->state_en1 = 0;
+	} else if (max_uA >= 500000) {
+		dev_dbg(rdev_get_dev(rdev),
+			"setting current limit to 500 mA\n");
+		gpio_set_value(bq->gpio_en2, 0);
+		bq->state_en2 = 0;
+		gpio_set_value(bq->gpio_en1, 1);
+		bq->state_en1 = 1;
+	} else if (max_uA >= 100000) {
+		dev_dbg(rdev_get_dev(rdev),
+			"setting current limit to 100 mA\n");
+		gpio_set_value(bq->gpio_en2, 0);
+		bq->state_en2 = 0;
+		gpio_set_value(bq->gpio_en1, 0);
+		bq->state_en1 = 0;
+	} else {
+		dev_err(rdev_get_dev(rdev), "cannot set current limit below 100 mA\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int bq2407x_get_current_limit(struct regulator_dev *rdev)
+{
+	struct bq2407x *bq = rdev_get_drvdata(rdev);
+
+	if (bq->state_en2 && bq->state_en1)
+		return 0;
+	else if (bq->state_en2 && !bq->state_en1)
+		return bq->max_uA;
+	else if (!bq->state_en2 && bq->state_en1)
+		return 500000;
+	else
+		return 100000;
+}
+
+static int bq2407x_enable(struct regulator_dev *rdev)
+{
+	struct bq2407x *bq = rdev_get_drvdata(rdev);
+
+	dev_dbg(rdev_get_dev(rdev), "enabling charger\n");
+
+	gpio_set_value(bq->gpio_nce, 0);
+	bq->state_nce = 0;
+
+	return 0;
+}
+
+static int bq2407x_disable(struct regulator_dev *rdev)
+{
+	struct bq2407x *bq = rdev_get_drvdata(rdev);
+
+	dev_dbg(rdev_get_dev(rdev), "disabling charger\n");
+
+	gpio_set_value(bq->gpio_nce, 1);
+	bq->state_nce = 1;
+
+	return 0;
+}
+
+static int bq2407x_is_enabled(struct regulator_dev *rdev)
+{
+	struct bq2407x *bq = rdev_get_drvdata(rdev);
+
+	return !bq->state_nce;
+}
+
+static struct regulator_ops bq2407x_ops = {
+	.set_current_limit = bq2407x_set_current_limit,
+	.get_current_limit = bq2407x_get_current_limit,
+	.enable            = bq2407x_enable,
+	.disable           = bq2407x_disable,
+	.is_enabled        = bq2407x_is_enabled,
+};
+
+static struct regulator_desc bq2407x_desc = {
+	.name  = "bq2407x",
+	.ops   = &bq2407x_ops,
+	.type  = REGULATOR_CURRENT,
+	.owner = THIS_MODULE,
+};
+
+static int __init bq2407x_probe(struct platform_device *pdev)
+{
+	struct bq2407x_mach_info *pdata = pdev->dev.platform_data;
+	struct bq2407x *bq;
+	int ret;
+
+	if (!pdata || !pdata->gpio_nce || !pdata->gpio_en1 || !pdata->gpio_en2)
+		return -EINVAL;
+
+	bq = kzalloc(sizeof(struct bq2407x), GFP_KERNEL);
+	if (!bq) {
+		dev_err(&pdev->dev, "cannot allocate memory\n");
+		return -ENOMEM;
+	}
+
+	ret = gpio_request(pdata->gpio_nce, "ncharge_en");
+	if (ret) {
+		dev_dbg(&pdev->dev, "couldn't request nCE GPIO: %d\n",
+			pdata->gpio_nce);
+		goto err_ce;
+	}
+	ret = gpio_request(pdata->gpio_en2, "charge_mode_en2");
+	if (ret) {
+		dev_dbg(&pdev->dev, "couldn't request EN2 GPIO: %d\n",
+			pdata->gpio_en2);
+		goto err_en2;
+	}
+	ret = gpio_request(pdata->gpio_en1, "charge_mode_en1");
+	if (ret) {
+		dev_dbg(&pdev->dev, "couldn't request EN1 GPIO: %d\n",
+			pdata->gpio_en1);
+		goto err_en1;
+	}
+
+	/* set initial current to 100mA and disable regulator */
+	ret = gpio_direction_output(pdata->gpio_en2, 0);
+	if (ret) {
+		dev_dbg(&pdev->dev, "couldn't set EN2 GPIO: %d\n",
+			pdata->gpio_en1);
+		goto err_reg;
+	}
+	bq->gpio_en2  = pdata->gpio_en2;
+	bq->state_en2 = 0;
+	ret = gpio_direction_output(pdata->gpio_en1, 0);
+	if (ret) {
+		dev_dbg(&pdev->dev, "couldn't set EN1 GPIO: %d\n",
+			pdata->gpio_en1);
+		goto err_reg;
+	}
+	bq->gpio_en1  = pdata->gpio_en1;
+	bq->state_en1 = 0;
+	ret = gpio_direction_output(pdata->gpio_nce, 1);
+	if (ret) {
+		dev_dbg(&pdev->dev, "couldn't set nCE GPIO: %d\n",
+			pdata->gpio_en1);
+		goto err_reg;
+	}
+	bq->gpio_nce  = pdata->gpio_nce;
+	bq->state_nce = 1;
+
+	/* get maximum current from regulator_init_data */
+	if (pdata->init_data) {
+		bq->max_uA = pdata->init_data->constraints.max_uA;
+		dev_dbg(&pdev->dev, "maximum current is %d mA\n",
+			bq->max_uA / 1000);
+	}
+
+	bq->rdev = regulator_register(&bq2407x_desc, &pdev->dev,
+					pdata->init_data, bq);
+	if (IS_ERR(bq->rdev)) {
+		dev_dbg(&pdev->dev, "couldn't register regulator\n");
+		ret = PTR_ERR(bq->rdev);
+		goto err_reg;
+	}
+
+	platform_set_drvdata(pdev, bq);
+	dev_dbg(&pdev->dev, "registered regulator\n");
+
+	return 0;
+err_reg:
+	gpio_free(pdata->gpio_en1);
+err_en1:
+	gpio_free(pdata->gpio_en2);
+err_en2:
+	gpio_free(pdata->gpio_nce);
+err_ce:
+	kfree(bq);
+	return ret;
+}
+
+static int __devexit bq2407x_remove(struct platform_device *pdev)
+{
+	struct bq2407x *bq = platform_get_drvdata(pdev);
+
+	regulator_unregister(bq->rdev);
+	gpio_free(bq->gpio_en1);
+	gpio_free(bq->gpio_en2);
+	gpio_free(bq->gpio_nce);
+
+	kfree(bq);
+
+	return 0;
+}
+
+static struct platform_driver bq2407x_driver = {
+	.driver = {
+		.name = "bq2407x",
+	},
+	.remove = __devexit_p(bq2407x_remove),
+};
+
+static int __init bq2407x_init(void)
+{
+	return platform_driver_probe(&bq2407x_driver, bq2407x_probe);
+}
+
+static void __exit bq2407x_exit(void)
+{
+	platform_driver_unregister(&bq2407x_driver);
+}
+
+module_init(bq2407x_init);
+module_exit(bq2407x_exit);
+
+MODULE_AUTHOR("Heiko Stuebner");
+MODULE_DESCRIPTION("TI bq2407x Li-Ion Charger driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/regulator/bq2407x.h b/include/linux/regulator/bq2407x.h
new file mode 100644
index 0000000..14d6d93
--- /dev/null
+++ b/include/linux/regulator/bq2407x.h
@@ -0,0 +1,35 @@
+/*
+ * Support for TI bq2407x 1.5A USB-friendly
+ * Li-Ion Charger connected via GPIOs.
+ *
+ * Copyright (c) 2011 Heiko Stuebner
+ *
+ * based on the bq24022 driver
+ * Copyright (c) 2008 Philipp Zabel
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+struct regulator_init_data;
+
+/**
+ * bq2407x_mach_info - platform data for bq2407x
+ * @gpio_nce: GPIO line connected to the nCE pin, used to control charging
+ * @gpio_en2: GPIO line connected to the EN2 pin, used to limit charging
+ * @gpio_en1: GPIO line connected to the EN1 pin, used to limit charging
+ * @max_uA: maximum current defined by resistor on ILIM connector
+ * Modes of operation:
+ * EN2 = 0, EN1 = 0: 100mA
+ * EN2 = 0, EN1 = 1: 500mA
+ * EN2 = 1, EN1 = 0: max_current
+ * EN2 = 1, EN1 = 1: Standby (usb suspend)
+ */
+struct bq2407x_mach_info {
+	int gpio_nce;
+	int gpio_en2;
+	int gpio_en1;
+	struct regulator_init_data *init_data;
+};
-- 
tg: (93ee7a9..) topic/drivers/bq2407x (depends on: master)
