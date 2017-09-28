From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v3 21/22] cpufreq: add support for CPU DVFS based on SCMI message protocol
Date: Thu, 28 Sep 2017 14:11:45 +0100
Message-ID: <1506604306-20739-22-git-send-email-sudeep.holla@arm.com>
References: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57306 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932082AbdI1NO4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 28 Sep 2017 09:14:56 -0400
In-Reply-To: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ALKML <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Roy Franz <roy.franz@cavium.com>, Harb Abdulhamid <harba@codeaurora.org>, Nishanth Menon <nm@ti.com>, Arnd Bergmann <arnd@arndb.de>, Loc Ho <lho@apm.com>, Alexey Klimov <alexey.klimov@arm.com>, Ryan Harkin <Ryan.Harkin@arm.com>, Jassi Brar <jassisinghbrar@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org

On some ARM based systems, a separate Cortex-M based System Control
Processor(SCP) provides the overall power, clock, reset and system
control including CPU DVFS. SCMI Message Protocol is used to
communicate with the SCP.

This patch adds a cpufreq driver for such systems using SCMI interface
to drive CPU DVFS.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 MAINTAINERS                    |   2 +-
 drivers/cpufreq/Kconfig.arm    |  11 ++
 drivers/cpufreq/Makefile       |   1 +
 drivers/cpufreq/scmi-cpufreq.c | 271 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 284 insertions(+), 1 deletion(-)
 create mode 100644 drivers/cpufreq/scmi-cpufreq.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 32c184391aee..1733813c52d9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12942,7 +12942,7 @@ L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/arm,sc[mp]i.txt
 F:	drivers/clk/clk-sc[mp]i.c
-F:	drivers/cpufreq/scpi-cpufreq.c
+F:	drivers/cpufreq/sc[mp]i-cpufreq.c
 F:	drivers/firmware/arm_scpi.c
 F:	drivers/firmware/arm_scmi/
 F:	include/linux/sc[mp]i_protocol.h
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index bdce4488ded1..e21f84cbd9b4 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -205,6 +205,17 @@ config ARM_SA1100_CPUFREQ
 config ARM_SA1110_CPUFREQ
 	bool
 
+config ARM_SCMI_CPUFREQ
+	tristate "SCMI based CPUfreq driver"
+	depends on ARM_SCMI_PROTOCOL || COMPILE_TEST
+	select PM_OPP
+	help
+	  This adds the CPUfreq driver support for ARM platforms using SCMI
+	  protocol for CPU power management.
+
+	  This driver uses SCMI Message Protocol driver to interact with the
+	  firmware providing the CPU DVFS functionality.
+
 config ARM_SCPI_CPUFREQ
         tristate "SCPI based CPUfreq driver"
 	depends on ARM_BIG_LITTLE_CPUFREQ && ARM_SCPI_PROTOCOL && COMMON_CLK_SCPI
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index c7af9b2a255e..1206207f9b62 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -71,6 +71,7 @@ obj-$(CONFIG_ARM_S3C64XX_CPUFREQ)	+= s3c64xx-cpufreq.o
 obj-$(CONFIG_ARM_S5PV210_CPUFREQ)	+= s5pv210-cpufreq.o
 obj-$(CONFIG_ARM_SA1100_CPUFREQ)	+= sa1100-cpufreq.o
 obj-$(CONFIG_ARM_SA1110_CPUFREQ)	+= sa1110-cpufreq.o
+obj-$(CONFIG_ARM_SCMI_CPUFREQ)		+= scmi-cpufreq.o
 obj-$(CONFIG_ARM_SCPI_CPUFREQ)		+= scpi-cpufreq.o
 obj-$(CONFIG_ARM_SPEAR_CPUFREQ)		+= spear-cpufreq.o
 obj-$(CONFIG_ARM_STI_CPUFREQ)		+= sti-cpufreq.o
diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
new file mode 100644
index 000000000000..bc5385638eb4
--- /dev/null
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -0,0 +1,271 @@
+/*
+ * System Control and Power Interface (SCMI) based CPUFreq Interface driver
+ *
+ * Copyright (C) 2017 ARM Ltd.
+ * Sudeep Holla <sudeep.holla@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/cpu.h>
+#include <linux/cpufreq.h>
+#include <linux/cpumask.h>
+#include <linux/cpu_cooling.h>
+#include <linux/export.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <linux/slab.h>
+#include <linux/scmi_protocol.h>
+#include <linux/types.h>
+
+struct scmi_data {
+	int domain_id;
+	struct device *cpu_dev;
+	struct thermal_cooling_device *cdev;
+};
+
+static const struct scmi_handle *handle;
+
+unsigned int scmi_cpufreq_get_rate(unsigned int cpu)
+{
+	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
+	struct scmi_perf_ops *perf_ops = handle->perf_ops;
+	struct scmi_data *priv = policy->driver_data;
+	unsigned long rate;
+	int ret;
+
+	ret = perf_ops->freq_get(handle, priv->domain_id, &rate, false);
+	if (ret)
+		return 0;
+	return rate / 1000;
+}
+
+/*
+ * perf_ops->freq_set is not a synchronous, the actual OPP change will
+ * happen asynchronously and can get notified if the events are
+ * subscribed for by the SCMI firmware
+ */
+static int
+scmi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
+{
+	struct scmi_data *priv = policy->driver_data;
+	struct scmi_perf_ops *perf_ops = handle->perf_ops;
+	u64 freq = policy->freq_table[index].frequency * 1000;
+
+	return perf_ops->freq_set(handle, priv->domain_id, freq, false);
+}
+
+static int
+scmi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
+{
+	int cpu, domain, tdomain;
+	struct device *tcpu_dev;
+
+	domain = handle->perf_ops->device_domain_id(cpu_dev);
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
+		tdomain = handle->perf_ops->device_domain_id(tcpu_dev);
+		if (tdomain == domain)
+			cpumask_set_cpu(cpu, cpumask);
+	}
+
+	return 0;
+}
+
+static int scmi_cpufreq_init(struct cpufreq_policy *policy)
+{
+	int ret;
+	unsigned int latency;
+	struct device *cpu_dev;
+	struct scmi_data *priv;
+	struct cpufreq_frequency_table *freq_table;
+
+	cpu_dev = get_cpu_device(policy->cpu);
+	if (!cpu_dev) {
+		pr_err("failed to get cpu%d device\n", policy->cpu);
+		return -ENODEV;
+	}
+
+	ret = handle->perf_ops->add_opps_to_device(cpu_dev);
+	if (ret) {
+		dev_warn(cpu_dev, "failed to add opps to the device\n");
+		return ret;
+	}
+
+	ret = scmi_get_sharing_cpus(cpu_dev, policy->cpus);
+	if (ret) {
+		dev_warn(cpu_dev, "failed to get sharing cpumask\n");
+		return ret;
+	}
+
+	ret = dev_pm_opp_set_sharing_cpus(cpu_dev, policy->cpus);
+	if (ret) {
+		dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	/*
+	 * We need OPP table to function and since OPPs are added by the
+	 * platform, let's wait for the same.
+	 */
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
+	priv->domain_id = handle->perf_ops->device_domain_id(cpu_dev);
+
+	policy->driver_data = priv;
+
+	ret = cpufreq_table_validate_and_show(policy, freq_table);
+	if (ret) {
+		dev_err(cpu_dev, "%s: invalid frequency table: %d\n", __func__,
+			ret);
+		goto out_free_cpufreq_table;
+	}
+
+	/* SCMI allows DVFS request for any domain from any CPU */
+	policy->dvfs_possible_from_any_cpu = true;
+
+	latency = handle->perf_ops->get_transition_latency(cpu_dev);
+	if (!latency)
+		latency = CPUFREQ_ETERNAL;
+
+	policy->cpuinfo.transition_latency = latency;
+
+	return 0;
+
+out_free_cpufreq_table:
+	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
+out_free_priv:
+	kfree(priv);
+out_free_opp:
+	dev_pm_opp_cpumask_remove_table(policy->cpus);
+
+	return ret;
+}
+
+static int scmi_cpufreq_exit(struct cpufreq_policy *policy)
+{
+	struct scmi_data *priv = policy->driver_data;
+
+	cpufreq_cooling_unregister(priv->cdev);
+	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
+	kfree(priv);
+	dev_pm_opp_cpumask_remove_table(policy->related_cpus);
+
+	return 0;
+}
+
+static void scmi_cpufreq_ready(struct cpufreq_policy *policy)
+{
+	struct scmi_data *priv = policy->driver_data;
+	struct device_node *np = of_node_get(priv->cpu_dev->of_node);
+
+	if (WARN_ON(!np))
+		return;
+
+	if (of_find_property(np, "#cooling-cells", NULL)) {
+		u32 pcoeff = 0;
+
+		of_property_read_u32(np, "dynamic-power-coefficient",
+				     &pcoeff);
+
+		priv->cdev = of_cpufreq_power_cooling_register(np, policy,
+							       pcoeff, NULL);
+		if (IS_ERR(priv->cdev)) {
+			dev_err(priv->cpu_dev,
+				"running cpufreq without cooling device: %ld\n",
+				PTR_ERR(priv->cdev));
+
+			priv->cdev = NULL;
+		}
+	}
+
+	of_node_put(np);
+}
+
+static struct cpufreq_driver scmi_cpufreq_driver = {
+	.name	= "scmi",
+	.flags	= CPUFREQ_STICKY | CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
+		  CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+	.verify	= cpufreq_generic_frequency_table_verify,
+	.attr	= cpufreq_generic_attr,
+	.target_index	= scmi_cpufreq_set_target,
+	.get	= scmi_cpufreq_get_rate,
+	.init	= scmi_cpufreq_init,
+	.exit	= scmi_cpufreq_exit,
+	.ready	= scmi_cpufreq_ready,
+};
+
+static int scmi_cpufreq_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	handle = devm_scmi_handle_get(&pdev->dev);
+
+	if (IS_ERR_OR_NULL(handle) || !handle->perf_ops)
+		return -EPROBE_DEFER;
+
+	ret = cpufreq_register_driver(&scmi_cpufreq_driver);
+	if (ret) {
+		dev_err(&pdev->dev, "%s: registering cpufreq failed, err: %d\n",
+			__func__, ret);
+	}
+
+	return ret;
+}
+
+static int scmi_cpufreq_remove(struct platform_device *pdev)
+{
+	cpufreq_unregister_driver(&scmi_cpufreq_driver);
+	return 0;
+}
+
+static struct platform_driver scmi_cpufreq_platdrv = {
+	.driver = {
+		.name	= "scmi-cpufreq",
+	},
+	.probe		= scmi_cpufreq_probe,
+	.remove		= scmi_cpufreq_remove,
+};
+module_platform_driver(scmi_cpufreq_platdrv);
+
+MODULE_AUTHOR("Sudeep Holla <sudeep.holla@arm.com>");
+MODULE_DESCRIPTION("ARM SCMI CPUFreq interface driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
