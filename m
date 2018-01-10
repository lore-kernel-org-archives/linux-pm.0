From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v2 2/2] cpufreq: scpi: remove arm_big_little dependency
Date: Wed, 10 Jan 2018 16:44:15 +0000
Message-ID: <1515602655-12740-3-git-send-email-sudeep.holla@arm.com>
References: <1515602655-12740-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1515602655-12740-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Jeremy Linton <jeremy.linton@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

The dependency on physical_package_id from the topology to get the
cluster identifier is wrong. The concept of cluster used in ARM topology
is unfortunately not well defined in the architecture, we should avoid
using it. Further the frequency domain need not be mapped to so called
"clusters" one to one.

SCPI already provides means to obtain the frequency domain id from the
device tree. In order to support some new topologies(e.g. DSU which
contains 2 frequency domains within the physical cluster), pseudo
clusters are created to make this driver work which is wrong again.

In order to solve those issues and also remove dependency of topological
physical id for frequency domain, this patch removes the arm_big_little
dependency from scpi driver.

Cc: linux-amlogic@lists.infradead.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpufreq/scpi-cpufreq.c | 193 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 178 insertions(+), 15 deletions(-)

Hi AmLogic team,

I would like to get tested-by tag so that there's no last minute surprise
from this patch on Amlogic platforms.

Regards,
Sudeep

diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index 05d299052c5c..247fcbfa4cb5 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -18,27 +18,89 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/clk.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
+#include <linux/cpumask.h>
+#include <linux/cpu_cooling.h>
+#include <linux/export.h>
 #include <linux/module.h>
-#include <linux/platform_device.h>
+#include <linux/of_platform.h>
 #include <linux/pm_opp.h>
 #include <linux/scpi_protocol.h>
+#include <linux/slab.h>
 #include <linux/types.h>
 
-#include "arm_big_little.h"
+struct scpi_data {
+	struct clk *clk;
+	struct device *cpu_dev;
+	struct thermal_cooling_device *cdev;
+};
 
 static struct scpi_ops *scpi_ops;
 
-static int scpi_get_transition_latency(struct device *cpu_dev)
+static unsigned int scpi_cpufreq_get_rate(unsigned int cpu)
+{
+	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
+	struct scpi_data *priv = policy->driver_data;
+	unsigned long rate = clk_get_rate(priv->clk);
+
+	return rate / 1000;
+}
+
+static int
+scpi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
+{
+	struct scpi_data *priv = policy->driver_data;
+	u64 rate = policy->freq_table[index].frequency * 1000;
+	int ret;
+
+	ret = clk_set_rate(priv->clk, rate);
+	if (!ret && (clk_get_rate(priv->clk) != rate))
+		ret = -EIO;
+
+	return ret;
+}
+
+static int
+scpi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 {
-	return scpi_ops->get_transition_latency(cpu_dev);
+	int cpu, domain, tdomain;
+	struct device *tcpu_dev;
+
+	domain = scpi_ops->device_domain_id(cpu_dev);
+	if (domain < 0)
+		return domain;
+
+	for_each_possible_cpu(cpu) {
+		if (cpu == cpu_dev->id)
+			continue;
+
+		tcpu_dev = get_cpu_device(cpu);
+		if (!tcpu_dev)
+			continue;
+
+		tdomain = scpi_ops->device_domain_id(tcpu_dev);
+		if (tdomain == domain)
+			cpumask_set_cpu(cpu, cpumask);
+	}
+
+	return 0;
 }
 
-static int scpi_init_opp_table(const struct cpumask *cpumask)
+static int scpi_cpufreq_init(struct cpufreq_policy *policy)
 {
 	int ret;
-	struct device *cpu_dev = get_cpu_device(cpumask_first(cpumask));
+	unsigned int latency;
+	struct device *cpu_dev;
+	struct scpi_data *priv;
+	struct cpufreq_frequency_table *freq_table;
+
+	cpu_dev = get_cpu_device(policy->cpu);
+	if (!cpu_dev) {
+		pr_err("failed to get cpu%d device\n", policy->cpu);
+		return -ENODEV;
+	}
 
 	ret = scpi_ops->add_opps_to_device(cpu_dev);
 	if (ret) {
@@ -46,32 +108,133 @@ static int scpi_init_opp_table(const struct cpumask *cpumask)
 		return ret;
 	}
 
-	ret = dev_pm_opp_set_sharing_cpus(cpu_dev, cpumask);
-	if (ret)
+	ret = scpi_get_sharing_cpus(cpu_dev, policy->cpus);
+	if (ret) {
+		dev_warn(cpu_dev, "failed to get sharing cpumask\n");
+		return ret;
+	}
+
+	ret = dev_pm_opp_set_sharing_cpus(cpu_dev, policy->cpus);
+	if (ret) {
 		dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
 			__func__, ret);
+		return ret;
+	}
+
+	ret = dev_pm_opp_get_opp_count(cpu_dev);
+	if (ret <= 0) {
+		dev_dbg(cpu_dev, "OPP table is not ready, deferring probe\n");
+		ret = -EPROBE_DEFER;
+		goto out_free_opp;
+	}
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		ret = -ENOMEM;
+		goto out_free_opp;
+	}
+
+	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
+	if (ret) {
+		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
+		goto out_free_priv;
+	}
+
+	priv->cpu_dev = cpu_dev;
+	priv->clk = clk_get(cpu_dev, NULL);
+	if (IS_ERR(priv->clk)) {
+		dev_err(cpu_dev, "%s: Failed to get clk for cpu: %d\n",
+			__func__, cpu_dev->id);
+		goto out_free_cpufreq_table;
+	}
+
+	policy->driver_data = priv;
+
+	ret = cpufreq_table_validate_and_show(policy, freq_table);
+	if (ret) {
+		dev_err(cpu_dev, "%s: invalid frequency table: %d\n", __func__,
+			ret);
+		goto out_put_clk;
+	}
+
+	/* scpi allows DVFS request for any domain from any CPU */
+	policy->dvfs_possible_from_any_cpu = true;
+
+	latency = scpi_ops->get_transition_latency(cpu_dev);
+	if (!latency)
+		latency = CPUFREQ_ETERNAL;
+
+	policy->cpuinfo.transition_latency = latency;
+
+	policy->fast_switch_possible = false;
+	return 0;
+
+out_put_clk:
+	clk_put(priv->clk);
+out_free_cpufreq_table:
+	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
+out_free_priv:
+	kfree(priv);
+out_free_opp:
+	dev_pm_opp_cpumask_remove_table(policy->cpus);
+
 	return ret;
 }
 
-static const struct cpufreq_arm_bL_ops scpi_cpufreq_ops = {
-	.name	= "scpi",
-	.get_transition_latency = scpi_get_transition_latency,
-	.init_opp_table = scpi_init_opp_table,
-	.free_opp_table = dev_pm_opp_cpumask_remove_table,
+static int scpi_cpufreq_exit(struct cpufreq_policy *policy)
+{
+	struct scpi_data *priv = policy->driver_data;
+
+	cpufreq_cooling_unregister(priv->cdev);
+	clk_put(priv->clk);
+	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
+	kfree(priv);
+	dev_pm_opp_cpumask_remove_table(policy->related_cpus);
+
+	return 0;
+}
+
+static void scpi_cpufreq_ready(struct cpufreq_policy *policy)
+{
+	struct scpi_data *priv = policy->driver_data;
+	struct thermal_cooling_device *cdev;
+
+	cdev = of_cpufreq_cooling_register(policy);
+	if (!IS_ERR(cdev))
+		priv->cdev = cdev;
+}
+
+static struct cpufreq_driver scpi_cpufreq_driver = {
+	.name	= "scpi-cpufreq",
+	.flags	= CPUFREQ_STICKY | CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
+		  CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+	.verify	= cpufreq_generic_frequency_table_verify,
+	.attr	= cpufreq_generic_attr,
+	.get	= scpi_cpufreq_get_rate,
+	.init	= scpi_cpufreq_init,
+	.exit	= scpi_cpufreq_exit,
+	.ready	= scpi_cpufreq_ready,
+	.target_index	= scpi_cpufreq_set_target,
 };
 
 static int scpi_cpufreq_probe(struct platform_device *pdev)
 {
+	int ret;
+
 	scpi_ops = get_scpi_ops();
 	if (!scpi_ops)
 		return -EIO;
 
-	return bL_cpufreq_register(&scpi_cpufreq_ops);
+	ret = cpufreq_register_driver(&scpi_cpufreq_driver);
+	if (ret)
+		dev_err(&pdev->dev, "%s: registering cpufreq failed, err: %d\n",
+			__func__, ret);
+	return ret;
 }
 
 static int scpi_cpufreq_remove(struct platform_device *pdev)
 {
-	bL_cpufreq_unregister(&scpi_cpufreq_ops);
+	cpufreq_unregister_driver(&scpi_cpufreq_driver);
 	scpi_ops = NULL;
 	return 0;
 }
-- 
2.7.4
