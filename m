From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCHv2 15/17] ARM: mvebu: add cpuidle support for Armada 370
Date: Wed,  9 Jul 2014 15:40:19 +0200
Message-ID: <1404913221-17343-16-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:47398 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755446AbaGINks (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jul 2014 09:40:48 -0400
In-Reply-To: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>
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
 arch/arm/mach-mvebu/pmsu.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 0a24073..7c3d3e1 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -36,7 +36,6 @@
 #include <asm/tlbflush.h>
 #include "common.h"
 
-static void __iomem *pmsu_mp_base;
 
 #define PMSU_BASE_OFFSET    0x100
 #define PMSU_REG_SIZE	    0x1000
@@ -70,10 +69,15 @@ static void __iomem *pmsu_mp_base;
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
 
@@ -163,6 +167,8 @@ static int __init mvebu_v7_pmsu_init(void)
 		goto out;
 	}
 
+	pmsu_mp_phys_base = res.start;
+
 	pmsu_mp_base = ioremap(res.start, resource_size(&res));
 	if (!pmsu_mp_base) {
 		pr_err("unable to map registers\n");
@@ -273,7 +279,7 @@ int armada_370_xp_pmsu_idle_enter(unsigned long deepidle)
 	"isb	"
 	: : : "r0");
 
-	pr_warn("Failed to suspend the system\n");
+	pr_debug("Failed to suspend the system\n");
 
 	return 0;
 }
@@ -323,6 +329,11 @@ static struct notifier_block mvebu_v7_cpu_pm_notifier = {
 	.notifier_call = mvebu_v7_cpu_pm_notify,
 };
 
+static struct mvebu_v7_cpuidle armada_370_cpuidle = {
+	.type = CPUIDLE_ARMADA_370,
+	.cpu_suspend = armada_370_xp_cpu_suspend,
+};
+
 static struct mvebu_v7_cpuidle armada_xp_cpuidle = {
 	.type = CPUIDLE_ARMADA_XP,
 	.cpu_suspend = armada_370_xp_cpu_suspend,
@@ -332,6 +343,35 @@ static struct platform_device mvebu_v7_cpuidle_device = {
 	.name = "cpuidle-mvebu-v7",
 };
 
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
+	mvebu_v7_cpuidle_device.dev.platform_data = &armada_370_cpuidle;
+
+	return 0;
+}
+
 static __init int armada_xp_cpuidle_init(void)
 {
 	struct device_node *np;
@@ -358,6 +398,8 @@ static int __init mvebu_v7_cpu_pm_init(void)
 
 	if (of_machine_is_compatible("marvell,armadaxp"))
 		ret = armada_xp_cpuidle_init();
+	else if (of_machine_is_compatible("marvell,armada370"))
+		ret = armada_370_cpuidle_init();
 	else
 		return 0;
 
-- 
2.0.0

