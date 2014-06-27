From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 06/16] ARM: mvebu: Rename the armada_370_xp into mvebu_v7 in pmsu.c file
Date: Fri, 27 Jun 2014 15:22:47 +0200
Message-ID: <1403875377-940-7-git-send-email-gregory.clement@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:42085 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753157AbaF0NX4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Jun 2014 09:23:56 -0400
In-Reply-To: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>

Actually most of the function related to the PMSU are not specific to
the Armada 370 or Armada XP SoCs, but can also be used for most of the
other mvebu ARMv7 SoCs.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index cdc6d87d0b49..087157c20b8a 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -79,7 +79,7 @@ extern void armada_370_xp_cpu_resume(void);
 static unsigned long pmsu_mp_phys_base;
 static void __iomem *pmsu_mp_base;
 
-static struct platform_device armada_xp_cpuidle_device = {
+static struct platform_device mvebu_v7_cpuidle_device = {
 	.name = "cpuidle-armada-370-xp",
 };
 
@@ -118,7 +118,7 @@ void mvebu_boot_addr_wa(int crypto_eng_id, u32 resume_addr_reg)
 	*(unsigned long *)(sram_virt_base + code_len - 4) = resume_addr_reg;
 }
 
-static int __init armada_370_xp_pmsu_init(void)
+static int __init mvebu_v7_pmsu_init(void)
 {
 	struct device_node *np;
 	struct resource res;
@@ -164,7 +164,7 @@ static int __init armada_370_xp_pmsu_init(void)
 	return ret;
 }
 
-static void armada_370_xp_pmsu_enable_l2_powerdown_onidle(void)
+static void mvebu_v7_pmsu_enable_l2_powerdown_onidle(void)
 {
 	u32 reg;
 
@@ -178,7 +178,7 @@ static void armada_370_xp_pmsu_enable_l2_powerdown_onidle(void)
 }
 
 /* No locking is needed because we only access per-CPU registers */
-void armada_370_xp_pmsu_idle_prepare(bool deepidle)
+static void mvebu_v7_pmsu_idle_prepare(bool deepidle)
 {
 	unsigned int hw_cpu = cpu_logical_map(smp_processor_id());
 	u32 reg;
@@ -215,9 +215,9 @@ void armada_370_xp_pmsu_idle_prepare(bool deepidle)
 	writel(reg, pmsu_mp_base + PMSU_CPU_POWER_DOWN_CONTROL(hw_cpu));
 }
 
-static noinline int do_armada_370_xp_cpu_suspend(unsigned long deepidle)
+static noinline int do_armada_xp_370_cpu_suspend(unsigned long deepidle)
 {
-	armada_370_xp_pmsu_idle_prepare(deepidle);
+	mvebu_v7_pmsu_idle_prepare(deepidle);
 
 	v7_exit_coherency_flush(all);
 
@@ -248,13 +248,13 @@ static noinline int do_armada_370_xp_cpu_suspend(unsigned long deepidle)
 	return 0;
 }
 
-static int armada_370_xp_cpu_suspend(unsigned long deepidle)
+static int armada_xp_370_cpu_suspend(unsigned long deepidle)
 {
-	return cpu_suspend(deepidle, do_armada_370_xp_cpu_suspend);
+	return cpu_suspend(deepidle, do_armada_xp_370_cpu_suspend);
 }
 
 /* No locking is needed because we only access per-CPU registers */
-static noinline void armada_370_xp_pmsu_idle_restore(void)
+static noinline void mvebu_v7_pmsu_idle_restore(void)
 {
 	unsigned int hw_cpu = cpu_logical_map(smp_processor_id());
 	u32 reg;
@@ -276,24 +276,24 @@ static noinline void armada_370_xp_pmsu_idle_restore(void)
 	writel(reg, pmsu_mp_base + PMSU_STATUS_AND_MASK(hw_cpu));
 }
 
-static int armada_370_xp_cpu_pm_notify(struct notifier_block *self,
+static int mvebu_v7_cpu_pm_notify(struct notifier_block *self,
 				    unsigned long action, void *hcpu)
 {
 	if (action == CPU_PM_ENTER) {
 		unsigned int hw_cpu = cpu_logical_map(smp_processor_id());
 		mvebu_pmsu_set_cpu_boot_addr(hw_cpu, armada_370_xp_cpu_resume);
 	} else if (action == CPU_PM_EXIT) {
-		armada_370_xp_pmsu_idle_restore();
+		mvebu_v7_pmsu_idle_restore();
 	}
 
 	return NOTIFY_OK;
 }
 
-static struct notifier_block armada_370_xp_cpu_pm_notifier = {
-	.notifier_call = armada_370_xp_cpu_pm_notify,
+static struct notifier_block mvebu_v7_cpu_pm_notifier = {
+	.notifier_call = mvebu_v7_cpu_pm_notify,
 };
 
-int __init armada_370_xp_cpu_pm_init(void)
+static int __init mvebu_v7_cpu_pm_init(void)
 {
 	struct device_node *np;
 
@@ -328,13 +328,13 @@ int __init armada_370_xp_cpu_pm_init(void)
 		mvebu_boot_addr_wa(ARMADA_370_CRYPT0_ENG_ID, pmsu_mp_phys_base +
 				PMSU_BOOT_ADDR_REDIRECT_OFFSET(0));
 
-	armada_370_xp_pmsu_enable_l2_powerdown_onidle();
-	armada_xp_cpuidle_device.dev.platform_data = armada_370_xp_cpu_suspend;
-	platform_device_register(&armada_xp_cpuidle_device);
-	cpu_pm_register_notifier(&armada_370_xp_cpu_pm_notifier);
+	mvebu_v7_pmsu_enable_l2_powerdown_onidle();
+	mvebu_v7_cpuidle_device.dev.platform_data = armada_xp_370_cpu_suspend;
+	platform_device_register(&mvebu_v7_cpuidle_device);
+	cpu_pm_register_notifier(&mvebu_v7_cpu_pm_notifier);
 
 	return 0;
 }
 
-arch_initcall(armada_370_xp_cpu_pm_init);
-early_initcall(armada_370_xp_pmsu_init);
+arch_initcall(mvebu_v7_cpu_pm_init);
+early_initcall(mvebu_v7_pmsu_init);
-- 
1.8.1.2

