From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v6 2/7] thermal: tsens: Add support to split up register address space into two
Date: Mon,  9 Jul 2018 17:13:24 +0530
Message-ID: <e7c5c74bd5ad1820f0f015d8e9b3d7c7b24854a4.1531135999.git.amit.kucheria@linaro.org>
References: <cover.1531135999.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1531135999.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1531135999.git.amit.kucheria@linaro.org>
References: <cover.1531135999.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, smohanad@codeaurora.org, vivek.gautam@codeaurora.org, andy.gross@linaro.org, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

There are two banks of registers for v2 TSENS IPs: SROT and TM. On older
SoCs these were contiguous, leading to DTs mapping them as one register
address space of size 0x2000. In newer SoCs, these two banks are not
contiguous anymore.

Fixing old DTs to split the address space into allows us to have cleaner
common code e.g. get_temp() that is shared across new and old platforms.

But we need to add logic to init_common() to differentiate between old and
new DTs and adjust associated offsets for the TM register bank so that the
old DTs will continue to function correctly.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-8996.c   |  2 +-
 drivers/thermal/qcom/tsens-common.c | 11 +++++++++++
 drivers/thermal/qcom/tsens.h        |  1 +
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens-8996.c b/drivers/thermal/qcom/tsens-8996.c
index e1f7781..60765b1 100644
--- a/drivers/thermal/qcom/tsens-8996.c
+++ b/drivers/thermal/qcom/tsens-8996.c
@@ -28,7 +28,7 @@ static int get_temp_8996(struct tsens_device *tmdev, int id, int *temp)
 	unsigned int sensor_addr;
 	int last_temp = 0, last_temp2 = 0, last_temp3 = 0, ret;
 
-	sensor_addr = STATUS_OFFSET + s->hw_id * 4;
+	sensor_addr = tmdev->tm_offset + STATUS_OFFSET + s->hw_id * 4;
 	ret = regmap_read(tmdev->map, sensor_addr, &code);
 	if (ret)
 		return ret;
diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index b1449ad..4a741b0 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -16,6 +16,7 @@
 #include <linux/io.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/of_address.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include "tsens.h"
@@ -126,11 +127,21 @@ static const struct regmap_config tsens_config = {
 int __init init_common(struct tsens_device *tmdev)
 {
 	void __iomem *base;
+	struct platform_device *op = of_find_device_by_node(tmdev->dev->of_node);
 
+	if (!op)
+		return -EINVAL;
 	base = of_iomap(tmdev->dev->of_node, 0);
 	if (!base)
 		return -EINVAL;
 
+	if (op->num_resources > 1) {
+		tmdev->tm_offset = 0;
+	} else {
+		/* old DTs where SROT and TM were in a contiguous 2K block */
+		tmdev->tm_offset = 0x1000;
+	}
+
 	tmdev->map = devm_regmap_init_mmio(tmdev->dev, base, &tsens_config);
 	if (IS_ERR(tmdev->map)) {
 		iounmap(base);
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index dc56e1e..d785b37 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -77,6 +77,7 @@ struct tsens_device {
 	struct device			*dev;
 	u32				num_sensors;
 	struct regmap			*map;
+	u32				tm_offset;
 	struct tsens_context		ctx;
 	const struct tsens_ops		*ops;
 	struct tsens_sensor		sensor[0];
-- 
2.7.4
