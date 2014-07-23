From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCHv3 15/16] ARM: mvebu: add cpuidle support for Armada 38x
Date: Wed, 23 Jul 2014 15:00:52 +0200
Message-ID: <1406120453-29291-16-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1406120453-29291-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:40759 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751347AbaGWNBN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jul 2014 09:01:13 -0400
In-Reply-To: <1406120453-29291-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>
Cc: Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

Unlike the Armada XP and the Armada 370, this SoC uses a Cortex A9
core. Consequently, the procedure to enter the idle state is
different: interaction with the SCU, not disabling snooping, etc.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c    | 85 ++++++++++++++++++++++++++++++++++++++++++-
 arch/arm/mach-mvebu/pmsu_ll.S | 14 +++++++
 2 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 9190ae8..bd7c66a 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -29,6 +29,7 @@
 #include <linux/smp.h>
 #include <asm/cacheflush.h>
 #include <asm/cp15.h>
+#include <asm/smp_scu.h>
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
 #include <asm/tlbflush.h>
@@ -63,6 +64,18 @@
 #define L2C_NFABRIC_PM_CTL		    0x4
 #define L2C_NFABRIC_PM_CTL_PWR_DOWN		BIT(20)
 
+/* PMSU delay registers */
+#define PMSU_POWERDOWN_DELAY		    0xF04
+#define PMSU_POWERDOWN_DELAY_PMU		BIT(1)
+#define PMSU_POWERDOWN_DELAY_MASK		0xFFFE
+#define PMSU_DFLT_ARMADA38X_DELAY	        0x64
+
+/* CA9 MPcore SoC Control registers */
+
+#define MPCORE_RESET_CTL		    0x64
+#define MPCORE_RESET_CTL_L2			BIT(0)
+#define MPCORE_RESET_CTL_DEBUG			BIT(16)
+
 #define SRAM_PHYS_BASE  0xFFFF0000
 #define BOOTROM_BASE    0xFFF00000
 #define BOOTROM_SIZE    0x100000
@@ -74,6 +87,8 @@ extern void ll_disable_coherency(void);
 extern void ll_enable_coherency(void);
 
 extern void armada_370_xp_cpu_resume(void);
+extern void armada_38x_cpu_resume(void);
+
 static phys_addr_t pmsu_mp_phys_base;
 static void __iomem *pmsu_mp_base;
 
@@ -287,6 +302,32 @@ static int armada_370_xp_cpu_suspend(unsigned long deepidle)
 	return cpu_suspend(deepidle, armada_370_xp_pmsu_idle_enter);
 }
 
+static int armada_38x_do_cpu_suspend(unsigned long deepidle)
+{
+	unsigned long flags = 0;
+
+	if (deepidle)
+		flags |= PMSU_PREPARE_DEEP_IDLE;
+
+	mvebu_v7_pmsu_idle_prepare(flags);
+	/*
+	 * Already flushed cache, but do it again as the outer cache
+	 * functions dirty the cache with spinlocks
+	 */
+	v7_exit_coherency_flush(louis);
+
+	scu_power_mode(mvebu_get_scu_base(), SCU_PM_POWEROFF);
+
+	cpu_do_idle();
+
+	return 1;
+}
+
+static int armada_38x_cpu_suspend(unsigned long deepidle)
+{
+	return cpu_suspend(false, armada_38x_do_cpu_suspend);
+}
+
 /* No locking is needed because we only access per-CPU registers */
 void mvebu_v7_pmsu_idle_exit(void)
 {
@@ -295,7 +336,6 @@ void mvebu_v7_pmsu_idle_exit(void)
 
 	if (pmsu_mp_base == NULL)
 		return;
-
 	/* cancel ask HW to power down the L2 Cache if possible */
 	reg = readl(pmsu_mp_base + PMSU_CONTROL_AND_CONFIG(hw_cpu));
 	reg &= ~PMSU_CONTROL_AND_CONFIG_L2_PWDDN;
@@ -359,6 +399,47 @@ static __init int armada_370_cpuidle_init(void)
 	return 0;
 }
 
+static __init int armada_38x_cpuidle_init(void)
+{
+	struct device_node *np;
+	void __iomem *mpsoc_base;
+	u32 reg;
+
+	np = of_find_compatible_node(NULL, NULL,
+				     "marvell,armada-380-coherency-fabric");
+	if (!np)
+		return -ENODEV;
+	of_node_put(np);
+
+	np = of_find_compatible_node(NULL, NULL,
+				     "marvell,armada-380-mpcore-soc-ctrl");
+	if (!np)
+		return -ENODEV;
+	mpsoc_base = of_iomap(np, 0);
+	BUG_ON(!mpsoc_base);
+	of_node_put(np);
+
+	/* Set up reset mask when powering down the cpus */
+	reg = readl(mpsoc_base + MPCORE_RESET_CTL);
+	reg |= MPCORE_RESET_CTL_L2;
+	reg |= MPCORE_RESET_CTL_DEBUG;
+	writel(reg, mpsoc_base + MPCORE_RESET_CTL);
+	iounmap(mpsoc_base);
+
+	/* Set up delay */
+	reg = readl(pmsu_mp_base + PMSU_POWERDOWN_DELAY);
+	reg &= ~PMSU_POWERDOWN_DELAY_MASK;
+	reg |= PMSU_DFLT_ARMADA38X_DELAY;
+	reg |= PMSU_POWERDOWN_DELAY_PMU;
+	writel(reg, pmsu_mp_base + PMSU_POWERDOWN_DELAY);
+
+	mvebu_cpu_resume = armada_38x_cpu_resume;
+	mvebu_v7_cpuidle_device.dev.platform_data = armada_38x_cpu_suspend;
+	mvebu_v7_cpuidle_device.name = "cpuidle-armada-38x";
+
+	return 0;
+}
+
 static __init int armada_xp_cpuidle_init(void)
 {
 	struct device_node *np;
@@ -389,6 +470,8 @@ static int __init mvebu_v7_cpu_pm_init(void)
 		ret = armada_xp_cpuidle_init();
 	else if (of_machine_is_compatible("marvell,armada370"))
 		ret = armada_370_cpuidle_init();
+	else if (of_machine_is_compatible("marvell,armada380"))
+		ret = armada_38x_cpuidle_init();
 	else
 		return 0;
 
diff --git a/arch/arm/mach-mvebu/pmsu_ll.S b/arch/arm/mach-mvebu/pmsu_ll.S
index 17d7f3b..a945756 100644
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
2.0.0

