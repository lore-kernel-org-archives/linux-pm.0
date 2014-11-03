From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH 04/12] mfd: exynos-pmu: Register exynos-pmu driver as a mfd
 driver
Date: Mon, 03 Nov 2014 09:23:02 +0530
Message-ID: <1414986790-11940-5-git-send-email-amit.daniel@samsung.com>
References: <1414986790-11940-1-git-send-email-amit.daniel@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1414986790-11940-1-git-send-email-amit.daniel@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: kgene.kim@samsung.com, pankaj.dubey@samsung.com, Amit Daniel Kachhap <amit.daniel@samsung.com>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pm@vger.kernel.org

This can be used later to probe and configure PMU client drivers
like pm_domain etc.
A global structure pmu_dev_client_data is created to pass exynos-pmu
platform data to all the clients. Currently the data passed is register
base addresses.
Although the exynos-pmu driver also provides the sysreg interfaces to
provide register base addresses but this is costlier than readl/writel,
so both the interfaces are provided to mfd based exynos-pmu client
drivers.

Cc: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 drivers/mfd/exynos-pmu.c               |   25 +++++++++++++++++++++++++
 include/linux/mfd/samsung/exynos-pmu.h |    5 +++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/mfd/exynos-pmu.c b/drivers/mfd/exynos-pmu.c
index 07019f0..c46f3f5 100644
--- a/drivers/mfd/exynos-pmu.c
+++ b/drivers/mfd/exynos-pmu.c
@@ -11,12 +11,19 @@
 
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
+#include <linux/mfd/core.h>
 #include <linux/mfd/samsung/exynos-regs-pmu.h>
 #include <linux/mfd/samsung/exynos-pmu.h>
 
 #define PMU_TABLE_END	(-1U)
 
+enum pmu_mfd_list {
+	MFD_POWER_DOMAIN,
+	MFD_MAX,
+};
+
 struct exynos_pmu_conf {
 	unsigned int offset;
 	unsigned int val[NUM_SYS_POWERDOWN];
@@ -33,6 +40,8 @@ struct exynos_pmu_data {
 struct exynos_pmu_context {
 	struct device *dev;
 	const struct exynos_pmu_data *pmu_data;
+	struct mfd_cell cells[MFD_MAX];
+	struct pmu_dev_client_data mfd_data;
 };
 
 static void __iomem *pmu_base_addr;
@@ -482,6 +491,8 @@ static int exynos_pmu_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	struct device *dev = &pdev->dev;
 	struct resource *res;
+	struct mfd_cell *cell;
+	int ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pmu_base_addr = devm_ioremap_resource(dev, res);
@@ -506,6 +517,20 @@ static int exynos_pmu_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pmu_context);
 
+	/* Initialize and invoke mfd clients */
+	cell = &pmu_context->cells[MFD_POWER_DOMAIN];
+	cell->name = "exynos-pmu-domain";
+	pmu_context->mfd_data.mem_base_addr = pmu_base_addr;
+	pmu_context->mfd_data.mem_size = resource_size(res);
+	cell->platform_data = &pmu_context->mfd_data;
+	cell->pdata_size = sizeof(pmu_context->mfd_data);
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
diff --git a/include/linux/mfd/samsung/exynos-pmu.h b/include/linux/mfd/samsung/exynos-pmu.h
index a2ab0d5..d2f4083 100644
--- a/include/linux/mfd/samsung/exynos-pmu.h
+++ b/include/linux/mfd/samsung/exynos-pmu.h
@@ -19,6 +19,11 @@ enum sys_powerdown {
 	NUM_SYS_POWERDOWN,
 };
 
+struct pmu_dev_client_data {
+	void __iomem *mem_base_addr;
+	unsigned int mem_size;
+};
+
 extern void exynos_sys_powerdown_conf(enum sys_powerdown mode);
 
 #endif /* __EXYNOS_PMU_H */
-- 
1.7.9.5
