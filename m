From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH 11/12] clk: samsung: save and restore clock registers for power
 domain
Date: Mon, 03 Nov 2014 09:23:09 +0530
Message-ID: <1414986790-11940-12-git-send-email-amit.daniel@samsung.com>
References: <1414986790-11940-1-git-send-email-amit.daniel@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1414986790-11940-1-git-send-email-amit.daniel@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: kgene.kim@samsung.com, pankaj.dubey@samsung.com, Amit Daniel Kachhap <amit.daniel@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@linaro.org>
List-Id: linux-pm@vger.kernel.org

This patch adds support for save and restore for clock registers
which loses register contents across power domain off/on sequence.

Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Mike Turquette <mturquette@linaro.org>
Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 drivers/clk/samsung/clk.c |   66 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/samsung/clk.h |   14 ++++++++++
 2 files changed, 80 insertions(+)

diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index dd1f7c9..9fd1369 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -11,10 +11,12 @@
  * clock framework for Samsung platforms.
 */
 
+#include <linux/pm_domain.h>
 #include <linux/syscore_ops.h>
 #include "clk.h"
 
 static LIST_HEAD(clock_reg_cache_list);
+static LIST_HEAD(clock_pd_reg_cache_list);
 
 void samsung_clk_save(void __iomem *base,
 				    struct samsung_clk_reg_dump *rd,
@@ -370,6 +372,67 @@ static void samsung_clk_sleep_init(void __iomem *reg_base,
 		unsigned long nr_rdump) {}
 #endif
 
+static int samsung_power_domain_notifier(struct notifier_block *nb,
+				    unsigned long event, void *data)
+{
+	struct generic_pm_domain *genpd = data;
+	struct samsung_clock_pd_reg_cache *reg_cache;
+
+	switch (event) {
+	case GPD_OFF_PRE:
+		/* save all the pd domain clock registers */
+		list_for_each_entry(reg_cache, &clock_pd_reg_cache_list, node)
+			if (!strcmp(reg_cache->pd_name, genpd->name))
+				samsung_clk_save(reg_cache->reg_base,
+						reg_cache->rdump,
+						reg_cache->rd_num);
+		break;
+	case GPD_ON_POST:
+		/* restore all the pd domain clock registers */
+		list_for_each_entry(reg_cache, &clock_pd_reg_cache_list, node)
+			if (!strcmp(reg_cache->pd_name, genpd->name))
+				samsung_clk_restore(reg_cache->reg_base,
+						reg_cache->rdump,
+						reg_cache->rd_num);
+		break;
+	case GPD_OFF_POST:
+	case GPD_ON_PRE:
+		break;
+	default:
+		pr_err("%s: Invalid pm domain event\n", __func__);
+	}
+	return 0;
+}
+
+/* Notifier for power domain on/off changes */
+static struct notifier_block power_domain_notifier_block = {
+	.notifier_call = samsung_power_domain_notifier,
+};
+
+static void samsung_clk_pd_init(void __iomem *reg_base,
+		const unsigned long *rdump, unsigned long nr_rdump,
+		char *pd_name)
+{
+	struct samsung_clock_pd_reg_cache *pd_reg_cache;
+
+	pd_reg_cache = kzalloc(sizeof(struct samsung_clock_pd_reg_cache),
+			GFP_KERNEL);
+	if (!pd_reg_cache)
+		panic("could not allocate register reg_cache.\n");
+
+	pd_reg_cache->rdump = samsung_clk_alloc_reg_dump(rdump, nr_rdump);
+
+	if (!pd_reg_cache->rdump)
+		panic("could not allocate register dump storage.\n");
+
+	pd_reg_cache->reg_base = reg_base;
+	pd_reg_cache->rd_num = nr_rdump;
+	pd_reg_cache->pd_name = pd_name;
+	list_add_tail(&pd_reg_cache->node, &clock_pd_reg_cache_list);
+
+	genpd_register_notifier(&power_domain_notifier_block, pd_name);
+}
+
 /*
  * Common function which registers plls, muxes, dividers and gates
  * for each CMU. It also add CMU register list to register cache.
@@ -408,6 +471,9 @@ void __init samsung_cmu_register_one(struct device_node *np,
 	if (cmu->clk_regs)
 		samsung_clk_sleep_init(reg_base, cmu->clk_regs,
 			cmu->nr_clk_regs);
+	if (cmu->pd_clk_regs)
+		samsung_clk_pd_init(reg_base, cmu->pd_clk_regs,
+			cmu->nr_clk_regs, cmu->pd_name);
 
 	samsung_clk_of_add_provider(np, ctx);
 }
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index 3f471e9..f67f5e5 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -331,6 +331,14 @@ struct samsung_clock_reg_cache {
 	unsigned int rd_num;
 };
 
+struct samsung_clock_pd_reg_cache {
+	struct list_head node;
+	void __iomem *reg_base;
+	struct samsung_clk_reg_dump *rdump;
+	unsigned int rd_num;
+	char *pd_name;
+};
+
 struct samsung_cmu_info {
 	/* list of pll clocks and respective count */
 	struct samsung_pll_clock *pll_clks;
@@ -356,6 +364,12 @@ struct samsung_cmu_info {
 	/* list and number of clocks registers */
 	unsigned long *clk_regs;
 	unsigned int nr_clk_regs;
+
+	/* list and number of clocks to be saved/restored during
+	 * power domain shutdown */
+	char *pd_name;
+	unsigned long *pd_clk_regs;
+	unsigned int nr_pd_clk_regs;
 };
 
 extern struct samsung_clk_provider *__init samsung_clk_init(
-- 
1.7.9.5
