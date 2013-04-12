From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [V3 patch 14/19] ARM: tegra: cpuidle: use init/exit common routine for tegra2
Date: Fri, 12 Apr 2013 14:36:00 +0200
Message-ID: <1365770165-27096-15-git-send-email-daniel.lezcano@linaro.org>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:41641 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753703Ab3DLMgz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Apr 2013 08:36:55 -0400
Received: by mail-wi0-f182.google.com with SMTP id hi18so1529997wib.15
        for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2013 05:36:54 -0700 (PDT)
In-Reply-To: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linus.walleij@linaro.org, jason@lakedaemon.net, andrew@lunn.ch, kernel@pengutronix.de, swarren@wwwdotorg.org, santosh.shilimkar@ti.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, khilman@deeprootsystems.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

Remove the duplicated code and use the cpuidle common code for initialization.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/cpuidle-tegra20.c |   30 +-----------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
index f1f6ac4..590ec25 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -70,8 +70,6 @@ static struct cpuidle_driver tegra_idle_driver = {
 	.safe_state_index = 0,
 };
 
-static DEFINE_PER_CPU(struct cpuidle_device, tegra_idle_device);
-
 #ifdef CONFIG_PM_SLEEP
 #ifdef CONFIG_SMP
 static void __iomem *pmc = IO_ADDRESS(TEGRA_PMC_BASE);
@@ -220,34 +218,8 @@ static int tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
 
 int __init tegra20_cpuidle_init(void)
 {
-	int ret;
-	unsigned int cpu;
-	struct cpuidle_device *dev;
-	struct cpuidle_driver *drv = &tegra_idle_driver;
-
 #ifdef CONFIG_PM_SLEEP
 	tegra_tear_down_cpu = tegra20_tear_down_cpu;
 #endif
-
-	ret = cpuidle_register_driver(&tegra_idle_driver);
-	if (ret) {
-		pr_err("CPUidle driver registration failed\n");
-		return ret;
-	}
-
-	for_each_possible_cpu(cpu) {
-		dev = &per_cpu(tegra_idle_device, cpu);
-		dev->cpu = cpu;
-#ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
-		dev->coupled_cpus = *cpu_possible_mask;
-#endif
-
-		ret = cpuidle_register_device(dev);
-		if (ret) {
-			pr_err("CPU%u: CPUidle device registration failed\n",
-				cpu);
-			return ret;
-		}
-	}
-	return 0;
+	return cpuidle_register(&tegra_idle_driver, cpu_possible_mask);
 }
-- 
1.7.9.5

