From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 14/16] ARM: mvebu: Add CPU idle support for Armada 370
Date: Fri, 27 Jun 2014 15:22:55 +0200
Message-ID: <1403875377-940-15-git-send-email-gregory.clement@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:42131 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753419AbaF0NYF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Jun 2014 09:24:05 -0400
In-Reply-To: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>

Unlike the Armada XP the Armada 370 always power done the L2 cache, so
it have only 2 cpuidle states. Thanks to the previous patches, adding
the support for this new SoCs required only the modification of the
architecture specific part.

The message in case of failure to suspend the system was switched from
warn to debug. Indeed due to the "slow exit process from the deep idle
state" in Armada 370, this situation happens quite often. Using the
_debug version avoids spamming the kernel logs, but still allows to
enable it if needed.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c | 60 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 9396839e162e..bfd471538811 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -250,7 +250,7 @@ static noinline int do_armada_xp_370_cpu_suspend(unsigned long deepidle)
 	"isb	"
 	: : "r" (0));
 
-	pr_warn("Failed to suspend the system\n");
+	pr_debug("Failed to suspend the system\n");
 
 	return 0;
 }
@@ -302,6 +302,24 @@ static struct notifier_block mvebu_v7_cpu_pm_notifier = {
 
 static bool (*mvebu_v7_cpu_idle_init)(void);
 
+static struct mvebu_v7_cpuidle armada_370_cpuidle = {
+	.mvebu_v7_idle_driver = {
+		.name			= "armada_370_idle",
+		.states[0]		= ARM_CPUIDLE_WFI_STATE,
+		.states[1]		= {
+			.exit_latency		= 100,
+			.power_usage		= 5,
+			.target_residency	= 1000,
+			.flags			= CPUIDLE_FLAG_TIME_VALID |
+			MVEBU_V7_FLAG_DEEP_IDLE,
+			.name			= "Deep Idle",
+			.desc			= "CPU and L2 Fabric power down",
+		},
+		.state_count = 2,
+	},
+	.mvebu_v7_cpu_suspend = armada_xp_370_cpu_suspend,
+};
+
 static struct mvebu_v7_cpuidle armada_xp_cpuidle = {
 	.mvebu_v7_idle_driver = {
 		.name			= "armada_xp_idle",
@@ -328,6 +346,31 @@ static struct mvebu_v7_cpuidle armada_xp_cpuidle = {
 	.mvebu_v7_cpu_suspend = armada_xp_370_cpu_suspend,
 };
 
+static __init bool armada_370_cpuidle_init(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric");
+	if (!np)
+		return false;
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
+	mvebu_boot_addr_wa(ARMADA_370_CRYPT0_ENG_ID, pmsu_mp_phys_base +
+			PMSU_BOOT_ADDR_REDIRECT_OFFSET(0));
+
+	mvebu_cpu_resume = armada_370_xp_cpu_resume;
+	mvebu_v7_cpuidle_device.dev.platform_data = &armada_370_cpuidle;
+	return true;
+}
+
 static __init bool armada_xp_cpuidle_init(void)
 {
 	struct device_node *np;
@@ -345,6 +388,9 @@ static struct of_device_id of_cpuidle_table[] __initdata = {
 	{ .compatible = "marvell,armadaxp",
 	  .data = (void *)armada_xp_cpuidle_init,
 	},
+	{ .compatible = "marvell,armada370",
+	  .data = (void *)armada_370_cpuidle_init,
+	},
 	{ /* end of list */ },
 };
 
@@ -373,18 +419,6 @@ static int __init mvebu_v7_cpu_pm_init(void)
 		return 0;
 	of_node_put(np);
 
-	/*
-	 * On Armada 370, there is "a slow exit process from the deep
-	 * idle state due to heavy L1/L2 cache cleanup operations
-	 * performed by the BootROM software". To avoid this, we
-	 * replace the restart code of the bootrom by a a simple jump
-	 * to the boot address. Then the code located at this boot
-	 * address will take care of the initialization.
-	 */
-	if (of_machine_is_compatible("marvell,armada370"))
-		mvebu_boot_addr_wa(ARMADA_370_CRYPT0_ENG_ID, pmsu_mp_phys_base +
-				PMSU_BOOT_ADDR_REDIRECT_OFFSET(0));
-
 	mvebu_v7_pmsu_enable_l2_powerdown_onidle();
 	platform_device_register(&mvebu_v7_cpuidle_device);
 	cpu_pm_register_notifier(&mvebu_v7_cpu_pm_notifier);
-- 
1.8.1.2

