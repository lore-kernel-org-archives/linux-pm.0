From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 2/2] cpufreq: dt: rework resources initialization
Date: Thu, 07 Feb 2019 13:22:27 +0100
Message-ID: <20190207122227.19873-3-m.szyprowski@samsung.com>
References: <20190207122227.19873-1-m.szyprowski@samsung.com>
        <CGME20190207122256eucas1p17e8742176bda911263d2d14d2797a886@eucas1p1.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20190207122227.19873-1-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dave Gerlach <d-gerlach@ti.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-pm@vger.kernel.org

All resources needed for driver operation (clocks and regulators) are now
gathered in driver ->probe() and kept for the whole driver lifetime. This
allows to get rid of the re-acquiring resources always in ->init()
callback, which might be called in a context not approperiate for such
operation.

This fixes following warning during system suspend/resume cycle on Samsung
Exynos based Odroid XU3/XU4 boards:

--->8---
Enabling non-boot CPUs ...
CPU1 is up
CPU2 is up
CPU3 is up
------------[ cut here ]------------
WARNING: CPU: 4 PID: 29 at drivers/i2c/i2c-core-base.c:1869 __i2c_transfer+0x6f8/0xa50
Modules linked in:
CPU: 4 PID: 29 Comm: cpuhp/4 Tainted: G        W         5.0.0-rc4-next-20190131-00024-g54b06b29cc65 #5324
Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[<c01110e8>] (unwind_backtrace) from [<c010d11c>] (show_stack+0x10/0x14)
[<c010d11c>] (show_stack) from [<c09a2584>] (dump_stack+0x90/0xc8)
[<c09a2584>] (dump_stack) from [<c0120bd0>] (__warn+0xf8/0x124)
[<c0120bd0>] (__warn) from [<c0120c3c>] (warn_slowpath_null+0x40/0x48)
[<c0120c3c>] (warn_slowpath_null) from [<c065cda0>] (__i2c_transfer+0x6f8/0xa50)
[<c065cda0>] (__i2c_transfer) from [<c065d168>] (i2c_transfer+0x70/0xe4)
[<c065d168>] (i2c_transfer) from [<c053ce4c>] (regmap_i2c_read+0x48/0x64)
[<c053ce4c>] (regmap_i2c_read) from [<c0536f1c>] (_regmap_raw_read+0xf8/0x450)
[<c0536f1c>] (_regmap_raw_read) from [<c053772c>] (_regmap_bus_read+0x38/0x68)
[<c053772c>] (_regmap_bus_read) from [<c05365a0>] (_regmap_read+0x60/0x250)
[<c05365a0>] (_regmap_read) from [<c05367cc>] (regmap_read+0x3c/0x5c)
[<c05367cc>] (regmap_read) from [<c047cfc0>] (regulator_is_enabled_regmap+0x20/0x90)
[<c047cfc0>] (regulator_is_enabled_regmap) from [<c0477660>] (_regulator_is_enabled+0x34/0x40)
[<c0477660>] (_regulator_is_enabled) from [<c0478674>] (create_regulator+0x1a4/0x25c)
[<c0478674>] (create_regulator) from [<c047c818>] (_regulator_get+0xe4/0x278)
[<c047c818>] (_regulator_get) from [<c068f1dc>] (dev_pm_opp_set_regulators+0xa0/0x1c0)
[<c068f1dc>] (dev_pm_opp_set_regulators) from [<c0698cc8>] (cpufreq_init+0x98/0x2d0)
[<c0698cc8>] (cpufreq_init) from [<c06959e4>] (cpufreq_online+0xc8/0x71c)
[<c06959e4>] (cpufreq_online) from [<c06960fc>] (cpuhp_cpufreq_online+0x8/0x10)
[<c06960fc>] (cpuhp_cpufreq_online) from [<c01213d4>] (cpuhp_invoke_callback+0xf4/0xebc)
[<c01213d4>] (cpuhp_invoke_callback) from [<c0122e4c>] (cpuhp_thread_fun+0x1d8/0x320)
[<c0122e4c>] (cpuhp_thread_fun) from [<c0149858>] (smpboot_thread_fn+0x194/0x340)
[<c0149858>] (smpboot_thread_fn) from [<c014573c>] (kthread+0x124/0x160)
[<c014573c>] (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
Exception stack(0xe897dfb0 to 0xe897dff8)
dfa0:                                     00000000 00000000 00000000 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
irq event stamp: 3865
hardirqs last  enabled at (3873): [<c0186dec>] vprintk_emit+0x228/0x2a4
hardirqs last disabled at (3880): [<c0186cf0>] vprintk_emit+0x12c/0x2a4
softirqs last  enabled at (3052): [<c0102564>] __do_softirq+0x3a4/0x66c
softirqs last disabled at (3043): [<c0128464>] irq_exit+0x140/0x168
---[ end trace db48b455d924fec2 ]---
CPU4 is up
CPU5 is up
CPU6 is up
CPU7 is up
--->8---

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/cpufreq/cpufreq-dt.c | 134 ++++++++++++++---------------------
 1 file changed, 52 insertions(+), 82 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 02a344e9d818..ef17bf29dc7c 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -29,11 +29,13 @@
 struct private_data {
 	struct opp_table *opp_table;
 	struct device *cpu_dev;
-	const char *reg_name;
+	struct clk *clk;
 	struct regulator *reg;
 	bool have_static_opps;
 };
 
+static struct private_data *priv_data;
+
 static struct freq_attr *cpufreq_dt_attr[] = {
 	&cpufreq_freq_attr_scaling_available_freqs,
 	NULL,   /* Extra space for boost-attr if required */
@@ -94,7 +96,7 @@ static const char *find_supply_name(struct device *dev)
 	return name;
 }
 
-static int resources_available(void)
+static int get_cpu_resources(struct private_data *priv, unsigned int cpu)
 {
 	struct device *cpu_dev;
 	struct regulator *cpu_reg;
@@ -102,9 +104,9 @@ static int resources_available(void)
 	int ret = 0;
 	const char *name;
 
-	cpu_dev = get_cpu_device(0);
+	cpu_dev = get_cpu_device(cpu);
 	if (!cpu_dev) {
-		pr_err("failed to get cpu0 device\n");
+		pr_err("failed to get cpu%d device\n", cpu);
 		return -ENODEV;
 	}
 
@@ -123,12 +125,10 @@ static int resources_available(void)
 		return ret;
 	}
 
-	clk_put(cpu_clk);
-
 	name = find_supply_name(cpu_dev);
 	/* Platform doesn't require regulator */
 	if (!name)
-		return 0;
+		goto no_regulator;
 
 	cpu_reg = regulator_get_optional(cpu_dev, name);
 	ret = PTR_ERR_OR_ZERO(cpu_reg);
@@ -138,48 +138,42 @@ static int resources_available(void)
 		 * not yet registered, we should try defering probe.
 		 */
 		if (ret == -EPROBE_DEFER)
-			dev_dbg(cpu_dev, "cpu0 regulator not ready, retry\n");
+			dev_dbg(cpu_dev, "regulator not ready, retry\n");
 		else
-			dev_dbg(cpu_dev, "no regulator for cpu0: %d\n", ret);
-
-		return ret;
+			dev_dbg(cpu_dev, "no regulator for cpu: %d\n", ret);
+		goto free;
 	}
-
-	regulator_put(cpu_reg);
+no_regulator:
+	priv->cpu_dev = cpu_dev;
+	priv->clk = cpu_clk;
+	priv->reg = cpu_reg;
 	return 0;
+free:
+	clk_put(cpu_clk);
+	return ret;
+}
+
+static void put_cpu_resources(struct private_data *priv)
+{
+	clk_put(priv->clk);
+	regulator_put(priv->reg);
 }
 
 static int cpufreq_init(struct cpufreq_policy *policy)
 {
 	struct cpufreq_frequency_table *freq_table;
 	struct opp_table *opp_table = NULL;
-	struct private_data *priv;
-	struct regulator *reg;
-	struct device *cpu_dev;
-	struct clk *cpu_clk;
+	struct private_data *priv = &priv_data[policy->cpu];
+	struct device *cpu_dev = priv->cpu_dev;
 	unsigned int transition_latency;
 	bool fallback = false;
-	const char *name;
 	int ret;
 
-	cpu_dev = get_cpu_device(policy->cpu);
-	if (!cpu_dev) {
-		pr_err("failed to get cpu%d device\n", policy->cpu);
-		return -ENODEV;
-	}
-
-	cpu_clk = clk_get(cpu_dev, NULL);
-	if (IS_ERR(cpu_clk)) {
-		ret = PTR_ERR(cpu_clk);
-		dev_err(cpu_dev, "%s: failed to get clk: %d\n", __func__, ret);
-		return ret;
-	}
-
 	/* Get OPP-sharing information from "operating-points-v2" bindings */
 	ret = dev_pm_opp_of_get_sharing_cpus(cpu_dev, policy->cpus);
 	if (ret) {
 		if (ret != -ENOENT)
-			goto out_put_clk;
+			return ret;
 
 		/*
 		 * operating-points-v2 not supported, fallback to old method of
@@ -190,35 +184,18 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 			fallback = true;
 	}
 
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		ret = -ENOMEM;
-		goto out_put_clk;
-	}
-
 	/*
 	 * OPP layer will be taking care of regulators.
 	 */
-	name = find_supply_name(cpu_dev);
-	if (name) {
-		reg = regulator_get_optional(cpu_dev, name);
-		ret = PTR_ERR_OR_ZERO(reg);
-		if (ret) {
-			dev_err(cpu_dev, "Failed to get regulator for cpu%d: %d\n",
-				policy->cpu, ret);
-			goto out_free_priv;
-		}
-		priv->reg = reg;
+	if (priv->reg) {
 		opp_table = dev_pm_opp_set_regulators(cpu_dev, &priv->reg, 1);
 		if (IS_ERR(opp_table)) {
 			ret = PTR_ERR(opp_table);
-			dev_err(cpu_dev, "Failed to set regulator for cpu%d: %d\n",
-				policy->cpu, ret);
-			goto out_put_regulator;
+			dev_err(cpu_dev, "Failed to set regulator for cpu: %d\n",
+				ret);
+			return ret;
 		}
 	}
-
-	priv->reg_name = name;
 	priv->opp_table = opp_table;
 
 	/*
@@ -264,11 +241,9 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		goto out_free_opp;
 	}
 
-	priv->cpu_dev = cpu_dev;
 	policy->driver_data = priv;
-	policy->clk = cpu_clk;
+	policy->clk = priv->clk;
 	policy->freq_table = freq_table;
-
 	policy->suspend_freq = dev_pm_opp_get_suspend_opp_freq(cpu_dev) / 1000;
 
 	/* Support turbo/boost mode */
@@ -296,16 +271,8 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 out_free_opp:
 	if (priv->have_static_opps)
 		dev_pm_opp_of_cpumask_remove_table(policy->cpus);
-out_put_opp_regulator:
-	if (name)
-		dev_pm_opp_put_regulators(opp_table);
-out_put_regulator:
 	if (priv->reg)
-		regulator_put(priv->reg);
-out_free_priv:
-	kfree(priv);
-out_put_clk:
-	clk_put(cpu_clk);
+		dev_pm_opp_put_regulators(opp_table);
 
 	return ret;
 }
@@ -317,13 +284,8 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
 	if (priv->have_static_opps)
 		dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
-	if (priv->reg_name)
-		dev_pm_opp_put_regulators(priv->opp_table);
 	if (priv->reg)
-		regulator_put(priv->reg);
-
-	clk_put(policy->clk);
-	kfree(priv);
+		dev_pm_opp_put_regulators(priv->opp_table);
 
 	return 0;
 }
@@ -344,18 +306,21 @@ static struct cpufreq_driver dt_cpufreq_driver = {
 static int dt_cpufreq_probe(struct platform_device *pdev)
 {
 	struct cpufreq_dt_platform_data *data = dev_get_platdata(&pdev->dev);
-	int ret;
+	int i, ret;
 
-	/*
-	 * All per-cluster (CPUs sharing clock/voltages) initialization is done
-	 * from ->init(). In probe(), we just need to make sure that clk and
-	 * regulators are available. Else defer probe and retry.
-	 *
-	 * FIXME: Is checking this only for CPU0 sufficient ?
-	 */
-	ret = resources_available();
-	if (ret)
-		return ret;
+	priv_data = devm_kcalloc(&pdev->dev, num_possible_cpus(),
+				 sizeof(*priv_data), GFP_KERNEL);
+	if (!priv_data)
+		return -ENOMEM;
+
+	for (i = 0; i < num_possible_cpus(); i++) {
+		ret = get_cpu_resources(&priv_data[i], i);
+		if (ret) {
+			while (i-- > 0)
+				put_cpu_resources(&priv_data[i]);
+			return ret;
+		}
+	}
 
 	if (data) {
 		if (data->have_governor_per_policy)
@@ -375,7 +340,12 @@ static int dt_cpufreq_probe(struct platform_device *pdev)
 
 static int dt_cpufreq_remove(struct platform_device *pdev)
 {
+	int i;
+
 	cpufreq_unregister_driver(&dt_cpufreq_driver);
+	for (i = 0; i < num_possible_cpus(); i++)
+		put_cpu_resources(&priv_data[i]);
+
 	return 0;
 }
 
-- 
2.17.1
