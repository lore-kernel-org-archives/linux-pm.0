From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 289/304] thermal: tsens: qcom: do not create duplicate regmap debugfs entries
Date: Mon, 28 Jan 2019 10:43:26 -0500
Message-ID: <20190128154341.47195-289-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

[ Upstream commit 4ab248b3b10a58e379e2d32333fff99ea5ca256c ]

Regmap would use device name to create debugfs entries. If the device
has multiple regmaps it is recommended to use name field in regmap_config.
Fix this by providing name to the regmap configs correctly.

Without this patch we would see below error on DB820c.

qcom-tsens 4a9000.thermal-sensor: Failed to create 4a9000.thermal-sensor
debugfs directory

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Amit Kucheria <amit.kucheria@linaro.org>
Tested-by: Amit Kucheria <amit.kucheria@linaro.org>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
