From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v3 07/16] thermal: tsens: Pass register offsets as private data
Date: Wed, 12 Sep 2018 15:22:52 +0530
Message-ID: <dccdcf386d8d5298a77ec31cde699852cc4409c5.1536744310.git.amit.kucheria@linaro.org>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1536744310.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1536744310.git.amit.kucheria@linaro.org>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, smohanad@codeaurora.org, andy.gross@linaro.org, dianders@chromium.org, mka@chromium.org, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Registers have moved around across TSENS generations. For example, the
CTRL register was at offset 0x0 in the SROT region on msm8916 but is at
offset 0x4 in newer v2 based TSENS HW blocks.

Allow passing offsets of important registers so that we can continue to
use common functions.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-8916.c | 1 +
 drivers/thermal/qcom/tsens-8974.c | 1 +
 drivers/thermal/qcom/tsens-v2.c   | 2 ++
 drivers/thermal/qcom/tsens.c      | 3 +++
 drivers/thermal/qcom/tsens.h      | 9 +++++++++
 5 files changed, 16 insertions(+)

diff --git a/drivers/thermal/qcom/tsens-8916.c b/drivers/thermal/qcom/tsens-8916.c
index c4955c85e922..c6dd620ac029 100644
--- a/drivers/thermal/qcom/tsens-8916.c
+++ b/drivers/thermal/qcom/tsens-8916.c
@@ -100,5 +100,6 @@ static const struct tsens_ops ops_8916 = {
 const struct tsens_data data_8916 = {
 	.num_sensors	= 5,
 	.ops		= &ops_8916,
+	.reg_offsets	= { [SROT_CTRL_OFFSET] = 0x0 },
 	.hw_ids		= (unsigned int []){0, 1, 2, 4, 5 },
 };
diff --git a/drivers/thermal/qcom/tsens-8974.c b/drivers/thermal/qcom/tsens-8974.c
index 7e149edbfeb6..3d3fda3d731b 100644
--- a/drivers/thermal/qcom/tsens-8974.c
+++ b/drivers/thermal/qcom/tsens-8974.c
@@ -232,4 +232,5 @@ static const struct tsens_ops ops_8974 = {
 const struct tsens_data data_8974 = {
 	.num_sensors	= 11,
 	.ops		= &ops_8974,
+	.reg_offsets	= { [SROT_CTRL_OFFSET] = 0x0 },
 };
diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 1bdef92e4521..381a212872bf 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -68,10 +68,12 @@ static const struct tsens_ops ops_generic_v2 = {
 
 const struct tsens_data data_tsens_v2 = {
 	.ops            = &ops_generic_v2,
+	.reg_offsets	= { [SROT_CTRL_OFFSET] = 0x4 },
 };
 
 /* Kept around for backward compatibility with old msm8996.dtsi */
 const struct tsens_data data_8996 = {
 	.num_sensors	= 13,
 	.ops		= &ops_generic_v2,
+	.reg_offsets	= { [SROT_CTRL_OFFSET] = 0x4 },
 };
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 9a8e8f7b4ae1..f1ec9bbe4717 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -144,6 +144,9 @@ static int tsens_probe(struct platform_device *pdev)
 		else
 			tmdev->sensor[i].hw_id = i;
 	}
+	for (i = 0; i < REG_ARRAY_SIZE; i++) {
+		tmdev->reg_offsets[i] = data->reg_offsets[i];
+	}
 
 	if (!tmdev->ops || !tmdev->ops->init || !tmdev->ops->get_temp)
 		return -EINVAL;
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index b9c4bcf255fa..7b7feee5dc46 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -48,15 +48,23 @@ struct tsens_ops {
 	int (*get_trend)(struct tsens_device *, int, enum thermal_trend *);
 };
 
+enum reg_list {
+	SROT_CTRL_OFFSET,
+
+	REG_ARRAY_SIZE,
+};
+
 /**
  * struct tsens_data - tsens instance specific data
  * @num_sensors: Max number of sensors supported by platform
  * @ops: operations the tsens instance supports
  * @hw_ids: Subset of sensors ids supported by platform, if not the first n
+ * @reg_offsets: Register offsets for commonly used registers
  */
 struct tsens_data {
 	const u32		num_sensors;
 	const struct tsens_ops	*ops;
+	const u16		reg_offsets[REG_ARRAY_SIZE];
 	unsigned int		*hw_ids;
 };
 
@@ -72,6 +80,7 @@ struct tsens_device {
 	struct regmap			*tm_map;
 	struct regmap			*srot_map;
 	u32				tm_offset;
+	u16				reg_offsets[REG_ARRAY_SIZE];
 	struct tsens_context		ctx;
 	const struct tsens_ops		*ops;
 	struct tsens_sensor		sensor[0];
-- 
2.17.1
