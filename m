From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH 6/9] ARM: domain: Add platform handlers for CPU PM domains
Date: Tue,  4 Aug 2015 17:35:36 -0600
Message-ID: <1438731339-58317-7-git-send-email-lina.iyer@linaro.org>
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35773 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754663AbbHDXgP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2015 19:36:15 -0400
Received: by pabxd6 with SMTP id xd6so2468208pab.2
        for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2015 16:36:14 -0700 (PDT)
In-Reply-To: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@linaro.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>, Rob Herring <robh@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

In addition to the common power up/down actions of CPU PM domain core,
platforms may have additional configuration before the CPU domain can be
powered off or considered active. Allow platform drivers to register
handlers for CPU PM domains.

Platform drivers may register their callbacks against a compatible
string defined by their PM domain provider device node in the DT. At
domain init, the platform driver can initialize the platform specific
genpd attributes. The init callback would need to return successfully,
for the platform power_on/off handlers to be registered with the CPU PM
domain.

The code uses __init section to reduce memory needed for platform
handlers and therefore can be freed after the driver is initialized, a
desirable outcome for single kernel image.

Cc: Rob Herring <robh@kernel.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 Documentation/arm/cpu-domains.txt | 26 ++++++++++++++++++++++++++
 arch/arm/common/domains.c         | 37 +++++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/arm-pd.h     | 30 ++++++++++++++++++++++++++++++
 include/asm-generic/vmlinux.lds.h |  2 ++
 4 files changed, 95 insertions(+)
 create mode 100644 arch/arm/include/asm/arm-pd.h

diff --git a/Documentation/arm/cpu-domains.txt b/Documentation/arm/cpu-domains.txt
index 3e535b7..a0b98f3 100644
--- a/Documentation/arm/cpu-domains.txt
+++ b/Documentation/arm/cpu-domains.txt
@@ -47,3 +47,29 @@ attaches the domains' CPU devices to as specified in the DT. This happens
 automatically at kernel init, when the domain is specified as compatible with
 "arm,pd". Powering on/off the common cluster hardware would also be done when
 the PM domain is runtime suspended or resumed.
+
+SoCs may have additional configuration for the CPU PM domain. The ARM code
+provides a way for the platform driver to add those properties to the genpd
+before the genpd object is initialized. Additionally, platform driver may also
+register for CPU domain power_on/power_off callbacks.
+
+Platform drivers may register the callbacks using the __init section macro
+ARM_PD_METHOD_OF_DECLARE. The callbacks in of_arm_pd_ops, can be specified
+against a compatible flag for the domain provider.
+
+Callback for platform drivers -
+
+int (*init)(struct device_node *dn, struct generic_pm_domain *d)
+The init() callback is called before the generic PM domain is registered with
+the GenPD framework. The device node is provided to identify the domain that
+is being initialized. The init function must return 0, in order for the
+power_on and power_off callbacks to be registered with the CPU PD framework.
+
+int (*power_on)(struct generic_pm_domain *d);
+The power_on() callback is called when the first CPU in the cluster is ready
+to resume execution. The domain may be considered active at this point.
+
+int (*power_off)(struct generic_pm_domain *d);
+The power_off() callback is called when the last CPU in the cluster enters
+idle. The domain may be configured to power off and wait for a CPU's wakeup
+interrupt.
diff --git a/arch/arm/common/domains.c b/arch/arm/common/domains.c
index 15981e9..bbffeed 100644
--- a/arch/arm/common/domains.c
+++ b/arch/arm/common/domains.c
@@ -18,12 +18,19 @@
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
+#include <asm/arm-pd.h>
+
 #define NAME_MAX 36
 
 struct arm_pm_domain {
 	struct generic_pm_domain genpd;
+	struct of_arm_pd_ops platform_ops;
 };
 
+extern struct of_arm_pd_method __arm_pd_method_of_table[];
+static const struct of_arm_pd_method __arm_pd_method_of_table_sentinel
+	__used __section(__arm_pd_method_of_table_end);
+
 static inline
 struct arm_pm_domain *to_arm_pd(struct generic_pm_domain *d)
 {
@@ -32,20 +39,30 @@ struct arm_pm_domain *to_arm_pd(struct generic_pm_domain *d)
 
 static int arm_pd_power_down(struct generic_pm_domain *genpd)
 {
+	struct arm_pm_domain *pd = to_arm_pd(genpd);
+
 	/*
 	 * Notify CPU PM domain power down
 	 * TODO: Call the notificated directly from here.
 	 */
 	cpu_cluster_pm_enter();
 
+	if (pd->platform_ops.power_off)
+		return pd->platform_ops.power_off(genpd);
+
 	return 0;
 }
 
 static int arm_pd_power_up(struct generic_pm_domain *genpd)
 {
+	struct arm_pm_domain *pd = to_arm_pd(genpd);
+
 	/* Notify CPU PM domain power up */
 	cpu_cluster_pm_exit();
 
+	if (pd->platform_ops.power_on)
+		return pd->platform_ops.power_on(genpd);
+
 	return 0;
 }
 
@@ -134,6 +151,7 @@ static int __init arm_domain_init(void)
 {
 	struct device_node *np;
 	int count = 0;
+	struct of_arm_pd_method *m = __arm_pd_method_of_table;
 
 	for_each_compatible_node(np, NULL, "arm,pd") {
 		struct arm_pm_domain *pd;
@@ -145,6 +163,25 @@ static int __init arm_domain_init(void)
 		if (!pd)
 			return -ENOMEM;
 
+		/* Invoke platform initialization for the PM domain */
+		for (; m->handle; m++) {
+			int ret;
+
+			if (of_device_is_compatible(np, m->handle)) {
+				ret = m->ops->init(np, &pd->genpd);
+				if (!ret) {
+					pr_debug("CPU PD ops found for %s\n",
+							m->handle);
+					pd->platform_ops.power_on =
+						m->ops->power_on;
+					pd->platform_ops.power_off =
+						m->ops->power_off;
+				}
+				break;
+			}
+		}
+
+		/* Initialize rest of CPU PM domain specifics */
 		pd->genpd.name = kstrndup(np->name, NAME_MAX, GFP_KERNEL);
 		pd->genpd.power_off = arm_pd_power_down;
 		pd->genpd.power_on = arm_pd_power_up;
diff --git a/arch/arm/include/asm/arm-pd.h b/arch/arm/include/asm/arm-pd.h
new file mode 100644
index 0000000..fc44abf
--- /dev/null
+++ b/arch/arm/include/asm/arm-pd.h
@@ -0,0 +1,30 @@
+/*
+ * linux/arch/arm/include/asm/arm-pd.h
+ *
+ * Copyright (C) 2015 Linaro Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ARM_PD_H__
+#define __ARM_PD_H__
+
+struct of_arm_pd_ops {
+	int (*init)(struct device_node *dn, struct generic_pm_domain *d);
+	int (*power_on)(struct generic_pm_domain *d);
+	int (*power_off)(struct generic_pm_domain *d);
+};
+
+struct of_arm_pd_method {
+	const char *handle;
+	struct of_arm_pd_ops *ops;
+};
+
+#define ARM_PD_METHOD_OF_DECLARE(_name, _handle, _ops)	\
+	static const struct of_arm_pd_method __arm_pd_method_of_table_##_name \
+	__used __section(__arm_pd_method_of_table)		\
+	= { .handle = _handle, .ops = _ops }
+
+#endif /* __ARM_PD_H__ */
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 8bd374d..bd97a69 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -179,6 +179,7 @@
 #define RESERVEDMEM_OF_TABLES()	OF_TABLE(CONFIG_OF_RESERVED_MEM, reservedmem)
 #define CPU_METHOD_OF_TABLES()	OF_TABLE(CONFIG_SMP, cpu_method)
 #define CPUIDLE_METHOD_OF_TABLES() OF_TABLE(CONFIG_CPU_IDLE, cpuidle_method)
+#define ARM_PD_METHOD_OF_TABLES() OF_TABLE(CONFIG_PM_GENERIC_DOMAINS, arm_pd_method)
 #define EARLYCON_OF_TABLES()	OF_TABLE(CONFIG_SERIAL_EARLYCON, earlycon)
 
 #define KERNEL_DTB()							\
@@ -514,6 +515,7 @@
 	IOMMU_OF_TABLES()						\
 	CPU_METHOD_OF_TABLES()						\
 	CPUIDLE_METHOD_OF_TABLES()					\
+	ARM_PD_METHOD_OF_TABLES()					\
 	KERNEL_DTB()							\
 	IRQCHIP_OF_MATCH_TABLE()					\
 	EARLYCON_TABLE()						\
-- 
2.1.4

