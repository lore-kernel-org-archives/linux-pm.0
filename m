From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v2 2/3] thermal: tsens: switch from of_iomap() to devm_ioremap_resource()
Date: Thu, 26 Jul 2018 16:03:09 +0530
Message-ID: <a737a9decfee231ad065304077755267fa5466d7.1532600791.git.amit.kucheria@linaro.org>
References: <cover.1532600791.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1532600791.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1532600791.git.amit.kucheria@linaro.org>
References: <cover.1532600791.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, smohanad@codeaurora.org, andy.gross@linaro.org, dianders@chromium.org, mka@chromium.org, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

devm_ioremap_resources() automatically requests resources (so that the I/O
region shows up in /proc/iomem) and devm_ wrappers do better error handling
and unmapping of the I/O region when needed.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/thermal/qcom/tsens-common.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 25e7f247b027..6207d8d92351 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -127,13 +127,11 @@ static const struct regmap_config tsens_config = {
 int __init init_common(struct tsens_device *tmdev)
 {
 	void __iomem *base;
+	struct resource *res;
 	struct platform_device *op = of_find_device_by_node(tmdev->dev->of_node);
 
 	if (!op)
 		return -EINVAL;
-	base = of_iomap(tmdev->dev->of_node, 0);
-	if (!base)
-		return -EINVAL;
 
 	/* The driver only uses the TM register address space for now */
 	if (op->num_resources > 1) {
@@ -143,11 +141,14 @@ int __init init_common(struct tsens_device *tmdev)
 		tmdev->tm_offset = 0x1000;
 	}
 
+	res = platform_get_resource(op, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&op->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
 	tmdev->map = devm_regmap_init_mmio(tmdev->dev, base, &tsens_config);
-	if (IS_ERR(tmdev->map)) {
-		iounmap(base);
+	if (IS_ERR(tmdev->map))
 		return PTR_ERR(tmdev->map);
-	}
 
 	return 0;
 }
-- 
2.17.GIT
