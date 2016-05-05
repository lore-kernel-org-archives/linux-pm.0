From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v6 06/11] thermal: qcom: tsens-8996: Add support for 8996 family of SoCs
Date: Thu,  5 May 2016 14:21:44 +0530
Message-ID: <1462438309-11196-7-git-send-email-rnayak@codeaurora.org>
References: <1462438309-11196-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:36970 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756285AbcEEIwu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 May 2016 04:52:50 -0400
In-Reply-To: <1462438309-11196-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com, andy.gross@linaro.org
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rui.zhang@intel.com, sboyd@codeaurora.org, nrajan@codeaurora.org, lina.iyer@linaro.org, punit.agrawal@arm.com, Rajendra Nayak <rnayak@codeaurora.org>

The TSENS controller in 8996 family of SoCs is capable of converting the
ADC code outputs to real temperature values (in decidegree Celsius).
It can also be programmed to provide raw ADC code, but the secure software
on 8996 programs it to provide real temperatures and also does the needed
calibrations.

We check the valid bit to ensure valid data is read by the AHB master.
And the spec recommends the below algorithm to read data 3 consecutive
times, which takes care of the worst case delay taken to propagate the
updated data to the register.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/thermal/qcom/Makefile     |  2 +-
 drivers/thermal/qcom/tsens-8996.c | 84 +++++++++++++++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens.c      |  3 ++
 drivers/thermal/qcom/tsens.h      |  2 +-
 4 files changed, 89 insertions(+), 2 deletions(-)
 create mode 100644 drivers/thermal/qcom/tsens-8996.c

diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
index f3cefd1..2cc2193 100644
--- a/drivers/thermal/qcom/Makefile
+++ b/drivers/thermal/qcom/Makefile
@@ -1,2 +1,2 @@
 obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
-qcom_tsens-y			+= tsens.o tsens-common.o tsens-8916.o tsens-8974.o tsens-8960.o
+qcom_tsens-y			+= tsens.o tsens-common.o tsens-8916.o tsens-8974.o tsens-8960.o tsens-8996.o
diff --git a/drivers/thermal/qcom/tsens-8996.c b/drivers/thermal/qcom/tsens-8996.c
new file mode 100644
index 0000000..e2e1274
--- /dev/null
+++ b/drivers/thermal/qcom/tsens-8996.c
@@ -0,0 +1,84 @@
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
+#include <linux/regmap.h>
+#include "tsens.h"
+
+#define STATUS_OFFSET	0x10a0
+#define LAST_TEMP_MASK	0xfff
+#define STATUS_VALID_BIT	BIT(21)
+#define CODE_SIGN_BIT		BIT(11)
+
+static int get_temp_8996(struct tsens_device *tmdev, int id, int *temp)
+{
+	struct tsens_sensor *s = &tmdev->sensor[id];
+	u32 code;
+	unsigned int sensor_addr;
+	int last_temp = 0, last_temp2 = 0, last_temp3 = 0, ret;
+
+	sensor_addr = STATUS_OFFSET + s->hw_id * 4;
+	ret = regmap_read(tmdev->map, sensor_addr, &code);
+	if (ret)
+		return ret;
+	last_temp = code & LAST_TEMP_MASK;
+	if (code & STATUS_VALID_BIT)
+		goto done;
+
+	/* Try a second time */
+	ret = regmap_read(tmdev->map, sensor_addr, &code);
+	if (ret)
+		return ret;
+	if (code & STATUS_VALID_BIT) {
+		last_temp = code & LAST_TEMP_MASK;
+		goto done;
+	} else {
+		last_temp2 = code & LAST_TEMP_MASK;
+	}
+
+	/* Try a third/last time */
+	ret = regmap_read(tmdev->map, sensor_addr, &code);
+	if (ret)
+		return ret;
+	if (code & STATUS_VALID_BIT) {
+		last_temp = code & LAST_TEMP_MASK;
+		goto done;
+	} else {
+		last_temp3 = code & LAST_TEMP_MASK;
+	}
+
+	if (last_temp == last_temp2)
+		last_temp = last_temp2;
+	else if (last_temp2 == last_temp3)
+		last_temp = last_temp3;
+done:
+	/* Code sign bit is the sign extension for a negative value */
+	if (last_temp & CODE_SIGN_BIT)
+		last_temp |= ~CODE_SIGN_BIT;
+
+	/* Temperatures are in deciCelicius */
+	*temp = last_temp * 100;
+
+	return 0;
+}
+
+const struct tsens_ops ops_8996 = {
+	.init		= init_common,
+	.get_temp	= get_temp_8996,
+};
+
+const struct tsens_data data_8996 = {
+	.num_sensors	= 13,
+	.ops		= &ops_8996,
+};
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index cef86c3..b182272 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -69,6 +69,9 @@ static const struct of_device_id tsens_table[] = {
 	}, {
 		.compatible = "qcom,msm8974-tsens",
 		.data = &data_8974,
+	}, {
+		.compatible = "qcom,msm8996-tsens",
+		.data = &data_8996,
 	},
 	{}
 };
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 42071a4..b0f8c47 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -87,6 +87,6 @@ void compute_intercept_slope(struct tsens_device *, u32 *, u32 *, u32);
 int init_common(struct tsens_device *);
 int get_temp_common(struct tsens_device *, int, int *);
 
-extern const struct tsens_data data_8916, data_8974, data_8960;
+extern const struct tsens_data data_8916, data_8974, data_8960, data_8996;
 
 #endif /* __QCOM_TSENS_H__ */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

