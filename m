From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v2 4/7] PM / Domains: Introduce PM domains for CPUs/clusters
Date: Thu,  3 Sep 2015 13:58:31 -0600
Message-ID: <1441310314-8857-5-git-send-email-lina.iyer@linaro.org>
References: <1441310314-8857-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35771 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984AbbICT6v (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Sep 2015 15:58:51 -0400
Received: by pacfv12 with SMTP id fv12so246075pac.2
        for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2015 12:58:51 -0700 (PDT)
In-Reply-To: <1441310314-8857-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, geert@linux-m68k.org, k.kozlowski@samsung.com, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

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
 Documentation/arm/cpu-domains.txt |  56 +++++++++++
 drivers/base/power/Makefile       |   2 +-
 drivers/base/power/cpu-pd.c       | 206 ++++++++++++++++++++++++++++++++++++++
 include/linux/cpu-pd.h            |  35 +++++++
 4 files changed, 298 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/arm/cpu-domains.txt
 create mode 100644 drivers/base/power/cpu-pd.c
 create mode 100644 include/linux/cpu-pd.h

diff --git a/Documentation/arm/cpu-domains.txt b/Documentation/arm/cpu-domains.txt
new file mode 100644
index 0000000..0ac0411
--- /dev/null
+++ b/Documentation/arm/cpu-domains.txt
@@ -0,0 +1,56 @@
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
+
+of_register_cpu_pm_domain() -
+Platforms that need to initialize their genpd, can use this method to
+initialize a CPU PD. The genpd and the callbacks are supplied through the @pd.
diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
index f94a6cc..db2787f 100644
--- a/drivers/base/power/Makefile
+++ b/drivers/base/power/Makefile
@@ -2,7 +2,7 @@ obj-$(CONFIG_PM)	+= sysfs.o generic_ops.o common.o qos.o runtime.o wakeirq.o
 obj-$(CONFIG_PM_SLEEP)	+= main.o wakeup.o
 obj-$(CONFIG_PM_TRACE_RTC)	+= trace.o
 obj-$(CONFIG_PM_OPP)	+= opp.o
-obj-$(CONFIG_PM_GENERIC_DOMAINS)	+=  domain.o domain_governor.o
+obj-$(CONFIG_PM_GENERIC_DOMAINS)	+=  domain.o domain_governor.o cpu-pd.o
 obj-$(CONFIG_HAVE_CLK)	+= clock_ops.o
 
 ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
diff --git a/drivers/base/power/cpu-pd.c b/drivers/base/power/cpu-pd.c
new file mode 100644
index 0000000..5f30025
--- /dev/null
+++ b/drivers/base/power/cpu-pd.c
@@ -0,0 +1,206 @@
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
+#include <linux/module.h>
+#include <linux/cpu_pm.h>
+#include <linux/cpu-pd.h>
+#include <linux/device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+
+#define NAME_MAX 36
+
+/* List of CPU PM domains we care about */
+static LIST_HEAD(of_cpu_pd_list);
+
+static inline
+struct cpu_pm_domain *to_cpu_pd(struct generic_pm_domain *d)
+{
+	struct cpu_pm_domain *pd;
+
+	list_for_each_entry(pd, &of_cpu_pd_list, link) {
+		if (pd->genpd == d)
+			return pd;
+	}
+
+	return NULL;
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
+static int of_pm_domain_attach_cpus(void)
+{
+	int cpuid, ret;
+
+	/* Find any CPU nodes with a phandle to this power domain */
+	for_each_possible_cpu(cpuid) {
+		struct device *cpu_dev;
+
+		cpu_dev = get_cpu_device(cpuid);
+		if (!cpu_dev) {
+			pr_warn("%s: Unable to get device for CPU%d\n",
+					__func__, cpuid);
+			return -ENODEV;
+		}
+
+		if (cpu_online(cpuid)) {
+			pm_runtime_set_active(cpu_dev);
+			/*
+			 * Execute the below on that 'cpu' to ensure that the
+			 * reference counting is correct. Its possible that
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
+		pm_runtime_enable(cpu_dev);
+
+		/*
+		 * We attempt to attach the device to genpd again. We would
+		 * have failed in our earlier attempt to attach to the domain
+		 * provider as the CPU device would not have been IRQ safe,
+		 * while the domain is defined as IRQ safe. IRQ safe domains
+		 * can only have IRQ safe devices.
+		 */
+		ret = genpd_dev_pm_attach(cpu_dev);
+		if (ret) {
+			dev_warn(cpu_dev,
+				"%s: Unable to attach to power-domain: %d\n",
+				__func__, ret);
+			pm_runtime_disable(cpu_dev);
+		} else
+			dev_dbg(cpu_dev, "Attached to PM domain\n");
+	}
+
+	return 0;
+}
+
+/**
+ * of_register_cpu_pm_domain() - Register the CPU PM domain with GenPD
+ * framework
+ * @dn: PM domain provider device node
+ * @pd: The CPU PM domain that has been initialized
+ *
+ * This can be used by the platform code to setup the ->genpd of the @pd
+ * The platform can also set up its callbacks in the ->plat_ops.
+ */
+int of_register_cpu_pm_domain(struct device_node *dn,
+		struct cpu_pm_domain *pd)
+{
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
+	INIT_LIST_HEAD(&pd->link);
+	list_add(&pd->link, &of_cpu_pd_list);
+	pd->dn = dn;
+
+	/* Register the CPU genpd */
+	pr_debug("adding %s as generic power domain.\n", pd->genpd->name);
+	pm_genpd_init(pd->genpd, &simple_qos_governor, false);
+	of_genpd_add_provider_simple(dn, pd->genpd);
+
+	/* Attach the CPUs to the CPU PM domain */
+	return of_pm_domain_attach_cpus();
+}
+EXPORT_SYMBOL(of_register_cpu_pm_domain);
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
+int of_init_cpu_pm_domain(struct device_node *dn, struct cpu_pm_ops *ops)
+{
+	struct cpu_pm_domain *pd;
+
+	if (!of_device_is_available(dn))
+		return -ENODEV;
+
+	pd = kzalloc(sizeof(*pd), GFP_KERNEL);
+	if (!pd)
+		return -ENOMEM;
+
+	pd->genpd = kzalloc(sizeof(*(pd->genpd)), GFP_KERNEL);
+	if (!pd->genpd) {
+		kfree(pd);
+		return -ENOMEM;
+	}
+
+	if (ops) {
+		pd->plat_ops.power_off = ops->power_off;
+		pd->plat_ops.power_on = ops->power_on;
+	}
+
+	pd->genpd->name = kstrndup(dn->full_name, NAME_MAX, GFP_KERNEL);
+
+	return of_register_cpu_pm_domain(dn, pd);
+}
+EXPORT_SYMBOL(of_init_cpu_pm_domain);
diff --git a/include/linux/cpu-pd.h b/include/linux/cpu-pd.h
new file mode 100644
index 0000000..9ae6f5b
--- /dev/null
+++ b/include/linux/cpu-pd.h
@@ -0,0 +1,35 @@
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
+struct cpu_pm_ops {
+	int (*power_off)(struct generic_pm_domain *genpd);
+	int (*power_on)(struct generic_pm_domain *genpd);
+};
+
+struct cpu_pm_domain {
+	struct list_head link;
+	struct generic_pm_domain *genpd;
+	struct device_node *dn;
+	struct cpu_pm_ops plat_ops;
+};
+
+extern int of_register_cpu_pm_domain(struct device_node *dn,
+		struct cpu_pm_domain *pd);
+extern int of_init_cpu_pm_domain(struct device_node *dn,
+		struct cpu_pm_ops *ops);
+
+#endif /* __CPU_PD_H__ */
-- 
2.1.4

