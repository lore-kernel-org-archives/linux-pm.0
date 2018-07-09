From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v5 1/7] thermal: tsens: Get rid of unused fields in structure
Date: Mon,  9 Jul 2018 16:57:34 +0530
Message-ID: <a55492279160077e59fcc1e29b2c3b6d9d0f822f.1531133611.git.amit.kucheria@linaro.org>
References: <cover.1531133611.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1531133611.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1531133611.git.amit.kucheria@linaro.org>
References: <cover.1531133611.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, smohanad@codeaurora.org, vivek.gautam@codeaurora.org, andy.gross@linaro.org, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

status_field and trdy are unused in any of the tsens drivers. Remove them.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/thermal/qcom/tsens.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 911c197..dc56e1e 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -77,9 +77,7 @@ struct tsens_device {
 	struct device			*dev;
 	u32				num_sensors;
 	struct regmap			*map;
-	struct regmap_field		*status_field;
 	struct tsens_context		ctx;
-	bool				trdy;
 	const struct tsens_ops		*ops;
 	struct tsens_sensor		sensor[0];
 };
-- 
2.7.4
