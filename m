From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V5 11/14] soc: tegra: pmc: Add generic PM domain support
Date: Thu, 28 Jan 2016 16:33:49 +0000
Message-ID: <1453998832-27383-12-git-send-email-jonathanh@nvidia.com>
References: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1453998832-27383-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Adds generic PM support to the PMC driver where the PM domains are
populated from device-tree and the PM domain consumer devices are
bound to their relevant PM domains via device-tree as well.

Update the tegra_powergate_sequence_power_up() API so that internally
it calls the same tegra_powergate_xxx functions that are used by the
tegra generic power domain code for consistency.

This is based upon work by Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
and Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>.

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/soc/tegra/pmc.c                     | 470 ++++++++++++++++++++++++++--
 include/dt-bindings/power/tegra-powergate.h |  36 +++
 include/soc/tegra/pmc.h                     |  39 +--
 3 files changed, 480 insertions(+), 65 deletions(-)
 create mode 100644 include/dt-bindings/power/tegra-powergate.h

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index ecb4f66819fd..915dc37e0d92 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -19,6 +19,8 @@
 
 #define pr_fmt(fmt) "tegra-pmc: " fmt
 
+#include <dt-bindings/power/tegra-powergate.h>
+
 #include <linux/kernel.h>
 #include <linux/clk.h>
 #include <linux/clk/tegra.h>
@@ -31,7 +33,9 @@
 #include <linux/iopoll.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/reboot.h>
 #include <linux/reset.h>
 #include <linux/seq_file.h>
@@ -102,6 +106,19 @@
 
 #define GPU_RG_CNTRL			0x2d4
 
+struct tegra_powergate {
+	struct generic_pm_domain genpd;
+	struct generic_pm_domain *parent;
+	struct tegra_pmc *pmc;
+	unsigned int id;
+	struct list_head node;
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
@@ -134,6 +151,7 @@ struct tegra_pmc_soc {
  * @lp0_vec_phys: physical base address of the LP0 warm boot code
  * @lp0_vec_size: size of the LP0 warm boot code
  * @powergates_valid: Bitmap of valid power gates
+ * @powergates_list: list of power gates
  * @powergates_lock: mutex for power gate register access
  */
 struct tegra_pmc {
@@ -160,6 +178,7 @@ struct tegra_pmc {
 	u32 lp0_vec_size;
 	DECLARE_BITMAP(powergates_valid, TEGRA_POWERGATE_MAX);
 
+	struct list_head powergates_list;
 	struct mutex powergates_lock;
 };
 
@@ -168,6 +187,12 @@ static struct tegra_pmc *pmc = &(struct tegra_pmc) {
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
@@ -218,6 +243,174 @@ static int tegra_powergate_set(unsigned int id, bool new_state)
 	return err;
 }
 
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
+		goto err_clks;
+
+	usleep_range(10, 20);
+
+	tegra_powergate_remove_clamping(pg->id);
+
+	usleep_range(10, 20);
+
+	err = tegra_powergate_reset_deassert(pg);
+	if (err)
+		goto err_reset;
+
+	usleep_range(10, 20);
+
+	if (disable_clocks)
+		tegra_powergate_disable_clocks(pg);
+
+	return 0;
+
+err_reset:
+	tegra_powergate_disable_clocks(pg);
+	usleep_range(10, 20);
+err_clks:
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
+		goto err_reset;
+
+	usleep_range(10, 20);
+
+	tegra_powergate_disable_clocks(pg);
+
+	usleep_range(10, 20);
+
+	err = tegra_powergate_set(pg->id, false);
+	if (err)
+		goto err_powergate;
+
+	return 0;
+
+err_powergate:
+	tegra_powergate_enable_clocks(pg);
+	usleep_range(10, 20);
+	tegra_powergate_reset_deassert(pg);
+	usleep_range(10, 20);
+err_reset:
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
@@ -319,35 +512,20 @@ EXPORT_SYMBOL(tegra_powergate_remove_clamping);
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
+	struct tegra_powergate pg;
+	int err;
 
-	ret = tegra_powergate_remove_clamping(id);
-	if (ret)
-		goto err_clamp;
+	pg.id = id;
+	pg.clks = &clk;
+	pg.num_clks = 1;
+	pg.resets = &rst;
+	pg.num_resets = 1;
 
-	usleep_range(10, 20);
-	reset_control_deassert(rst);
+	err = tegra_powergate_power_up(&pg, false);
+	if (err)
+		pr_err("failed to turn on partition %d: %d\n", id, err);
 
-	return 0;
-
-err_clamp:
-	clk_disable_unprepare(clk);
-err_clk:
-	tegra_powergate_power_off(id);
-err_power:
-	return ret;
+	return err;
 }
 EXPORT_SYMBOL(tegra_powergate_sequence_power_up);
 
@@ -487,6 +665,233 @@ static int tegra_powergate_debugfs_init(void)
 	return 0;
 }
 
+static int tegra_powergate_of_get_clks(struct device *dev,
+				       struct tegra_powergate *pg)
+{
+	struct clk *clk;
+	unsigned int i;
+	int err;
+
+	pg->num_clks = of_count_phandle_with_args(pg->of_node, "clocks",
+						  "#clock-cells");
+	if (pg->num_clks == 0)
+		return -ENODEV;
+
+	pg->clks = devm_kcalloc(dev, pg->num_clks, sizeof(clk), GFP_KERNEL);
+	if (!pg->clks)
+		return -ENOMEM;
+
+	for (i = 0; i < pg->num_clks; i++) {
+		pg->clks[i] = of_clk_get(pg->of_node, i);
+		if (IS_ERR(pg->clks[i])) {
+			err = PTR_ERR(pg->clks[i]);
+			goto err;
+		}
+	}
+
+	return 0;
+
+err:
+	while (i--)
+		clk_put(pg->clks[i]);
+
+	pg->num_clks = 0;
+
+	return err;
+}
+
+static int tegra_powergate_of_get_resets(struct device *dev,
+					 struct tegra_powergate *pg)
+{
+	struct reset_control *rst;
+	unsigned int i;
+	int err;
+
+	pg->num_resets = of_count_phandle_with_args(pg->of_node, "resets",
+					   "#reset-cells");
+	if (pg->num_resets == 0)
+		return -ENODEV;
+
+	pg->resets = devm_kcalloc(dev, pg->num_resets, sizeof(rst), GFP_KERNEL);
+	if (!pg->resets)
+		return -ENOMEM;
+
+	for (i = 0; i < pg->num_resets; i++) {
+		pg->resets[i] = of_reset_control_get_by_index(pg->of_node, i);
+		if (IS_ERR(pg->resets[i])) {
+			err = PTR_ERR(pg->resets[i]);
+			goto err;
+		}
+	}
+
+	return 0;
+
+err:
+	while (i--)
+		reset_control_put(pg->resets[i]);
+
+	pg->num_resets = 0;
+
+	return err;
+}
+
+static struct tegra_powergate *
+tegra_powergate_add_one(struct tegra_pmc *pmc, struct device_node *np,
+			struct generic_pm_domain *parent)
+{
+	struct tegra_powergate *pg;
+	unsigned int id;
+	bool off;
+	int err;
+
+	/*
+	 * If the powergate ID is missing or invalid then return NULL
+	 * to skip this one and allow any others to be created.
+	 */
+	err = of_property_read_u32(np, "nvidia,powergate", &id);
+	if (err) {
+		dev_WARN(pmc->dev, "no powergate ID for node %s\n", np->name);
+		return NULL;
+	}
+
+	if (!tegra_powergate_is_valid(id)) {
+		dev_WARN(pmc->dev, "powergate ID invalid for %s\n", np->name);
+		return NULL;
+	}
+
+	pg = devm_kzalloc(pmc->dev, sizeof(*pg), GFP_KERNEL);
+	if (!pg) {
+		err = -ENOMEM;
+		goto error;
+	}
+
+	pg->id = id;
+	pg->of_node = np;
+	pg->parent = parent;
+	pg->genpd.name = np->name;
+	pg->genpd.power_off = tegra_genpd_power_off;
+	pg->genpd.power_on = tegra_genpd_power_on;
+	pg->pmc = pmc;
+
+	err = tegra_powergate_of_get_clks(pmc->dev, pg);
+	if (err)
+		goto error;
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
+	list_add_tail(&pg->node, &pmc->powergates_list);
+
+	dev_dbg(pmc->dev, "added power domain %s\n", pg->genpd.name);
+
+	return pg;
+
+remove_subdomain:
+	WARN_ON(pm_genpd_remove_subdomain(pg->parent, &pg->genpd));
+remove_domain_and_resets:
+	WARN_ON(pm_genpd_remove(&pg->genpd));
+	while (pg->num_resets--)
+		reset_control_put(pg->resets[pg->num_resets]);
+remove_clks:
+	while (pg->num_clks--)
+		clk_put(pg->clks[pg->num_clks]);
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
+			goto err;
+		}
+
+		if (pg)
+			err = tegra_powergate_add(pmc, child, pg->parent);
+
+err:
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
+	struct tegra_powergate *pg, *n;
+
+	list_for_each_entry_safe(pg, n, &pmc->powergates_list, node) {
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
+		list_del(&pg->node);
+	}
+}
+
+static int tegra_powergate_init(struct tegra_pmc *pmc)
+{
+	struct device_node *np;
+	int err;
+
+	INIT_LIST_HEAD(&pmc->powergates_list);
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
@@ -880,24 +1285,31 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 
 	tegra_pmc_init_tsense_reset(pmc);
 
+	err = tegra_powergate_init(pmc);
+	if (err < 0)
+		goto error;
+
 	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
 		err = tegra_powergate_debugfs_init();
 		if (err < 0)
-			goto error;
+			goto remove_powergates;
 	}
 
 	err = register_restart_handler(&tegra_pmc_restart_handler);
 	if (err) {
-		debugfs_remove(pmc->debugfs);
 		dev_err(&pdev->dev, "unable to register restart handler, %d\n",
 			err);
-		goto error;
+		goto remove_debugfs;
 	}
 
 	iounmap(base);
 
 	return 0;
 
+remove_debugfs:
+	debugfs_remove(pmc->debugfs);
+remove_powergates:
+	tegra_powergate_remove(pmc);
 error:
 	mutex_lock(&pmc->powergates_lock);
 	pmc->base = base;
diff --git a/include/dt-bindings/power/tegra-powergate.h b/include/dt-bindings/power/tegra-powergate.h
new file mode 100644
index 000000000000..bcab501badfc
--- /dev/null
+++ b/include/dt-bindings/power/tegra-powergate.h
@@ -0,0 +1,36 @@
+#ifndef _DT_BINDINGS_POWER_TEGRA_POWERGATE_H
+#define _DT_BINDINGS_POWER_TEGRA_POWERGATE_H
+
+#define TEGRA_POWERGATE_CPU	0
+#define TEGRA_POWERGATE_3D	1
+#define TEGRA_POWERGATE_VENC	2
+#define TEGRA_POWERGATE_PCIE	3
+#define TEGRA_POWERGATE_VDEC	4
+#define TEGRA_POWERGATE_L2	5
+#define TEGRA_POWERGATE_MPE	6
+#define TEGRA_POWERGATE_HEG	7
+#define TEGRA_POWERGATE_SATA	8
+#define TEGRA_POWERGATE_CPU1	9
+#define TEGRA_POWERGATE_CPU2	10
+#define TEGRA_POWERGATE_CPU3	11
+#define TEGRA_POWERGATE_CELP	12
+#define TEGRA_POWERGATE_3D1	13
+#define TEGRA_POWERGATE_CPU0	14
+#define TEGRA_POWERGATE_C0NC	15
+#define TEGRA_POWERGATE_C1NC	16
+#define TEGRA_POWERGATE_SOR	17
+#define TEGRA_POWERGATE_DIS	18
+#define TEGRA_POWERGATE_DISB	19
+#define TEGRA_POWERGATE_XUSBA	20
+#define TEGRA_POWERGATE_XUSBB	21
+#define TEGRA_POWERGATE_XUSBC	22
+#define TEGRA_POWERGATE_VIC	23
+#define TEGRA_POWERGATE_IRAM	24
+#define TEGRA_POWERGATE_NVDEC	25
+#define TEGRA_POWERGATE_NVJPG	26
+#define TEGRA_POWERGATE_AUD	27
+#define TEGRA_POWERGATE_DFD	28
+#define TEGRA_POWERGATE_VE2	29
+#define TEGRA_POWERGATE_MAX	TEGRA_POWERGATE_VE2
+
+#endif
diff --git a/include/soc/tegra/pmc.h b/include/soc/tegra/pmc.h
index e9e53473a63e..c028557365ad 100644
--- a/include/soc/tegra/pmc.h
+++ b/include/soc/tegra/pmc.h
@@ -19,6 +19,8 @@
 #ifndef __SOC_TEGRA_PMC_H__
 #define __SOC_TEGRA_PMC_H__
 
+#include <dt-bindings/power/tegra-powergate.h>
+
 #include <linux/reboot.h>
 
 #include <soc/tegra/pm.h>
@@ -39,43 +41,8 @@ int tegra_pmc_cpu_remove_clamping(unsigned int cpuid);
 #endif /* CONFIG_SMP */
 
 /*
- * powergate and I/O rail APIs
+ * I/O rail APIs
  */
-
-#define TEGRA_POWERGATE_CPU	0
-#define TEGRA_POWERGATE_3D	1
-#define TEGRA_POWERGATE_VENC	2
-#define TEGRA_POWERGATE_PCIE	3
-#define TEGRA_POWERGATE_VDEC	4
-#define TEGRA_POWERGATE_L2	5
-#define TEGRA_POWERGATE_MPE	6
-#define TEGRA_POWERGATE_HEG	7
-#define TEGRA_POWERGATE_SATA	8
-#define TEGRA_POWERGATE_CPU1	9
-#define TEGRA_POWERGATE_CPU2	10
-#define TEGRA_POWERGATE_CPU3	11
-#define TEGRA_POWERGATE_CELP	12
-#define TEGRA_POWERGATE_3D1	13
-#define TEGRA_POWERGATE_CPU0	14
-#define TEGRA_POWERGATE_C0NC	15
-#define TEGRA_POWERGATE_C1NC	16
-#define TEGRA_POWERGATE_SOR	17
-#define TEGRA_POWERGATE_DIS	18
-#define TEGRA_POWERGATE_DISB	19
-#define TEGRA_POWERGATE_XUSBA	20
-#define TEGRA_POWERGATE_XUSBB	21
-#define TEGRA_POWERGATE_XUSBC	22
-#define TEGRA_POWERGATE_VIC	23
-#define TEGRA_POWERGATE_IRAM	24
-#define TEGRA_POWERGATE_NVDEC	25
-#define TEGRA_POWERGATE_NVJPG	26
-#define TEGRA_POWERGATE_AUD	27
-#define TEGRA_POWERGATE_DFD	28
-#define TEGRA_POWERGATE_VE2	29
-#define TEGRA_POWERGATE_MAX	TEGRA_POWERGATE_VE2
-
-#define TEGRA_POWERGATE_3D0	TEGRA_POWERGATE_3D
-
 #define TEGRA_IO_RAIL_CSIA	0
 #define TEGRA_IO_RAIL_CSIB	1
 #define TEGRA_IO_RAIL_DSI	2
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
