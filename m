From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v1 3/3] thermal: tsens: Fix negative temperature reporting
Date: Wed, 18 Jul 2018 12:55:03 +0530
Message-ID: <42d6f2a6f9babd6351bd2fcde4000d5ca9c351ce.1531898088.git.amit.kucheria@linaro.org>
References: <cover.1531898088.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1531898088.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1531898088.git.amit.kucheria@linaro.org>
References: <cover.1531898088.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, smohanad@codeaurora.org, andy.gross@linaro.org, dianders@chromium.org, mka@chromium.org, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The current code will always return 0xffffffff in case of negative
temperatures due to a bug in how the binary sign extension is being done.

Use sign_extend32() instead.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-v2.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 908e3dc..46abc21 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -5,19 +5,20 @@
  */
 
 #include <linux/regmap.h>
+#include <linux/bitops.h>
 #include "tsens.h"
 
 #define STATUS_OFFSET		0xa0
 #define LAST_TEMP_MASK		0xfff
 #define STATUS_VALID_BIT	BIT(21)
-#define CODE_SIGN_BIT		BIT(11)
 
 static int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
 {
 	struct tsens_sensor *s = &tmdev->sensor[id];
 	u32 code;
 	unsigned int status_reg;
-	int last_temp = 0, last_temp2 = 0, last_temp3 = 0, ret;
+	u32 last_temp = 0, last_temp2 = 0, last_temp3 = 0;
+	int ret;
 
 	status_reg = tmdev->tm_offset + STATUS_OFFSET + s->hw_id * 4;
 	ret = regmap_read(tmdev->map, status_reg, &code);
@@ -54,12 +55,8 @@ static int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
 	else if (last_temp2 == last_temp3)
 		last_temp = last_temp3;
 done:
-	/* Code sign bit is the sign extension for a negative value */
-	if (last_temp & CODE_SIGN_BIT)
-		last_temp |= ~CODE_SIGN_BIT;
-
-	/* Temperatures are in deciCelicius */
-	*temp = last_temp * 100;
+	/* Convert temperatures to milliCelicius */
+	*temp = sign_extend32(last_temp, fls(LAST_TEMP_MASK) - 1) * 100;
 
 	return 0;
 }
-- 
2.7.4
