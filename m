From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] thermal: tsens: qcom: do not create duplicate regmap debugfs entries
Date: Thu, 15 Nov 2018 17:43:30 +0000
Message-ID: <20181115174330.15224-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: amit.kucheria@linaro.org, edubezval@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, daniel.lezcano@linaro.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: linux-pm@vger.kernel.org

Regmap would use device name to create debugfs entries. If the device
has multiple regmaps it is recommended to use name field in regmap_config.
Fix this by providing name to the regmap configs correctly.

Without this patch we would see below error on DB820c.

qcom-tsens 4a9000.thermal-sensor: Failed to create 4a9000.thermal-sensor
debugfs directory

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 3be4be2e0465..78652cac7f3d 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -114,6 +114,14 @@ int get_temp_common(struct tsens_device *tmdev, int id, int *temp)
 }
 
 static const struct regmap_config tsens_config = {
+	.name		= "tm",
+	.reg_bits	= 32,
+	.val_bits	= 32,
+	.reg_stride	= 4,
+};
+
+static const struct regmap_config tsens_srot_config = {
+	.name		= "srot",
 	.reg_bits	= 32,
 	.val_bits	= 32,
 	.reg_stride	= 4,
@@ -139,8 +147,8 @@ int __init init_common(struct tsens_device *tmdev)
 		if (IS_ERR(srot_base))
 			return PTR_ERR(srot_base);
 
-		tmdev->srot_map = devm_regmap_init_mmio(tmdev->dev,
-							srot_base, &tsens_config);
+		tmdev->srot_map = devm_regmap_init_mmio(tmdev->dev, srot_base,
+							&tsens_srot_config);
 		if (IS_ERR(tmdev->srot_map))
 			return PTR_ERR(tmdev->srot_map);
 
-- 
2.19.1
