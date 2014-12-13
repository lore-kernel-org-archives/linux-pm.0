From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH RFC v3 2/2] clk: samsung: Add PM runtime support for clocks.
Date: Sat, 13 Dec 2014 22:21:58 +0530
Message-ID: <1418489518-7252-2-git-send-email-amit.daniel@samsung.com>
References: <1418489518-7252-1-git-send-email-amit.daniel@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1418489518-7252-1-git-send-email-amit.daniel@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, khilman@linaro.org, rjw@rjwysocki.net, len.brown@intel.com, ulf.hansson@linaro.org, tomasz.figa@gmail.com, kgene.kim@samsung.com, s.nawrocki@samsung.com, thomas.ab@samsung.com, pankaj.dubey@samsung.com, m.szyprowski@samsung.com, geert+renesas@glider.be, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Amit Daniel Kachhap <amit.daniel@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch adds PM runtime support for clocks associated with Power
Domain. The PM runtime suspend/resume handlers will be called when the
power domain associated with it, is turned on/off.

The registration of clocks happen in early initailisation. The probe
is later called to register the clock device with the power domain.

Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 drivers/clk/samsung/clk.c | 95 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/samsung/clk.h | 11 ++++++
 2 files changed, 106 insertions(+)

diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index dd1f7c9..c517aa8 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -11,6 +11,10 @@
  * clock framework for Samsung platforms.
 */
 
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
 #include <linux/syscore_ops.h>
 #include "clk.h"
 
@@ -370,6 +374,93 @@ static void samsung_clk_sleep_init(void __iomem *reg_base,
 		unsigned long nr_rdump) {}
 #endif
 
+static int samsung_cmu_runtime_suspend(struct device *dev)
+{
+	struct samsung_clock_pd_reg_cache *reg_cache;
+
+	reg_cache = dev_get_drvdata(dev);
+	samsung_clk_save(reg_cache->reg_base, reg_cache->rdump,
+			reg_cache->rd_num);
+	return 0;
+}
+
+static int samsung_cmu_runtime_resume(struct device *dev)
+{
+	struct samsung_clock_pd_reg_cache *reg_cache;
+
+	reg_cache = dev_get_drvdata(dev);
+	samsung_clk_restore(reg_cache->reg_base, reg_cache->rdump,
+			reg_cache->rd_num);
+	return 0;
+}
+
+#define MAX_CMU_DEVICE_MATCH	50
+static int samsung_cmu_count;
+static struct of_device_id samsung_cmu_match[MAX_CMU_DEVICE_MATCH];
+MODULE_DEVICE_TABLE(of, samsung_cmu_match);
+
+static void samsung_clk_pd_init(struct device_node *np, void __iomem *reg_base,
+				struct samsung_cmu_info *cmu)
+{
+	struct samsung_clock_pd_reg_cache *pd_reg_cache;
+	const char *name;
+
+	if (samsung_cmu_count == MAX_CMU_DEVICE_MATCH)
+		panic("Maximum clock device limit reached.\n");
+
+	if (of_property_read_string_index(np, "compatible", 0, &name))
+		panic("Invalid DT node.\n");
+
+	pd_reg_cache = kzalloc(sizeof(struct samsung_clock_pd_reg_cache),
+			GFP_KERNEL);
+	if (!pd_reg_cache)
+		panic("Could not allocate register reg_cache.\n");
+
+	pd_reg_cache->rdump = samsung_clk_alloc_reg_dump(cmu->pd_clk_regs,
+				cmu->nr_pd_clk_regs);
+	if (!pd_reg_cache->rdump)
+		panic("Could not allocate register dump storage.\n");
+
+	pd_reg_cache->reg_base = reg_base;
+	pd_reg_cache->rd_num = cmu->nr_pd_clk_regs;
+
+	/* Fill up the compatible string and data */
+	samsung_cmu_match[samsung_cmu_count].data = pd_reg_cache;
+	strcpy(samsung_cmu_match[samsung_cmu_count].compatible, name);
+	samsung_cmu_count++;
+}
+
+static int __init samsung_cmu_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct of_device_id *match;
+
+	/* get the platform data */
+	match = (struct of_device_id *)of_match_node(samsung_cmu_match,
+							pdev->dev.of_node);
+	if (!match)
+		return 0;
+	platform_set_drvdata(pdev, (void *)match->data);
+	pm_runtime_enable(dev);
+	pm_genpd_dev_need_restore(dev,
+				GPD_DEV_RESTORE_FORCE | GPD_DEV_SUSPEND_INIT);
+	return 0;
+}
+
+static const struct dev_pm_ops samsung_cmu_pm_ops = {
+	SET_RUNTIME_PM_OPS(samsung_cmu_runtime_suspend,
+			samsung_cmu_runtime_resume, NULL)
+};
+
+static struct platform_driver samsung_cmu_driver = {
+	.driver = {
+		.name   = "exynos-clk",
+		.of_match_table = samsung_cmu_match,
+		.pm = &samsung_cmu_pm_ops,
+	},
+	.probe = samsung_cmu_probe,
+};
+
 /*
  * Common function which registers plls, muxes, dividers and gates
  * for each CMU. It also add CMU register list to register cache.
@@ -409,5 +500,9 @@ void __init samsung_cmu_register_one(struct device_node *np,
 		samsung_clk_sleep_init(reg_base, cmu->clk_regs,
 			cmu->nr_clk_regs);
 
+	if (cmu->pd_clk_regs)
+		samsung_clk_pd_init(np, reg_base, cmu);
+
 	samsung_clk_of_add_provider(np, ctx);
 }
+module_platform_driver(samsung_cmu_driver);
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index 3f471e9..c184ec1 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -331,6 +331,12 @@ struct samsung_clock_reg_cache {
 	unsigned int rd_num;
 };
 
+struct samsung_clock_pd_reg_cache {
+	void __iomem *reg_base;
+	struct samsung_clk_reg_dump *rdump;
+	unsigned int rd_num;
+};
+
 struct samsung_cmu_info {
 	/* list of pll clocks and respective count */
 	struct samsung_pll_clock *pll_clks;
@@ -356,6 +362,11 @@ struct samsung_cmu_info {
 	/* list and number of clocks registers */
 	unsigned long *clk_regs;
 	unsigned int nr_clk_regs;
+
+	/* list and number of clocks to be saved/restored during
+	 * power domain shutdown */
+	unsigned long *pd_clk_regs;
+	unsigned int nr_pd_clk_regs;
 };
 
 extern struct samsung_clk_provider *__init samsung_clk_init(
-- 
2.2.0
