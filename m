From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [V4 patch 11/15] ARM: tegra: cpuidle: use init/exit common routine for tegra3
Date: Tue, 23 Apr 2013 10:54:41 +0200
Message-ID: <1366707285-12179-12-git-send-email-daniel.lezcano@linaro.org>
References: <1366707285-12179-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:65053 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756534Ab3DWIzS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Apr 2013 04:55:18 -0400
Received: by mail-we0-f179.google.com with SMTP id u3so352845wey.10
        for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2013 01:55:17 -0700 (PDT)
In-Reply-To: <1366707285-12179-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: andrew@lunn.ch, khilman@deeprootsystems.com, nsekhar@ti.com, josephl@nvidia.com, kgene.kim@samsung.com, patches@linaro.org, magnus.damm@gmail.com, tony@atomide.com, plagnioj@jcrosoft.com, linaro-kernel@lists.linaro.org, jason@lakedaemon.net, swarren@wwwdotorg.org, rob.herring@calxeda.com, horms@verge.net.au, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, deepthi@linux.vnet.ibm.com, jkosina@suse.cz, linux-pm@vger.kernel.org, lethal@linux-sh.org, kernel@pengutronix.de

Remove the duplicated code and use the cpuidle common code for initialization.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/cpuidle-tegra30.c |   27 +--------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra30.c b/arch/arm/mach-tegra/cpuidle-tegra30.c
index f6a0c72..36dc2be 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra30.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra30.c
@@ -64,8 +64,6 @@ static struct cpuidle_driver tegra_idle_driver = {
 	},
 };
 
-static DEFINE_PER_CPU(struct cpuidle_device, tegra_idle_device);
-
 #ifdef CONFIG_PM_SLEEP
 static bool tegra30_cpu_cluster_power_down(struct cpuidle_device *dev,
 					   struct cpuidle_driver *drv,
@@ -156,31 +154,8 @@ static int tegra30_idle_lp2(struct cpuidle_device *dev,
 
 int __init tegra30_cpuidle_init(void)
 {
-	int ret;
-	unsigned int cpu;
-	struct cpuidle_device *dev;
-	struct cpuidle_driver *drv = &tegra_idle_driver;
-
 #ifdef CONFIG_PM_SLEEP
 	tegra_tear_down_cpu = tegra30_tear_down_cpu;
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
-
-		ret = cpuidle_register_device(dev);
-		if (ret) {
-			pr_err("CPU%u: CPUidle device registration failed\n",
-				cpu);
-			return ret;
-		}
-	}
-	return 0;
+	return cpuidle_register(&tegra_idle_driver, NULL);
 }
-- 
1.7.9.5

