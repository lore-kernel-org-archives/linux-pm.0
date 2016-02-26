From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V6 07/10] soc: tegra: pmc: Add generic PM domain support
Date: Fri, 26 Feb 2016 15:48:41 +0000
Message-ID: <1456501724-28477-8-git-send-email-jonathanh@nvidia.com>
References: <1456501724-28477-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:4809 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933449AbcBZPtS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2016 10:49:18 -0500
In-Reply-To: <1456501724-28477-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>

Adds generic PM support to the PMC driver where the PM domains are
populated from device-tree and the PM domain consumer devices are
bound to their relevant PM domains via device-tree as well.

Update the tegra_powergate_sequence_power_up() API so that internally
it calls the same tegra_powergate_xxx functions that are used by the
tegra generic power domain code for consistency.

To ensure that the Tegra power domains (a.k.a powergates) cannot be
controlled via both the legacy tegra_powergate_xxx functions as well
as the generic PM domain framework, add a bit map for available
powergates that can be controlled via the legacy powergate functions.

Move the majority of the tegra_powergate_remove_clamping() function
to a sub-function, so that this can be used by both the legacy and
generic power domain code.

This is based upon work by Thierry Reding <treding@nvidia.com>
and Vince Hsu <vinceh@nvidia.com>.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 585 ++++++++++++++++++++++++++++++++++++++++++------
 include/soc/tegra/pmc.h |   1 +
 2 files changed, 522 insertions(+), 64 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 08966c26d65c..9d2d204342c5 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -31,10 +31,13 @@
 #include <linux/iopoll.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/reboot.h>
 #include <linux/reset.h>
 #include <linux/seq_file.h>
+#include <linux/slab.h>
 #include <linux/spinlock.h>
 
 #include <soc/tegra/common.h>
@@ -102,6 +105,18 @@
 
 #define GPU_RG_CNTRL			0x2d4
 
+struct tegra_powergate {
+	struct generic_pm_domain genpd;
+	struct generic_pm_domain *parent;
+	struct tegra_pmc *pmc;
+	unsigned int id;
+	struct device_node *of_node;
+	struct clk **clks;
+	unsigned int num_clks;
+	struct reset_control **resets;
+	unsigned int num_resets;
+};
+
 struct tegra_pmc_soc {
 	unsigned int num_powergates;
 	const char *const *powergates;
@@ -132,6 +147,7 @@ struct tegra_pmc_soc {
  * @cpu_pwr_good_en: CPU power good signal is enabled
  * @lp0_vec_phys: physical base address of the LP0 warm boot code
  * @lp0_vec_size: size of the LP0 warm boot code
+ * @powergates_available: Bitmap of available power gates
  * @powergates_lock: mutex for power gate register access
  */
 struct tegra_pmc {
@@ -156,6 +172,7 @@ struct tegra_pmc {
 	bool cpu_pwr_good_en;
 	u32 lp0_vec_phys;
 	u32 lp0_vec_size;
+	DECLARE_BITMAP(powergates_available, TEGRA_POWERGATE_MAX);
 
 	struct mutex powergates_lock;
 };
@@ -165,6 +182,12 @@ static struct tegra_pmc *pmc = &(struct tegra_pmc) {
 	.suspend_mode = TEGRA_SUSPEND_NONE,
 };
 
+static inline struct tegra_powergate *
+to_powergate(struct generic_pm_domain *domain)
+{
+	return container_of(domain, struct tegra_powergate, genpd);
+}
+
 static u32 tegra_pmc_readl(unsigned long offset)
 {
 	return readl(pmc->base + offset);
@@ -188,6 +211,11 @@ static inline bool tegra_powergate_is_valid(int id)
 	return (pmc->soc && pmc->soc->powergates[id]);
 }
 
+static inline bool tegra_powergate_is_available(int id)
+{
+	return test_bit(id, pmc->powergates_available);
+}
+
 /**
  * tegra_powergate_set() - set the state of a partition
  * @id: partition ID
@@ -218,13 +246,219 @@ static int tegra_powergate_set(unsigned int id, bool new_state)
 	return err;
 }
 
+static int __tegra_powergate_remove_clamping(unsigned int id)
+{
+	u32 mask;
+
+	mutex_lock(&pmc->powergates_lock);
+
+	/*
+	 * On Tegra124 and later, the clamps for the GPU are controlled by a
+	 * separate register (with different semantics).
+	 */
+	if (id == TEGRA_POWERGATE_3D) {
+		if (pmc->soc->has_gpu_clamps) {
+			tegra_pmc_writel(0, GPU_RG_CNTRL);
+			goto out;
+		}
+	}
+
+	/*
+	 * Tegra 2 has a bug where PCIE and VDE clamping masks are
+	 * swapped relatively to the partition ids
+	 */
+	if (id == TEGRA_POWERGATE_VDEC)
+		mask = (1 << TEGRA_POWERGATE_PCIE);
+	else if (id == TEGRA_POWERGATE_PCIE)
+		mask = (1 << TEGRA_POWERGATE_VDEC);
+	else
+		mask = (1 << id);
+
+	tegra_pmc_writel(mask, REMOVE_CLAMPING);
+
+out:
+	mutex_unlock(&pmc->powergates_lock);
+
+	return 0;
+}
+
+static void tegra_powergate_disable_clocks(struct tegra_powergate *pg)
+{
+	unsigned int i;
+
+	for (i = 0; i < pg->num_clks; i++)
+		clk_disable_unprepare(pg->clks[i]);
+}
+
+static int tegra_powergate_enable_clocks(struct tegra_powergate *pg)
+{
+	unsigned int i;
+	int err;
+
+	for (i = 0; i < pg->num_clks; i++) {
+		err = clk_prepare_enable(pg->clks[i]);
+		if (err)
+			goto out;
+	}
+
+	return 0;
+
+out:
+	while (i--)
+		clk_disable_unprepare(pg->clks[i]);
+
+	return err;
+}
+
+static int tegra_powergate_reset_assert(struct tegra_powergate *pg)
+{
+	unsigned int i;
+	int err;
+
+	for (i = 0; i < pg->num_resets; i++) {
+		err = reset_control_assert(pg->resets[i]);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int tegra_powergate_reset_deassert(struct tegra_powergate *pg)
+{
+	unsigned int i;
+	int err;
+
+	for (i = 0; i < pg->num_resets; i++) {
+		err = reset_control_deassert(pg->resets[i]);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int tegra_powergate_power_up(struct tegra_powergate *pg,
+				    bool disable_clocks)
+{
+	int err;
+
+	err = tegra_powergate_reset_assert(pg);
+	if (err)
+		return err;
+
+	usleep_range(10, 20);
+
+	err = tegra_powergate_set(pg->id, true);
+	if (err < 0)
+		return err;
+
+	usleep_range(10, 20);
+
+	err = tegra_powergate_enable_clocks(pg);
+	if (err)
+		goto disable_clks;
+
+	usleep_range(10, 20);
+
+	err = __tegra_powergate_remove_clamping(pg->id);
+	if (err)
+		goto disable_clks;
+
+	usleep_range(10, 20);
+
+	err = tegra_powergate_reset_deassert(pg);
+	if (err)
+		goto powergate_off;
+
+	usleep_range(10, 20);
+
+	if (disable_clocks)
+		tegra_powergate_disable_clocks(pg);
+
+	return 0;
+
+disable_clks:
+	tegra_powergate_disable_clocks(pg);
+	usleep_range(10, 20);
+powergate_off:
+	tegra_powergate_set(pg->id, false);
+
+	return err;
+}
+
+static int tegra_powergate_power_down(struct tegra_powergate *pg)
+{
+	int err;
+
+	err = tegra_powergate_enable_clocks(pg);
+	if (err)
+		return err;
+
+	usleep_range(10, 20);
+
+	err = tegra_powergate_reset_assert(pg);
+	if (err)
+		goto disable_clks;
+
+	usleep_range(10, 20);
+
+	tegra_powergate_disable_clocks(pg);
+
+	usleep_range(10, 20);
+
+	err = tegra_powergate_set(pg->id, false);
+	if (err)
+		goto assert_resets;
+
+	return 0;
+
+assert_resets:
+	tegra_powergate_enable_clocks(pg);
+	usleep_range(10, 20);
+	tegra_powergate_reset_deassert(pg);
+	usleep_range(10, 20);
+disable_clks:
+	tegra_powergate_disable_clocks(pg);
+
+	return err;
+}
+
+static int tegra_genpd_power_on(struct generic_pm_domain *domain)
+{
+	struct tegra_powergate *pg = to_powergate(domain);
+	struct tegra_pmc *pmc = pg->pmc;
+	int err;
+
+	err = tegra_powergate_power_up(pg, true);
+	if (err)
+		dev_err(pmc->dev, "failed to turn on PM domain %s: %d\n",
+			pg->of_node->name, err);
+
+	return err;
+}
+
+static int tegra_genpd_power_off(struct generic_pm_domain *domain)
+{
+	struct tegra_powergate *pg = to_powergate(domain);
+	struct tegra_pmc *pmc = pg->pmc;
+	int err;
+
+	err = tegra_powergate_power_down(pg);
+	if (err)
+		dev_err(pmc->dev, "failed to turn off PM domain %s: %d\n",
+			pg->of_node->name, err);
+
+	return err;
+}
+
 /**
  * tegra_powergate_power_on() - power on partition
  * @id: partition ID
  */
 int tegra_powergate_power_on(unsigned int id)
 {
-	if (!tegra_powergate_is_valid(id))
+	if (!tegra_powergate_is_available(id))
 		return -EINVAL;
 
 	return tegra_powergate_set(id, true);
@@ -236,7 +470,7 @@ int tegra_powergate_power_on(unsigned int id)
  */
 int tegra_powergate_power_off(unsigned int id)
 {
-	if (!tegra_powergate_is_valid(id))
+	if (!tegra_powergate_is_available(id))
 		return -EINVAL;
 
 	return tegra_powergate_set(id, false);
@@ -267,41 +501,10 @@ int tegra_powergate_is_powered(unsigned int id)
  */
 int tegra_powergate_remove_clamping(unsigned int id)
 {
-	u32 mask;
-
-	if (!tegra_powergate_is_valid(id))
+	if (!tegra_powergate_is_available(id))
 		return -EINVAL;
 
-	mutex_lock(&pmc->powergates_lock);
-
-	/*
-	 * On Tegra124 and later, the clamps for the GPU are controlled by a
-	 * separate register (with different semantics).
-	 */
-	if (id == TEGRA_POWERGATE_3D) {
-		if (pmc->soc->has_gpu_clamps) {
-			tegra_pmc_writel(0, GPU_RG_CNTRL);
-			goto out;
-		}
-	}
-
-	/*
-	 * Tegra 2 has a bug where PCIE and VDE clamping masks are
-	 * swapped relatively to the partition ids
-	 */
-	if (id == TEGRA_POWERGATE_VDEC)
-		mask = (1 << TEGRA_POWERGATE_PCIE);
-	else if (id == TEGRA_POWERGATE_PCIE)
-		mask = (1 << TEGRA_POWERGATE_VDEC);
-	else
-		mask = (1 << id);
-
-	tegra_pmc_writel(mask, REMOVE_CLAMPING);
-
-out:
-	mutex_unlock(&pmc->powergates_lock);
-
-	return 0;
+	return __tegra_powergate_remove_clamping(id);
 }
 EXPORT_SYMBOL(tegra_powergate_remove_clamping);
 
@@ -316,35 +519,20 @@ EXPORT_SYMBOL(tegra_powergate_remove_clamping);
 int tegra_powergate_sequence_power_up(unsigned int id, struct clk *clk,
 				      struct reset_control *rst)
 {
-	int ret;
-
-	reset_control_assert(rst);
-
-	ret = tegra_powergate_power_on(id);
-	if (ret)
-		goto err_power;
-
-	ret = clk_prepare_enable(clk);
-	if (ret)
-		goto err_clk;
-
-	usleep_range(10, 20);
-
-	ret = tegra_powergate_remove_clamping(id);
-	if (ret)
-		goto err_clamp;
+	struct tegra_powergate pg;
+	int err;
 
-	usleep_range(10, 20);
-	reset_control_deassert(rst);
+	pg.id = id;
+	pg.clks = &clk;
+	pg.num_clks = 1;
+	pg.resets = &rst;
+	pg.num_resets = 1;
 
-	return 0;
+	err = tegra_powergate_power_up(&pg, false);
+	if (err)
+		pr_err("failed to turn on partition %d: %d\n", id, err);
 
-err_clamp:
-	clk_disable_unprepare(clk);
-err_clk:
-	tegra_powergate_power_off(id);
-err_power:
-	return ret;
+	return err;
 }
 EXPORT_SYMBOL(tegra_powergate_sequence_power_up);
 
@@ -486,6 +674,259 @@ static int tegra_powergate_debugfs_init(void)
 	return 0;
 }
 
+static int tegra_powergate_of_get_clks(struct device *dev,
+				       struct tegra_powergate *pg)
+{
+	struct clk *clk;
+	unsigned int i, count;
+	int err;
+
+	count = of_count_phandle_with_args(pg->of_node, "clocks",
+					   "#clock-cells");
+	if (count == 0)
+		return -ENODEV;
+
+	pg->clks = devm_kcalloc(dev, count, sizeof(clk), GFP_KERNEL);
+	if (!pg->clks)
+		return -ENOMEM;
+
+	for (i = 0; i < count; i++) {
+		pg->clks[i] = of_clk_get(pg->of_node, i);
+		if (IS_ERR(pg->clks[i])) {
+			err = PTR_ERR(pg->clks[i]);
+			goto err;
+		}
+	}
+
+	pg->num_clks = count;
+
+	return 0;
+
+err:
+	while (i--)
+		clk_put(pg->clks[i]);
+
+	return err;
+}
+
+static int tegra_powergate_of_get_resets(struct device *dev,
+					 struct tegra_powergate *pg)
+{
+	struct reset_control *rst;
+	unsigned int i, count;
+	int err;
+
+	count = of_count_phandle_with_args(pg->of_node, "resets",
+					   "#reset-cells");
+	if (count == 0)
+		return -ENODEV;
+
+	pg->resets = devm_kcalloc(dev, count, sizeof(rst), GFP_KERNEL);
+	if (!pg->resets)
+		return -ENOMEM;
+
+	for (i = 0; i < count; i++) {
+		pg->resets[i] = of_reset_control_get_by_index(pg->of_node, i);
+		if (IS_ERR(pg->resets[i])) {
+			err = PTR_ERR(pg->resets[i]);
+			goto error;
+		}
+	}
+
+	pg->num_resets = count;
+
+	return 0;
+
+error:
+	while (i--)
+		reset_control_put(pg->resets[i]);
+
+	return err;
+}
+
+static struct tegra_powergate *
+tegra_powergate_add_one(struct tegra_pmc *pmc, struct device_node *np,
+			struct generic_pm_domain *parent)
+{
+	struct tegra_powergate *pg;
+	const __be32 *reg;
+	unsigned int id;
+	bool off;
+	int err;
+
+	/*
+	 * If the powergate ID is missing or invalid then return NULL
+	 * to skip this one and allow any others to be created.
+	 */
+	reg = of_get_property(np, "reg", NULL);
+	if (!reg) {
+		dev_WARN(pmc->dev, "reg node missing for %s\n", np->name);
+		return NULL;
+	}
+
+	id = be32_to_cpup(reg);
+
+	if (!tegra_powergate_is_available(id)) {
+		dev_WARN(pmc->dev, "%s powergate is not available\n", np->name);
+		return NULL;
+	}
+
+	/*
+	 * Clear the bit for this powergate so it cannot be managed
+	 * directly via the legacy APIs for controlling powergates.
+	 */
+	clear_bit(id, pmc->powergates_available);
+
+	pg = kzalloc(sizeof(*pg), GFP_KERNEL);
+	if (!pg) {
+		err = -ENOMEM;
+		goto set_available;
+	}
+
+	pg->id = id;
+	pg->of_node = np;
+	pg->parent = parent;
+	pg->genpd.owner = pmc->dev;
+	pg->genpd.name = np->name;
+	pg->genpd.power_off = tegra_genpd_power_off;
+	pg->genpd.power_on = tegra_genpd_power_on;
+	pg->pmc = pmc;
+
+	err = tegra_powergate_of_get_clks(pmc->dev, pg);
+	if (err)
+		goto free_mem;
+
+	err = tegra_powergate_of_get_resets(pmc->dev, pg);
+	if (err)
+		goto remove_clks;
+
+	off = !tegra_powergate_is_powered(pg->id);
+
+	pm_genpd_init(&pg->genpd, NULL, off);
+
+	if (pg->parent) {
+		err = pm_genpd_add_subdomain(pg->parent, &pg->genpd);
+		if (err)
+			goto remove_domain_and_resets;
+	}
+
+	err = of_genpd_add_provider_simple(pg->of_node, &pg->genpd);
+	if (err)
+		goto remove_subdomain;
+
+	dev_dbg(pmc->dev, "added power domain %s\n", pg->genpd.name);
+
+	return pg;
+
+remove_subdomain:
+	if (pg->parent)
+		if (WARN_ON(pm_genpd_remove_subdomain(pg->parent, &pg->genpd)))
+			goto error;
+
+remove_domain_and_resets:
+	if (WARN_ON(pm_genpd_remove(&pg->genpd)))
+		goto error;
+
+	while (pg->num_resets--)
+		reset_control_put(pg->resets[pg->num_resets]);
+
+remove_clks:
+	while (pg->num_clks--)
+		clk_put(pg->clks[pg->num_clks]);
+
+free_mem:
+	kfree(pg);
+
+set_available:
+	set_bit(id, pmc->powergates_available);
+
+error:
+	dev_err(pmc->dev, "failed to create power domain for node %s\n",
+		np->name);
+
+	return ERR_PTR(err);
+}
+
+static int tegra_powergate_add(struct tegra_pmc *pmc, struct device_node *np,
+			       struct generic_pm_domain *parent)
+{
+	struct tegra_powergate *pg;
+	struct device_node *child;
+	int err = 0;
+
+	for_each_child_of_node(np, child) {
+		pg = tegra_powergate_add_one(pmc, child, parent);
+		if (IS_ERR(pg)) {
+			err = PTR_ERR(pg);
+			goto error;
+		}
+
+		if (pg)
+			err = tegra_powergate_add(pmc, child, &pg->genpd);
+
+error:
+		of_node_put(child);
+
+		if (err)
+			break;
+	}
+
+	return err;
+}
+
+static void tegra_powergate_remove(struct tegra_pmc *pmc)
+{
+	struct generic_pm_domain *genpd = pm_genpd_list_get_tail(pmc->dev);
+	struct tegra_powergate *pg;
+
+	while (genpd) {
+		pg = to_powergate(genpd);
+
+		of_genpd_del_provider(pg->of_node);
+
+		if (pg->parent) {
+			if (WARN_ON(pm_genpd_remove_subdomain(pg->parent,
+							      &pg->genpd)))
+				return;
+
+			pg->parent = NULL;
+		}
+
+		if (WARN_ON(pm_genpd_remove(&pg->genpd)))
+			return;
+
+		while (pg->num_clks--)
+			clk_put(pg->clks[pg->num_clks]);
+
+		while (pg->num_resets--)
+			reset_control_put(pg->resets[pg->num_resets]);
+
+		kfree(pg);
+
+		set_bit(pg->id, pmc->powergates_available);
+
+		genpd = pm_genpd_list_get_tail(pmc->dev);
+	}
+}
+
+static int tegra_powergate_init(struct tegra_pmc *pmc)
+{
+	struct device_node *np;
+	int err;
+
+	np = of_get_child_by_name(pmc->dev->of_node, "powergates");
+	if (!np)
+		return 0;
+
+	err = tegra_powergate_add(pmc, np, NULL);
+	if (err)
+		tegra_powergate_remove(pmc);
+
+	of_node_put(np);
+
+	return err;
+}
+
 static int tegra_io_rail_prepare(unsigned int id, unsigned long *request,
 				 unsigned long *status, unsigned int *bit)
 {
@@ -873,18 +1314,21 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 
 	tegra_pmc_init_tsense_reset(pmc);
 
+	err = tegra_powergate_init(pmc);
+	if (err < 0)
+		return err;
+
 	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
 		err = tegra_powergate_debugfs_init();
 		if (err < 0)
-			return err;
+			goto remove_powergates;
 	}
 
 	err = register_restart_handler(&tegra_pmc_restart_handler);
 	if (err) {
-		debugfs_remove(pmc->debugfs);
 		dev_err(&pdev->dev, "unable to register restart handler, %d\n",
 			err);
-		return err;
+		goto remove_debugfs;
 	}
 
 	mutex_lock(&pmc->powergates_lock);
@@ -893,6 +1337,13 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 	mutex_unlock(&pmc->powergates_lock);
 
 	return 0;
+
+remove_debugfs:
+	debugfs_remove(pmc->debugfs);
+remove_powergates:
+	tegra_powergate_remove(pmc);
+
+	return err;
 }
 
 #if defined(CONFIG_PM_SLEEP) && defined(CONFIG_ARM)
@@ -1120,6 +1571,7 @@ static int __init tegra_pmc_early_init(void)
 	const struct of_device_id *match;
 	struct device_node *np;
 	struct resource regs;
+	unsigned int i;
 	bool invert;
 	u32 value;
 
@@ -1169,6 +1621,11 @@ static int __init tegra_pmc_early_init(void)
 		return -ENXIO;
 	}
 
+	/* Create a bit-map of the available and valid partitions */
+	for (i = 0; i < pmc->soc->num_powergates; i++)
+		if (pmc->soc->powergates[i])
+			set_bit(i, pmc->powergates_available);
+
 	mutex_init(&pmc->powergates_lock);
 
 	/*
diff --git a/include/soc/tegra/pmc.h b/include/soc/tegra/pmc.h
index 07e332dd44fb..e9e53473a63e 100644
--- a/include/soc/tegra/pmc.h
+++ b/include/soc/tegra/pmc.h
@@ -72,6 +72,7 @@ int tegra_pmc_cpu_remove_clamping(unsigned int cpuid);
 #define TEGRA_POWERGATE_AUD	27
 #define TEGRA_POWERGATE_DFD	28
 #define TEGRA_POWERGATE_VE2	29
+#define TEGRA_POWERGATE_MAX	TEGRA_POWERGATE_VE2
 
 #define TEGRA_POWERGATE_3D0	TEGRA_POWERGATE_3D
 
-- 
2.1.4

