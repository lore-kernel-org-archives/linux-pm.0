From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH/RFC v2 04/11] soc: renesas: rcar: Add DT support for SYSC PM domains
Date: Mon, 15 Feb 2016 22:16:53 +0100
Message-ID: <1455571020-18968-5-git-send-email-geert+renesas@glider.be>
References: <1455571020-18968-1-git-send-email-geert+renesas@glider.be>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1455571020-18968-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Populate the SYSC PM domains from DT.

Special cases, like PM domains containing CPU cores or SCUs, are
handled by scanning the DT topology.

The SYSCIER register value is derived from the PM domains found in DT,
which will allow to get rid of the hardcoded values in pm-rcar-gen2.c.
However, this means we have to scan for PM domains even if CONFIG_PM=n.

FIXME:
  - This needs better integration with the PM code in pm-rcar-gen2, the
    SMP code in smp-r8a7790, and Magnus' DT APMU series.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
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
 drivers/soc/renesas/pm-rcar.c | 327 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 327 insertions(+)

diff --git a/drivers/soc/renesas/pm-rcar.c b/drivers/soc/renesas/pm-rcar.c
index cc684e9cc8db5d1c..c0540934126e58eb 100644
--- a/drivers/soc/renesas/pm-rcar.c
+++ b/drivers/soc/renesas/pm-rcar.c
@@ -2,6 +2,7 @@
  * R-Car SYSC Power management support
  *
  * Copyright (C) 2014  Magnus Damm
+ * Copyright (C) 2015-2016 Glider bvba
  *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
@@ -11,6 +12,9 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/mm.h>
+#include <linux/of_address.h>
+#include <linux/pm_domain.h>
+#include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/io.h>
 #include <linux/soc/renesas/pm-rcar.h>
@@ -38,6 +42,18 @@
 #define PWRONSR_OFFS		0x10	/* Power Resume Status Register */
 #define PWRER_OFFS		0x14	/* Power Shutoff/Resume Error */
 
+/*
+ * SYSC Power Control Register Base Addresses (R-Car Gen2)
+ */
+#define SYSC_PWR_CA15_CPU	0x40	/* CA15 cores (incl. L1C) (H2/M2/V2H) */
+#define SYSC_PWR_CA7_CPU	0x1c0	/* CA7 cores (incl. L1C) (H2/E2) */
+
+/*
+ * SYSC Power Control Register Base Addresses (R-Car Gen3)
+ */
+#define SYSC_PWR_CA57_CPU	0x80	/* CA57 cores (incl. L1C) (H3) */
+#define SYSC_PWR_CA53_CPU	0x200	/* CA53 cores (incl. L1C) (H3) */
+
 
 #define SYSCSR_RETRIES		100
 #define SYSCSR_DELAY_US		1
@@ -51,11 +67,40 @@
 static void __iomem *rcar_sysc_base;
 static DEFINE_SPINLOCK(rcar_sysc_lock); /* SMP CPUs + I/O devices */
 
+static unsigned int rcar_gen;
+
 static int rcar_sysc_pwr_on_off(const struct rcar_sysc_ch *sysc_ch, bool on)
 {
 	unsigned int sr_bit, reg_offs;
 	int k;
 
+	/*
+	 * Only R-Car H1 can control power to CPUs
+	 * Use WFI to power off, CPG/APMU to resume ARM cores on later R-Car
+	 * Generations
+	 */
+	switch (rcar_gen) {
+	case 2:
+		/* FIXME Check rcar_pm_domain.cpu instead? */
+		switch (sysc_ch->chan_offs) {
+		case SYSC_PWR_CA15_CPU:
+		case SYSC_PWR_CA7_CPU:
+			pr_err("%s: Cannot control power to CPU\n", __func__);
+			return -EINVAL;
+		}
+		break;
+
+	case 3:
+		/* FIXME Check rcar_pm_domain.cpu instead? */
+		switch (sysc_ch->chan_offs) {
+		case SYSC_PWR_CA57_CPU:
+		case SYSC_PWR_CA53_CPU:
+			pr_err("%s: Cannot control power to CPU\n", __func__);
+			return -EINVAL;
+		}
+		break;
+	}
+
 	if (on) {
 		sr_bit = SYSCSR_PONENB;
 		reg_offs = PWRONCR_OFFS;
@@ -162,3 +207,285 @@ void __iomem *rcar_sysc_init(phys_addr_t base)
 
 	return rcar_sysc_base;
 }
+
+#ifdef CONFIG_PM_GENERIC_DOMAINS
+struct rcar_pm_domain {
+	struct generic_pm_domain genpd;
+	struct dev_power_governor *gov;
+	struct rcar_sysc_ch ch;
+	unsigned busy:1;		/* Set if always -EBUSY */
+	unsigned cpu:1;			/* Set if domain contains CPU */
+	char name[0];
+};
+
+static inline struct rcar_pm_domain *to_rcar_pd(struct generic_pm_domain *d)
+{
+	return container_of(d, struct rcar_pm_domain, genpd);
+}
+
+static bool rcar_pd_active_wakeup(struct device *dev)
+{
+	return true;
+}
+
+static int rcar_pd_power_down(struct generic_pm_domain *genpd)
+{
+	struct rcar_pm_domain *rcar_pd = to_rcar_pd(genpd);
+
+	pr_debug("%s: %s\n", __func__, genpd->name);
+
+	if (rcar_pd->busy) {
+		pr_debug("%s: %s busy\n", __func__, genpd->name);
+		return -EBUSY;
+	}
+
+	return rcar_sysc_power_down(&rcar_pd->ch);
+}
+
+static int rcar_pd_power_up(struct generic_pm_domain *genpd)
+{
+	pr_debug("%s: %s\n", __func__, genpd->name);
+	return rcar_sysc_power_up(&to_rcar_pd(genpd)->ch);
+}
+
+static void rcar_init_pm_domain(struct rcar_pm_domain *rcar_pd)
+{
+	struct generic_pm_domain *genpd = &rcar_pd->genpd;
+	struct dev_power_governor *gov = rcar_pd->gov;
+
+	pm_genpd_init(genpd, gov ? : &simple_qos_governor, false);
+	genpd->dev_ops.active_wakeup	= rcar_pd_active_wakeup;
+	genpd->power_off		= rcar_pd_power_down;
+	genpd->power_on			= rcar_pd_power_up;
+
+	if (rcar_sysc_power_is_off(&rcar_pd->ch))
+		rcar_sysc_power_up(&rcar_pd->ch);
+}
+
+enum pd_types {
+	PD_NORMAL,
+	PD_CPU,
+	PD_SCU,
+};
+
+#define MAX_NUM_SPECIAL_PDS	16
+
+static struct special_pd {
+	struct device_node *pd;
+	enum pd_types type;
+} special_pds[MAX_NUM_SPECIAL_PDS] __initdata;
+
+static unsigned int num_special_pds __initdata;
+
+static void __init add_special_pd(struct device_node *np, enum pd_types type)
+{
+	unsigned int i;
+	struct device_node *pd;
+
+	pd = of_parse_phandle(np, "power-domains", 0);
+	if (!pd)
+		return;
+
+	for (i = 0; i < num_special_pds; i++)
+		if (pd == special_pds[i].pd && type == special_pds[i].type) {
+			of_node_put(pd);
+			return;
+		}
+
+	if (num_special_pds == ARRAY_SIZE(special_pds)) {
+		pr_warn("Too many special PM domains\n");
+		of_node_put(pd);
+		return;
+	}
+
+	pr_debug("Special PM domain %s type %d for %s\n", pd->name, type,
+		 np->full_name);
+
+	special_pds[num_special_pds].pd = pd;
+	special_pds[num_special_pds].type = type;
+	num_special_pds++;
+}
+
+static void __init get_special_pds(void)
+{
+	struct device_node *cpu, *scu;
+
+	/* PM domains containing CPUs */
+	for_each_node_by_type(cpu, "cpu") {
+		add_special_pd(cpu, PD_CPU);
+
+		/* SCU, represented by an L2 node */
+		scu = of_parse_phandle(cpu, "next-level-cache", 0);
+		if (scu) {
+			add_special_pd(scu, PD_SCU);
+			of_node_put(scu);
+		}
+	}
+}
+
+static void __init put_special_pds(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < num_special_pds; i++)
+		of_node_put(special_pds[i].pd);
+}
+
+static enum pd_types __init pd_type(const struct device_node *pd)
+{
+	unsigned int i;
+
+	for (i = 0; i < num_special_pds; i++)
+		if (pd == special_pds[i].pd)
+			return special_pds[i].type;
+
+	return PD_NORMAL;
+}
+
+static void __init rcar_setup_pm_domain(struct device_node *np,
+					struct rcar_pm_domain *pd)
+{
+	const char *name = pd->genpd.name;
+
+	switch (pd_type(np)) {
+	case PD_CPU:
+		/*
+		 * This domain contains a CPU core and therefore it should
+		 * only be turned off if the CPU is not in use.
+		 */
+		pr_debug("PM domain %s contains CPU\n", name);
+		pd->gov = &pm_domain_always_on_gov;
+		pd->busy = true;
+		pd->cpu = true;
+		break;
+
+	case PD_SCU:
+		/*
+		 * This domain contains an SCU and cache-controller, and
+		 * therefore it should only be turned off if the CPU cores are
+		 * not in use.
+		 */
+		pr_debug("PM domain %s contains SCU\n", name);
+		pd->gov = &pm_domain_always_on_gov;
+		pd->busy = true;
+		break;
+
+	case PD_NORMAL:
+		break;
+	}
+
+	rcar_init_pm_domain(pd);
+}
+
+static int __init rcar_add_pm_domains(struct device_node *parent,
+				      struct generic_pm_domain *genpd_parent,
+				      u32 *syscier)
+{
+	struct device_node *np;
+
+	for_each_child_of_node(parent, np) {
+		struct rcar_pm_domain *pd;
+		u32 reg[2];
+		int n;
+
+		if (of_property_read_u32_array(np, "reg", reg,
+					       ARRAY_SIZE(reg))) {
+			of_node_put(np);
+			return -EINVAL;
+		}
+
+		*syscier |= BIT(reg[0]);
+
+		if (!IS_ENABLED(CONFIG_PM)) {
+			/* Just continue parsing "reg" to update *syscier */
+			rcar_add_pm_domains(np, NULL, syscier);
+			continue;
+		}
+
+		n = snprintf(NULL, 0, "%s@%u", np->name, reg[0]) + 1;
+
+		pd = kzalloc(sizeof(*pd) + n, GFP_KERNEL);
+		if (!pd) {
+			of_node_put(np);
+			return -ENOMEM;
+		}
+
+		snprintf(pd->name, n, "%s@%u", np->name, reg[0]);
+		pd->genpd.name = pd->name;
+		pd->ch.chan_offs = reg[1] & ~31;
+		pd->ch.chan_bit = reg[1] & 31;
+		pd->ch.isr_bit = reg[0];
+
+		rcar_setup_pm_domain(np, pd);
+		if (genpd_parent)
+			pm_genpd_add_subdomain(genpd_parent, &pd->genpd);
+		of_genpd_add_provider_simple(np, &pd->genpd);
+
+		rcar_add_pm_domains(np, &pd->genpd, syscier);
+	}
+	return 0;
+}
+
+static const struct of_device_id rcar_sysc_matches[] = {
+	{ .compatible = "renesas,r8a7779-sysc", .data = (void *)1 },
+	{ .compatible = "renesas,rcar-gen2-sysc", .data = (void *)2 },
+	{ .compatible = "renesas,rcar-gen3-sysc", .data = (void *)3 },
+	{ /* sentinel */ }
+};
+
+static int __init rcar_init_pm_domains(void)
+{
+	const struct of_device_id *match;
+	struct device_node *np, *pmd;
+	bool scanned = false;
+	void __iomem *base;
+	int ret = 0;
+
+	for_each_matching_node_and_match(np, rcar_sysc_matches, &match) {
+		u32 syscier = 0;
+
+		rcar_gen = (uintptr_t)match->data;
+
+		base = of_iomap(np, 0);
+		if (!base) {
+			pr_warn("%s cannot map reg 0\n", np->full_name);
+			continue;
+		}
+
+		rcar_sysc_base = base;	// FIXME conflicts with rcar_sysc_init()
+
+		pmd = of_get_child_by_name(np, "pm-domains");
+		if (!pmd) {
+			pr_warn("%s lacks pm-domains node\n", np->full_name);
+			continue;
+		}
+
+		if (!scanned) {
+			/* Find PM domains containing special blocks */
+			get_special_pds();
+			scanned = true;
+		}
+
+		ret = rcar_add_pm_domains(pmd, NULL, &syscier);
+		of_node_put(pmd);
+		if (ret) {
+			of_node_put(np);
+			break;
+		}
+
+		/*
+		 * Enable all interrupt sources, but do not use interrupt
+		 * handler
+		 */
+		pr_debug("%s: syscier = 0x%08x\n", np->full_name, syscier);
+		iowrite32(syscier, rcar_sysc_base + SYSCIER);
+		iowrite32(0, rcar_sysc_base + SYSCIMR);
+	}
+
+	put_special_pds();
+
+	return ret;
+}
+
+core_initcall(rcar_init_pm_domains);
+#endif /* PM_GENERIC_DOMAINS */
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
