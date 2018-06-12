From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v2 5/5] thermal: tsens: Check if we have valid data before reading
Date: Tue, 12 Jun 2018 13:54:57 +0300
Message-ID: <021331bdb04642e9ddf34accda65a93b850c4a23.1528799892.git.amit.kucheria@linaro.org>
References: <cover.1528799892.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1528799892.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1528799892.git.amit.kucheria@linaro.org>
References: <cover.1528799892.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, Zhang Rui <rui.zhang@intel.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 961ace4..f510e61 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -114,6 +114,9 @@ int get_temp_common(struct tsens_device *tmdev, int id, int *temp)
 #define STATUS_VALID_BIT	BIT(21)
 #define CODE_SIGN_BIT		BIT(11)
 
+#define TRDY_OFFSET     	0xe4
+#define TRDY_READY_BIT  	BIT(0)
+
 int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
 {
 	struct tsens_sensor *s = &tmdev->sensor[id];
@@ -121,6 +124,12 @@ int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
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
