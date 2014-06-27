From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 15/16] ARM: mvebu: Add CPU idle support for Armada 38x
Date: Fri, 27 Jun 2014 15:22:56 +0200
Message-ID: <1403875377-940-16-git-send-email-gregory.clement@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:42161 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753419AbaF0NYH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Jun 2014 09:24:07 -0400
In-Reply-To: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>

Unlike the Armada XP and the Armada 370, this SoC uses a Cortex A9
core. Beside this, the main difference for the cpu idle is the way to
handle the L2 cache and the use of SCU.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c    | 101 +++++++++++++++++++++++++++++++++++++++++-
 arch/arm/mach-mvebu/pmsu_ll.S |  14 ++++++
 2 files changed, 113 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index bfd471538811..3e49fb73c3d5 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -32,6 +32,7 @@
 #include <asm/cacheflush.h>
 #include <asm/cpuidle.h>
 #include <asm/cp15.h>
+#include <asm/smp_scu.h>
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
 #include <asm/tlbflush.h>
@@ -66,6 +67,19 @@
 #define L2C_NFABRIC_PM_CTL		    0x4
 #define L2C_NFABRIC_PM_CTL_PWR_DOWN		BIT(20)
 
+/* PMSU delay registers */
+#define PMSU_POWERDOWN_DELAY		    0xF04
+#define PMSU_POWERDOWN_DELAY_PMU		BIT(1)
+#define PMSU_POWERDOWN_DELAY_MASK		0xFFFE
+
+#define PMSU_DFLT_ARMADA38X_DELAY	0x64
+
+/* CA9 MPcore SoC Control registers */
+
+#define MPCORE_RESET_CTL		    0x64
+#define MPCORE_RESET_CTL_L2			BIT(0)
+#define MPCORE_RESET_CTL_DEBUG			BIT(16)
+
 #define ARMADA_370_CRYPT0_ENG_ID	0x9
 #define CRYPT0_ENG_ATTR	0x1
 
@@ -78,10 +92,13 @@ extern void ll_disable_coherency(void);
 extern void ll_enable_coherency(void);
 
 extern void armada_370_xp_cpu_resume(void);
+extern void armada_38x_cpu_resume(void);
 
 static unsigned long pmsu_mp_phys_base;
 static void __iomem *pmsu_mp_base;
 
+static void __iomem *scu_base;
+
 static void *mvebu_cpu_resume;
 
 static struct platform_device mvebu_v7_cpuidle_device = {
@@ -151,6 +168,7 @@ static int __init mvebu_v7_pmsu_init(void)
 				np->full_name)) {
 		pr_err("unable to request region\n");
 		ret = -EBUSY;
+
 		goto out;
 	}
 
@@ -163,7 +181,6 @@ static int __init mvebu_v7_pmsu_init(void)
 		ret = -ENOMEM;
 		goto out;
 	}
-
  out:
 	of_node_put(np);
 	return ret;
@@ -260,6 +277,27 @@ static int armada_xp_370_cpu_suspend(unsigned long deepidle)
 	return cpu_suspend(deepidle, do_armada_xp_370_cpu_suspend);
 }
 
+static noinline int do_armada_38x_cpu_suspend(unsigned long deepidle)
+{
+	mvebu_v7_pmsu_idle_prepare(deepidle, false);
+	/*
+	 * Already flushed cache, but do it again as the outer cache
+	 * functions dirty the cache with spinlocks
+	 */
+	v7_exit_coherency_flush(louis);
+
+	scu_power_mode(scu_base, SCU_PM_POWEROFF);
+
+	cpu_do_idle();
+
+	return 1;
+}
+
+static int armada_38x_cpu_suspend(unsigned long deepidle)
+{
+	return cpu_suspend(false, do_armada_38x_cpu_suspend);
+}
+
 /* No locking is needed because we only access per-CPU registers */
 static noinline void mvebu_v7_pmsu_idle_restore(void)
 {
@@ -268,7 +306,6 @@ static noinline void mvebu_v7_pmsu_idle_restore(void)
 
 	if (pmsu_mp_base == NULL)
 		return;
-
 	/* cancel ask HW to power down the L2 Cache if possible */
 	reg = readl(pmsu_mp_base + PMSU_CONTROL_AND_CONFIG(hw_cpu));
 	reg &= ~PMSU_CONTROL_AND_CONFIG_L2_PWDDN;
@@ -320,6 +357,23 @@ static struct mvebu_v7_cpuidle armada_370_cpuidle = {
 	.mvebu_v7_cpu_suspend = armada_xp_370_cpu_suspend,
 };
 
+static struct mvebu_v7_cpuidle armada_38x_cpuidle = {
+	.mvebu_v7_idle_driver = {
+		.name			= "armada_38x_idle",
+		.states[0]		= ARM_CPUIDLE_WFI_STATE,
+		.states[1]		= {
+			.exit_latency		= 10,
+			.power_usage		= 5,
+			.target_residency	= 100,
+			.flags			= CPUIDLE_FLAG_TIME_VALID,
+			.name			= "Idle",
+			.desc			= "CPU and SCU power down",
+		},
+		.state_count = 2,
+	},
+	.mvebu_v7_cpu_suspend = armada_38x_cpu_suspend,
+};
+
 static struct mvebu_v7_cpuidle armada_xp_cpuidle = {
 	.mvebu_v7_idle_driver = {
 		.name			= "armada_xp_idle",
@@ -371,6 +425,46 @@ static __init bool armada_370_cpuidle_init(void)
 	return true;
 }
 
+static __init bool armada_38x_cpuidle_init(void)
+{
+	struct device_node *np;
+	void __iomem *mpsoc_base;
+	u32 reg;
+
+	np = of_find_compatible_node(NULL, NULL,
+				"marvell,armada-380-coherency-fabric");
+	if (!np)
+		return false;
+	of_node_put(np);
+
+	np = of_find_compatible_node(NULL, NULL,
+				"marvell,armada-380-mpcore-soc-ctrl");
+	if (!np)
+		return false;
+	mpsoc_base = of_iomap(np, 0);
+	WARN_ON(!mpsoc_base);
+
+	/* Set up reset mask when powering down the cpus */
+	reg = readl(mpsoc_base + MPCORE_RESET_CTL);
+	reg |= MPCORE_RESET_CTL_L2;
+	reg |= MPCORE_RESET_CTL_DEBUG;
+	writel(reg, mpsoc_base + MPCORE_RESET_CTL);
+	iounmap(mpsoc_base);
+	of_node_put(np);
+
+	/* Set up delay */
+	reg = readl(pmsu_mp_base + PMSU_POWERDOWN_DELAY);
+	reg &= ~PMSU_POWERDOWN_DELAY_MASK;
+	reg |= PMSU_DFLT_ARMADA38X_DELAY;
+	reg |= PMSU_POWERDOWN_DELAY_PMU;
+	writel(reg, pmsu_mp_base + PMSU_POWERDOWN_DELAY);
+
+	scu_base = mvebu_get_scu_base();
+	mvebu_cpu_resume = armada_38x_cpu_resume;
+	mvebu_v7_cpuidle_device.dev.platform_data = &armada_38x_cpuidle;
+	return true;
+}
+
 static __init bool armada_xp_cpuidle_init(void)
 {
 	struct device_node *np;
@@ -391,6 +485,9 @@ static struct of_device_id of_cpuidle_table[] __initdata = {
 	{ .compatible = "marvell,armada370",
 	  .data = (void *)armada_370_cpuidle_init,
 	},
+	{ .compatible = "marvell,armada380",
+	  .data = (void *)armada_38x_cpuidle_init,
+	},
 	{ /* end of list */ },
 };
 
diff --git a/arch/arm/mach-mvebu/pmsu_ll.S b/arch/arm/mach-mvebu/pmsu_ll.S
index 3b702a16bd3d..15b823dff61a 100644
--- a/arch/arm/mach-mvebu/pmsu_ll.S
+++ b/arch/arm/mach-mvebu/pmsu_ll.S
@@ -23,6 +23,20 @@ ARM_BE8(setend	be )			@ go BE8 if entered LE
 	b	cpu_resume
 ENDPROC(armada_370_xp_cpu_resume)
 
+ENTRY(armada_38x_cpu_resume)
+	/* do we need it for Armada 38x*/
+ARM_BE8(setend	be )			@ go BE8 if entered LE
+	bl	v7_invalidate_l1
+	mrc     p15, 4, r1, c15, c0	@ get SCU base address
+	orr	r1, r1, #0x8		@ SCU CPU Power Status Register
+	mrc	15, 0, r0, cr0, cr0, 5	@ get the CPU ID
+	and	r0, r0, #15
+	add	r1, r1, r0
+	mov	r0, #0x0
+	strb	r0, [r1]		@ switch SCU power state to Normal mode
+	b	cpu_resume
+ENDPROC(armada_38x_cpu_resume)
+
 .global mvebu_boot_wa_start
 .global mvebu_boot_wa_end
 
-- 
1.8.1.2

