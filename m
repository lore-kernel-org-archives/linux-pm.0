From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH 2/9] thermal: qcom: tsens-8916: Add support for 8916 family of SoCs
Date: Wed,  8 Jul 2015 15:17:11 +0530
Message-ID: <1436348838-22671-3-git-send-email-rnayak@codeaurora.org>
References: <1436348838-22671-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:54870 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933709AbbGHJsY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2015 05:48:24 -0400
In-Reply-To: <1436348838-22671-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: sboyd@codeaurora.org, srinivas.kandagatla@linaro.org, nrajan@codeaurora.org, lina.iyer@linaro.org, Rajendra Nayak <rnayak@codeaurora.org>

Add support to calibrate sensors on 8916 family and also add common
functions to read temperature from sensors (This can be reused on
other SoCs having similar TSENS device)
The calibration data is read from eeprom using the generic eeprom
framework apis.

Based on the original code by Siddartha Mohanadoss and Stephen Boyd.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/thermal/qcom/Makefile       |   2 +-
 drivers/thermal/qcom/tsens-8916.c   | 107 ++++++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens-common.c | 128 ++++++++++++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens.h        |  11 ++++
 4 files changed, 247 insertions(+), 1 deletion(-)
 create mode 100644 drivers/thermal/qcom/tsens-8916.c
 create mode 100644 drivers/thermal/qcom/tsens-common.c

diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
index 401069b..05c98e4 100644
--- a/drivers/thermal/qcom/Makefile
+++ b/drivers/thermal/qcom/Makefile
@@ -1,2 +1,2 @@
 obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
-qcom_tsens-y			+= tsens.o
+qcom_tsens-y			+= tsens.o tsens-common.o tsens-8916.o
diff --git a/drivers/thermal/qcom/tsens-8916.c b/drivers/thermal/qcom/tsens-8916.c
new file mode 100644
index 0000000..a69aea3
--- /dev/null
+++ b/drivers/thermal/qcom/tsens-8916.c
@@ -0,0 +1,107 @@
+/*
+ * Copyright (c) 2015, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/platform_device.h>
+#include "tsens.h"
+
+/* eeprom layout data for 8916 */
+#define BASE0_MASK	0x0000007f
+#define BASE1_MASK	0xfe000000
+#define BASE0_SHIFT	0
+#define BASE1_SHIFT	25
+
+#define S0_P1_MASK	0x00000f80
+#define S1_P1_MASK	0x003e0000
+#define S2_P1_MASK	0xf8000000
+#define S3_P1_MASK	0x000003e0
+#define S4_P1_MASK	0x000f8000
+
+#define S0_P2_MASK	0x0001f000
+#define S1_P2_MASK	0x07c00000
+#define S2_P2_MASK	0x0000001f
+#define S3_P2_MASK	0x00007c00
+#define S4_P2_MASK	0x01f00000
+
+#define S0_P1_SHIFT	7
+#define S1_P1_SHIFT	17
+#define S2_P1_SHIFT	27
+#define S3_P1_SHIFT	5
+#define S4_P1_SHIFT	15
+
+#define S0_P2_SHIFT	12
+#define S1_P2_SHIFT	22
+#define S2_P2_SHIFT	0
+#define S3_P2_SHIFT	10
+#define S4_P2_SHIFT	20
+
+#define CAL_SEL_MASK	0xe0000000
+#define CAL_SEL_SHIFT	29
+
+static int calibrate_8916(struct tsens_device *tmdev)
+{
+	int base0 = 0, base1 = 0, i;
+	u32 p1[5], p2[5];
+	int mode = 0;
+	u32 *qfprom_cdata, *qfprom_csel;
+
+	qfprom_cdata = (u32 *)qfprom_read(tmdev->dev, "calib");
+	if (IS_ERR(qfprom_cdata))
+		return PTR_ERR(qfprom_cdata);
+
+	qfprom_csel = (u32 *)qfprom_read(tmdev->dev, "calib_sel");
+	if (IS_ERR(qfprom_csel))
+		return PTR_ERR(qfprom_csel);
+
+	mode = (qfprom_csel[0] & CAL_SEL_MASK) >> CAL_SEL_SHIFT;
+	dev_dbg(tmdev->dev, "calibration mode is %d\n", mode);
+
+	switch (mode) {
+	case TWO_PT_CALIB:
+		base1 = (qfprom_cdata[1] & BASE1_MASK) >> BASE1_SHIFT;
+		p2[0] = (qfprom_cdata[0] & S0_P2_MASK) >> S0_P2_SHIFT;
+		p2[1] = (qfprom_cdata[0] & S1_P2_MASK) >> S1_P2_SHIFT;
+		p2[2] = (qfprom_cdata[1] & S2_P2_MASK) >> S2_P2_SHIFT;
+		p2[3] = (qfprom_cdata[1] & S3_P2_MASK) >> S3_P2_SHIFT;
+		p2[4] = (qfprom_cdata[1] & S4_P2_MASK) >> S4_P2_SHIFT;
+		for (i = 0; i < tmdev->num_sensors; i++)
+			p2[i] = ((base1 + p2[i]) << 3);
+		/* Fall through */
+	case ONE_PT_CALIB2:
+		base0 = (qfprom_cdata[0] & BASE0_MASK);
+		p1[0] = (qfprom_cdata[0] & S0_P1_MASK) >> S0_P1_SHIFT;
+		p1[1] = (qfprom_cdata[0] & S1_P1_MASK) >> S1_P1_SHIFT;
+		p1[2] = (qfprom_cdata[0] & S2_P1_MASK) >> S2_P1_SHIFT;
+		p1[3] = (qfprom_cdata[1] & S3_P1_MASK) >> S3_P1_SHIFT;
+		p1[4] = (qfprom_cdata[1] & S4_P1_MASK) >> S4_P1_SHIFT;
+		for (i = 0; i < tmdev->num_sensors; i++)
+			p1[i] = (((base0) + p1[i]) << 3);
+		break;
+	default:
+		for (i = 0; i < tmdev->num_sensors; i++) {
+			p1[i] = 500;
+			p2[i] = 780;
+		}
+		break;
+	}
+
+	compute_intercept_slope(tmdev, p1, p2, mode);
+
+	return 0;
+}
+
+const struct tsens_ops ops_8916 = {
+	.init		= init_common,
+	.calibrate	= calibrate_8916,
+	.get_temp	= get_temp_common,
+};
diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
new file mode 100644
index 0000000..5fcabd1
--- /dev/null
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -0,0 +1,128 @@
+/*
+ * Copyright (c) 2015, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/platform_device.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/regmap.h>
+#include "tsens.h"
+
+#define S0_ST_ADDR		0x1030
+#define SN_ADDR_OFFSET		0x4
+#define SN_ST_TEMP_MASK		0x3ff
+#define CAL_DEGC_PT1		30
+#define CAL_DEGC_PT2		120
+#define SLOPE_FACTOR		1000
+
+char *qfprom_read(struct device *dev, const char *cname)
+{
+	struct nvmem_cell *cell;
+	ssize_t data;
+	char *ret;
+
+	cell = nvmem_cell_get(dev, cname);
+	if (IS_ERR(cell))
+		return ERR_CAST(cell);
+
+	ret = nvmem_cell_read(cell, &data);
+	nvmem_cell_put(cell);
+	return ret;
+}
+
+void compute_intercept_slope(struct tsens_device *tmdev, u32 *p1,
+			     u32 *p2, u32 mode)
+{
+	int i;
+	int num, den;
+
+	for (i = 0; i < tmdev->num_sensors; i++) {
+		dev_dbg(tmdev->dev,
+			"sensor%d - data_point1:%#x data_point2:%#x\n",
+			i, p1[i], p2[i]);
+
+		if (mode == TWO_PT_CALIB) {
+			/* slope (m) = adc_code2 - adc_code1 (y2 - y1)/
+				temp_120_degc - temp_30_degc (x2 - x1) */
+			num = p2[i] - p1[i];
+			num *= SLOPE_FACTOR;
+			den = CAL_DEGC_PT2 - CAL_DEGC_PT1;
+			tmdev->sensor[i].slope = num / den;
+		}
+
+		tmdev->sensor[i].offset = (p1[i] * SLOPE_FACTOR) -
+				(CAL_DEGC_PT1 *
+				tmdev->sensor[i].slope);
+		dev_dbg(tmdev->dev, "offset:%d\n", tmdev->sensor[i].offset);
+	}
+}
+
+static inline int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
+{
+	int degc, num, den;
+
+	num = (adc_code * SLOPE_FACTOR) - s->offset;
+	den = s->slope;
+
+	if (num > 0)
+		degc = num + (den / 2);
+	else if (num < 0)
+		degc = num - (den / 2);
+	else
+		degc = num;
+
+	degc /= den;
+
+	return degc;
+}
+
+int get_temp_common(struct tsens_device *tmdev, int id, long *temp)
+{
+	struct tsens_sensor *s = &tmdev->sensor[id];
+	u32 code;
+	unsigned int sensor_addr;
+	int last_temp = 0, ret;
+
+	sensor_addr = S0_ST_ADDR + s->hw_id * SN_ADDR_OFFSET;
+	ret = regmap_read(tmdev->map, sensor_addr, &code);
+	if (ret)
+		return ret;
+	last_temp = code & SN_ST_TEMP_MASK;
+
+	*temp = code_to_degc(last_temp, s) * 1000;
+
+	return 0;
+}
+
+static const struct regmap_config tsens_config = {
+	.reg_bits	= 32,
+	.val_bits	= 32,
+	.reg_stride	= 4,
+};
+
+int init_common(struct tsens_device *tmdev)
+{
+	void __iomem *base;
+
+	base = of_iomap(tmdev->dev->of_node, 0);
+	if (IS_ERR(base))
+		return -EINVAL;
+
+	tmdev->map = devm_regmap_init_mmio(tmdev->dev, base, &tsens_config);
+	if (!tmdev->map)
+		return -ENODEV;
+
+	return 0;
+}
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 9b274e1..81c5efb 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -13,6 +13,10 @@
 #ifndef __QCOM_TSENS_H__
 #define __QCOM_TSENS_H__
 
+#define ONE_PT_CALIB		0x1
+#define ONE_PT_CALIB2		0x2
+#define TWO_PT_CALIB		0x3
+
 struct tsens_device;
 
 struct tsens_sensor {
@@ -55,4 +59,11 @@ struct tsens_device {
 	struct tsens_sensor		sensor[0];
 };
 
+char *qfprom_read(struct device *, const char *);
+void compute_intercept_slope(struct tsens_device *, u32 *, u32 *, u32);
+int init_common(struct tsens_device *);
+int get_temp_common(struct tsens_device *, int, long *);
+
+extern const struct tsens_ops ops_8916;
+
 #endif /* __QCOM_TSENS_H__ */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

