From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 1/2] cpufreq: dt/ti/opp: move regulators initialization to
 the drivers
Date: Thu, 07 Feb 2019 13:22:26 +0100
Message-ID: <20190207122227.19873-2-m.szyprowski@samsung.com>
References: <20190207122227.19873-1-m.szyprowski@samsung.com>
        <CGME20190207122255eucas1p1444023f01217a43cfb958fe0bd48ef4d@eucas1p1.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20190207122227.19873-1-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dave Gerlach <d-gerlach@ti.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-pm@vger.kernel.org

dev_pm_opp_set_regulators() helper is used to assign the regulators to
the used operation points. This helper however only got the names of the
passed regulators and performs their initialization on its own.

Change this by requiring proper regulator objects and move regulator
gathering to the client drivers. This will be later needed to avoid
regulator initialization in forbidden context (i.e. during early system
resume, when no irqs are available yet). Both clients of the
dev_pm_opp_set_regulators() function are adapted to the new signature.

ti-cpufreq driver is also marked with 'suppress_bind_attrs', as it really
doesn't properly support driver removal.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/cpufreq/cpufreq-dt.c | 39 ++++++++++++++++++++++-----------
 drivers/cpufreq/ti-cpufreq.c | 42 ++++++++++++++++++++++++++++++------
 drivers/opp/core.c           | 40 ++++------------------------------
 include/linux/pm_opp.h       |  2 +-
 4 files changed, 67 insertions(+), 56 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 36a011ea0039..02a344e9d818 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -30,6 +30,7 @@ struct private_data {
 	struct opp_table *opp_table;
 	struct device *cpu_dev;
 	const char *reg_name;
+	struct regulator *reg;
 	bool have_static_opps;
 };
 
@@ -153,6 +154,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	struct cpufreq_frequency_table *freq_table;
 	struct opp_table *opp_table = NULL;
 	struct private_data *priv;
+	struct regulator *reg;
 	struct device *cpu_dev;
 	struct clk *cpu_clk;
 	unsigned int transition_latency;
@@ -188,27 +190,34 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 			fallback = true;
 	}
 
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		ret = -ENOMEM;
+		goto out_put_clk;
+	}
+
 	/*
-	 * OPP layer will be taking care of regulators now, but it needs to know
-	 * the name of the regulator first.
+	 * OPP layer will be taking care of regulators.
 	 */
 	name = find_supply_name(cpu_dev);
 	if (name) {
-		opp_table = dev_pm_opp_set_regulators(cpu_dev, &name, 1);
+		reg = regulator_get_optional(cpu_dev, name);
+		ret = PTR_ERR_OR_ZERO(reg);
+		if (ret) {
+			dev_err(cpu_dev, "Failed to get regulator for cpu%d: %d\n",
+				policy->cpu, ret);
+			goto out_free_priv;
+		}
+		priv->reg = reg;
+		opp_table = dev_pm_opp_set_regulators(cpu_dev, &priv->reg, 1);
 		if (IS_ERR(opp_table)) {
 			ret = PTR_ERR(opp_table);
 			dev_err(cpu_dev, "Failed to set regulator for cpu%d: %d\n",
 				policy->cpu, ret);
-			goto out_put_clk;
+			goto out_put_regulator;
 		}
 	}
 
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		ret = -ENOMEM;
-		goto out_put_regulator;
-	}
-
 	priv->reg_name = name;
 	priv->opp_table = opp_table;
 
@@ -287,10 +296,14 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 out_free_opp:
 	if (priv->have_static_opps)
 		dev_pm_opp_of_cpumask_remove_table(policy->cpus);
-	kfree(priv);
-out_put_regulator:
+out_put_opp_regulator:
 	if (name)
 		dev_pm_opp_put_regulators(opp_table);
+out_put_regulator:
+	if (priv->reg)
+		regulator_put(priv->reg);
+out_free_priv:
+	kfree(priv);
 out_put_clk:
 	clk_put(cpu_clk);
 
@@ -306,6 +319,8 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
 		dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
 	if (priv->reg_name)
 		dev_pm_opp_put_regulators(priv->opp_table);
+	if (priv->reg)
+		regulator_put(priv->reg);
 
 	clk_put(policy->clk);
 	kfree(priv);
diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 22b53bf26817..623ae7fa34f9 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -23,6 +23,7 @@
 #include <linux/of_platform.h>
 #include <linux/pm_opp.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
 #define REVISION_MASK				0xF
@@ -213,13 +214,43 @@ static const struct of_device_id *ti_cpufreq_match_node(void)
 	return match;
 }
 
+#define TI_MULTIREGULATOR_COUNT 2
+static struct regulator *multi_regulators[TI_MULTIREGULATOR_COUNT];
+
+static int ti_setup_multi_regulators(struct device *cpu_dev)
+{
+	struct opp_table *ti_opp_table;
+	int ret = 0;
+
+	multi_regulators[0] = regulator_get(cpu_dev, "vdd");
+	if (IS_ERR(multi_regulators[0]))
+		return PTR_ERR(multi_regulators[0]);
+	multi_regulators[1] = regulator_get(cpu_dev, "vbb");
+	if (IS_ERR(multi_regulators[1])) {
+		ret = PTR_ERR(multi_regulators[1]);
+		goto free0;
+	}
+
+	ti_opp_table = dev_pm_opp_set_regulators(cpu_dev, multi_regulators,
+						 TI_MULTIREGULATOR_COUNT);
+	if (IS_ERR(ti_opp_table)) {
+		ret = PTR_ERR(ti_opp_table);
+		goto free1;
+	}
+	return 0;
+free1:
+	regulator_put(multi_regulators[1]);
+free0:
+	regulator_put(multi_regulators[0]);
+	return ret;
+}
+
 static int ti_cpufreq_probe(struct platform_device *pdev)
 {
 	u32 version[VERSION_COUNT];
 	const struct of_device_id *match;
 	struct opp_table *ti_opp_table;
 	struct ti_cpufreq_data *opp_data;
-	const char * const reg_names[] = {"vdd", "vbb"};
 	int ret;
 
 	match = dev_get_platdata(&pdev->dev);
@@ -273,14 +304,10 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
 	}
 
 	opp_data->opp_table = ti_opp_table;
-
 	if (opp_data->soc_data->multi_regulator) {
-		ti_opp_table = dev_pm_opp_set_regulators(opp_data->cpu_dev,
-							 reg_names,
-							 ARRAY_SIZE(reg_names));
-		if (IS_ERR(ti_opp_table)) {
+		ret = ti_setup_multi_regulators(opp_data->cpu_dev);
+		if (ret) {
 			dev_pm_opp_put_supported_hw(opp_data->opp_table);
-			ret =  PTR_ERR(ti_opp_table);
 			goto fail_put_node;
 		}
 	}
@@ -316,6 +343,7 @@ static struct platform_driver ti_cpufreq_driver = {
 	.driver = {
 		.name = "ti-cpufreq",
 	},
+	.suppress_bind_attrs = true,
 };
 builtin_platform_driver(ti_cpufreq_driver);
 
diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index d7f97167cac3..fc143a38fe8d 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1477,11 +1477,10 @@ static void _free_set_opp_data(struct opp_table *opp_table)
  * This must be called before any OPPs are initialized for the device.
  */
 struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
-					    const char * const names[],
+					    struct regulator **regulators,
 					    unsigned int count)
 {
 	struct opp_table *opp_table;
-	struct regulator *reg;
 	int ret, i;
 
 	opp_table = dev_pm_opp_get_opp_table(dev);
@@ -1498,41 +1497,14 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
 	if (opp_table->regulators)
 		return opp_table;
 
-	opp_table->regulators = kmalloc_array(count,
-					      sizeof(*opp_table->regulators),
-					      GFP_KERNEL);
-	if (!opp_table->regulators) {
-		ret = -ENOMEM;
-		goto err;
-	}
-
-	for (i = 0; i < count; i++) {
-		reg = regulator_get_optional(dev, names[i]);
-		if (IS_ERR(reg)) {
-			ret = PTR_ERR(reg);
-			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "%s: no regulator (%s) found: %d\n",
-					__func__, names[i], ret);
-			goto free_regulators;
-		}
-
-		opp_table->regulators[i] = reg;
-	}
-
+	opp_table->regulators = regulators;
 	opp_table->regulator_count = count;
 
 	/* Allocate block only once to pass to set_opp() routines */
 	ret = _allocate_set_opp_data(opp_table);
-	if (ret)
-		goto free_regulators;
-
-	return opp_table;
-
-free_regulators:
-	while (i != 0)
-		regulator_put(opp_table->regulators[--i]);
+	if (ret == 0)
+		return opp_table;
 
-	kfree(opp_table->regulators);
 	opp_table->regulators = NULL;
 	opp_table->regulator_count = -1;
 err:
@@ -1556,12 +1528,8 @@ void dev_pm_opp_put_regulators(struct opp_table *opp_table)
 	/* Make sure there are no concurrent readers while updating opp_table */
 	WARN_ON(!list_empty(&opp_table->opp_list));
 
-	for (i = opp_table->regulator_count - 1; i >= 0; i--)
-		regulator_put(opp_table->regulators[i]);
-
 	_free_set_opp_data(opp_table);
 
-	kfree(opp_table->regulators);
 	opp_table->regulators = NULL;
 	opp_table->regulator_count = -1;
 
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 24c757a32a7b..3cf24c2c4969 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -123,7 +123,7 @@ struct opp_table *dev_pm_opp_set_supported_hw(struct device *dev, const u32 *ver
 void dev_pm_opp_put_supported_hw(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name);
 void dev_pm_opp_put_prop_name(struct opp_table *opp_table);
-struct opp_table *dev_pm_opp_set_regulators(struct device *dev, const char * const names[], unsigned int count);
+struct opp_table *dev_pm_opp_set_regulators(struct device *dev, struct regulator **regulators, unsigned int count);
 void dev_pm_opp_put_regulators(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char * name);
 void dev_pm_opp_put_clkname(struct opp_table *opp_table);
-- 
2.17.1
