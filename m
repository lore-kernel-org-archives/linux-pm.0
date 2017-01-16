From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 01/12] soc: samsung: pmu: Use common device name to let others
 to find it easily
Date: Mon, 16 Jan 2017 07:44:56 +0100
Message-ID: <1484549107-5957-2-git-send-email-m.szyprowski@samsung.com>
References: <1484549107-5957-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170116064523eucas1p18a55f951566df5ddd978364486154931@eucas1p1.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1484549107-5957-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch always set device name to "exynos-pmu" to let other drivers to
find PMU device easily. This is done mainly to get regmap to access PMU
registers from other drivers. This way it can be avoided to add phandle to
the PMU node to almost all drivers in the SoC just to get a regmap access
in the drivers. PMU is something like a SoC wide service, so there is no
point modeling it as hardware dependency for all devices in device tree.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/soc/samsung/exynos-pmu.c       |  1 +
 include/linux/soc/samsung/exynos-pmu.h | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
index 0acdfd82e751..63bb471845cb 100644
--- a/drivers/soc/samsung/exynos-pmu.c
+++ b/drivers/soc/samsung/exynos-pmu.c
@@ -120,6 +120,7 @@ static int exynos_pmu_probe(struct platform_device *pdev)
 		pmu_context->pmu_data->pmu_init();
 
 	platform_set_drvdata(pdev, pmu_context);
+	dev_set_name(dev, EXYNOS_PMU_DEV_NAME);
 
 	dev_dbg(dev, "Exynos PMU Driver probe done\n");
 	return 0;
diff --git a/include/linux/soc/samsung/exynos-pmu.h b/include/linux/soc/samsung/exynos-pmu.h
index e2e9de1acc5b..90d9205805ea 100644
--- a/include/linux/soc/samsung/exynos-pmu.h
+++ b/include/linux/soc/samsung/exynos-pmu.h
@@ -12,6 +12,10 @@
 #ifndef __LINUX_SOC_EXYNOS_PMU_H
 #define __LINUX_SOC_EXYNOS_PMU_H
 
+#include <linux/mfd/syscon.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
 enum sys_powerdown {
 	SYS_AFTR,
 	SYS_LPA,
@@ -21,4 +25,19 @@ enum sys_powerdown {
 
 extern void exynos_sys_powerdown_conf(enum sys_powerdown mode);
 
+#define EXYNOS_PMU_DEV_NAME "exynos-pmu"
+
+static inline struct regmap *exynos_get_pmu_regs(void)
+{
+	struct device *dev = bus_find_device_by_name(&platform_bus_type, NULL,
+						     EXYNOS_PMU_DEV_NAME);
+	if (dev) {
+		struct regmap *regs = syscon_node_to_regmap(dev->of_node);
+		put_device(dev);
+		if (!IS_ERR(regs))
+			return regs;
+	}
+	return NULL;
+}
+
 #endif /* __LINUX_SOC_EXYNOS_PMU_H */
-- 
1.9.1
