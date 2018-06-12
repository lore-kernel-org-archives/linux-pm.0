From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v2 3/5] thermal: tsens: Move 8996 get_temp() to common code for reuse
Date: Tue, 12 Jun 2018 13:54:55 +0300
Message-ID: <ed6b51a1b08e195968f5423a86e40146279a8807.1528799892.git.amit.kucheria@linaro.org>
References: <cover.1528799892.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1528799892.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1528799892.git.amit.kucheria@linaro.org>
References: <cover.1528799892.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, Zhang Rui <rui.zhang@intel.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

The TSENS block inside the 8996 is internally classified as version 2.
Several other SoC families use this block and can share this code. Rename
get_temp() to reflect that it can be used across the v2 family.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-8996.c   | 73 ++-----------------------------------
 drivers/thermal/qcom/tsens-common.c | 69 ++++++++++++++++++++++++++++++-----
 drivers/thermal/qcom/tsens.h        |  1 +
 3 files changed, 63 insertions(+), 80 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8996.c b/drivers/thermal/qcom/tsens-8996.c
index 6e59078..a0d9096 100644
--- a/drivers/thermal/qcom/tsens-8996.c
+++ b/drivers/thermal/qcom/tsens-8996.c
@@ -1,81 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2015, The Linux Foundation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
+ * Copyright (c) 2018, Linaro Limited
  */
 
-#include <linux/platform_device.h>
-#include <linux/regmap.h>
 #include "tsens.h"
 
-#define STATUS_OFFSET	0x10a0
-#define LAST_TEMP_MASK	0xfff
-#define STATUS_VALID_BIT	BIT(21)
-#define CODE_SIGN_BIT		BIT(11)
-
-static int get_temp_8996(struct tsens_device *tmdev, int id, int *temp)
-{
-	struct tsens_sensor *s = &tmdev->sensor[id];
-	u32 code;
-	unsigned int sensor_addr;
-	int last_temp = 0, last_temp2 = 0, last_temp3 = 0, ret;
-
-	sensor_addr = STATUS_OFFSET + s->hw_id * 4;
-	ret = regmap_read(tmdev->map, sensor_addr, &code);
-	if (ret)
-		return ret;
-	last_temp = code & LAST_TEMP_MASK;
-	if (code & STATUS_VALID_BIT)
-		goto done;
-
-	/* Try a second time */
-	ret = regmap_read(tmdev->map, sensor_addr, &code);
-	if (ret)
-		return ret;
-	if (code & STATUS_VALID_BIT) {
-		last_temp = code & LAST_TEMP_MASK;
-		goto done;
-	} else {
-		last_temp2 = code & LAST_TEMP_MASK;
-	}
-
-	/* Try a third/last time */
-	ret = regmap_read(tmdev->map, sensor_addr, &code);
-	if (ret)
-		return ret;
-	if (code & STATUS_VALID_BIT) {
-		last_temp = code & LAST_TEMP_MASK;
-		goto done;
-	} else {
-		last_temp3 = code & LAST_TEMP_MASK;
-	}
-
-	if (last_temp == last_temp2)
-		last_temp = last_temp2;
-	else if (last_temp2 == last_temp3)
-		last_temp = last_temp3;
-done:
-	/* Code sign bit is the sign extension for a negative value */
-	if (last_temp & CODE_SIGN_BIT)
-		last_temp |= ~CODE_SIGN_BIT;
-
-	/* Temperatures are in deciCelicius */
-	*temp = last_temp * 100;
-
-	return 0;
-}
-
 static const struct tsens_ops ops_8996 = {
 	.init		= init_common,
-	.get_temp	= get_temp_8996,
+	.get_temp	= get_temp_tsens_v2,
 };
 
 const struct tsens_data data_8996 = {
diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index b1449ad..961ace4 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -1,15 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2015, The Linux Foundation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
+ * Copyright (c) 2018, Linaro Limited
  */
 
 #include <linux/err.h>
@@ -117,6 +109,63 @@ int get_temp_common(struct tsens_device *tmdev, int id, int *temp)
 	return 0;
 }
 
+#define STATUS_OFFSET		0xa0
+#define LAST_TEMP_MASK		0xfff
+#define STATUS_VALID_BIT	BIT(21)
+#define CODE_SIGN_BIT		BIT(11)
+
+int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
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
 static const struct regmap_config tsens_config = {
 	.reg_bits	= 32,
 	.val_bits	= 32,
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index dc56e1e..80b273d 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -86,6 +86,7 @@ char *qfprom_read(struct device *, const char *);
 void compute_intercept_slope(struct tsens_device *, u32 *, u32 *, u32);
 int init_common(struct tsens_device *);
 int get_temp_common(struct tsens_device *, int, int *);
+int get_temp_tsens_v2(struct tsens_device *, int, int *);
 
 extern const struct tsens_data data_8916, data_8974, data_8960, data_8996;
 
-- 
2.7.4
