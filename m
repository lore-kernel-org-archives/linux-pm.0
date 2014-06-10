From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 21/24] ARM: ux500: Initial support for power domains
Date: Tue, 10 Jun 2014 12:51:34 +0200
Message-ID: <1402397497-26737-22-git-send-email-ulf.hansson@linaro.org>
References: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1402397497-26737-1-git-send-email-ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Philipp Zabel <philipp.zabel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

The ux500 SoC uses the generic power domain and requires the domains to
be specified through DT.

Currently the callbacks for handling power gating are empty functions
which shall be implemented once each device are handled properly from a
runtime PM perspective.

Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 arch/arm/mach-ux500/Makefile     |    1 +
 arch/arm/mach-ux500/pm.c         |    4 ++
 arch/arm/mach-ux500/pm_domains.c |   77 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-ux500/pm_domains.h |   17 +++++++++
 4 files changed, 99 insertions(+)
 create mode 100644 arch/arm/mach-ux500/pm_domains.c
 create mode 100644 arch/arm/mach-ux500/pm_domains.h

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 9741de95..4418a50 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -9,5 +9,6 @@ obj-$(CONFIG_MACH_MOP500)	+= board-mop500-regulators.o \
 				board-mop500-audio.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
+obj-$(CONFIG_PM_GENERIC_DOMAINS) += pm_domains.o
 
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
+ * Author: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
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
index 0000000..263d3ba
--- /dev/null
+++ b/arch/arm/mach-ux500/pm_domains.h
@@ -0,0 +1,17 @@
+/*
+ * Copyright (C) 2014 Linaro Ltd.
+ *
+ * Author: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#ifndef __MACH_UX500_PM_DOMAINS_H
+#define __MACH_UX500_PM_DOMAINS_H
+
+#ifdef CONFIG_PM_GENERIC_DOMAINS
+extern int __init ux500_pm_domains_init(void);
+#else
+static inline int ux500_pm_domains_init(void) { return 0; }
+#endif
+
+#endif
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
