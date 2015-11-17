From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC 10/27] drivers: power: Introduce PM domains for CPUs/clusters
Date: Tue, 17 Nov 2015 15:37:34 -0700
Message-ID: <1447799871-56374-11-git-send-email-lina.iyer@linaro.org>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Lina Iyer <lina.iyer@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

Define and add Generic PM domains (genpd) for CPU clusters. Many new
SoCs group CPUs as clusters. Clusters share common resources like power
rails, caches, VFP, Coresight etc. When all CPUs in the cluster are
idle, these shared resources may also be put in their idle state.

The idle time between the last CPU entering idle and a CPU resuming
execution is an opportunity for these shared resources to be powered
down. Generic PM domain provides a framework for defining such power
domains and attach devices to the domain. When the devices in the domain
are idle at runtime, the domain would also be suspended and resumed
before the first of the devices resume execution.

We define a generic PM domain for each cluster and attach CPU devices in
the cluster to that PM domain. The DT definitions for the SoC describe
this relationship. Genpd callbacks for power_on and power_off can then
be used to power up/down the shared resources for the domain.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Kevin Hilman <khilman@linaro.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 Documentation/arm/cpu-domains.txt |  52 +++++++++
 drivers/base/power/Makefile       |   1 +
 drivers/base/power/cpu-pd.c       | 231 ++++++++++++++++++++++++++++++++++++++
 include/linux/cpu-pd.h            |  32 ++++++
 4 files changed, 316 insertions(+)
 create mode 100644 Documentation/arm/cpu-domains.txt
 create mode 100644 drivers/base/power/cpu-pd.c
 create mode 100644 include/linux/cpu-pd.h

diff --git a/Documentation/arm/cpu-domains.txt b/Documentation/arm/cpu-domains.txt
new file mode 100644
index 0000000..ef5f215
--- /dev/null
+++ b/Documentation/arm/cpu-domains.txt
@@ -0,0 +1,52 @@
+CPU Clusters and PM domain
+
+Newer CPUs are grouped in a SoC as clusters. A cluster in addition to the
+CPUs may have caches, GIC, VFP and architecture specific power controller to
+power the cluster. A cluster may also be nested in another cluster, the
+hierarchy of which is depicted in the device tree. CPUIdle frameworks enables
+the CPUs to determine the sleep time and enter low power state to save power
+during periods of idle. CPUs in a cluster may enter and exit idle state
+independently. During the time when all the CPUs are in idle state, the
+cluster can safely be in idle state as well. When the last of the CPUs is
+powered off as a result of idle, the cluster may also be powered down, but the
+domain must be powered on before the first of the CPUs in the cluster resumes
+execution.
+
+SoCs can power down the CPU and resume execution in a few uSecs and the domain
+that powers the CPU cluster also have comparable idle latencies. The CPU WFI
+signal in ARM CPUs is used as a hardware trigger for the cluster hardware to
+enter their idle state. The hardware can be programmed in advance to put the
+cluster in the desired idle state befitting the wakeup latency requested by
+the CPUs. When all the CPUs in a cluster have executed their WFI instruction,
+the state machine for the power controller may put the cluster components in
+their power down or idle state. Generally, the domains would power on with the
+hardware sensing the CPU's interrupts. The domains may however, need to be
+reconfigured by the CPU to remain active, until the last CPU is ready to enter
+idle again. To power down a cluster, it is generally required to power down
+all the CPUs. The caches would also need to be flushed. The hardware state of
+some of the components may need to be saved and restored when powered back on.
+SoC vendors may also have hardware specific configuration that must be done
+before the cluster can be powered off. When the cluster is powered off,
+notifications may be sent out to other SoC components to scale down or even
+power off their resources.
+
+Power management domains represent relationship of devices and their power
+controllers. They are represented in the DT as domain consumers and providers.
+A device may have a domain provider and a domain provider may support multiple
+domain consumers. Domains like clusters, may also be nested inside one
+another. A domain that has no active consumer, may be powered off and any
+resuming consumer would trigger the domain back to active. Parent domains may
+be powered off when the child domains are powered off. The CPU cluster can be
+fashioned as a PM domain. When the CPU devices are powered off, the PM domain
+may be powered off.
+
+The code in Generic PM domains handles the hierarchy of devices, domains and
+the reference counting of objects leading to last man down and first man up.
+The CPU domains core code defines PM domains for each CPU cluster and attaches
+the domains' CPU devices to as specified in the DT. Platform drivers may use
+the following API to register their CPU PM domains.
+
+of_init_cpu_pm_domain() -
+Provides a single step registration of the CPU PM domain and attach CPUs to
+the genpd. Platform drivers may additionally register callbacks for power_on
+and power_off operations.
diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
index 5998c53..59cb3ef 100644
--- a/drivers/base/power/Makefile
+++ b/drivers/base/power/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_PM_SLEEP)	+= main.o wakeup.o
 obj-$(CONFIG_PM_TRACE_RTC)	+= trace.o
 obj-$(CONFIG_PM_OPP)	+= opp/
 obj-$(CONFIG_PM_GENERIC_DOMAINS)	+=  domain.o domain_governor.o
+obj-$(CONFIG_PM_GENERIC_DOMAINS_OF)	+= cpu-pd.o
 obj-$(CONFIG_HAVE_CLK)	+= clock_ops.o
 
 ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
diff --git a/drivers/base/power/cpu-pd.c b/drivers/base/power/cpu-pd.c
new file mode 100644
index 0000000..9758b8d
--- /dev/null
+++ b/drivers/base/power/cpu-pd.c
@@ -0,0 +1,231 @@
+/*
+ * CPU Generic PM Domain.
+ *
+ * Copyright (C) 2015 Linaro Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#define DEBUG
+
+#include <linux/kernel.h>
+#include <linux/export.h>
+#include <linux/cpu.h>
+#include <linux/cpu_pm.h>
+#include <linux/cpu-pd.h>
+#include <linux/device.h>
+#include <linux/pm_runtime.h>
+#include <linux/platform_device.h>
+#include <linux/rculist.h>
+#include <linux/slab.h>
+
+#define CPU_PD_NAME_MAX 36
+
+/* List of CPU PM domains we care about */
+static LIST_HEAD(of_cpu_pd_list);
+static DEFINE_SPINLOCK(cpu_pd_list_lock);
+
+static inline
+struct cpu_pm_domain *to_cpu_pd(struct generic_pm_domain *d)
+{
+	struct cpu_pm_domain *pd;
+	struct cpu_pm_domain *res = NULL;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(pd, &of_cpu_pd_list, link)
+		if (pd->genpd == d) {
+			res = pd;
+			break;
+		}
+	rcu_read_unlock();
+
+	return res;
+}
+
+static int cpu_pd_power_off(struct generic_pm_domain *genpd)
+{
+	struct cpu_pm_domain *pd = to_cpu_pd(genpd);
+
+	if (pd->plat_ops.power_off)
+		pd->plat_ops.power_off(genpd);
+
+	/*
+	 * Notify CPU PM domain power down
+	 * TODO: Call the notificated directly from here.
+	 */
+	cpu_cluster_pm_enter();
+
+	return 0;
+}
+
+static int cpu_pd_power_on(struct generic_pm_domain *genpd)
+{
+	struct cpu_pm_domain *pd = to_cpu_pd(genpd);
+
+	if (pd->plat_ops.power_on)
+		pd->plat_ops.power_on(genpd);
+
+	/* Notify CPU PM domain power up */
+	cpu_cluster_pm_exit();
+
+	return 0;
+}
+
+static void run_cpu(void *unused)
+{
+	struct device *cpu_dev = get_cpu_device(smp_processor_id());
+
+	/* We are running, increment the usage count */
+	pm_runtime_get_noresume(cpu_dev);
+}
+
+static int of_pm_domain_attach_cpus(struct device_node *dn)
+{
+	int cpuid, ret;
+
+	/* Find any CPU nodes with a phandle to this power domain */
+	for_each_possible_cpu(cpuid) {
+		struct device *cpu_dev;
+		struct device_node *cpu_pd;
+
+		cpu_dev = get_cpu_device(cpuid);
+		if (!cpu_dev) {
+			pr_warn("%s: Unable to get device for CPU%d\n",
+					__func__, cpuid);
+			return -ENODEV;
+		}
+
+		/* Only attach CPUs that are part of this domain */
+		cpu_pd = of_parse_phandle(cpu_dev->of_node, "power-domains", 0);
+		if (cpu_pd != dn)
+			continue;
+
+		if (cpu_online(cpuid)) {
+			pm_runtime_set_active(cpu_dev);
+			/*
+			 * Execute the below on that 'cpu' to ensure that the
+			 * reference counting is correct. It's possible that
+			 * while this code is executing, the 'cpu' may be
+			 * powered down, but we may incorrectly increment the
+			 * usage. By executing the get_cpu on the 'cpu',
+			 * we can ensure that the 'cpu' and its usage count are
+			 * matched.
+			 */
+			smp_call_function_single(cpuid, run_cpu, NULL, true);
+		} else {
+			pm_runtime_set_suspended(cpu_dev);
+		}
+
+		ret = genpd_dev_pm_attach(cpu_dev);
+		if (ret) {
+			dev_warn(cpu_dev,
+				"%s: Unable to attach to power-domain: %d\n",
+				__func__, ret);
+		} else {
+			pm_runtime_enable(cpu_dev);
+			dev_dbg(cpu_dev, "Attached CPU%d to domain\n", cpuid);
+		}
+	}
+
+	return 0;
+}
+
+int of_register_cpu_pm_domain(struct device_node *dn,
+		struct cpu_pm_domain *pd)
+{
+	int ret;
+
+	if (!pd || !pd->genpd)
+		return -EINVAL;
+
+	/*
+	 * The platform should not set up the genpd callbacks.
+	 * They should setup the pd->plat_ops instead.
+	 */
+	WARN_ON(pd->genpd->power_off);
+	WARN_ON(pd->genpd->power_on);
+
+	pd->genpd->power_off = cpu_pd_power_off;
+	pd->genpd->power_on = cpu_pd_power_on;
+	pd->genpd->flags |= GENPD_FLAG_IRQ_SAFE;
+
+	INIT_LIST_HEAD_RCU(&pd->link);
+	spin_lock(&cpu_pd_list_lock);
+	list_add_rcu(&pd->link, &of_cpu_pd_list);
+	spin_unlock(&cpu_pd_list_lock);
+	pd->dn = dn;
+
+	/* Register the CPU genpd */
+	pr_debug("adding %s as CPU PM domain.\n", pd->genpd->name);
+	ret = of_pm_genpd_init(dn, pd->genpd, &simple_qos_governor, false);
+	if (ret) {
+		pr_err("Unable to initialize domain %s\n", dn->full_name);
+		return ret;
+	}
+
+	ret = of_genpd_add_provider_simple(dn, pd->genpd);
+	if (ret)
+		pr_warn("Unable to add genpd %s as provider\n",
+				pd->genpd->name);
+
+	/* Attach the CPUs to the CPU PM domain */
+	ret = of_pm_domain_attach_cpus(dn);
+	if (ret)
+		of_genpd_del_provider(dn);
+
+	return ret;
+}
+
+/**
+ * of_init_cpu_pm_domain() - Initialize a CPU PM domain using the CPU pd
+ * provided
+ * @dn: PM domain provider device node
+ * @ops: CPU PM domain platform specific ops for callback
+ *
+ * This is a single step initialize the CPU PM domain with defaults,
+ * also register the genpd and attach CPUs to the genpd.
+ */
+struct generic_pm_domain *of_init_cpu_pm_domain(struct device_node *dn,
+				const struct cpu_pd_ops *ops)
+{
+	struct cpu_pm_domain *pd;
+	int ret;
+
+	if (!of_device_is_available(dn))
+		return ERR_PTR(-ENODEV);
+
+	pd = kzalloc(sizeof(*pd), GFP_KERNEL);
+	if (!pd)
+		return ERR_PTR(-ENOMEM);
+
+	pd->genpd = kzalloc(sizeof(*(pd->genpd)), GFP_KERNEL);
+	if (!pd->genpd) {
+		kfree(pd);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	pd->genpd->name = kstrndup(dn->full_name, CPU_PD_NAME_MAX, GFP_KERNEL);
+	if (!pd->genpd->name) {
+		kfree(pd->genpd);
+		kfree(pd);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	if (ops) {
+		pd->plat_ops.power_off = ops->power_off;
+		pd->plat_ops.power_on = ops->power_on;
+	}
+
+	ret = of_register_cpu_pm_domain(dn, pd);
+	if (ret) {
+		kfree(pd->genpd->name);
+		kfree(pd->genpd);
+		kfree(pd);
+		return ERR_PTR(ret);
+	}
+
+	return pd->genpd;
+}
+EXPORT_SYMBOL(of_init_cpu_pm_domain);
diff --git a/include/linux/cpu-pd.h b/include/linux/cpu-pd.h
new file mode 100644
index 0000000..a2a217d
--- /dev/null
+++ b/include/linux/cpu-pd.h
@@ -0,0 +1,32 @@
+/*
+ * include/linux/cpu-pd.h
+ *
+ * Copyright (C) 2015 Linaro Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __CPU_PD_H__
+#define __CPU_PD_H__
+
+#include <linux/list.h>
+#include <linux/of.h>
+#include <linux/pm_domain.h>
+
+struct cpu_pd_ops {
+	int (*power_off)(struct generic_pm_domain *genpd);
+	int (*power_on)(struct generic_pm_domain *genpd);
+};
+
+struct cpu_pm_domain {
+	struct list_head link;
+	struct generic_pm_domain *genpd;
+	struct device_node *dn;
+	struct cpu_pd_ops plat_ops;
+};
+
+struct generic_pm_domain *of_init_cpu_pm_domain(struct device_node *dn,
+		const struct cpu_pd_ops *ops);
+#endif /* __CPU_PD_H__ */
-- 
2.1.4
