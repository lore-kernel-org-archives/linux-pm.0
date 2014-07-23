From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCHv3 14/16] ARM: mvebu: add cpuidle support for Armada 370
Date: Wed, 23 Jul 2014 15:00:51 +0200
Message-ID: <1406120453-29291-15-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1406120453-29291-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:40751 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754587AbaGWNBM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jul 2014 09:01:12 -0400
In-Reply-To: <1406120453-29291-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>
Cc: Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

This commit introduces the cpuidle support for Armada 370. The main
difference compared to the already supported Armada XP is that the
Armada 370 has an issue caused by "a slow exit process from the deep
idle state due to heavy L1/L2 cache cleanup operations performed by
the BootROM software" (cf errata GL-BootROM-10).

To work around this issue, we replace the restart code of the BootROM
by some custom code located in an internal SRAM. For this purpose, we
use the common function mvebu_boot_addr_wa() introduced in the commit
"ARM: mvebu: Add a common function for the boot address work around".

The message in case of failure to suspend the system was switched from
the warn level to the debug level. Indeed due to the "slow exit
process from the deep idle state" in Armada 370, this situation
happens quite often. Using the debug level avoids spamming the kernel
logs, but still allows to enable it if needed.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c | 51 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 0cd2d09..9190ae8 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -34,7 +34,6 @@
 #include <asm/tlbflush.h>
 #include "common.h"
 
-static void __iomem *pmsu_mp_base;
 
 #define PMSU_BASE_OFFSET    0x100
 #define PMSU_REG_SIZE	    0x1000
@@ -68,17 +67,18 @@ static void __iomem *pmsu_mp_base;
 #define BOOTROM_BASE    0xFFF00000
 #define BOOTROM_SIZE    0x100000
 
+#define ARMADA_370_CRYPT0_ENG_TARGET   0x9
+#define ARMADA_370_CRYPT0_ENG_ATTR     0x1
+
 extern void ll_disable_coherency(void);
 extern void ll_enable_coherency(void);
 
 extern void armada_370_xp_cpu_resume(void);
+static phys_addr_t pmsu_mp_phys_base;
+static void __iomem *pmsu_mp_base;
 
 static void *mvebu_cpu_resume;
 
-static struct platform_device mvebu_v7_cpuidle_device = {
-	.name = "cpuidle-armada-xp",
-};
-
 static struct of_device_id of_pmsu_table[] = {
 	{ .compatible = "marvell,armada-370-pmsu", },
 	{ .compatible = "marvell,armada-370-xp-pmsu", },
@@ -165,6 +165,8 @@ static int __init mvebu_v7_pmsu_init(void)
 		goto out;
 	}
 
+	pmsu_mp_phys_base = res.start;
+
 	pmsu_mp_base = ioremap(res.start, resource_size(&res));
 	if (!pmsu_mp_base) {
 		pr_err("unable to map registers\n");
@@ -275,7 +277,7 @@ int armada_370_xp_pmsu_idle_enter(unsigned long deepidle)
 	"isb	"
 	: : : "r0");
 
-	pr_warn("Failed to suspend the system\n");
+	pr_debug("Failed to suspend the system\n");
 
 	return 0;
 }
@@ -325,7 +327,39 @@ static struct notifier_block mvebu_v7_cpu_pm_notifier = {
 	.notifier_call = mvebu_v7_cpu_pm_notify,
 };
 
-static int __init armada_xp_cpuidle_init(void)
+static struct platform_device mvebu_v7_cpuidle_device;
+
+static __init int armada_370_cpuidle_init(void)
+{
+	struct device_node *np;
+	phys_addr_t redirect_reg;
+
+	np = of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric");
+	if (!np)
+		return -ENODEV;
+	of_node_put(np);
+
+	/*
+	 * On Armada 370, there is "a slow exit process from the deep
+	 * idle state due to heavy L1/L2 cache cleanup operations
+	 * performed by the BootROM software". To avoid this, we
+	 * replace the restart code of the bootrom by a a simple jump
+	 * to the boot address. Then the code located at this boot
+	 * address will take care of the initialization.
+	 */
+	redirect_reg = pmsu_mp_phys_base + PMSU_BOOT_ADDR_REDIRECT_OFFSET(0);
+	mvebu_setup_boot_addr_wa(ARMADA_370_CRYPT0_ENG_TARGET,
+				 ARMADA_370_CRYPT0_ENG_ATTR,
+				 redirect_reg);
+
+	mvebu_cpu_resume = armada_370_xp_cpu_resume;
+	mvebu_v7_cpuidle_device.dev.platform_data = armada_370_xp_cpu_suspend;
+	mvebu_v7_cpuidle_device.name = "cpuidle-armada-370";
+
+	return 0;
+}
+
+static __init int armada_xp_cpuidle_init(void)
 {
 	struct device_node *np;
 
@@ -336,6 +370,7 @@ static int __init armada_xp_cpuidle_init(void)
 
 	mvebu_cpu_resume = armada_370_xp_cpu_resume;
 	mvebu_v7_cpuidle_device.dev.platform_data = armada_370_xp_cpu_suspend;
+	mvebu_v7_cpuidle_device.name = "cpuidle-armada-xp";
 
 	return 0;
 }
@@ -352,6 +387,8 @@ static int __init mvebu_v7_cpu_pm_init(void)
 
 	if (of_machine_is_compatible("marvell,armadaxp"))
 		ret = armada_xp_cpuidle_init();
+	else if (of_machine_is_compatible("marvell,armada370"))
+		ret = armada_370_cpuidle_init();
 	else
 		return 0;
 
-- 
2.0.0

