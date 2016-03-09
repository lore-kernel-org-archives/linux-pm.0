From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 03/11] soc: renesas: rcar-sysc: Add DT support for SYSC PM domains
Date: Wed,  9 Mar 2016 20:18:39 +0100
Message-ID: <1457551127-21934-4-git-send-email-geert+renesas@glider.be>
References: <1457551127-21934-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from laurent.telenet-ops.be ([195.130.137.89]:42741 "EHLO
	laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932859AbcCITSt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Mar 2016 14:18:49 -0500
In-Reply-To: <1457551127-21934-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Geert Uytterhoeven <geert+renesas@glider.be>

Populate the SYSC PM domains from DT, based on the presence of a device
node for the System Controller. The actual power area hiearchy, and
features of specific areas are obtained from tables in the C code.

The SYSCIER register value is derived from the power areas present,
which will help to get rid of the hardcoded values in pm-rcar-gen2.c
later.

Initialization is done from an early_initcall(), to make sure the PM
Domains are initialized before SMP.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - Drop check for CONFIG_PM_GENERIC_DOMAINS, which is now always
    enabled on R-Car SoCs,
  - Create PM Domains from hierarchy in C data instead of DT,
  - Initialize SYSCIER early, as SYSC needs the interrupt sources to be
    enabled to control power,
  - Mask all SYSC interrupt sources for the CPU,
  - Add support for an "always-on" domain,
  - Use early_initcall() instead of core_initcall(),
  - Do not power up CPU power areas during initialization, as this is
    handled later (directly or indirectly) by the SMP code,

v2:
  - Add missing definitions for SYSC_PWR_CA15_CPU and SYSC_PWR_CA7_CPU,
  - Add R-Car H3 (r8a7795) support,
  - Drop tests for CONFIG_ARCH_SHMOBILE_LEGACY,
  - Add missing break statements in rcar_sysc_pwr_on_off(),
  - Add missing calls to of_node_put() in error paths,
  - Fix build if CONFIG_PM=n,
  - Update compatible values,
  - Update copyright.
---
 drivers/soc/renesas/rcar-sysc.c | 202 ++++++++++++++++++++++++++++++++++++++++
 drivers/soc/renesas/rcar-sysc.h |  53 +++++++++++
 2 files changed, 255 insertions(+)
 create mode 100644 drivers/soc/renesas/rcar-sysc.h

diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index 9ba5fd15c53bf9b9..6b21ea2a65bf59b9 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -2,6 +2,7 @@
  * R-Car SYSC Power management support
  *
  * Copyright (C) 2014  Magnus Damm
+ * Copyright (C) 2015-2016 Glider bvba
  *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
@@ -11,10 +12,15 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/mm.h>
+#include <linux/of_address.h>
+#include <linux/pm_domain.h>
+#include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/io.h>
 #include <linux/soc/renesas/rcar-sysc.h>
 
+#include "rcar-sysc.h"
+
 /* SYSC Common */
 #define SYSCSR			0x00	/* SYSC Status Register */
 #define SYSCISR			0x04	/* Interrupt Status Register */
@@ -162,3 +168,199 @@ void __iomem *rcar_sysc_init(phys_addr_t base)
 
 	return rcar_sysc_base;
 }
+
+struct rcar_sysc_pd {
+	struct generic_pm_domain genpd;
+	struct rcar_sysc_ch ch;
+	unsigned int flags;
+	char name[0];
+};
+
+static inline struct rcar_sysc_pd *to_rcar_pd(struct generic_pm_domain *d)
+{
+	return container_of(d, struct rcar_sysc_pd, genpd);
+}
+
+static bool rcar_sysc_active_wakeup(struct device *dev)
+{
+	return true;
+}
+
+static int rcar_sysc_pd_power_off(struct generic_pm_domain *genpd)
+{
+	struct rcar_sysc_pd *pd = to_rcar_pd(genpd);
+
+	pr_debug("%s: %s\n", __func__, genpd->name);
+
+	if (pd->flags & PD_NO_CR) {
+		pr_debug("%s: Cannot control %s\n", __func__, genpd->name);
+		return -EBUSY;
+	}
+
+	if (pd->flags & PD_BUSY) {
+		pr_debug("%s: %s busy\n", __func__, genpd->name);
+		return -EBUSY;
+	}
+
+	return rcar_sysc_power_down(&pd->ch);
+}
+
+static int rcar_sysc_pd_power_on(struct generic_pm_domain *genpd)
+{
+	struct rcar_sysc_pd *pd = to_rcar_pd(genpd);
+
+	pr_debug("%s: %s\n", __func__, genpd->name);
+
+	if (pd->flags & PD_NO_CR) {
+		pr_debug("%s: Cannot control %s\n", __func__, genpd->name);
+		return 0;
+	}
+
+	return rcar_sysc_power_up(&to_rcar_pd(genpd)->ch);
+}
+
+static void __init rcar_sysc_pd_setup(struct device_node *np,
+				      struct rcar_sysc_pd *pd)
+{
+	struct generic_pm_domain *genpd = &pd->genpd;
+	const char *name = pd->genpd.name;
+	struct dev_power_governor *gov = &simple_qos_governor;
+
+	if (pd->flags & PD_CPU) {
+		/*
+		 * This domain contains a CPU core and therefore it should
+		 * only be turned off if the CPU is not in use.
+		 */
+		pr_debug("PM domain %s contains CPU\n", name);
+		pd->flags |= PD_BUSY;
+		gov = &pm_domain_always_on_gov;
+	} else if (pd->flags & PD_SCU) {
+		/*
+		 * This domain contains an SCU and cache-controller, and
+		 * therefore it should only be turned off if the CPU cores are
+		 * not in use.
+		 */
+		pr_debug("PM domain %s contains SCU\n", name);
+		pd->flags |= PD_BUSY;
+		gov = &pm_domain_always_on_gov;
+	} else if (pd->flags & PD_NO_CR) {
+		/*
+		 * This domain cannot be turned off.
+		 */
+		pd->flags |= PD_BUSY;
+		gov = &pm_domain_always_on_gov;
+	}
+
+	pm_genpd_init(genpd, gov, false);
+	genpd->dev_ops.active_wakeup = rcar_sysc_active_wakeup;
+	genpd->power_off = rcar_sysc_pd_power_off;
+	genpd->power_on = rcar_sysc_pd_power_on;
+
+	if (pd->flags & (PD_CPU | PD_NO_CR)) {
+		/* Skip CPUs (handled by SMP code) and areas without control */
+		pr_debug("%s: Not touching %s\n", __func__, genpd->name);
+		return;
+	}
+
+	if (!rcar_sysc_power_is_off(&pd->ch)) {
+		pr_debug("%s: %s is already powered\n", __func__, genpd->name);
+		return;
+	}
+
+	rcar_sysc_power_up(&pd->ch);
+}
+
+static const struct of_device_id rcar_sysc_matches[] = {
+	{ /* sentinel */ }
+};
+
+struct rcar_pm_domains {
+	struct genpd_onecell_data onecell_data;
+	struct generic_pm_domain *domains[0];
+};
+
+static int __init rcar_sysc_pd_init(void)
+{
+	const struct rcar_sysc_info *info;
+	const struct of_device_id *match;
+	struct rcar_pm_domains *domains;
+	struct device_node *np;
+	unsigned int i, n = 0;
+	void __iomem *base;
+	u32 syscier = 0;
+	int error;
+
+	np = of_find_matching_node_and_match(NULL, rcar_sysc_matches, &match);
+	if (!np)
+		return -ENODEV;
+
+	info = match->data;
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		pr_warn("%s cannot map reg 0\n", np->full_name);
+		error = -ENOMEM;
+		goto fail_put;
+	}
+
+	rcar_sysc_base = base;
+
+	for (i = 0; i < info->num_areas; i++) {
+		n = max_t(unsigned int, n, info->areas[i].isr_bit + 1);
+		syscier |= BIT(info->areas[i].isr_bit);
+	}
+
+	/*
+	 * SYSC needs all interrupt sources to be enabled to control power.
+	 * Mask all interrupt sources to prevent the CPU from receiving them.
+	 */
+	pr_debug("%s: syscier = 0x%08x\n", np->full_name, syscier);
+	iowrite32(syscier, rcar_sysc_base + SYSCIER);
+	iowrite32(syscier, rcar_sysc_base + SYSCIMR);
+
+	domains = kzalloc(sizeof(*domains) + n * sizeof(domains->domains[0]),
+			  GFP_KERNEL);
+	if (!domains) {
+		error = -ENOMEM;
+		goto fail_unmap;
+	}
+
+	for (i = 0; i < info->num_areas; i++) {
+		const struct rcar_sysc_area *area = &info->areas[i];
+		struct rcar_sysc_pd *pd;
+
+		pd = kzalloc(sizeof(*pd) + strlen(area->name) + 1, GFP_KERNEL);
+		if (!pd) {
+			error = -ENOMEM;
+			goto fail_unmap;
+		}
+
+		strcpy(pd->name, area->name);
+		pd->genpd.name = pd->name;
+		pd->ch.chan_offs = area->chan_offs;
+		pd->ch.chan_bit = area->chan_bit;
+		pd->ch.isr_bit = area->isr_bit;
+		pd->flags = area->flags;
+
+		rcar_sysc_pd_setup(np, pd);
+		if (area->parent >= 0)
+			pm_genpd_add_subdomain(domains->domains[area->parent],
+					       &pd->genpd);
+
+		domains->domains[area->isr_bit] = &pd->genpd;
+	}
+
+	domains->onecell_data.domains = domains->domains;
+	domains->onecell_data.num_domains = n;
+	of_genpd_add_provider_onecell(np, &domains->onecell_data);
+	of_node_put(np);
+	return 0;
+
+fail_unmap:
+	iounmap(base);
+fail_put:
+	of_node_put(np);
+	return error;
+}
+
+early_initcall(rcar_sysc_pd_init);
diff --git a/drivers/soc/renesas/rcar-sysc.h b/drivers/soc/renesas/rcar-sysc.h
new file mode 100644
index 0000000000000000..7bb48b4f7334f960
--- /dev/null
+++ b/drivers/soc/renesas/rcar-sysc.h
@@ -0,0 +1,53 @@
+/*
+ * Renesas R-Car System Controller
+ *
+ * Copyright (C) 2016 Glider bvba
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ */
+#ifndef __SOC_RENESAS_RCAR_SYSC_H__
+#define __SOC_RENESAS_RCAR_SYSC_H__
+
+#include <linux/types.h>
+
+
+/*
+ * Power Domain flags
+ */
+#define PD_CPU		BIT(0)	/* Area contains main CPU core */
+#define PD_SCU		BIT(1)	/* Area contains SCU and L2 cache */
+#define PD_NO_CR	BIT(2)	/* Area lacks PWR{ON,OFF}CR registers */
+
+#define PD_BUSY		BIT(3)	/* Busy, for internal use only */
+
+#define PD_CPU_CR	PD_CPU		  /* CPU area has CR (R-Car H1) */
+#define PD_CPU_NOCR	PD_CPU | PD_NO_CR /* CPU area lacks CR (R-Car Gen2/3) */
+#define PD_ALWAYS_ON	PD_NO_CR	  /* Always-on area */
+
+
+/*
+ * Description of a Power Area
+ */
+
+struct rcar_sysc_area {
+	const char *name;
+	u16 chan_offs;		/* Offset of PWRSR register for this area */
+	u8 chan_bit;		/* Bit in PWR* (except for PWRUP in PWRSR) */
+	u8 isr_bit;		/* Bit in SYSCI*R */
+	int parent;		/* -1 if none */
+	unsigned int flags;	/* See PD_* */
+};
+
+
+/*
+ * SoC-specific Power Area Description
+ */
+
+struct rcar_sysc_info {
+	const struct rcar_sysc_area *areas;
+	unsigned int num_areas;
+};
+
+#endif /* __SOC_RENESAS_RCAR_SYSC_H__ */
-- 
1.9.1

