From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCHv3 02/23] drivers: thermal: tsens: Rename tsens_data
Date: Wed, 20 Mar 2019 18:47:42 +0530
Message-ID: <286b40e37f26cad44f54dcb9420f1e7fb589a396.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>, David Brown <david.brown@linaro.org>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Rename to tsens_plat_data to denote that it is platform-data passed in
at compile-time.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-8916.c | 2 +-
 drivers/thermal/qcom/tsens-8960.c | 2 +-
 drivers/thermal/qcom/tsens-8974.c | 2 +-
 drivers/thermal/qcom/tsens-v2.c   | 4 ++--
 drivers/thermal/qcom/tsens.c      | 2 +-
 drivers/thermal/qcom/tsens.h      | 8 ++++----
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8916.c b/drivers/thermal/qcom/tsens-8916.c
index c6dd620ac029..66edcfca1526 100644
--- a/drivers/thermal/qcom/tsens-8916.c
+++ b/drivers/thermal/qcom/tsens-8916.c
@@ -97,7 +97,7 @@ static const struct tsens_ops ops_8916 = {
 	.get_temp	= get_temp_common,
 };
 
-const struct tsens_data data_8916 = {
+const struct tsens_plat_data data_8916 = {
 	.num_sensors	= 5,
 	.ops		= &ops_8916,
 	.reg_offsets	= { [SROT_CTRL_OFFSET] = 0x0 },
diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index 0f0adb302a7b..f3c3820e6e8e 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -277,7 +277,7 @@ static const struct tsens_ops ops_8960 = {
 	.resume		= resume_8960,
 };
 
-const struct tsens_data data_8960 = {
+const struct tsens_plat_data data_8960 = {
 	.num_sensors	= 11,
 	.ops		= &ops_8960,
 };
diff --git a/drivers/thermal/qcom/tsens-8974.c b/drivers/thermal/qcom/tsens-8974.c
index 3d3fda3d731b..5023f20afc14 100644
--- a/drivers/thermal/qcom/tsens-8974.c
+++ b/drivers/thermal/qcom/tsens-8974.c
@@ -229,7 +229,7 @@ static const struct tsens_ops ops_8974 = {
 	.get_temp	= get_temp_common,
 };
 
-const struct tsens_data data_8974 = {
+const struct tsens_plat_data data_8974 = {
 	.num_sensors	= 11,
 	.ops		= &ops_8974,
 	.reg_offsets	= { [SROT_CTRL_OFFSET] = 0x0 },
diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 381a212872bf..cc98a61e093b 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -66,13 +66,13 @@ static const struct tsens_ops ops_generic_v2 = {
 	.get_temp	= get_temp_tsens_v2,
 };
 
-const struct tsens_data data_tsens_v2 = {
+const struct tsens_plat_data data_tsens_v2 = {
 	.ops            = &ops_generic_v2,
 	.reg_offsets	= { [SROT_CTRL_OFFSET] = 0x4 },
 };
 
 /* Kept around for backward compatibility with old msm8996.dtsi */
-const struct tsens_data data_8996 = {
+const struct tsens_plat_data data_8996 = {
 	.num_sensors	= 13,
 	.ops		= &ops_generic_v2,
 	.reg_offsets	= { [SROT_CTRL_OFFSET] = 0x4 },
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index f1ec9bbe4717..065ec2189bd3 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -102,7 +102,7 @@ static int tsens_probe(struct platform_device *pdev)
 	struct device *dev;
 	struct device_node *np;
 	struct tsens_device *tmdev;
-	const struct tsens_data *data;
+	const struct tsens_plat_data *data;
 	const struct of_device_id *id;
 	u32 num_sensors;
 
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 89318523c848..232376c690cc 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -65,13 +65,13 @@ enum reg_list {
 };
 
 /**
- * struct tsens_data - tsens platform data
+ * struct tsens_plat_data - tsens compile-time platform data
  * @num_sensors: Number of sensors supported by platform
  * @ops: operations the tsens instance supports
  * @hw_ids: Subset of sensors ids supported by platform, if not the first n
  * @reg_offsets: Register offsets for commonly used registers
  */
-struct tsens_data {
+struct tsens_plat_data {
 	const u32		num_sensors;
 	const struct tsens_ops	*ops;
 	const u16		reg_offsets[REG_ARRAY_SIZE];
@@ -117,8 +117,8 @@ int init_common(struct tsens_device *);
 int get_temp_common(struct tsens_device *, int, int *);
 
 /* TSENS v1 targets */
-extern const struct tsens_data data_8916, data_8974, data_8960;
+extern const struct tsens_plat_data data_8916, data_8974, data_8960;
 /* TSENS v2 targets */
-extern const struct tsens_data data_8996, data_tsens_v2;
+extern const struct tsens_plat_data data_8996, data_tsens_v2;
 
 #endif /* __QCOM_TSENS_H__ */
-- 
2.17.1
