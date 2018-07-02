From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v4 5/6] thermal: tsens: Check if we have valid data before reading
Date: Mon,  2 Jul 2018 18:14:08 +0530
Message-ID: <e2fd1933390c2c1c0fedc6e2c4f2093470c4242a.1530533998.git.amit.kucheria@linaro.org>
References: <cover.1530533998.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1530533998.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1530533998.git.amit.kucheria@linaro.org>
References: <cover.1530533998.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, smohanad@codeaurora.org, vivek.gautam@codeaurora.org, andy.gross@linaro.org, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/thermal/qcom/tsens-v2.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 1871945..0473f33 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -7,6 +7,9 @@
 #include <linux/regmap.h>
 #include "tsens.h"
 
+#define TRDY_OFFSET            0xe4
+#define TRDY_READY_BIT         BIT(0)
+
 #define STATUS_OFFSET		0xa0
 #define LAST_TEMP_MASK		0xfff
 #define STATUS_VALID_BIT	BIT(21)
@@ -19,6 +22,12 @@ static int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
 	unsigned int sensor_addr;
 	int last_temp = 0, last_temp2 = 0, last_temp3 = 0, ret;
 
+	ret = regmap_read(tmdev->map, TRDY_OFFSET, &code);
+	if (ret)
+		return ret;
+	if (code & TRDY_READY_BIT)
+		return -ENODATA;
+
 	sensor_addr = STATUS_OFFSET + s->hw_id * 4;
 	ret = regmap_read(tmdev->map, sensor_addr, &code);
 	if (ret)
-- 
2.7.4
