From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v1 24/24] drivers: thermal: tsens: Move calibration constants to header file
Date: Thu,  7 Feb 2019 16:19:42 +0530
Message-ID: <99a7e1fca9db203b2784fcbe0f8cab6993e51a39.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>, David Brown <david.brown@linaro.org>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This will allow calibration routines to correctly include the constants
from anywhere and allow more code sharing.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 5 -----
 drivers/thermal/qcom/tsens.h        | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index a935d2335eea..35e82aaaef59 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -12,11 +12,6 @@
 #include <linux/regmap.h>
 #include "tsens.h"
 
-#define CAL_DEGC_PT1		30
-#define CAL_DEGC_PT2		120
-#define SLOPE_FACTOR		1000
-#define SLOPE_DEFAULT		3200
-
 char *qfprom_read(struct device *dev, const char *cname)
 {
 	struct nvmem_cell *cell;
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 4ed07e607cbc..8a747ab892f5 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -9,6 +9,11 @@
 #define ONE_PT_CALIB		0x1
 #define ONE_PT_CALIB2		0x2
 #define TWO_PT_CALIB		0x3
+#define CAL_DEGC_PT1		30
+#define CAL_DEGC_PT2		120
+#define SLOPE_FACTOR		1000
+#define SLOPE_DEFAULT		3200
+
 
 #include <linux/thermal.h>
 #include <linux/regmap.h>
-- 
2.17.1
