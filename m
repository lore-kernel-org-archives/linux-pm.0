From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [V3 patch 11/19] ARM: tegra: cpuidle: use init/exit common routine
Date: Fri, 12 Apr 2013 14:35:57 +0200
Message-ID: <1365770165-27096-12-git-send-email-daniel.lezcano@linaro.org>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:51778 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753703Ab3DLMgp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Apr 2013 08:36:45 -0400
Received: by mail-we0-f176.google.com with SMTP id s43so1943262wey.7
        for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2013 05:36:44 -0700 (PDT)
In-Reply-To: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linus.walleij@linaro.org, jason@lakedaemon.net, andrew@lunn.ch, kernel@pengutronix.de, swarren@wwwdotorg.org, santosh.shilimkar@ti.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, khilman@deeprootsystems.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

Remove the duplicated code and use the cpuidle common code for initialization.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/cpuidle-tegra114.c |   26 +-------------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra114.c b/arch/arm/mach-tegra/cpuidle-tegra114.c
index c5fadf9..1d1c602 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra114.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra114.c
@@ -29,31 +29,7 @@ static struct cpuidle_driver tegra_idle_driver = {
 	},
 };
 
-static DEFINE_PER_CPU(struct cpuidle_device, tegra_idle_device);
-
 int __init tegra114_cpuidle_init(void)
 {
-	int ret;
-	unsigned int cpu;
-	struct cpuidle_device *dev;
-	struct cpuidle_driver *drv = &tegra_idle_driver;
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

