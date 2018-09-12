From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v3 08/16] thermal: tsens: Check if the IP is correctly enabled by firmware
Date: Wed, 12 Sep 2018 15:22:53 +0530
Message-ID: <140b054230a61e13995ae4b685746c8faf068d61.1536744310.git.amit.kucheria@linaro.org>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1536744310.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1536744310.git.amit.kucheria@linaro.org>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, smohanad@codeaurora.org, andy.gross@linaro.org, dianders@chromium.org, mka@chromium.org, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The SROT registers are initialised by the secure firmware at boot. We
don't have write access to the registers. Check if the block is enabled
before continuing.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 0b8a793f15f4..3be4be2e0465 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -12,6 +12,10 @@
 #include <linux/regmap.h>
 #include "tsens.h"
 
+/* SROT */
+#define TSENS_EN		BIT(0)
+
+/* TM */
 #define STATUS_OFFSET		0x30
 #define SN_ADDR_OFFSET		0x4
 #define SN_ST_TEMP_MASK		0x3ff
@@ -119,7 +123,10 @@ int __init init_common(struct tsens_device *tmdev)
 {
 	void __iomem *tm_base, *srot_base;
 	struct resource *res;
+	u32 code;
+	int ret;
 	struct platform_device *op = of_find_device_by_node(tmdev->dev->of_node);
+	u16 ctrl_offset = tmdev->reg_offsets[SROT_CTRL_OFFSET];
 
 	if (!op)
 		return -EINVAL;
@@ -151,5 +158,15 @@ int __init init_common(struct tsens_device *tmdev)
 	if (IS_ERR(tmdev->tm_map))
 		return PTR_ERR(tmdev->tm_map);
 
+	if (tmdev->srot_map) {
+		ret = regmap_read(tmdev->srot_map, ctrl_offset, &code);
+		if (ret)
+			return ret;
+		if (!(code & TSENS_EN)) {
+			dev_err(tmdev->dev, "tsens device is not enabled\n");
+			return -ENODEV;
+		}
+	}
+
 	return 0;
 }
-- 
2.17.1
