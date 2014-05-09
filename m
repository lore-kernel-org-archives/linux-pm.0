From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/3] ARM: ux500: Initial support for power domains
Date: Fri,  9 May 2014 15:05:02 +0200
Message-ID: <1399640704-12289-2-git-send-email-ulf.hansson@linaro.org>
References: <1399640704-12289-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:45912 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbaEINFM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 May 2014 09:05:12 -0400
Received: by mail-lb0-f177.google.com with SMTP id s7so5328379lbd.36
        for <linux-pm@vger.kernel.org>; Fri, 09 May 2014 06:05:10 -0700 (PDT)
In-Reply-To: <1399640704-12289-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Alessandro Rubini <rubini@unipv.it>, Russell King <linux@arm.linux.org.uk>
Cc: linux-pm@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

Initial support for power domains for ux500. To enable this feature we
require to use DT, thus we need to add bindings for the ux500 specific
parts as well.

The implementation of the ux500 power domains is based upon the generic
power domain.

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: devicetree@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 .../devicetree/bindings/arm/ux500/power_domain.txt |   35 +++++++++
 arch/arm/mach-ux500/Kconfig                        |    5 ++
 arch/arm/mach-ux500/Makefile                       |    1 +
 arch/arm/mach-ux500/pm.c                           |    4 +
 arch/arm/mach-ux500/pm_domains.c                   |   77 ++++++++++++++++++++
 arch/arm/mach-ux500/pm_domains.h                   |   17 +++++
 include/dt-bindings/arm/ux500_pm_domains.h         |   15 ++++
 7 files changed, 154 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/ux500/power_domain.txt
 create mode 100644 arch/arm/mach-ux500/pm_domains.c
 create mode 100644 arch/arm/mach-ux500/pm_domains.h
 create mode 100644 include/dt-bindings/arm/ux500_pm_domains.h

diff --git a/Documentation/devicetree/bindings/arm/ux500/power_domain.txt b/Documentation/devicetree/bindings/arm/ux500/power_domain.txt
new file mode 100644
index 0000000..1c98f01
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/ux500/power_domain.txt
@@ -0,0 +1,35 @@
+* ST-Ericsson UX500 Power Domains
+
+UX500 supports multiple power domains which are used to gate power to one or
+more peripherals on the SOC.
+
+The implementation of power domains for UX500 are based upon the generic power
+domain and use the corresponding DT bindings.
+
+==Power domain providers==
+
+Required properties:
+ - compatible: Must be "stericsson,ux500-pm-domains".
+ - #power-domain-cells : Number of cells in a power domain specifier, must be 1.
+
+Example:
+	pm_domains: pm_domains0 {
+		compatible = "stericsson,ux500-pm-domains";
+		#power-domain-cells = <1>;
+	};
+
+==Power domain consumers==
+
+Required properties:
+ - power-domains: A phandle and power domain specifier. Below are the list of
+		valid specifiers:
+
+		Index	Specifier
+		-----	---------
+		0	DOMAIN_VAPE
+
+Example:
+	sdi0_per1@80126000 {
+		compatible = "arm,pl18x", "arm,primecell";
+		power-domains = <&pm_domains DOMAIN_VAPE>
+	};
diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index b41a42d..0727fa7 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -77,4 +77,9 @@ config UX500_DEBUG_UART
 	  Choose the UART on which kernel low-level debug messages should be
 	  output.
 
+config UX500_PM_DOMAINS
+	def_bool y
+	depends on PM_RUNTIME && OF
+	select PM_GENERIC_DOMAINS
+
 endif
diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index de544aa..0dc5d01 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -10,5 +10,6 @@ obj-$(CONFIG_MACH_MOP500)	+= board-mop500-sdi.o \
 				board-mop500-audio.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
+obj-$(CONFIG_UX500_PM_DOMAINS)	+= pm_domains.o
 
 CFLAGS_hotplug.o		+= -march=armv7-a
diff --git a/arch/arm/mach-ux500/pm.c b/arch/arm/mach-ux500/pm.c
index b80a9a2..2cb587b 100644
--- a/arch/arm/mach-ux500/pm.c
+++ b/arch/arm/mach-ux500/pm.c
@@ -17,6 +17,7 @@
 #include <linux/platform_data/arm-ux500-pm.h>
 
 #include "db8500-regs.h"
+#include "pm_domains.h"
 
 /* ARM WFI Standby signal register */
 #define PRCM_ARM_WFI_STANDBY    (prcmu_base + 0x130)
@@ -191,4 +192,7 @@ void __init ux500_pm_init(u32 phy_base, u32 size)
 
 	/* Set up ux500 suspend callbacks. */
 	suspend_set_ops(UX500_SUSPEND_OPS);
+
+	/* Initialize ux500 power domains */
+	ux500_pm_domains_init();
 }
diff --git a/arch/arm/mach-ux500/pm_domains.c b/arch/arm/mach-ux500/pm_domains.c
new file mode 100644
index 0000000..dbc115b
--- /dev/null
+++ b/arch/arm/mach-ux500/pm_domains.c
@@ -0,0 +1,77 @@
+/*
+ * Copyright (C) 2014 Linaro Ltd.
+ *
+ * Author: Ulf Hansson <ulf.hansson@linaro.org>
+ * License terms: GNU General Public License (GPL) version 2
+ *
+ * Implements power domains as generic power domains for ux500.
+ */
+#include <linux/printk.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/pm_domain.h>
+
+#include <dt-bindings/arm/ux500_pm_domains.h>
+#include "pm_domains.h"
+
+static int pd_power_off(struct generic_pm_domain *domain)
+{
+	/*
+	 * Handle the gating of the power domain regulator here.
+	 * Drivers/subsystems operating the devices in the power domain needs
+	 * to handle register context save/restore to be able to enable power
+	 * domain gating/ungating.
+	 */
+	return 0;
+}
+
+static int pd_power_on(struct generic_pm_domain *domain)
+{
+	/*
+	 * Handle the ungating of the power domain regulator here.
+	 * Drivers/subsystems operating the devices in the power domain needs
+	 * to handle register context save/restore to be able to enable power
+	 * domain gating/ungating.
+	 */
+	return 0;
+}
+
+static struct generic_pm_domain ux500_pm_domain_vape = {
+	.name = "VAPE",
+	.power_off = pd_power_off,
+	.power_on = pd_power_on,
+};
+
+static struct generic_pm_domain *ux500_pm_domains[NR_DOMAINS] = {
+	[DOMAIN_VAPE] = &ux500_pm_domain_vape,
+};
+
+static struct of_device_id ux500_pm_domain_matches[] = {
+	{ .compatible = "stericsson,ux500-pm-domains", },
+	{ },
+};
+
+int __init ux500_pm_domains_init(void)
+{
+	struct device_node *np;
+	struct genpd_onecell_data *genpd_data;
+	int i;
+
+	np = of_find_matching_node(NULL, ux500_pm_domain_matches);
+	if (!np)
+		return -ENODEV;
+
+	genpd_data = kzalloc(sizeof(*genpd_data), GFP_KERNEL);
+	if (!genpd_data)
+		return -ENOMEM;
+
+	genpd_data->domain_num = ARRAY_SIZE(ux500_pm_domains);
+	genpd_data->domains = ux500_pm_domains;
+
+	for (i = 0; i < ARRAY_SIZE(ux500_pm_domains); ++i)
+		pm_genpd_init(ux500_pm_domains[i], NULL, false);
+
+	of_genpd_add_provider(np, of_genpd_xlate_onecell, genpd_data);
+	return 0;
+}
diff --git a/arch/arm/mach-ux500/pm_domains.h b/arch/arm/mach-ux500/pm_domains.h
new file mode 100644
index 0000000..057a978
--- /dev/null
+++ b/arch/arm/mach-ux500/pm_domains.h
@@ -0,0 +1,17 @@
+/*
+ * Copyright (C) 2014 Linaro Ltd.
+ *
+ * Author: Ulf Hansson <ulf.hansson@linaro.org>
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#ifndef __MACH_UX500_PM_DOMAINS_H
+#define __MACH_UX500_PM_DOMAINS_H
+
+#ifdef CONFIG_UX500_PM_DOMAINS
+extern int __init ux500_pm_domains_init(void);
+#else
+static inline int ux500_pm_domains_init(void) { return 0; }
+#endif
+
+#endif
diff --git a/include/dt-bindings/arm/ux500_pm_domains.h b/include/dt-bindings/arm/ux500_pm_domains.h
new file mode 100644
index 0000000..73cf25a
--- /dev/null
+++ b/include/dt-bindings/arm/ux500_pm_domains.h
@@ -0,0 +1,15 @@
+/*
+ * Copyright (C) 2014 Linaro Ltd.
+ *
+ * Author: Ulf Hansson <ulf.hansson@linaro.org>
+ * License terms: GNU General Public License (GPL) version 2
+ */
+#ifndef _DT_BINDINGS_ARM_UX500_PM_DOMAINS_H
+#define _DT_BINDINGS_ARM_UX500_PM_DOMAINS_H
+
+#define DOMAIN_VAPE		0
+
+/* Number of power domains. */
+#define NR_DOMAINS		(DOMAIN_VAPE + 1)
+
+#endif
-- 
1.7.9.5

