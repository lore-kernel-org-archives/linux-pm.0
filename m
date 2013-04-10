From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 13/18] ARM: tegra2: cpuidle: use init/exit common routine
Date: Wed, 10 Apr 2013 16:22:18 +0200
Message-ID: <1365603743-5618-14-git-send-email-daniel.lezcano@linaro.org>
References: <1365603743-5618-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:60174 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936887Ab3DJOXQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Apr 2013 10:23:16 -0400
Received: by mail-we0-f174.google.com with SMTP id u12so402751wey.33
        for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2013 07:23:14 -0700 (PDT)
In-Reply-To: <1365603743-5618-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linus.walleij@linaro.org, jason@lakedaemon.net, andrew@lunn.ch, kernel@pengutronix.de, swarren@wwwdotorg.org, santosh.shilimkar@ti.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, khilman@deeprootsystems.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

Remove the duplicated code and use the cpuidle common code for initialization.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-tegra/cpuidle-tegra20.c |   33 +--------------------------------
 1 file changed, 1 insertion(+), 32 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
index f1f6ac4..d6c2ba6 100644
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
@@ -220,34 +218,5 @@ static int tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
 
 int __init tegra20_cpuidle_init(void)
 {
-	int ret;
-	unsigned int cpu;
-	struct cpuidle_device *dev;
-	struct cpuidle_driver *drv = &tegra_idle_driver;
-
-#ifdef CONFIG_PM_SLEEP
-	tegra_tear_down_cpu = tegra20_tear_down_cpu;
-#endif
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

