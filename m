From: Khiem Nguyen <khiem.nguyen.xt-NdPGGYSbX7otW8iMtHSHnA@public.gmane.org>
Subject: [PATCH 2/4] thermal: rcar_gen3_thermal: Add R-Car Gen3 thermal driver
 support
Date: Sun, 19 Jun 2016 10:34:54 +0700
Message-ID: <576612DE.3070204@rvc.renesas.com>
References: <57661211.7010900@rvc.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <57661211.7010900-NdPGGYSbX7otW8iMtHSHnA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Thao Phuong Le. Nguyen" <thao.nguyen.yb-NdPGGYSbX7otW8iMtHSHnA@public.gmane.org>, "Hien Duy. Dang" <hien.dang.eb-NdPGGYSbX7otW8iMtHSHnA@public.gmane.org>, Toru Oishi <toru.oishi.zj-NdPGGYSbX7otW8iMtHSHnA@public.gmane.org>, "Khiem Trong. Nguyen" <khiem.nguyen.xt-NdPGGYSbX7otW8iMtHSHnA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


Signed-off-by: Hien Dang <hien.dang.eb-NdPGGYSbX7otW8iMtHSHnA@public.gmane.org>
Signed-off-by: Thao Nguyen <thao.nguyen.yb-NdPGGYSbX7otW8iMtHSHnA@public.gmane.org>
Signed-off-by: Khiem Nguyen <khiem.nguyen.xt-NdPGGYSbX7otW8iMtHSHnA@public.gmane.org>
---
 drivers/thermal/Kconfig             |   9 +
 drivers/thermal/Makefile            |   1 +
 drivers/thermal/rcar_gen3_thermal.c | 524 ++++++++++++++++++++++++++++++++++++
 3 files changed, 534 insertions(+)
 create mode 100644 drivers/thermal/rcar_gen3_thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 2d702ca..151feb7 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -223,6 +223,15 @@ config RCAR_THERMAL
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
index cded802..3ac9186 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+= qcom-spmi-temp-alarm.o
 obj-$(CONFIG_SPEAR_THERMAL)	+= spear_thermal.o
 obj-$(CONFIG_ROCKCHIP_THERMAL)	+= rockchip_thermal.o
 obj-$(CONFIG_RCAR_THERMAL)	+= rcar_thermal.o
+obj-$(CONFIG_RCAR_GEN3_THERMAL)	+= rcar_gen3_thermal.o
 obj-$(CONFIG_KIRKWOOD_THERMAL)  += kirkwood_thermal.o
 obj-y				+= samsung/
 obj-$(CONFIG_DOVE_THERMAL)  	+= dove_thermal.o
diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
new file mode 100644
index 0000000..a9a372b
--- /dev/null
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -0,0 +1,524 @@
+/*
+ *  R-Car Gen3 THS/CIVM thermal sensor driver
+ *  Based on drivers/thermal/rcar_thermal.c
+ *
+ * Copyright (C) 2016 Renesas Electronics Corporation.
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
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/spinlock.h>
+#include <linux/thermal.h>
+
+/* Register offset */
+#define REG_GEN3_CTSR		0x20
+#define REG_GEN3_THCTR		0x20
+#define REG_GEN3_IRQSTR		0x04
+#define REG_GEN3_IRQMSK		0x08
+#define REG_GEN3_IRQCTL		0x0C
+#define REG_GEN3_IRQEN		0x10
+#define REG_GEN3_IRQTEMP1	0x14
+#define REG_GEN3_IRQTEMP2	0x18
+#define REG_GEN3_IRQTEMP3	0x1C
+#define REG_GEN3_TEMP		0x28
+#define REG_GEN3_THCODE1	0x50
+#define REG_GEN3_THCODE2	0x54
+#define REG_GEN3_THCODE3	0x58
+
+#define PTAT_BASE		0xE6198000
+#define REG_GEN3_PTAT1		0x5C
+#define REG_GEN3_PTAT2		0x60
+#define REG_GEN3_PTAT3		0x64
+#define PTAT_SIZE		REG_GEN3_PTAT3
+
+/* CTSR bit */
+#define PONM            (0x1 << 8)
+#define AOUT            (0x1 << 7)
+#define THBGR           (0x1 << 5)
+#define VMEN            (0x1 << 4)
+#define VMST            (0x1 << 1)
+#define THSST           (0x1 << 0)
+
+/* THCTR bit */
+#define CTCTL		(0x1 << 24)
+#define THCNTSEN(x)	(x << 16)
+
+#define BIT_LEN_12	0x1
+
+#define CTEMP_MASK	0xFFF
+
+#define MCELSIUS(temp)			((temp) * 1000)
+#define TEMP_IRQ_SHIFT(tsc_id)	(0x1 << tsc_id)
+#define TEMPD_IRQ_SHIFT(tsc_id)	(0x1 << (tsc_id + 3))
+#define GEN3_FUSE_MASK	0xFFF
+
+/* Structure for thermal temperature calculation */
+struct equation_coefs {
+	long a1;
+	long b1;
+	long a2;
+	long b2;
+};
+
+struct fuse_factors {
+	int thcode_1;
+	int thcode_2;
+	int thcode_3;
+	int ptat_1;
+	int ptat_2;
+	int ptat_3;
+};
+
+struct rcar_gen3_thermal_priv {
+	void __iomem *base;
+	struct device *dev;
+	struct thermal_zone_device *zone;
+	struct delayed_work work;
+	struct fuse_factors factor;
+	struct equation_coefs coef;
+	spinlock_t lock;
+	int id;
+	int irq;
+	u32 ctemp;
+	const struct rcar_gen3_thermal_data *data;
+};
+
+struct rcar_gen3_thermal_data {
+	int (*thermal_init)(struct rcar_gen3_thermal_priv *priv);
+};
+
+#define rcar_priv_to_dev(priv)		((priv)->dev)
+#define rcar_has_irq_support(priv)	((priv)->irq)
+
+/* Temperature calculation  */
+#define CODETSD(x)		((x) * 1000)
+#define TJ_1 96000L
+#define TJ_3 (-41000L)
+#define PW2(x) ((x)*(x))
+
+static u32 thermal_reg_read(struct rcar_gen3_thermal_priv *priv, u32 reg)
+{
+	return ioread32(priv->base + reg);
+}
+
+static void thermal_reg_write(struct rcar_gen3_thermal_priv *priv,
+				u32 reg, u32 data)
+{
+	iowrite32(data, priv->base + reg);
+}
+
+static int _round_temp(int temp)
+{
+	int tmp1, tmp2;
+	int result = 0;
+
+	tmp1 = abs(temp) % 1000;
+	tmp2 = abs(temp) / 1000;
+
+	if (tmp1 < 250)
+		result = CODETSD(tmp2);
+	else if (tmp1 < 750 && tmp1 >= 250)
+		result = CODETSD(tmp2) + 500;
+	else
+		result = CODETSD(tmp2) + 1000;
+
+	return ((temp < 0) ? (result * (-1)) : result);
+}
+
+static int _read_fuse_factor(struct rcar_gen3_thermal_priv *priv)
+{
+	/*
+	 * FIXME: The value should be read from some FUSE registers.
+	 * For available SoC, these registers have not been supported yet.
+	 * The pre-defined value will be applied for now.
+	 */
+	priv->factor.ptat_1 = 2351;
+	priv->factor.ptat_2 = 1509;
+	priv->factor.ptat_3 = 435;
+	switch (priv->id) {
+	case 0:
+		priv->factor.thcode_1 = 3248;
+		priv->factor.thcode_2 = 2800;
+		priv->factor.thcode_3 = 2221;
+		break;
+	case 1:
+		priv->factor.thcode_1 = 3245;
+		priv->factor.thcode_2 = 2795;
+		priv->factor.thcode_3 = 2216;
+		break;
+	case 2:
+		priv->factor.thcode_1 = 3250;
+		priv->factor.thcode_2 = 2805;
+		priv->factor.thcode_3 = 2237;
+		break;
+	}
+
+	return 0;
+}
+
+static void _linear_coefficient_calculation(struct rcar_gen3_thermal_priv *priv)
+{
+	int tj_2 = 0;
+	long a1, b1;
+	long a2, b2;
+	long a1_num, a1_den;
+	long a2_num, a2_den;
+
+	tj_2 = (CODETSD((priv->factor.ptat_2 - priv->factor.ptat_3) * 137)
+		/ (priv->factor.ptat_1 - priv->factor.ptat_3)) - CODETSD(41);
+
+	/*
+	 * The following code is to calculate coefficients for linear equation.
+	 */
+	/* Coefficient a1 and b1 */
+	a1_num = CODETSD(priv->factor.thcode_2 - priv->factor.thcode_3);
+	a1_den = tj_2 - TJ_3;
+	a1 = (10000 * a1_num) / a1_den;
+	b1 = (10000 * priv->factor.thcode_3) - ((a1 * TJ_3) / 1000);
+
+	/* Coefficient a2 and b2 */
+	a2_num = CODETSD(priv->factor.thcode_2 - priv->factor.thcode_1);
+	a2_den = tj_2 - TJ_1;
+	a2 = (10000 * a2_num) / a2_den;
+	b2 = (10000 * priv->factor.thcode_1) - ((a2 * TJ_1) / 1000);
+
+	priv->coef.a1 = DIV_ROUND_CLOSEST(a1, 10);
+	priv->coef.b1 = DIV_ROUND_CLOSEST(b1, 10);
+	priv->coef.a2 = DIV_ROUND_CLOSEST(a2, 10);
+	priv->coef.b2 = DIV_ROUND_CLOSEST(b2, 10);
+}
+
+int _linear_temp_converter(struct equation_coefs coef,
+					int temp_code)
+{
+	int temp, temp1, temp2;
+
+	temp1 = MCELSIUS((CODETSD(temp_code) - coef.b1)) / coef.a1;
+	temp2 = MCELSIUS((CODETSD(temp_code) - coef.b2)) / coef.a2;
+	temp = (temp1 + temp2) / 2;
+
+	return _round_temp(temp);
+}
+
+/*
+ *		Zone device functions
+ */
+static int rcar_gen3_thermal_update_temp(struct rcar_gen3_thermal_priv *priv)
+{
+	u32 ctemp;
+	int i;
+	unsigned long flags;
+	u32 reg = REG_GEN3_IRQTEMP1 + (priv->id * 4);
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	for (i = 0; i < 256; i++) {
+		ctemp = thermal_reg_read(priv, REG_GEN3_TEMP) & CTEMP_MASK;
+		if (rcar_has_irq_support(priv)) {
+			thermal_reg_write(priv, reg, ctemp);
+			if (thermal_reg_read(priv, REG_GEN3_IRQSTR) != 0)
+				break;
+		} else
+			break;
+
+		udelay(150);
+	}
+
+	priv->ctemp = ctemp;
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static int rcar_gen3_thermal_get_temp(void *devdata, int *temp)
+{
+	struct rcar_gen3_thermal_priv *priv = devdata;
+	int ctemp;
+	unsigned long flags;
+
+	rcar_gen3_thermal_update_temp(priv);
+
+	spin_lock_irqsave(&priv->lock, flags);
+	ctemp = _linear_temp_converter(priv->coef, priv->ctemp);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	if ((ctemp < MCELSIUS(-40)) || (ctemp > MCELSIUS(125))) {
+		struct device *dev = rcar_priv_to_dev(priv);
+
+		dev_dbg(dev, "Temperature is not measured correctly!\n");
+		return -EIO;
+	}
+
+	*temp = ctemp;
+
+	return 0;
+}
+
+static int r8a7795_thermal_init(struct rcar_gen3_thermal_priv *priv)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	thermal_reg_write(priv, REG_GEN3_CTSR,  THBGR);
+	thermal_reg_write(priv, REG_GEN3_CTSR,  0x0);
+
+	udelay(1000);
+
+	thermal_reg_write(priv, REG_GEN3_CTSR, PONM);
+	thermal_reg_write(priv, REG_GEN3_IRQCTL, 0x3F);
+	thermal_reg_write(priv, REG_GEN3_IRQEN, TEMP_IRQ_SHIFT(priv->id) |
+						TEMPD_IRQ_SHIFT(priv->id));
+	thermal_reg_write(priv, REG_GEN3_CTSR,
+			PONM | AOUT | THBGR | VMEN);
+	udelay(100);
+
+	thermal_reg_write(priv, REG_GEN3_CTSR,
+			PONM | AOUT | THBGR | VMEN | VMST | THSST);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static int r8a7796_thermal_init(struct rcar_gen3_thermal_priv *priv)
+{
+	unsigned long flags;
+	unsigned long reg_val;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	thermal_reg_write(priv, REG_GEN3_THCTR,  0x0);
+	udelay(1000);
+	thermal_reg_write(priv, REG_GEN3_IRQCTL, 0x3F);
+	thermal_reg_write(priv, REG_GEN3_IRQEN, TEMP_IRQ_SHIFT(priv->id) |
+						TEMPD_IRQ_SHIFT(priv->id));
+	thermal_reg_write(priv, REG_GEN3_THCTR,
+						CTCTL | THCNTSEN(BIT_LEN_12));
+	reg_val = thermal_reg_read(priv, REG_GEN3_THCTR);
+	reg_val &= ~CTCTL;
+	reg_val |= THSST;
+	thermal_reg_write(priv, REG_GEN3_THCTR, reg_val);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+/*
+ *		Interrupt
+ */
+#define rcar_gen3_thermal_irq_enable(p)		_thermal_irq_ctrl(p, 1)
+#define rcar_gen3_thermal_irq_disable(p)	_thermal_irq_ctrl(p, 0)
+static void _thermal_irq_ctrl(struct rcar_gen3_thermal_priv *priv, int enable)
+{
+	unsigned long flags;
+
+	if (!rcar_has_irq_support(priv))
+		return;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	thermal_reg_write(priv, REG_GEN3_IRQMSK,
+		enable ? (TEMP_IRQ_SHIFT(priv->id) |
+			TEMPD_IRQ_SHIFT(priv->id)) : 0);
+	spin_unlock_irqrestore(&priv->lock, flags);
+}
+
+static void rcar_gen3_thermal_work(struct work_struct *work)
+{
+	struct rcar_gen3_thermal_priv *priv;
+
+	priv = container_of(work, struct rcar_gen3_thermal_priv, work.work);
+
+	thermal_zone_device_update(priv->zone);
+
+	rcar_gen3_thermal_irq_enable(priv);
+}
+
+static irqreturn_t rcar_gen3_thermal_irq(int irq, void *data)
+{
+	struct rcar_gen3_thermal_priv *priv = data;
+	unsigned long flags;
+	int status;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	status = thermal_reg_read(priv, REG_GEN3_IRQSTR);
+	thermal_reg_write(priv, REG_GEN3_IRQSTR, 0);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	if ((status & TEMP_IRQ_SHIFT(priv->id)) ||
+		(status & TEMPD_IRQ_SHIFT(priv->id))) {
+		rcar_gen3_thermal_irq_disable(priv);
+		schedule_delayed_work(&priv->work,
+				      msecs_to_jiffies(300));
+	}
+
+	return IRQ_HANDLED;
+}
+
+static struct thermal_zone_of_device_ops rcar_gen3_tz_of_ops = {
+	.get_temp	= rcar_gen3_thermal_get_temp,
+};
+
+/*
+ *		Platform functions
+ */
+static int rcar_gen3_thermal_remove(struct platform_device *pdev)
+{
+	struct rcar_gen3_thermal_priv *priv = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+
+	rcar_gen3_thermal_irq_disable(priv);
+	thermal_zone_of_sensor_unregister(dev, priv->zone);
+
+	pm_runtime_put(dev);
+	pm_runtime_disable(dev);
+
+	return 0;
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
+	{ .compatible = "renesas,thermal-r8a7795", .data = &r8a7795_data},
+	{ .compatible = "renesas,thermal-r8a7796", .data = &r8a7796_data},
+	{ .compatible = "renesas,rcar-gen3-thermal", .data = &r8a7796_data},
+	{},
+};
+MODULE_DEVICE_TABLE(of, rcar_gen3_thermal_dt_ids);
+
+static int rcar_gen3_thermal_probe(struct platform_device *pdev)
+{
+	struct rcar_gen3_thermal_priv *priv;
+	struct device *dev = &pdev->dev;
+	struct resource *res, *irq;
+	int ret = -ENODEV;
+	int idle;
+	struct device_node *tz_nd, *tmp_nd;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+
+	priv->dev = dev;
+
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
+
+	priv->data = of_device_get_match_data(dev);
+	if (!priv->data)
+		goto error_unregister;
+
+	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	priv->irq = 0;
+	if (irq) {
+		priv->irq = 1;
+		for_each_node_with_property(tz_nd, "polling-delay") {
+			tmp_nd = of_parse_phandle(tz_nd,
+					"thermal-sensors", 0);
+			if (tmp_nd && !strcmp(tmp_nd->full_name,
+					dev->of_node->full_name)) {
+				of_property_read_u32(tz_nd, "polling-delay",
+					&idle);
+				(idle > 0) ? (priv->irq = 0) :
+						(priv->irq = 1);
+				break;
+			}
+		}
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		goto error_unregister;
+
+	priv->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->base)) {
+		ret = PTR_ERR(priv->base);
+		goto error_unregister;
+	}
+
+	spin_lock_init(&priv->lock);
+	INIT_DELAYED_WORK(&priv->work, rcar_gen3_thermal_work);
+
+	priv->id = of_alias_get_id(dev->of_node, "tsc");
+
+	priv->zone = devm_thermal_zone_of_sensor_register(dev, 0, priv,
+				&rcar_gen3_tz_of_ops);
+
+	if (IS_ERR(priv->zone)) {
+		dev_err(dev, "Can't register thermal zone\n");
+		ret = PTR_ERR(priv->zone);
+		priv->zone = NULL;
+		goto error_unregister;
+	}
+
+	priv->data->thermal_init(priv);
+	ret = _read_fuse_factor(priv);
+	if (ret)
+		goto error_unregister;
+	_linear_coefficient_calculation(priv);
+	ret = rcar_gen3_thermal_update_temp(priv);
+
+	if (ret < 0)
+		goto error_unregister;
+
+
+	rcar_gen3_thermal_irq_enable(priv);
+
+	/* Interrupt */
+	if (irq) {
+		ret = devm_request_irq(dev, irq->start,
+					rcar_gen3_thermal_irq, 0,
+				       dev_name(dev), priv);
+		if (ret) {
+			dev_err(dev, "IRQ request failed\n ");
+			goto error_unregister;
+		}
+	}
+
+	dev_info(dev, "probed\n");
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
+MODULE_DESCRIPTION("R-Car Gen3 THS/CIVM thermal sensor driver");
+MODULE_AUTHOR("Khiem Nguyen <khiem.nguyen.xt-NdPGGYSbX7otW8iMtHSHnA@public.gmane.org>");
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
