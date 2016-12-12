From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Subject: [PATCHv5 2/5] thermal: rcar_gen3_thermal: Add R-Car Gen3 thermal driver
Date: Mon, 12 Dec 2016 15:18:02 +0100
Message-ID: <20161212141805.14946-3-niklas.soderlund@ragnatech.se>
References: <20161212141805.14946-1-niklas.soderlund@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20161212141805.14946-1-niklas.soderlund@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Khiem Nguyen <khiem.nguyen.xt@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Hien Dang <hien.dang.eb@renesas.com>, Thao Nguyen <thao.nguyen.yb@rvc.renesas.com>, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
List-Id: linux-pm@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Add support for R-Car Gen3 thermal sensors. Polling only for now,
interrupts will be added incrementally. Same goes for reading fuses.
This is documented already, but no hardware available for now.

Signed-off-by: Hien Dang <hien.dang.eb@renesas.com>
Signed-off-by: Thao Nguyen <thao.nguyen.yb@rvc.renesas.com>
Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
[Niklas: document and rework temperature calculation]
Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/Kconfig             |   9 +
 drivers/thermal/Makefile            |   1 +
 drivers/thermal/rcar_gen3_thermal.c | 328 ++++++++++++++++++++++++++++++++++++
 3 files changed, 338 insertions(+)
 create mode 100644 drivers/thermal/rcar_gen3_thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index a13541b..da71f94 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -243,6 +243,15 @@ config RCAR_THERMAL
 	  Enable this to plug the R-Car thermal sensor driver into the Linux
 	  thermal framework.
 
+config RCAR_GEN3_THERMAL
+	tristate "Renesas R-Car Gen3 thermal driver"
+	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on HAS_IOMEM
+	depends on OF
+	help
+	  Enable this to plug the R-Car Gen3 thermal sensor driver into the Linux
+	  thermal framework.
+
 config KIRKWOOD_THERMAL
 	tristate "Temperature sensor on Marvell Kirkwood SoCs"
 	depends on MACH_KIRKWOOD || COMPILE_TEST
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index c92eb22..1216fb3 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+= qcom-spmi-temp-alarm.o
 obj-$(CONFIG_SPEAR_THERMAL)	+= spear_thermal.o
 obj-$(CONFIG_ROCKCHIP_THERMAL)	+= rockchip_thermal.o
 obj-$(CONFIG_RCAR_THERMAL)	+= rcar_thermal.o
+obj-$(CONFIG_RCAR_GEN3_THERMAL)	+= rcar_gen3_thermal.o
 obj-$(CONFIG_KIRKWOOD_THERMAL)  += kirkwood_thermal.o
 obj-y				+= samsung/
 obj-$(CONFIG_DOVE_THERMAL)  	+= dove_thermal.o
diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
new file mode 100644
index 0000000..7d78498
--- /dev/null
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -0,0 +1,328 @@
+/*
+ *  R-Car Gen3 THS thermal sensor driver
+ *  Based on rcar_thermal.c and work from Hien Dang and Khiem Nguyen.
+ *
+ * Copyright (C) 2016 Renesas Electronics Corporation.
+ * Copyright (C) 2016 Sang Engineering
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ */
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/thermal.h>
+
+/* Register offsets */
+#define REG_GEN3_IRQSTR		0x04
+#define REG_GEN3_IRQMSK		0x08
+#define REG_GEN3_IRQCTL		0x0C
+#define REG_GEN3_IRQEN		0x10
+#define REG_GEN3_IRQTEMP1	0x14
+#define REG_GEN3_IRQTEMP2	0x18
+#define REG_GEN3_IRQTEMP3	0x1C
+#define REG_GEN3_CTSR		0x20
+#define REG_GEN3_THCTR		0x20
+#define REG_GEN3_TEMP		0x28
+#define REG_GEN3_THCODE1	0x50
+#define REG_GEN3_THCODE2	0x54
+#define REG_GEN3_THCODE3	0x58
+
+/* CTSR bits */
+#define CTSR_PONM	BIT(8)
+#define CTSR_AOUT	BIT(7)
+#define CTSR_THBGR	BIT(5)
+#define CTSR_VMEN	BIT(4)
+#define CTSR_VMST	BIT(1)
+#define CTSR_THSST	BIT(0)
+
+/* THCTR bits */
+#define THCTR_PONM	BIT(6)
+#define THCTR_THSST	BIT(0)
+
+#define CTEMP_MASK	0xFFF
+
+#define MCELSIUS(temp)	((temp) * 1000)
+#define GEN3_FUSE_MASK	0xFFF
+
+#define TSC_MAX_NUM	3
+
+/* Structure for thermal temperature calculation */
+struct equation_coefs {
+	int a1;
+	int b1;
+	int a2;
+	int b2;
+};
+
+struct rcar_gen3_thermal_tsc {
+	void __iomem *base;
+	struct thermal_zone_device *zone;
+	struct equation_coefs coef;
+	struct mutex lock;
+};
+
+struct rcar_gen3_thermal_priv {
+	struct rcar_gen3_thermal_tsc *tscs[TSC_MAX_NUM];
+};
+
+struct rcar_gen3_thermal_data {
+	void (*thermal_init)(struct rcar_gen3_thermal_tsc *tsc);
+};
+
+static inline u32 rcar_gen3_thermal_read(struct rcar_gen3_thermal_tsc *tsc,
+					 u32 reg)
+{
+	return ioread32(tsc->base + reg);
+}
+
+static inline void rcar_gen3_thermal_write(struct rcar_gen3_thermal_tsc *tsc,
+					   u32 reg, u32 data)
+{
+	iowrite32(data, tsc->base + reg);
+}
+
+/*
+ * Linear approximation for temperature
+ *
+ * [reg] = [temp] * a + b => [temp] = ([reg] - b) / a
+ *
+ * The constants a and b are calculated using two triplets of int values PTAT
+ * and THCODE. PTAT and THCODE can either be read from hardware or use hard
+ * coded values from driver. The formula to calculate a and b are taken from
+ * BSP and sparsely documented and understood.
+ *
+ * Examining the linear formula and the formula used to calculate constants a
+ * and b while knowing that the span for PTAT and THCODE values are between
+ * 0x000 and 0xfff the largest integer possible is 0xfff * 0xfff == 0xffe001.
+ * Integer also needs to be signed so that leaves 7 bits for decimal
+ * fixed point scaling, which amounts to a decimal scaling factor of 100.
+ */
+
+#define SCALE_FACTOR 100
+#define SCALE_INT(_x) ((_x) * SCALE_FACTOR)
+#define SCALE_MUL(_a, _b) (((_a)*(_b)) / SCALE_FACTOR)
+#define SCALE_DIV(_a, _b) (((_a)*SCALE_FACTOR)/(_b))
+#define SCALE_TO_MCELSIUS(_x) ((_x) * 10)
+
+#define RCAR3_THERMAL_GRAN 500 /* mili Celsius */
+
+/* no idea where these constants come from */
+#define TJ_1 SCALE_INT(96)
+#define TJ_3 SCALE_INT(-41)
+
+static void rcar_gen3_thermal_calc_coefs(struct equation_coefs *coef,
+					 int *ptat, int *thcode)
+{
+	int tj_2;
+
+	/* TODO: Find documentation and document constant calculation formula */
+
+	tj_2 = SCALE_DIV(SCALE_MUL(SCALE_INT(ptat[1] - ptat[2]), SCALE_INT(137)),
+			 SCALE_INT(ptat[0] - ptat[2])) - SCALE_INT(41);
+
+	coef->a1 = SCALE_DIV(SCALE_INT(thcode[1] - thcode[2]), tj_2 - TJ_3);
+	coef->b1 = SCALE_INT(thcode[2]) - SCALE_MUL(coef->a1, TJ_3);
+
+	coef->a2 = SCALE_DIV(SCALE_INT(thcode[1] - thcode[0]), tj_2 - TJ_1);
+	coef->b2 = SCALE_INT(thcode[0]) - SCALE_MUL(coef->a2, TJ_1);
+}
+
+static int rcar_gen3_thermal_round(int temp)
+{
+	int result, round_offs;
+
+	round_offs = temp >= 0 ? RCAR3_THERMAL_GRAN / 2 :
+		-RCAR3_THERMAL_GRAN / 2;
+	result = (temp + round_offs) / RCAR3_THERMAL_GRAN;
+	return result * RCAR3_THERMAL_GRAN;
+}
+
+static int rcar_gen3_thermal_get_temp(void *devdata, int *temp)
+{
+	struct rcar_gen3_thermal_tsc *tsc = devdata;
+	int mcelsius, val1, val2;
+	u32 reg;
+
+	/* Read register and convert to mili Celsius */
+	mutex_lock(&tsc->lock);
+
+	reg = rcar_gen3_thermal_read(tsc, REG_GEN3_TEMP) & CTEMP_MASK;
+
+	val1 = SCALE_DIV(SCALE_INT(reg) - tsc->coef.b1, tsc->coef.a1);
+	val2 = SCALE_DIV(SCALE_INT(reg) - tsc->coef.b2, tsc->coef.a2);
+	mcelsius = SCALE_TO_MCELSIUS((val1 + val2) / 2);
+
+	mutex_unlock(&tsc->lock);
+
+	/* Make sure we are inside specifications */
+	if ((mcelsius < MCELSIUS(-40)) || (mcelsius > MCELSIUS(125)))
+		return -EIO;
+
+	/* Round value to device granularity setting */
+	*temp = rcar_gen3_thermal_round(mcelsius);
+
+	return 0;
+}
+
+static struct thermal_zone_of_device_ops rcar_gen3_tz_of_ops = {
+	.get_temp	= rcar_gen3_thermal_get_temp,
+};
+
+static void r8a7795_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
+{
+	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,  CTSR_THBGR);
+	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,  0x0);
+
+	usleep_range(1000, 2000);
+
+	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR, CTSR_PONM);
+	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQCTL, 0x3F);
+	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,
+				CTSR_PONM | CTSR_AOUT | CTSR_THBGR | CTSR_VMEN);
+
+	usleep_range(100, 200);
+
+	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,
+				CTSR_PONM | CTSR_AOUT | CTSR_THBGR | CTSR_VMEN |
+				CTSR_VMST | CTSR_THSST);
+}
+
+static void r8a7796_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
+{
+	u32 reg_val;
+
+	reg_val = rcar_gen3_thermal_read(tsc, REG_GEN3_THCTR);
+	reg_val &= ~THCTR_PONM;
+	rcar_gen3_thermal_write(tsc, REG_GEN3_THCTR, reg_val);
+
+	usleep_range(1000, 2000);
+
+	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQCTL, 0x3F);
+	reg_val = rcar_gen3_thermal_read(tsc, REG_GEN3_THCTR);
+	reg_val |= THCTR_THSST;
+	rcar_gen3_thermal_write(tsc, REG_GEN3_THCTR, reg_val);
+}
+
+static const struct rcar_gen3_thermal_data r8a7795_data = {
+	.thermal_init = r8a7795_thermal_init,
+};
+
+static const struct rcar_gen3_thermal_data r8a7796_data = {
+	.thermal_init = r8a7796_thermal_init,
+};
+
+static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
+	{ .compatible = "renesas,r8a7795-thermal", .data = &r8a7795_data},
+	{ .compatible = "renesas,r8a7796-thermal", .data = &r8a7796_data},
+	{},
+};
+MODULE_DEVICE_TABLE(of, rcar_gen3_thermal_dt_ids);
+
+static int rcar_gen3_thermal_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	pm_runtime_put(dev);
+	pm_runtime_disable(dev);
+
+	return 0;
+}
+
+static int rcar_gen3_thermal_probe(struct platform_device *pdev)
+{
+	struct rcar_gen3_thermal_priv *priv;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	struct thermal_zone_device *zone;
+	int ret, i;
+	const struct rcar_gen3_thermal_data *match_data =
+		of_device_get_match_data(dev);
+
+	/* default values if FUSEs are missing */
+	/* TODO: Read values from hardware on supported platforms */
+	int ptat[3] = { 2351, 1509, 435 };
+	int thcode[TSC_MAX_NUM][3] = {
+		{ 3248, 2800, 2221 },
+		{ 3245, 2795, 2216 },
+		{ 3250, 2805, 2237 },
+	};
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
+
+	for (i = 0; i < TSC_MAX_NUM; i++) {
+		struct rcar_gen3_thermal_tsc *tsc;
+
+		tsc = devm_kzalloc(dev, sizeof(*tsc), GFP_KERNEL);
+		if (!tsc) {
+			ret = -ENOMEM;
+			goto error_unregister;
+		}
+
+		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
+		if (!res)
+			break;
+
+		tsc->base = devm_ioremap_resource(dev, res);
+		if (IS_ERR(tsc->base)) {
+			ret = PTR_ERR(tsc->base);
+			goto error_unregister;
+		}
+
+		priv->tscs[i] = tsc;
+		mutex_init(&tsc->lock);
+
+		match_data->thermal_init(tsc);
+		rcar_gen3_thermal_calc_coefs(&tsc->coef, ptat, thcode[i]);
+
+		zone = devm_thermal_zone_of_sensor_register(dev, i, tsc,
+							    &rcar_gen3_tz_of_ops);
+		if (IS_ERR(zone)) {
+			dev_err(dev, "Can't register thermal zone\n");
+			ret = PTR_ERR(zone);
+			goto error_unregister;
+		}
+		tsc->zone = zone;
+	}
+
+	return 0;
+
+error_unregister:
+	rcar_gen3_thermal_remove(pdev);
+
+	return ret;
+}
+
+static struct platform_driver rcar_gen3_thermal_driver = {
+	.driver	= {
+		.name	= "rcar_gen3_thermal",
+		.of_match_table = rcar_gen3_thermal_dt_ids,
+	},
+	.probe		= rcar_gen3_thermal_probe,
+	.remove		= rcar_gen3_thermal_remove,
+};
+module_platform_driver(rcar_gen3_thermal_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("R-Car Gen3 THS thermal sensor driver");
+MODULE_AUTHOR("Wolfram Sang <wsa+renesas@sang-engineering.com>");
-- 
2.10.2
