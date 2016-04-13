From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v5 03/11] soc: renesas: rcar-sysc: Add DT support for SYSC PM
 domains
Date: Wed, 13 Apr 2016 16:44:24 +0200
Message-ID: <1460558672-10290-4-git-send-email-geert+renesas@glider.be>
References: <1460558672-10290-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1460558672-10290-1-git-send-email-geert+renesas@glider.be>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-renesas-soc@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Populate the SYSC PM domains from DT, based on the presence of a device
node for the System Controller. The actual power area hiearchy, and
features of specific areas are obtained from tables in the C code.

The SYSCIER and SYSCIMR register values are derived from the power areas
present, which will help to get rid of the hardcoded values in R-Car H1
and R-Car Gen2 platform code later.

Initialization is done from an early_initcall(), to make sure the PM
Domains are initialized before secondary CPU bringup.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v5:
  - Mask SYSC interrupts sources before enabling them (doesn't matter
    much as they're disabled at the GIC level anyway),
  - Re-add explicit "always-on" power area instead of aliasing the SoC's
    Clock Domain,
  - Merge the two initialization phases again,

v4:
  - Make sure not to clear reserved SYSCIMR bits that were set before,
  - Make the always-on power area implicit and always present, and an
    alias of the existing SoC's Clock Domain. This makes the number of
    power areas a compile-time constant, and allows to drop PD_ALWAYS_ON
    and some checks.
  - Split initialization in two phases,
  - Document that ARM cores are controlled by PSCI on R-Car Gen3
    (although the underlying CPG/APMU hardware is the same as on Gen2),
  - Minor improvements (double evaluation, unused parameter, debug
    message consolidation),

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
 drivers/soc/renesas/rcar-sysc.c | 206 +++++++++++++++++++++++++++++++++++++++-
 drivers/soc/renesas/rcar-sysc.h |  53 +++++++++++
 2 files changed, 258 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/renesas/rcar-sysc.h

diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index 9ba5fd15c53bf9b9..674a46ce46aac04d 100644
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
@@ -29,7 +35,8 @@
 /*
  * Power Control Register Offsets inside the register block for each domain
  * Note: The "CR" registers for ARM cores exist on H1 only
- *       Use WFI to power off, CPG/APMU to resume ARM cores on R-Car Gen2
+ *	 Use WFI to power off, CPG/APMU to resume ARM cores on R-Car Gen2
+ *	 Use PSCI on R-Car Gen3
  */
 #define PWRSR_OFFS		0x00	/* Power Status Register */
 #define PWROFFCR_OFFS		0x04	/* Power Shutoff Control Register */
@@ -48,6 +55,8 @@
 #define SYSCISR_RETRIES		1000
 #define SYSCISR_DELAY_US	1
 
+#define RCAR_PD_ALWAYS_ON	32	/* Always-on power area */
+
 static void __iomem *rcar_sysc_base;
 static DEFINE_SPINLOCK(rcar_sysc_lock); /* SMP CPUs + I/O devices */
 
@@ -162,3 +171,198 @@ void __iomem *rcar_sysc_init(phys_addr_t base)
 
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
+	return rcar_sysc_power_up(&pd->ch);
+}
+
+static void __init rcar_sysc_pd_setup(struct rcar_sysc_pd *pd)
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
+		pr_debug("PM domain %s contains %s\n", name, "CPU");
+		pd->flags |= PD_BUSY;
+		gov = &pm_domain_always_on_gov;
+	} else if (pd->flags & PD_SCU) {
+		/*
+		 * This domain contains an SCU and cache-controller, and
+		 * therefore it should only be turned off if the CPU cores are
+		 * not in use.
+		 */
+		pr_debug("PM domain %s contains %s\n", name, "SCU");
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
+	struct generic_pm_domain *domains[RCAR_PD_ALWAYS_ON + 1];
+};
+
+static int __init rcar_sysc_pd_init(void)
+{
+	const struct rcar_sysc_info *info;
+	const struct of_device_id *match;
+	struct rcar_pm_domains *domains;
+	struct device_node *np;
+	u32 syscier, syscimr;
+	void __iomem *base;
+	unsigned int i;
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
+		pr_warn("%s: Cannot map regs\n", np->full_name);
+		error = -ENOMEM;
+		goto out_put;
+	}
+
+	rcar_sysc_base = base;
+
+	domains = kzalloc(sizeof(*domains), GFP_KERNEL);
+	if (!domains) {
+		error = -ENOMEM;
+		goto out_put;
+	}
+
+	domains->onecell_data.domains = domains->domains;
+	domains->onecell_data.num_domains = ARRAY_SIZE(domains->domains);
+
+	for (i = 0, syscier = 0; i < info->num_areas; i++)
+		syscier |= BIT(info->areas[i].isr_bit);
+
+	/*
+	 * Mask all interrupt sources to prevent the CPU from receiving them.
+	 * Make sure not to clear reserved bits that were set before.
+	 */
+	syscimr = ioread32(base + SYSCIMR);
+	syscimr |= syscier;
+	pr_debug("%s: syscimr = 0x%08x\n", np->full_name, syscimr);
+	iowrite32(syscimr, base + SYSCIMR);
+
+	/*
+	 * SYSC needs all interrupt sources enabled to control power.
+	 */
+	pr_debug("%s: syscier = 0x%08x\n", np->full_name, syscier);
+	iowrite32(syscier, base + SYSCIER);
+
+	for (i = 0; i < info->num_areas; i++) {
+		const struct rcar_sysc_area *area = &info->areas[i];
+		struct rcar_sysc_pd *pd;
+
+		pd = kzalloc(sizeof(*pd) + strlen(area->name) + 1, GFP_KERNEL);
+		if (!pd) {
+			error = -ENOMEM;
+			goto out_put;
+		}
+
+		strcpy(pd->name, area->name);
+		pd->genpd.name = pd->name;
+		pd->ch.chan_offs = area->chan_offs;
+		pd->ch.chan_bit = area->chan_bit;
+		pd->ch.isr_bit = area->isr_bit;
+		pd->flags = area->flags;
+
+		rcar_sysc_pd_setup(pd);
+		if (area->parent >= 0)
+			pm_genpd_add_subdomain(domains->domains[area->parent],
+					       &pd->genpd);
+
+		domains->domains[area->isr_bit] = &pd->genpd;
+	}
+
+	of_genpd_add_provider_onecell(np, &domains->onecell_data);
+
+out_put:
+	of_node_put(np);
+	return error;
+}
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
