From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v5 07/13] ARM: shmobile: apmu: Add APMU DT support via Enable method
Date: Tue, 28 Jun 2016 16:10:36 +0200
Message-ID: <1467123042-8468-8-git-send-email-geert+renesas@glider.be>
References: <1467123042-8468-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from michel.telenet-ops.be ([195.130.137.88]:59849 "EHLO
	michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752411AbcF1OKt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jun 2016 10:10:49 -0400
In-Reply-To: <1467123042-8468-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Keita Kobayashi <keita.kobayashi.ym@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Magnus Damm <damm+renesas@opensource.se>, Geert Uytterhoeven <geert+renesas@glider.be>

From: Magnus Damm <damm+renesas@opensource.se>

Allow DT configuration of the APMU hardware in the case when the APMU is
pointed out in the DTB via the enable-method. The ability to configure
the APMU via C code is still kept intact to prevent DTB breakage for older
SoCs that do not rely on the enable-method for SMP support.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
[geert: Fix CONFIG_SMP=n build]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v5:
  - No changes,

v4:
  - Remove bogus of_node_put(),
  - Fix CONFIG_SMP=n build,
  - Correct whitespace,

v3:
  - Move is_allowed declaration, break when allowed,

v2:
  - Adjust to use .cpu_can_disable instead of .cpu_disable.
---
 arch/arm/mach-shmobile/platsmp-apmu.c | 92 +++++++++++++++++++++++++++++++++--
 1 file changed, 88 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index c1558ef0c590dd3e..0c6bb458b7a45128 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -24,6 +24,7 @@
 #include <asm/suspend.h>
 #include "common.h"
 #include "platsmp-apmu.h"
+#include "rcar-gen2.h"
 
 static struct {
 	void __iomem *iomem;
@@ -118,14 +119,66 @@ static void apmu_parse_cfg(void (*fn)(struct resource *res, int cpu, int bit),
 	}
 }
 
-void __init shmobile_smp_apmu_prepare_cpus(unsigned int max_cpus,
-					   struct rcar_apmu_config *apmu_config,
-					   int num)
+static const struct of_device_id apmu_ids[] = {
+	{ .compatible = "renesas,apmu" },
+	{ /*sentinel*/ }
+};
+
+static void apmu_parse_dt(void (*fn)(struct resource *res, int cpu, int bit))
+{
+	struct device_node *np_apmu, *np_cpu;
+	struct resource res;
+	int bit, index;
+	u32 id;
+
+	for_each_matching_node(np_apmu, apmu_ids) {
+		/* only enable the cluster that includes the boot CPU */
+		bool is_allowed = false;
+
+		for (bit = 0; bit < CONFIG_NR_CPUS; bit++) {
+			np_cpu = of_parse_phandle(np_apmu, "cpus", bit);
+			if (np_cpu) {
+				if (!of_property_read_u32(np_cpu, "reg", &id)) {
+					if (id == cpu_logical_map(0)) {
+						is_allowed = true;
+						of_node_put(np_cpu);
+						break;
+					}
+
+				}
+				of_node_put(np_cpu);
+			}
+		}
+		if (!is_allowed)
+			continue;
+
+		for (bit = 0; bit < CONFIG_NR_CPUS; bit++) {
+			np_cpu = of_parse_phandle(np_apmu, "cpus", bit);
+			if (np_cpu) {
+				if (!of_property_read_u32(np_cpu, "reg", &id)) {
+					index = get_logical_index(id);
+					if ((index >= 0) &&
+					    !of_address_to_resource(np_apmu,
+								    0, &res))
+						fn(&res, index, bit);
+				}
+				of_node_put(np_cpu);
+			}
+		}
+	}
+}
+
+static void __init shmobile_smp_apmu_setup_boot(void)
 {
 	/* install boot code shared by all CPUs */
 	shmobile_boot_fn = virt_to_phys(shmobile_smp_boot);
+}
 
-	/* perform per-cpu setup */
+void __init shmobile_smp_apmu_prepare_cpus(unsigned int max_cpus,
+					   struct rcar_apmu_config *apmu_config,
+					   int num)
+{
+	shmobile_smp_apmu_setup_boot();
 	apmu_parse_cfg(apmu_init_cpu, apmu_config, num);
 }
 
@@ -136,7 +189,38 @@ int shmobile_smp_apmu_boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 	return apmu_wrap(cpu, apmu_power_on);
 }
+
+static void __init shmobile_smp_apmu_prepare_cpus_dt(unsigned int max_cpus)
+{
+	shmobile_smp_apmu_setup_boot();
+	apmu_parse_dt(apmu_init_cpu);
+	rcar_gen2_pm_init();
+}
+
+static int shmobile_smp_apmu_boot_secondary_md21(unsigned int cpu,
+						 struct task_struct *idle)
+{
+	/* Error out when hardware debug mode is enabled */
+	if (rcar_gen2_read_mode_pins() & BIT(21)) {
+		pr_warn("Unable to boot CPU%u when MD21 is set\n", cpu);
+		return -ENOTSUPP;
+	}
+
+	return shmobile_smp_apmu_boot_secondary(cpu, idle);
+}
+
+static struct smp_operations apmu_smp_ops __initdata = {
+	.smp_prepare_cpus	= shmobile_smp_apmu_prepare_cpus_dt,
+	.smp_boot_secondary	= shmobile_smp_apmu_boot_secondary_md21,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_can_disable	= shmobile_smp_cpu_can_disable,
+	.cpu_die		= shmobile_smp_apmu_cpu_die,
+	.cpu_kill		= shmobile_smp_apmu_cpu_kill,
 #endif
+};
+
+CPU_METHOD_OF_DECLARE(shmobile_smp_apmu, "renesas,apmu", &apmu_smp_ops);
+#endif /* CONFIG_SMP */
 
 #if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_SUSPEND)
 /* nicked from arch/arm/mach-exynos/hotplug.c */
-- 
1.9.1

