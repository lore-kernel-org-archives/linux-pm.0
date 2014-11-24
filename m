From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH RFC v2 03/12] soc: samsung: exynos-pmu: Register exynos pd
 driver as a mfd client
Date: Mon, 24 Nov 2014 18:34:07 +0530
Message-ID: <1416834256-11225-3-git-send-email-amit.daniel@samsung.com>
References: <1416833572-6880-1-git-send-email-amit.daniel@samsung.com>
 <1416834256-11225-1-git-send-email-amit.daniel@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1416834256-11225-1-git-send-email-amit.daniel@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: kgene.kim@samsung.com, linux-kernel@vger.kernel.org, s.nawrocki@samsung.com, pankaj.dubey@samsung.com, ulf.hansson@linaro.org, khilman@kernel.org, linux-pm@vger.kernel.org, geert@linux-m68k.org, rjw@rjwysocki.net, devicetree@vger.kernel.org, Amit Daniel Kachhap <amit.daniel@samsung.com>
List-Id: linux-pm@vger.kernel.org

This is used to probe exynos power domain. This method can be also used
for probing other PMU client drivers like pm sleep etc. Currently no
platform data is supplied but can be easily extended when required.

Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 drivers/soc/samsung/exynos-pmu.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
index cb9e356..da77c7e 100644
--- a/drivers/soc/samsung/exynos-pmu.c
+++ b/drivers/soc/samsung/exynos-pmu.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/io.h>
+#include <linux/mfd/core.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
@@ -21,6 +22,10 @@
 
 #define PMU_TABLE_END	(-1U)
 
+enum pmu_mfd_list {
+	MFD_PD,
+	MFD_MAX,
+};
 struct exynos_pmu_conf {
 	unsigned int offset;
 	unsigned int val[NUM_SYS_POWERDOWN];
@@ -38,6 +43,7 @@ struct exynos_pmu_data {
 struct exynos_pmu_context {
 	struct device *dev;
 	const struct exynos_pmu_data *pmu_data;
+	struct mfd_cell cells[MFD_MAX];
 };
 
 static void __iomem *pmu_base_addr;
@@ -1220,6 +1226,7 @@ static int exynos_pmu_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	struct device *dev = &pdev->dev;
 	struct resource *res;
+	struct mfd_cell *cell;
 	int ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1249,6 +1256,17 @@ static int exynos_pmu_probe(struct platform_device *pdev)
 	if (ret)
 		dev_warn(dev, "can't register restart handler err=%d\n", ret);
 
+	/* Initialize and invoke mfd clients */
+	cell = &pmu_context->cells[MFD_PD];
+	cell->name = "exynos-pmu-pd";
+
+	ret = mfd_add_devices(&pdev->dev, pdev->id, pmu_context->cells, MFD_MAX,
+				NULL, 0, NULL);
+	if (ret) {
+		dev_err(&pdev->dev, "fail to register client devices\n");
+		return ret;
+	}
+
 	dev_dbg(dev, "Exynos PMU Driver probe done\n");
 	return 0;
 }
-- 
1.7.9.5
