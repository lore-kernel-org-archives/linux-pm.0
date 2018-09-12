From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v3 05/16] thermal: tsens: Add the SROT address map
Date: Wed, 12 Sep 2018 15:22:50 +0530
Message-ID: <2900c1006e7e978403b1b95448f9c959c7ae486a.1536744310.git.amit.kucheria@linaro.org>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1536744310.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1536744310.git.amit.kucheria@linaro.org>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, smohanad@codeaurora.org, andy.gross@linaro.org, dianders@chromium.org, mka@chromium.org, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On platforms whose device trees specify two address spaces for TSENS, the
second one points to the SROT registers. Initialise the SROT map on those
platforms.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 14 ++++++++++++--
 drivers/thermal/qcom/tsens.h        |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 0585084630b3..0b8a793f15f4 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -117,16 +117,26 @@ static const struct regmap_config tsens_config = {
 
 int __init init_common(struct tsens_device *tmdev)
 {
-	void __iomem *tm_base;
+	void __iomem *tm_base, *srot_base;
 	struct resource *res;
 	struct platform_device *op = of_find_device_by_node(tmdev->dev->of_node);
 
 	if (!op)
 		return -EINVAL;
 
-	/* The driver only uses the TM register address space for now */
 	if (op->num_resources > 1) {
+		/* DT with separate SROT and TM address space */
 		tmdev->tm_offset = 0;
+		res = platform_get_resource(op, IORESOURCE_MEM, 1);
+		srot_base = devm_ioremap_resource(&op->dev, res);
+		if (IS_ERR(srot_base))
+			return PTR_ERR(srot_base);
+
+		tmdev->srot_map = devm_regmap_init_mmio(tmdev->dev,
+							srot_base, &tsens_config);
+		if (IS_ERR(tmdev->srot_map))
+			return PTR_ERR(tmdev->srot_map);
+
 	} else {
 		/* old DTs where SROT and TM were in a contiguous 2K block */
 		tmdev->tm_offset = 0x1000;
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 58e98c4d3a8b..b9c4bcf255fa 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -70,6 +70,7 @@ struct tsens_device {
 	struct device			*dev;
 	u32				num_sensors;
 	struct regmap			*tm_map;
+	struct regmap			*srot_map;
 	u32				tm_offset;
 	struct tsens_context		ctx;
 	const struct tsens_ops		*ops;
-- 
2.17.1
