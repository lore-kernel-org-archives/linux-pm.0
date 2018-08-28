From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v2 05/11] thermal: tsens: Get rid of dead code
Date: Tue, 28 Aug 2018 19:08:34 +0530
Message-ID: <c50d9e71fc8cf466b9a7ff32edf7fb9370cca2dd.1535462942.git.amit.kucheria@linaro.org>
References: <cover.1535462942.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1535462942.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1535462942.git.amit.kucheria@linaro.org>
References: <cover.1535462942.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, smohanad@codeaurora.org, andy.gross@linaro.org, dianders@chromium.org, mka@chromium.org, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

hw_id is dynamically allocated but not used anywhere. Get rid of dead
code.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/thermal/qcom/tsens.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 90bb431cf740..9a8e8f7b4ae1 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -80,11 +80,6 @@ static int tsens_register(struct tsens_device *tmdev)
 {
 	int i;
 	struct thermal_zone_device *tzd;
-	u32 *hw_id, n = tmdev->num_sensors;
-
-	hw_id = devm_kcalloc(tmdev->dev, n, sizeof(u32), GFP_KERNEL);
-	if (!hw_id)
-		return -ENOMEM;
 
 	for (i = 0;  i < tmdev->num_sensors; i++) {
 		tmdev->sensor[i].tmdev = tmdev;
-- 
2.17.1
