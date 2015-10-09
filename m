From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v4 4/8] thermal: qcom: tsens-8960: Add support for 8960 family of SoCs
Date: Fri,  9 Oct 2015 15:11:06 +0530
Message-ID: <1444383670-32693-5-git-send-email-rnayak@codeaurora.org>
References: <1444383670-32693-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:42915 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933432AbbJIJlo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 Oct 2015 05:41:44 -0400
In-Reply-To: <1444383670-32693-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com, agross@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rui.zhang@intel.com, sboyd@codeaurora.org, srinivas.kandagatla@linaro.org, nrajan@codeaurora.org, lina.iyer@linaro.org, punit.agrawal@arm.com, Rajendra Nayak <rnayak@codeaurora.org>

8960 family of SoCs have the TSENS device as part of GCC, hence
the driver probes the virtual child device created by GCC and
uses the parent to extract all DT properties and reuses the GCC
regmap.

Also GCC/TSENS are part of a  domain thats not always ON.
Hence add .suspend and .resume hooks to save and restore some of
the inited register context.

Also 8960 family have some of the TSENS init sequence thats
required to be done by the HLOS driver (some later versions of TSENS
do not export these registers to non-secure world, and hence need
these initializations to be done by secure bootloaders)

8660 from the same family has just one sensor and hence some register
offset/layout differences which need special handling in the driver.

Based on the original code from Siddartha Mohanadoss, Stephen Boyd and
Narendran Rajan.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/thermal/qcom/Makefile     |   2 +-
 drivers/thermal/qcom/tsens-8960.c | 291 ++++++++++++++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens.c      |  13 +-
 drivers/thermal/qcom/tsens.h      |   2 +-
 4 files changed, 302 insertions(+), 6 deletions(-)
 create mode 100644 drivers/thermal/qcom/tsens-8960.c

diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
index a471100..f3cefd1 100644
--- a/drivers/thermal/qcom/Makefile
+++ b/drivers/thermal/qcom/Makefile
@@ -1,2 +1,2 @@
 obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
-qcom_tsens-y			+= tsens.o tsens-common.o tsens-8916.o tsens-8974.o
+qcom_tsens-y			+= tsens.o tsens-common.o tsens-8916.o tsens-8974.o tsens-8960.o
diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
new file mode 100644
index 0000000..00f45e7
--- /dev/null
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -0,0 +1,291 @@
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
+#include <linux/delay.h>
+#include <linux/bitops.h>
+#include <linux/regmap.h>
+#include "tsens.h"
+
+#define CAL_MDEGC		30000
+
+#define CONFIG_ADDR		0x3640
+#define CONFIG_ADDR_8660	0x3620
+/* CONFIG_ADDR bitmasks */
+#define CONFIG			0x9b
+#define CONFIG_MASK		0xf
+#define CONFIG_8660		1
+#define CONFIG_SHIFT_8660	28
+#define CONFIG_MASK_8660	(3 << CONFIG_SHIFT_8660)
+
+#define STATUS_CNTL_ADDR_8064	0x3660
+#define CNTL_ADDR		0x3620
+/* CNTL_ADDR bitmasks */
+#define EN			BIT(0)
+#define SW_RST			BIT(1)
+#define SENSOR0_EN		BIT(3)
+#define SLP_CLK_ENA		BIT(26)
+#define SLP_CLK_ENA_8660	BIT(24)
+#define MEASURE_PERIOD		1
+#define SENSOR0_SHIFT		3
+
+/* INT_STATUS_ADDR bitmasks */
+#define MIN_STATUS_MASK		BIT(0)
+#define LOWER_STATUS_CLR	BIT(1)
+#define UPPER_STATUS_CLR	BIT(2)
+#define MAX_STATUS_MASK		BIT(3)
+
+#define THRESHOLD_ADDR		0x3624
+/* THRESHOLD_ADDR bitmasks */
+#define THRESHOLD_MAX_LIMIT_SHIFT	24
+#define THRESHOLD_MIN_LIMIT_SHIFT	16
+#define THRESHOLD_UPPER_LIMIT_SHIFT	8
+#define THRESHOLD_LOWER_LIMIT_SHIFT	0
+
+/* Initial temperature threshold values */
+#define LOWER_LIMIT_TH		0x50
+#define UPPER_LIMIT_TH		0xdf
+#define MIN_LIMIT_TH		0x0
+#define MAX_LIMIT_TH		0xff
+
+#define S0_STATUS_ADDR		0x3628
+#define INT_STATUS_ADDR		0x363c
+#define TRDY_MASK		BIT(7)
+
+static int suspend_8960(struct tsens_device *tmdev)
+{
+	int ret;
+	unsigned int mask;
+	struct regmap *map = tmdev->map;
+
+	ret = regmap_read(map, THRESHOLD_ADDR, &tmdev->ctx.threshold);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(map, CNTL_ADDR, &tmdev->ctx.control);
+	if (ret)
+		return ret;
+
+	if (tmdev->num_sensors > 1)
+		mask = SLP_CLK_ENA | EN;
+	else
+		mask = SLP_CLK_ENA_8660 | EN;
+
+	ret = regmap_update_bits(map, CNTL_ADDR, mask, 0);
+	if (ret)
+		return ret;
+
+	tmdev->trdy = false;
+
+	return 0;
+}
+
+static int resume_8960(struct tsens_device *tmdev)
+{
+	int ret;
+	unsigned long reg_cntl;
+	struct regmap *map = tmdev->map;
+
+	ret = regmap_update_bits(map, CNTL_ADDR, SW_RST, SW_RST);
+	if (ret)
+		return ret;
+
+	/*
+	 * Separate CONFIG restore is not needed only for 8660 as
+	 * config is part of CTRL Addr and its restored as such
+	 */
+	if (tmdev->num_sensors > 1) {
+		ret = regmap_update_bits(map, CONFIG_ADDR, CONFIG_MASK, CONFIG);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_write(map, THRESHOLD_ADDR, tmdev->ctx.threshold);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(map, CNTL_ADDR, tmdev->ctx.control);
+	if (ret)
+		return ret;
+
+	reg_cntl = tmdev->ctx.control;
+	reg_cntl >>= SENSOR0_SHIFT;
+
+	return 0;
+}
+
+static int enable_8960(struct tsens_device *tmdev, int id)
+{
+	int ret;
+	u32 reg, mask;
+
+	ret = regmap_read(tmdev->map, CNTL_ADDR, &reg);
+	if (ret)
+		return ret;
+
+	mask = BIT(id + SENSOR0_SHIFT);
+	ret = regmap_write(tmdev->map, CNTL_ADDR, reg | SW_RST);
+	if (ret)
+		return ret;
+
+	if (tmdev->num_sensors > 1)
+		reg |= mask | SLP_CLK_ENA | EN;
+	else
+		reg |= mask | SLP_CLK_ENA_8660 | EN;
+
+	tmdev->trdy = false;
+	ret = regmap_write(tmdev->map, CNTL_ADDR, reg);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void disable_8960(struct tsens_device *tmdev)
+{
+	int ret;
+	u32 reg_cntl;
+	u32 mask;
+
+	mask = GENMASK(tmdev->num_sensors - 1, 0);
+	mask <<= SENSOR0_SHIFT;
+	mask |= EN;
+
+	ret = regmap_read(tmdev->map, CNTL_ADDR, &reg_cntl);
+	if (ret)
+		return;
+
+	reg_cntl &= ~mask;
+
+	if (tmdev->num_sensors > 1)
+		reg_cntl &= ~SLP_CLK_ENA;
+	else
+		reg_cntl &= ~SLP_CLK_ENA_8660;
+
+	regmap_write(tmdev->map, CNTL_ADDR, reg_cntl);
+}
+
+static int init_8960(struct tsens_device *tmdev)
+{
+	int ret, i;
+	u32 reg_cntl;
+
+	tmdev->map = dev_get_regmap(tmdev->dev, NULL);
+	if (!tmdev->map)
+		return -ENODEV;
+
+	/*
+	 * The status registers for each sensor are discontiguous
+	 * because some SoCs have 5 sensors while others have more
+	 * but the control registers stay in the same place, i.e
+	 * directly after the first 5 status registers.
+	 */
+	for (i = 0; i < tmdev->num_sensors; i++) {
+		if (i >= 5)
+			tmdev->sensor[i].status = S0_STATUS_ADDR + 40;
+		tmdev->sensor[i].status += i * 4;
+	}
+
+	reg_cntl = SW_RST;
+	ret = regmap_update_bits(tmdev->map, CNTL_ADDR, SW_RST, reg_cntl);
+	if (ret)
+		return ret;
+
+	if (tmdev->num_sensors > 1) {
+		reg_cntl |= SLP_CLK_ENA | (MEASURE_PERIOD << 18);
+		reg_cntl &= ~SW_RST;
+		ret = regmap_update_bits(tmdev->map, CONFIG_ADDR,
+					 CONFIG_MASK, CONFIG);
+	} else {
+		reg_cntl |= SLP_CLK_ENA_8660 | (MEASURE_PERIOD << 16);
+		reg_cntl &= ~CONFIG_MASK_8660;
+		reg_cntl |= CONFIG_8660 << CONFIG_SHIFT_8660;
+	}
+
+	reg_cntl |= GENMASK(tmdev->num_sensors - 1, 0) << SENSOR0_SHIFT;
+	ret = regmap_write(tmdev->map, CNTL_ADDR, reg_cntl);
+	if (ret)
+		return ret;
+
+	reg_cntl |= EN;
+	ret = regmap_write(tmdev->map, CNTL_ADDR, reg_cntl);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int calibrate_8960(struct tsens_device *tmdev)
+{
+	int i;
+	char *data;
+
+	ssize_t num_read = tmdev->num_sensors;
+	struct tsens_sensor *s = tmdev->sensor;
+
+	data = qfprom_read(tmdev->dev, "calib");
+	if (IS_ERR(data))
+		data = qfprom_read(tmdev->dev, "calib_backup");
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	for (i = 0; i < num_read; i++, s++)
+		s->offset = CAL_MDEGC - s->slope * data[i];
+
+	return 0;
+}
+
+/* Temperature on y axis and ADC-code on x-axis */
+static inline int code_to_mdegC(u32 adc_code, const struct tsens_sensor *s)
+{
+	return adc_code * s->slope + s->offset;
+}
+
+static int get_temp_8960(struct tsens_device *tmdev, int id, int *temp)
+{
+	int ret;
+	u32 code, trdy;
+	const struct tsens_sensor *s = &tmdev->sensor[id];
+
+	if (!tmdev->trdy) {
+		ret = regmap_read(tmdev->map, INT_STATUS_ADDR, &trdy);
+		if (ret)
+			return ret;
+		while (!(trdy & TRDY_MASK)) {
+			usleep_range(1000, 1100);
+			regmap_read(tmdev->map, INT_STATUS_ADDR, &trdy);
+		}
+		tmdev->trdy = true;
+	}
+
+	ret = regmap_read(tmdev->map, s->status, &code);
+	if (ret)
+		return ret;
+
+	*temp = code_to_mdegC(code, s);
+
+	dev_dbg(tmdev->dev, "Sensor%d temp is: %d", id, *temp);
+
+	return 0;
+}
+
+const struct tsens_ops ops_8960 = {
+	.init		= init_8960,
+	.calibrate	= calibrate_8960,
+	.get_temp	= get_temp_8960,
+	.enable		= enable_8960,
+	.disable	= disable_8960,
+	.suspend	= suspend_8960,
+	.resume		= resume_8960,
+};
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 06ed0c6..d640e8f 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -119,7 +119,11 @@ static int tsens_probe(struct platform_device *pdev)
 	struct tsens_device *tmdev;
 	const struct of_device_id *id;
 
-	dev = &pdev->dev;
+	if (pdev->dev.of_node)
+		dev = &pdev->dev;
+	else
+		dev = pdev->dev.parent;
+
 	np = dev->of_node;
 
 	num = of_property_count_u32_elems(np, "qcom,tsens-slopes");
@@ -141,10 +145,11 @@ static int tsens_probe(struct platform_device *pdev)
 					   &s->slope);
 
 	id = of_match_node(tsens_table, np);
-	if (!id)
-		return -ENODEV;
+	if (id)
+		tmdev->ops = id->data;
+	else
+		tmdev->ops = &ops_8960;
 
-	tmdev->ops = id->data;
 	if (!tmdev->ops || !tmdev->ops->init || !tmdev->ops->calibrate ||
 	    !tmdev->ops->get_temp)
 		return -EINVAL;
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 00183db..10e2e84 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -64,6 +64,6 @@ void compute_intercept_slope(struct tsens_device *, u32 *, u32 *, u32);
 int init_common(struct tsens_device *);
 int get_temp_common(struct tsens_device *, int, int *);
 
-extern const struct tsens_ops ops_8916, ops_8974;
+extern const struct tsens_ops ops_8960, ops_8916, ops_8974;
 
 #endif /* __QCOM_TSENS_H__ */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

