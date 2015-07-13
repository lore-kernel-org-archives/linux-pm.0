From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V3 15/19] soc: tegra: pmc: Add generic PM domain support
Date: Mon, 13 Jul 2015 13:39:53 +0100
Message-ID: <1436791197-32358-16-git-send-email-jonathanh@nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1436791197-32358-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, =?UTF-8?q?Terje=20Bergstr=C3=B6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Adds generic PM support to the PMC driver where the PM domains are
populated from device-tree and the PM domain consumer devices are
bound to their relevant PM domains via device-tree as well.

Update the tegra_powergate_power_on_legacy/off_legacy() APIs so that
internally they call the same tegra_powergate_xxx functions that are
used by the tegra generic power domain code for consistency.

This is based upon work by Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
and Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>.

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/soc/tegra/pmc.c                     | 545 +++++++++++++++++++++++++++-
 include/dt-bindings/power/tegra-powergate.h |  42 +++
 include/soc/tegra/pmc.h                     |  52 +--
 3 files changed, 580 insertions(+), 59 deletions(-)
 create mode 100644 include/dt-bindings/power/tegra-powergate.h

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 934653785bb7..4de92a9dae65 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -19,8 +19,11 @@
 
 #define pr_fmt(fmt) "tegra-pmc: " fmt
 
+#include <dt-bindings/power/tegra-powergate.h>
+
 #include <linux/kernel.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/clk/tegra.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
@@ -30,17 +33,24 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/reboot.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
+#include <linux/sched.h>
 #include <linux/seq_file.h>
 #include <linux/spinlock.h>
 
 #include <soc/tegra/common.h>
 #include <soc/tegra/fuse.h>
+#include <soc/tegra/mc.h>
 #include <soc/tegra/pmc.h>
 
+#define PMC_POWERGATE_ARRAY_MAX		10
+
 #define PMC_CNTRL			0x0
 #define  PMC_CNTRL_SYSCLK_POLARITY	(1 << 10)  /* sys clk polarity */
 #define  PMC_CNTRL_SYSCLK_OE		(1 << 11)  /* system clock enable */
@@ -106,6 +116,22 @@
 
 #define PMC_PWRGATE_STATE(val, id)	(!!(val & BIT(id)))
 
+struct tegra_powergate {
+	struct generic_pm_domain genpd;
+	struct tegra_pmc *pmc;
+	struct tegra_mc *mc;
+	unsigned int id;
+	struct list_head node;
+	struct device_node *of_node;
+	struct regulator *vdd;
+	struct clk **clks;
+	struct reset_control **resets;
+	const struct tegra_mc_flush **flushes;
+	u32 num_clks;
+	u32 num_resets;
+	u32 num_flushes;
+};
+
 struct tegra_pmc_soc {
 	unsigned int num_powergates;
 	const char *const *powergates;
@@ -118,8 +144,10 @@ struct tegra_pmc_soc {
 
 /**
  * struct tegra_pmc - NVIDIA Tegra PMC
+ * @dev: pointer to parent device
  * @base: pointer to I/O remapped register region
  * @clk: pointer to pclk clock
+ * @soc: SoC-specific data
  * @rate: currently configured rate of pclk
  * @suspend_mode: lowest suspend mode available
  * @cpu_good_time: CPU power good time (in microseconds)
@@ -133,6 +161,7 @@ struct tegra_pmc_soc {
  * @cpu_pwr_good_en: CPU power good signal is enabled
  * @lp0_vec_phys: physical base address of the LP0 warm boot code
  * @lp0_vec_size: size of the LP0 warm boot code
+ * @powergates_list: list of power gates
  * @powergates_lock: mutex for power gate register access
  */
 struct tegra_pmc {
@@ -157,6 +186,7 @@ struct tegra_pmc {
 	u32 lp0_vec_phys;
 	u32 lp0_vec_size;
 
+	struct list_head powergates_list;
 	struct mutex powergates_lock;
 };
 
@@ -165,6 +195,12 @@ static struct tegra_pmc *pmc = &(struct tegra_pmc) {
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
@@ -175,6 +211,37 @@ static void tegra_pmc_writel(u32 value, unsigned long offset)
 	writel(value, pmc->base + offset);
 }
 
+static int tegra_powergate_get_regulator(struct tegra_powergate *powergate)
+{
+	struct platform_device *pdev;
+
+	if (powergate->id != TEGRA_POWERGATE_EXT)
+		return -EINVAL;
+
+	pdev = of_find_device_by_node(powergate->of_node);
+	if (!pdev)
+		return -EINVAL;
+
+	powergate->vdd = devm_regulator_get_optional(&pdev->dev, "vdd");
+	if (IS_ERR(powergate->vdd))
+		return PTR_ERR(powergate->vdd);
+
+	return 0;
+}
+
+static int tegra_powergate_enable_regulator(struct tegra_powergate *powergate)
+{
+	int ret = 0;
+
+	if (IS_ERR_OR_NULL(powergate->vdd))
+		ret = tegra_powergate_get_regulator(powergate);
+
+	if (!ret)
+		ret = regulator_enable(powergate->vdd);
+
+	return ret;
+}
+
 /**
  * tegra_powergate_set() - set the state of a partition
  * @id: partition ID
@@ -207,6 +274,215 @@ static int tegra_powergate_set(int id, bool new_state, bool wait)
 	return ret;
 }
 
+static int tegra_powergate_enable(struct tegra_powergate *powergate,
+				  bool enable)
+{
+	if (powergate->id != TEGRA_POWERGATE_EXT)
+		return tegra_powergate_set(powergate->id, enable, true);
+
+	if (enable)
+		return tegra_powergate_enable_regulator(powergate);
+	else
+		return regulator_disable(powergate->vdd);
+}
+
+static bool tegra_powergate_is_supported(int id)
+{
+	switch (id) {
+	case TEGRA_POWERGATE_CPU:
+	case TEGRA_POWERGATE_CPU1:
+	case TEGRA_POWERGATE_CPU2:
+	case TEGRA_POWERGATE_CPU3:
+	case TEGRA_POWERGATE_CPU0:
+	case TEGRA_POWERGATE_C0NC:
+	case TEGRA_POWERGATE_IRAM:
+		return false;
+	default:
+		return true;
+	}
+}
+
+static bool _tegra_powergate_is_powered(struct tegra_powergate *powergate)
+{
+	if (powergate->id != TEGRA_POWERGATE_EXT)
+		return tegra_powergate_is_powered(powergate->id);
+
+	if (IS_ERR(powergate->vdd))
+		return false;
+	else
+		return regulator_is_enabled(powergate->vdd);
+}
+
+static void tegra_powergate_disable_clocks(struct tegra_powergate *powergate)
+{
+	int i;
+
+	for (i = 0; i < powergate->num_clks; i++)
+		clk_disable_unprepare(powergate->clks[i]);
+}
+
+static int tegra_powergate_enable_clocks(struct tegra_powergate *powergate)
+{
+	int err, i;
+
+	for (i = 0; i < powergate->num_clks; i++) {
+		err = clk_prepare_enable(powergate->clks[i]);
+		if (err)
+			goto out;
+	}
+
+	return 0;
+
+out:
+	while (i--)
+		clk_disable_unprepare(powergate->clks[i]);
+
+	return err;
+}
+
+static int tegra_powergate_mc_flush(struct tegra_powergate *powergate,
+				    bool enable)
+{
+	int i, err;
+
+	for (i = 0; i < powergate->num_flushes; i++) {
+		err = tegra_mc_flush(powergate->mc, powergate->flushes[i],
+				     enable);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int tegra_powergate_reset_assert(struct tegra_powergate *powergate)
+{
+	int err, i;
+
+	for (i = 0; i < powergate->num_resets; i++) {
+		err = reset_control_assert(powergate->resets[i]);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int tegra_powergate_reset_deassert(struct tegra_powergate *powergate)
+{
+	int err, i;
+
+	for (i = 0; i < powergate->num_resets; i++) {
+		err = reset_control_deassert(powergate->resets[i]);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int tegra_powergate_seq_power_up(struct tegra_powergate *powergate)
+{
+	int err;
+
+	err = tegra_powergate_reset_assert(powergate);
+	if (err)
+		goto out;
+	udelay(10);
+
+	err = tegra_powergate_enable(powergate, true);
+	if (err < 0)
+		goto out;
+	udelay(10);
+
+	err = tegra_powergate_enable_clocks(powergate);
+	if (err)
+		goto out;
+	udelay(10);
+
+	tegra_powergate_remove_clamping(powergate->id);
+
+	udelay(10);
+
+	err = tegra_powergate_reset_deassert(powergate);
+	if (err)
+		goto out;
+	udelay(10);
+
+	err = tegra_powergate_mc_flush(powergate, false);
+	if (err)
+		goto out;
+	udelay(10);
+
+	tegra_powergate_disable_clocks(powergate);
+
+	return 0;
+
+out:
+	return err;
+}
+
+static int tegra_powergate_seq_power_down(struct tegra_powergate *powergate)
+{
+	int err;
+
+	err = tegra_powergate_enable_clocks(powergate);
+	if (err)
+		goto out;
+	udelay(10);
+
+	err = tegra_powergate_mc_flush(powergate, true);
+	if (err)
+		goto out;
+	udelay(10);
+
+	err = tegra_powergate_reset_assert(powergate);
+	if (err)
+		goto out;
+	udelay(10);
+
+	tegra_powergate_disable_clocks(powergate);
+
+	udelay(10);
+
+	err = tegra_powergate_enable(powergate, false);
+	if (err)
+		goto out;
+
+	return 0;
+
+out:
+	return err;
+}
+
+static int tegra_genpd_power_on(struct generic_pm_domain *domain)
+{
+	struct tegra_powergate *powergate = to_powergate(domain);
+	struct tegra_pmc *pmc = powergate->pmc;
+	int err;
+
+	err = tegra_powergate_seq_power_up(powergate);
+
+	if (err)
+		dev_err(pmc->dev, "Failed to turn on PM Domain (%d)\n", err);
+
+	return 0;
+}
+
+static int tegra_genpd_power_off(struct generic_pm_domain *domain)
+{
+	struct tegra_powergate *powergate = to_powergate(domain);
+	struct tegra_pmc *pmc = powergate->pmc;
+	int err;
+
+	err = tegra_powergate_seq_power_down(powergate);
+
+	if (err)
+		dev_err(pmc->dev, "Failed to turn off PM Domain (%d)\n", err);
+
+	return err;
+}
+
 /**
  * tegra_powergate_power_on() - power on partition
  * @id: partition ID
@@ -247,6 +523,8 @@ int tegra_powergate_is_powered(int id)
 /**
  * tegra_powergate_remove_clamping() - remove power clamps for partition
  * @id: partition ID
+ *
+ * TODO: make this function static once we get rid of all outside callers
  */
 int tegra_powergate_remove_clamping(int id)
 {
@@ -331,26 +609,41 @@ err_power:
 }
 EXPORT_SYMBOL(tegra_powergate_sequence_power_up);
 
-int tegra_powergate_power_off_legacy(int id, struct clk *clk,
-				     struct reset_control *rst)
+int tegra_powergate_power_on_legacy(int id, struct clk *clk,
+				    struct reset_control *rst)
 {
-	int ret;
+	struct tegra_powergate powergate;
 
-	ret = clk_prepare_enable(clk);
-	if (ret)
-		return ret;
+	if (!pmc->soc || id < 0 || id >= pmc->soc->num_powergates)
+		return -EINVAL;
 
-	usleep_range(10, 20);
+	powergate.id = id;
+	powergate.clks = &clk;
+	powergate.resets = &rst;
+	powergate.num_clks = 1;
+	powergate.num_resets = 1;
+	powergate.num_flushes = 0;
 
-	reset_control_assert(rst);
+	return tegra_powergate_seq_power_up(&powergate);
+}
+EXPORT_SYMBOL(tegra_powergate_power_on_legacy);
 
-	usleep_range(10, 20);
+int tegra_powergate_power_off_legacy(int id, struct clk *clk,
+				     struct reset_control *rst)
+{
+	struct tegra_powergate powergate;
 
-	clk_disable_unprepare(clk);
+	if (!pmc->soc || id < 0 || id >= pmc->soc->num_powergates)
+		return -EINVAL;
 
-	usleep_range(10, 20);
+	powergate.id = id;
+	powergate.clks = &clk;
+	powergate.resets = &rst;
+	powergate.num_clks = 1;
+	powergate.num_resets = 1;
+	powergate.num_flushes = 0;
 
-	return tegra_powergate_power_off(id);
+	return tegra_powergate_seq_power_down(&powergate);
 }
 EXPORT_SYMBOL(tegra_powergate_power_off_legacy);
 
@@ -493,6 +786,228 @@ static int tegra_powergate_debugfs_init(void)
 	return 0;
 }
 
+static int tegra_powergate_of_get_clks(struct device *dev,
+				       struct tegra_powergate *powergate)
+{
+	struct clk *clks[PMC_POWERGATE_ARRAY_MAX];
+	int i = 0;
+
+	for (i = 0; i < PMC_POWERGATE_ARRAY_MAX; i++) {
+		clks[i] = of_clk_get(powergate->of_node, i);
+		if (IS_ERR(clks[i])) {
+			if (PTR_ERR(clks[i]) != -ENOENT)
+				return PTR_ERR(clks[i]);
+			break;
+		}
+	}
+
+	if (PTR_ERR(clks[i]) != -ENOENT) {
+		dev_err(dev, "unsupported number of clocks defined\n");
+		return -EINVAL;
+	}
+
+	powergate->clks = devm_kcalloc(dev, i, sizeof(*clks), GFP_KERNEL);
+	if (!powergate->clks)
+		return -ENOMEM;
+
+	memcpy(powergate->clks, clks, sizeof(*clks) * i);
+	powergate->num_clks = i;
+
+	return 0;
+}
+
+static int tegra_powergate_of_get_resets(struct device *dev,
+					 struct tegra_powergate *powergate)
+{
+	struct reset_control *rsts[PMC_POWERGATE_ARRAY_MAX];
+	int i = 0;
+
+	for (i = 0; i < PMC_POWERGATE_ARRAY_MAX; i++) {
+		rsts[i] = of_reset_control_get_by_index(powergate->of_node, i);
+		if (IS_ERR(rsts[i])) {
+			if (PTR_ERR(rsts[i]) != -ENOENT)
+				return PTR_ERR(rsts[i]);
+			break;
+		}
+	}
+
+	if (PTR_ERR(rsts[i]) != -ENOENT) {
+		dev_err(dev, "unsupported number of resets defined\n");
+		return -EINVAL;
+	}
+
+	powergate->resets = devm_kcalloc(dev, i, sizeof(*rsts), GFP_KERNEL);
+	if (!powergate->resets)
+		return -ENOMEM;
+
+	memcpy(powergate->resets, rsts, sizeof(*rsts) * i);
+	powergate->num_resets = i;
+
+	return 0;
+}
+
+static int tegra_powergate_of_get_mc_flush(struct device *dev,
+					   struct tegra_powergate *powergate)
+{
+	struct platform_device *pdev;
+	struct of_phandle_args args;
+	int i = 0, ret = 0;
+
+	ret = of_parse_phandle_with_args(dev->of_node, "nvidia-swgroups",
+					"#nvidia,swgroup-cells", 0, &args);
+	if (ret < 0) {
+		/*
+		 * The nvidia-swgroups property is
+		 * optional and so if missing simply return.
+		 */
+		if (ret == -ENOENT)
+			return 0;
+
+		dev_err(dev, "nvidia-swgroups property invalid for %s (%d)\n",
+			powergate->of_node->name, ret);
+		return ret;
+	}
+
+	powergate->flushes = devm_kcalloc(dev, args.args_count,
+					  sizeof(powergate->flushes),
+					  GFP_KERNEL);
+	if (!powergate->flushes) {
+		dev_err(dev, "failed to allocate memory for powergate flush\n");
+		return -ENOMEM;
+	}
+
+	pdev = of_find_device_by_node(args.np);
+	if (!pdev)
+		return -ENODEV;
+
+	powergate->mc = platform_get_drvdata(pdev);
+	if (!powergate->mc)
+		return -EINVAL;
+
+	for (i = 0; i < args.args_count; i++) {
+		powergate->flushes[i] = tegra_mc_flush_get(powergate->mc,
+							   args.args[i]);
+		if (!powergate->flushes[i])
+			return -EINVAL;
+	}
+
+	powergate->num_flushes = args.args_count;
+
+	return 0;
+}
+
+static int tegra_powergate_init_powerdomain(struct tegra_pmc *pmc,
+					    struct device_node *np,
+					    struct tegra_powergate *pg)
+{
+	bool off;
+	int err;
+
+	err = of_property_read_u32(np, "nvidia,powergate", &pg->id);
+	if (err) {
+		dev_err(pmc->dev, "no powergate ID for domain\n");
+		goto err;
+	}
+
+	if (tegra_powergate_is_supported(pg->id) == false) {
+		dev_warn(pmc->dev, "%s not currently supported by genpd\n",
+			 np->name);
+		return -EINVAL;
+	}
+
+	if (pg->id == TEGRA_POWERGATE_EXT) {
+		err = tegra_powergate_get_regulator(pg);
+		if (err) {
+			/*
+			 * The regulator might not be ready yet, so just
+			 * give a warning instead of failing the whole
+			 * init.
+			 */
+			dev_warn(pmc->dev, "couldn't locate regulator\n");
+		}
+	}
+
+	pg->of_node = np;
+	pg->genpd.name = np->name;
+	pg->genpd.power_off = tegra_genpd_power_off;
+	pg->genpd.power_on = tegra_genpd_power_on;
+	pg->pmc = pmc;
+
+	err = tegra_powergate_of_get_clks(pmc->dev, pg);
+	if (err)
+		goto err;
+
+	err = tegra_powergate_of_get_resets(pmc->dev, pg);
+	if (err)
+		goto err;
+
+	err = tegra_powergate_of_get_mc_flush(pmc->dev, pg);
+	if (err)
+		goto err;
+
+	list_add_tail(&pg->node, &pmc->powergates_list);
+
+	if (!IS_ERR(pg->vdd) || pg->id != TEGRA_POWERGATE_EXT)
+		tegra_genpd_power_off(&pg->genpd);
+
+	off = !_tegra_powergate_is_powered(pg);
+
+	pm_genpd_init(&pg->genpd, NULL, off);
+
+	dev_info(pmc->dev, "added power domain %s\n", np->name);
+
+	return 0;
+
+err:
+	dev_err(pmc->dev, "failed to add power domain for node %s\n",
+		np->name);
+	return err;
+}
+
+static int tegra_powergate_add_powerdomains(struct tegra_pmc *pmc,
+					    struct device_node *parent,
+					    struct generic_pm_domain *pd_parent)
+{
+	struct device_node *np;
+	int ret;
+
+	for_each_child_of_node(parent, np) {
+		struct tegra_powergate *pg;
+
+		pg = devm_kzalloc(pmc->dev, sizeof(*pg), GFP_KERNEL);
+		if (!pg)
+			return -ENOMEM;
+
+		ret = tegra_powergate_init_powerdomain(pmc, np, pg);
+		if (ret)
+			return ret;
+
+		if (pd_parent)
+			pm_genpd_add_subdomain(pd_parent, &pg->genpd);
+
+		of_genpd_add_provider_simple(np, &pg->genpd);
+
+		tegra_powergate_add_powerdomains(pmc, np, &pg->genpd);
+	}
+
+	return 0;
+}
+
+static int tegra_powergate_init(struct tegra_pmc *pmc)
+{
+	struct device_node *np;
+
+	INIT_LIST_HEAD(&pmc->powergates_list);
+
+	np = of_get_child_by_name(pmc->dev->of_node, "pm-domains");
+	if (!np) {
+		dev_dbg(pmc->dev, "power-domains node not found\n");
+		return 0;
+	}
+
+	return tegra_powergate_add_powerdomains(pmc, np, NULL);
+}
+
 static int tegra_io_rail_prepare(int id, unsigned long *request,
 				 unsigned long *status, unsigned int *bit)
 {
@@ -875,6 +1390,12 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 
 	tegra_pmc_init_tsense_reset(pmc);
 
+	if (IS_ENABLED(CONFIG_PM_GENERIC_DOMAINS)) {
+		err = tegra_powergate_init(pmc);
+		if (err < 0)
+			return err;
+	}
+
 	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
 		err = tegra_powergate_debugfs_init();
 		if (err < 0)
diff --git a/include/dt-bindings/power/tegra-powergate.h b/include/dt-bindings/power/tegra-powergate.h
new file mode 100644
index 000000000000..b1d51f028a99
--- /dev/null
+++ b/include/dt-bindings/power/tegra-powergate.h
@@ -0,0 +1,42 @@
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
+
+/*
+ * Pseudo powergate for power-domains that are power-gated externally.
+ * Make this a large number to allow other powergates to be added.
+ */
+#define TEGRA_POWERGATE_EXT	1000
+
+
+#endif
diff --git a/include/soc/tegra/pmc.h b/include/soc/tegra/pmc.h
index 4ca91d39304d..67b75d82edc7 100644
--- a/include/soc/tegra/pmc.h
+++ b/include/soc/tegra/pmc.h
@@ -19,6 +19,8 @@
 #ifndef __SOC_TEGRA_PMC_H__
 #define __SOC_TEGRA_PMC_H__
 
+#include <dt-bindings/power/tegra-powergate.h>
+
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/reboot.h>
@@ -41,42 +43,8 @@ int tegra_pmc_cpu_remove_clamping(int cpuid);
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
-
-#define TEGRA_POWERGATE_3D0	TEGRA_POWERGATE_3D
-
 #define TEGRA_IO_RAIL_CSIA	0
 #define TEGRA_IO_RAIL_CSIB	1
 #define TEGRA_IO_RAIL_DSI	2
@@ -119,18 +87,8 @@ int tegra_powergate_remove_clamping(int id);
 int tegra_powergate_sequence_power_up(int id, struct clk *clk,
 				      struct reset_control *rst);
 
-static inline int tegra_powergate_power_on_legacy(int id, struct clk *clk,
-						  struct reset_control *rst)
-{
-	int err = tegra_powergate_sequence_power_up(id, clk, rst);
-
-	if (!err) {
-		usleep_range(10, 20);
-		clk_disable_unprepare(clk);
-	}
-
-	return err;
-}
+int tegra_powergate_power_on_legacy(int id, struct clk *clk,
+				    struct reset_control *rst);
 
 int tegra_powergate_power_off_legacy(int id, struct clk *clk,
 				     struct reset_control *rst);
-- 
2.1.4
