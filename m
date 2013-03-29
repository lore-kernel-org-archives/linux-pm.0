From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 6/9] ARM: tegra: cpuidle: remove useless initialization
Date: Fri, 29 Mar 2013 11:31:32 +0100
Message-ID: <1364553095-25110-6-git-send-email-daniel.lezcano@linaro.org>
References: <1364553095-25110-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1364553095-25110-1-git-send-email-daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rjw-KKrjLPT3xs0@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-pm@vger.kernel.org

dev->state_count is initialized automatically by cpuidle_register_device.

When drv->state_count is equal to dev->state_count, no need to init this
field, so removing it.

Signed-off-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 arch/arm/mach-tegra/cpuidle-tegra114.c |    1 -
 arch/arm/mach-tegra/cpuidle-tegra20.c  |    1 -
 arch/arm/mach-tegra/cpuidle-tegra30.c  |    1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra114.c b/arch/arm/mach-tegra/cpuidle-tegra114.c
index 0f4e8c4..c527cff 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra114.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra114.c
@@ -49,7 +49,6 @@ int __init tegra114_cpuidle_init(void)
 		dev = &per_cpu(tegra_idle_device, cpu);
 		dev->cpu = cpu;
 
-		dev->state_count = drv->state_count;
 		ret = cpuidle_register_device(dev);
 		if (ret) {
 			pr_err("CPU%u: CPUidle device registration failed\n",
diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
index 1ad1a67..b94d76a 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -243,7 +243,6 @@ int __init tegra20_cpuidle_init(void)
 		dev->coupled_cpus = *cpu_possible_mask;
 #endif
 
-		dev->state_count = drv->state_count;
 		ret = cpuidle_register_device(dev);
 		if (ret) {
 			pr_err("CPU%u: CPUidle device registration failed\n",
diff --git a/arch/arm/mach-tegra/cpuidle-tegra30.c b/arch/arm/mach-tegra/cpuidle-tegra30.c
index 8b50cf4..c4e01fe 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra30.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra30.c
@@ -176,7 +176,6 @@ int __init tegra30_cpuidle_init(void)
 		dev = &per_cpu(tegra_idle_device, cpu);
 		dev->cpu = cpu;
 
-		dev->state_count = drv->state_count;
 		ret = cpuidle_register_device(dev);
 		if (ret) {
 			pr_err("CPU%u: CPUidle device registration failed\n",
-- 
1.7.9.5
