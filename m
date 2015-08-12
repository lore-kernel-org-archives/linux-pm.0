From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v2 2/2] ARM: domain: Add platform handlers for CPU PM domains
Date: Wed, 12 Aug 2015 13:00:24 -0600
Message-ID: <1439406024-41893-2-git-send-email-lina.iyer@linaro.org>
References: <1439406024-41893-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:32889 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955AbbHLTAp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Aug 2015 15:00:45 -0400
Received: by pdrh1 with SMTP id h1so10287699pdr.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2015 12:00:44 -0700 (PDT)
In-Reply-To: <1439406024-41893-1-git-send-email-lina.iyer@linaro.org>
In-Reply-To: <CAL_JsqLhHy5gO=usm1HLf8h6iz_5FguCDo-Qz2Km+XEwaCODUA@mail.gmail.com>
References: <CAL_JsqLhHy5gO=usm1HLf8h6iz_5FguCDo-Qz2Km+XEwaCODUA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@linaro.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, robherring2@gmail.com, sboyd@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>, Rob Herring <robh@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

In addition to the common power up/down actions of CPU PM domain core,
platforms may have additional configuration before the CPU domain can b
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
Changes since v1:

- Removed references to ARM
- Use OF_DECLARE_1 for __init section tables
---
 arch/arm/common/domains.c         | 38 ++++++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/cpu-pd.h     | 11 +++++++++++
 include/asm-generic/vmlinux.lds.h |  2 ++
 3 files changed, 51 insertions(+)

diff --git a/arch/arm/common/domains.c b/arch/arm/common/domains.c
index 4bc32a5..b1d9cc0 100644
--- a/arch/arm/common/domains.c
+++ b/arch/arm/common/domains.c
@@ -26,8 +26,28 @@
 /* List of CPU PM domains we care about */
 static LIST_HEAD(of_cpu_pd_list);
 
+static const struct of_device_id __cpu_pd_of_table_sentinel
+	__used __section(__cpu_pd_of_table_end);
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
 static int cpu_pd_power_down(struct generic_pm_domain *genpd)
 {
+	struct cpu_pm_domain *pd = to_cpu_pd(genpd);
+
+	if (pd->platform_ops.power_off)
+		pd->platform_ops.power_off(genpd);
 	/*
 	 * Notify CPU PM domain power down
 	 * TODO: Call the notificated directly from here.
@@ -39,6 +59,11 @@ static int cpu_pd_power_down(struct generic_pm_domain *genpd)
 
 static int cpu_pd_power_up(struct generic_pm_domain *genpd)
 {
+	struct cpu_pm_domain *pd = to_cpu_pd(genpd);
+
+	if (pd->platform_ops.power_on)
+		pd->platform_ops.power_on(genpd);
+
 	/* Notify CPU PM domain power up */
 	cpu_cluster_pm_exit();
 
@@ -203,6 +228,8 @@ static int __init of_cpu_pd_init(void)
 {
 	struct device_node *dn;
 	struct cpu_pm_domain *pd;
+	const struct of_device_id *m = &__cpu_pd_of_table;
+	void (*pd_init)(struct device_node *) = NULL;
 
 	for_each_compatible_node(dn, NULL, "cpu,pd") {
 
@@ -213,6 +240,17 @@ static int __init of_cpu_pd_init(void)
 		if (!pd)
 			return -ENOMEM;
 
+		/* Find a compatible platform driver */
+		for (; m->compatible; m++) {
+			if (of_device_is_compatible(dn, m->compatible)) {
+				pd_init = m->data;
+				break;
+			}
+		}
+
+		if (pd_init)
+			pd_init(dn);
+
 		of_register_cpu_pd(dn, pd);
 	}
 
diff --git a/arch/arm/include/asm/cpu-pd.h b/arch/arm/include/asm/cpu-pd.h
index 4785260..65db517 100644
--- a/arch/arm/include/asm/cpu-pd.h
+++ b/arch/arm/include/asm/cpu-pd.h
@@ -15,13 +15,24 @@
 #include <linux/of.h>
 #include <linux/pm_domain.h>
 
+struct cpu_pd_ops {
+	int (*power_on)(struct generic_pm_domain *d);
+	int (*power_off)(struct generic_pm_domain *d);
+};
+
 struct cpu_pm_domain {
 	struct list_head link;
 	struct generic_pm_domain *genpd;
+	struct cpu_pd_ops platform_ops;
 	struct device_node *dn;
 };
 
 extern int of_init_cpu_domain(struct device_node *dn, struct cpu_pm_domain *pd);
 extern struct cpu_pm_domain *of_get_cpu_domain(struct device_node *dn);
 
+extern const struct of_device_id __cpu_pd_of_table;
+
+#define CPU_PD_METHOD_OF_DECLARE(name, compat, fn)     \
+			OF_DECLARE_1(cpu_pd, name, compat, fn)
+
 #endif /* __CPU_PD_H__ */
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 8bd374d..f952933 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -179,6 +179,7 @@
 #define RESERVEDMEM_OF_TABLES()	OF_TABLE(CONFIG_OF_RESERVED_MEM, reservedmem)
 #define CPU_METHOD_OF_TABLES()	OF_TABLE(CONFIG_SMP, cpu_method)
 #define CPUIDLE_METHOD_OF_TABLES() OF_TABLE(CONFIG_CPU_IDLE, cpuidle_method)
+#define CPU_PD_OF_TABLES()	OF_TABLE(CONFIG_PM_GENERIC_DOMAINS, cpu_pd)
 #define EARLYCON_OF_TABLES()	OF_TABLE(CONFIG_SERIAL_EARLYCON, earlycon)
 
 #define KERNEL_DTB()							\
@@ -514,6 +515,7 @@
 	IOMMU_OF_TABLES()						\
 	CPU_METHOD_OF_TABLES()						\
 	CPUIDLE_METHOD_OF_TABLES()					\
+	CPU_PD_OF_TABLES()						\
 	KERNEL_DTB()							\
 	IRQCHIP_OF_MATCH_TABLE()					\
 	EARLYCON_TABLE()						\
-- 
2.1.4

