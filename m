From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH 5/9] ARM: common: Introduce PM domains for CPUs/clusters
Date: Tue,  4 Aug 2015 17:35:35 -0600
Message-ID: <1438731339-58317-6-git-send-email-lina.iyer@linaro.org>
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35751 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754663AbbHDXgN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2015 19:36:13 -0400
Received: by pabxd6 with SMTP id xd6so2467692pab.2
        for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2015 16:36:12 -0700 (PDT)
In-Reply-To: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@linaro.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Define and add Generic PM domains (genpd) for ARM CPU clusters. Many new
SoCs group CPUs as clusters. Clusters share common resources like GIC,
power rail, caches, VFP, Coresight etc. When all CPUs in the cluster are
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
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Kevin Hilman <khilman@linaro.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 Documentation/arm/cpu-domains.txt                  |  49 ++++++
 .../devicetree/bindings/arm/cpudomains.txt         |  23 +++
 arch/arm/common/Makefile                           |   1 +
 arch/arm/common/domains.c                          | 166 +++++++++++++++++++++
 4 files changed, 239 insertions(+)
 create mode 100644 Documentation/arm/cpu-domains.txt
 create mode 100644 Documentation/devicetree/bindings/arm/cpudomains.txt
 create mode 100644 arch/arm/common/domains.c

diff --git a/Documentation/arm/cpu-domains.txt b/Documentation/arm/cpu-domains.txt
new file mode 100644
index 0000000..3e535b7
--- /dev/null
+++ b/Documentation/arm/cpu-domains.txt
@@ -0,0 +1,49 @@
+CPU Clusters and PM domain
+
+Newer ARM CPUs are grouped in a SoC as clusters. A cluster in addition to the
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
+ARM SoCs can power down the CPU and resume execution in a few uSecs and the
+domain that powers the CPU cluster also have comparable idle latencies. The
+ARM CPU WFI signal is used as a hardware trigger for the cluster hardware to
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
+be powered off when the child domains are powered off. ARM CPU cluster can be
+fashioned as a PM domain. When the CPU devices are powered off, the PM domain
+may be powered off.
+
+The code in Generic PM domains handles the hierarchy of devices, domains and
+the reference counting of objects leading to last man down and first man up.
+The ARM CPU domains common code defines PM domains for each CPU cluster and
+attaches the domains' CPU devices to as specified in the DT. This happens
+automatically at kernel init, when the domain is specified as compatible with
+"arm,pd". Powering on/off the common cluster hardware would also be done when
+the PM domain is runtime suspended or resumed.
diff --git a/Documentation/devicetree/bindings/arm/cpudomains.txt b/Documentation/devicetree/bindings/arm/cpudomains.txt
new file mode 100644
index 0000000..d945861
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/cpudomains.txt
@@ -0,0 +1,23 @@
+ARM CPU Power domains
+
+The device tree allows describing of CPU power domains in a SoC. In ARM SoC,
+CPUs may be grouped as clusters. A cluster may have CPUs, GIC, Coresight,
+caches, VFP and power controller and other peripheral hardware. Generally,
+when the CPUs in the cluster are idle/suspended, the shared resources may also
+be suspended and resumed before any of the CPUs resume execution.
+
+CPUs are the defined as the PM domain consumers and there is a PM domain
+provider for the CPUs. Bindings for generic PM domains (genpd) is described in
+[1].
+
+The ARM CPU PM domain follows the same binding convention as any generic PM
+domain. Additional binding properties are -
+
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: Must also have
+			"arm,pd"
+		inorder to initialize the genpd provider as ARM CPU PM domain.
+
+[1]. Documentation/devicetree/bindings/power/power_domain.txt
diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index 6ee5959..e2e2c63 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -18,3 +18,4 @@ AFLAGS_vlock.o			:= -march=armv7-a
 obj-$(CONFIG_TI_PRIV_EDMA)	+= edma.o
 obj-$(CONFIG_BL_SWITCHER)	+= bL_switcher.o
 obj-$(CONFIG_BL_SWITCHER_DUMMY_IF) += bL_switcher_dummy_if.o
+obj-$(CONFIG_PM_GENERIC_DOMAINS) += domains.o
diff --git a/arch/arm/common/domains.c b/arch/arm/common/domains.c
new file mode 100644
index 0000000..15981e9
--- /dev/null
+++ b/arch/arm/common/domains.c
@@ -0,0 +1,166 @@
+/*
+ * ARM CPU Generic PM Domain.
+ *
+ * Copyright (C) 2015 Linaro Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/cpu_pm.h>
+#include <linux/device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+
+#define NAME_MAX 36
+
+struct arm_pm_domain {
+	struct generic_pm_domain genpd;
+};
+
+static inline
+struct arm_pm_domain *to_arm_pd(struct generic_pm_domain *d)
+{
+	return container_of(d, struct arm_pm_domain, genpd);
+}
+
+static int arm_pd_power_down(struct generic_pm_domain *genpd)
+{
+	/*
+	 * Notify CPU PM domain power down
+	 * TODO: Call the notificated directly from here.
+	 */
+	cpu_cluster_pm_enter();
+
+	return 0;
+}
+
+static int arm_pd_power_up(struct generic_pm_domain *genpd)
+{
+	/* Notify CPU PM domain power up */
+	cpu_cluster_pm_exit();
+
+	return 0;
+}
+
+static void __init run_cpu(void *unused)
+{
+	struct device *cpu_dev = get_cpu_device(smp_processor_id());
+
+	/* We are running, increment the usage count */
+	pm_runtime_get_noresume(cpu_dev);
+}
+
+static int __init arm_domain_cpu_init(void)
+{
+	int cpuid, ret;
+
+	/* Find any CPU nodes with a phandle to this power domain */
+	for_each_possible_cpu(cpuid) {
+		struct device *cpu_dev;
+		struct of_phandle_args pd_args;
+
+		cpu_dev = get_cpu_device(cpuid);
+		if (!cpu_dev) {
+			pr_warn("%s: Unable to get device for CPU%d\n",
+					__func__, cpuid);
+			return -ENODEV;
+		}
+
+		/*
+		 * We are only interested in CPUs that can be attached to
+		 * PM domains that are arm,pd compatible.
+		 */
+		ret = of_parse_phandle_with_args(cpu_dev->of_node,
+				"power-domains", "#power-domain-cells",
+				0, &pd_args);
+		if (ret) {
+			dev_dbg(cpu_dev,
+				"%s: Did not find a valid PM domain\n",
+					__func__);
+			continue;
+		}
+
+		if (!of_device_is_compatible(pd_args.np, "arm,pd")) {
+			dev_dbg(cpu_dev, "%s: does not have an ARM PD\n",
+					__func__);
+			continue;
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
+		pm_runtime_irq_safe(cpu_dev);
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
+		}
+	}
+
+	return 0;
+}
+
+static int __init arm_domain_init(void)
+{
+	struct device_node *np;
+	int count = 0;
+
+	for_each_compatible_node(np, NULL, "arm,pd") {
+		struct arm_pm_domain *pd;
+
+		if (!of_device_is_available(np))
+			continue;
+
+		pd = kzalloc(sizeof(*pd), GFP_KERNEL);
+		if (!pd)
+			return -ENOMEM;
+
+		pd->genpd.name = kstrndup(np->name, NAME_MAX, GFP_KERNEL);
+		pd->genpd.power_off = arm_pd_power_down;
+		pd->genpd.power_on = arm_pd_power_up;
+		pd->genpd.flags |= GENPD_FLAG_IRQ_SAFE;
+
+		pr_debug("adding %s as generic power domain.\n", np->full_name);
+		pm_genpd_init(&pd->genpd, &simple_qos_governor, false);
+		of_genpd_add_provider_simple(np, &pd->genpd);
+
+		count++;
+	}
+
+	/* We have ARM PD(s), attach CPUs to their domain */
+	if (count)
+		return arm_domain_cpu_init();
+
+	return 0;
+}
+device_initcall(arm_domain_init);
-- 
2.1.4

