From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v3 01/16] thermal: tsens: Prepare 8916 and 8974 tsens to use SROT and TM address space
Date: Wed, 12 Sep 2018 15:22:46 +0530
Message-ID: <b136431f98d157a1844fe42dd1b35a0a9e0128d3.1536744310.git.amit.kucheria@linaro.org>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1536744310.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1536744310.git.amit.kucheria@linaro.org>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, smohanad@codeaurora.org, andy.gross@linaro.org, dianders@chromium.org, mka@chromium.org, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

We've already converted over the devicetree of platforms using v2
version of the TSENS IP to use two address spaces. Now prepare to
convert over the 8916 and 8974 platforms to use separate SROT and TM
address spaces.

This patch will work with device trees with one or two address spaces
because we set the tm_offset in commit 5b1283984fa3 ("thermal: tsens:
Add support to split up register address space into two").

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/thermal/qcom/tsens-common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 6207d8d92351..478739543bbc 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -21,7 +21,7 @@
 #include <linux/regmap.h>
 #include "tsens.h"
 
-#define S0_ST_ADDR		0x1030
+#define STATUS_OFFSET		0x30
 #define SN_ADDR_OFFSET		0x4
 #define SN_ST_TEMP_MASK		0x3ff
 #define CAL_DEGC_PT1		30
@@ -107,8 +107,9 @@ int get_temp_common(struct tsens_device *tmdev, int id, int *temp)
 	unsigned int status_reg;
 	int last_temp = 0, ret;
 
-	status_reg = S0_ST_ADDR + s->hw_id * SN_ADDR_OFFSET;
+	status_reg = tmdev->tm_offset + STATUS_OFFSET + s->hw_id * SN_ADDR_OFFSET;
 	ret = regmap_read(tmdev->map, status_reg, &code);
+
 	if (ret)
 		return ret;
 	last_temp = code & SN_ST_TEMP_MASK;
-- 
2.17.1
