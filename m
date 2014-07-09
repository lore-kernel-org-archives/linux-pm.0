From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCHv2 05/17] ARM: mvebu: rename the armada_370_xp symbols to mvebu_v7 in pmsu.c
Date: Wed,  9 Jul 2014 15:40:09 +0200
Message-ID: <1404913221-17343-6-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:47324 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756007AbaGINkh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jul 2014 09:40:37 -0400
In-Reply-To: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>
Cc: Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

Most of the function related to the PMSU are not specific to the
Armada 370 or Armada XP SoCs. They can also be used for most of the
other mvebu ARMv7 SoCs, and will actually be used to support cpuidle
on Armada 38x.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/armada-370-xp.h |  1 -
 arch/arm/mach-mvebu/platsmp.c       |  2 +-
 arch/arm/mach-mvebu/pmsu.c          | 34 +++++++++++++++++-----------------
 arch/arm/mach-mvebu/pmsu.h          |  2 ++
 4 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-mvebu/armada-370-xp.h b/arch/arm/mach-mvebu/armada-370-xp.h
index 52c1603a..84cd90d 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.h
+++ b/arch/arm/mach-mvebu/armada-370-xp.h
@@ -25,6 +25,5 @@ extern struct smp_operations armada_xp_smp_ops;
 #endif
 
 int armada_370_xp_pmsu_idle_enter(unsigned long deepidle);
-void armada_370_xp_pmsu_idle_exit(void);
 
 #endif /* __MACH_ARMADA_370_XP_H */
diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
index b6fa9f0..6da2b72 100644
--- a/arch/arm/mach-mvebu/platsmp.c
+++ b/arch/arm/mach-mvebu/platsmp.c
@@ -108,7 +108,7 @@ static int armada_xp_boot_secondary(unsigned int cpu, struct task_struct *idle)
  */
 static void armada_xp_secondary_init(unsigned int cpu)
 {
-	armada_370_xp_pmsu_idle_exit();
+	mvebu_v7_pmsu_idle_exit();
 }
 
 static void __init armada_xp_smp_init_cpus(void)
diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 272a9c05..501d450 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -73,7 +73,7 @@ extern void ll_enable_coherency(void);
 
 extern void armada_370_xp_cpu_resume(void);
 
-static struct platform_device armada_xp_cpuidle_device = {
+static struct platform_device mvebu_v7_cpuidle_device = {
 	.name = "cpuidle-armada-370-xp",
 };
 
@@ -132,7 +132,7 @@ int mvebu_setup_boot_addr_wa(unsigned int crypto_eng_target,
 	return 0;
 }
 
-static int __init armada_370_xp_pmsu_init(void)
+static int __init mvebu_v7_pmsu_init(void)
 {
 	struct device_node *np;
 	struct resource res;
@@ -176,7 +176,7 @@ static int __init armada_370_xp_pmsu_init(void)
 	return ret;
 }
 
-static void armada_370_xp_pmsu_enable_l2_powerdown_onidle(void)
+static void mvebu_v7_pmsu_enable_l2_powerdown_onidle(void)
 {
 	u32 reg;
 
@@ -190,7 +190,7 @@ static void armada_370_xp_pmsu_enable_l2_powerdown_onidle(void)
 }
 
 /* No locking is needed because we only access per-CPU registers */
-static int armada_370_xp_prepare(unsigned long deepidle)
+static int mvebu_v7_pmsu_idle_prepare(bool deepidle)
 {
 	unsigned int hw_cpu = cpu_logical_map(smp_processor_id());
 	u32 reg;
@@ -233,7 +233,7 @@ int armada_370_xp_pmsu_idle_enter(unsigned long deepidle)
 {
 	int ret;
 
-	ret = armada_370_xp_prepare(deepidle);
+	ret = mvebu_v7_pmsu_idle_prepare(deepidle);
 	if (ret)
 		return ret;
 
@@ -272,7 +272,7 @@ static int armada_370_xp_cpu_suspend(unsigned long deepidle)
 }
 
 /* No locking is needed because we only access per-CPU registers */
-void armada_370_xp_pmsu_idle_exit(void)
+void mvebu_v7_pmsu_idle_exit(void)
 {
 	unsigned int hw_cpu = cpu_logical_map(smp_processor_id());
 	u32 reg;
@@ -294,24 +294,24 @@ void armada_370_xp_pmsu_idle_exit(void)
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
-		armada_370_xp_pmsu_idle_exit();
+		mvebu_v7_pmsu_idle_exit();
 	}
 
 	return NOTIFY_OK;
 }
 
-static struct notifier_block armada_370_xp_cpu_pm_notifier = {
-	.notifier_call = armada_370_xp_cpu_pm_notify,
+static struct notifier_block mvebu_v7_cpu_pm_notifier = {
+	.notifier_call = mvebu_v7_cpu_pm_notify,
 };
 
-static int __init armada_370_xp_cpu_pm_init(void)
+static int __init mvebu_v7_cpu_pm_init(void)
 {
 	struct device_node *np;
 
@@ -334,13 +334,13 @@ static int __init armada_370_xp_cpu_pm_init(void)
 		return 0;
 	of_node_put(np);
 
-	armada_370_xp_pmsu_enable_l2_powerdown_onidle();
-	armada_xp_cpuidle_device.dev.platform_data = armada_370_xp_cpu_suspend;
-	platform_device_register(&armada_xp_cpuidle_device);
-	cpu_pm_register_notifier(&armada_370_xp_cpu_pm_notifier);
+	mvebu_v7_pmsu_enable_l2_powerdown_onidle();
+	mvebu_v7_cpuidle_device.dev.platform_data = armada_370_xp_cpu_suspend;
+	platform_device_register(&mvebu_v7_cpuidle_device);
+	cpu_pm_register_notifier(&mvebu_v7_cpu_pm_notifier);
 
 	return 0;
 }
 
-arch_initcall(armada_370_xp_cpu_pm_init);
-early_initcall(armada_370_xp_pmsu_init);
+arch_initcall(mvebu_v7_cpu_pm_init);
+early_initcall(mvebu_v7_pmsu_init);
diff --git a/arch/arm/mach-mvebu/pmsu.h b/arch/arm/mach-mvebu/pmsu.h
index ae50194..6b58c1f 100644
--- a/arch/arm/mach-mvebu/pmsu.h
+++ b/arch/arm/mach-mvebu/pmsu.h
@@ -16,4 +16,6 @@ int mvebu_setup_boot_addr_wa(unsigned int crypto_eng_target,
                              unsigned int crypto_eng_attribute,
                              phys_addr_t resume_addr_reg);
 
+void mvebu_v7_pmsu_idle_exit(void);
+
 #endif	/* __MACH_370_XP_PMSU_H */
-- 
2.0.0

