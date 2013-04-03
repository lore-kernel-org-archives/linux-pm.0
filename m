From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 5/9] ARM: tegra: cpuidle: remove useless initialization
Date: Wed,  3 Apr 2013 14:15:18 +0200
Message-ID: <1364991322-20585-5-git-send-email-daniel.lezcano@linaro.org>
References: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:42750 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760475Ab3DCMPj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Apr 2013 08:15:39 -0400
Received: by mail-we0-f181.google.com with SMTP id d7so1099920wer.26
        for <linux-pm@vger.kernel.org>; Wed, 03 Apr 2013 05:15:38 -0700 (PDT)
In-Reply-To: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, rnayak@ti.com, swarren@wwwdotorg.org, linux-tegra@vger.kernel.org, horms+renesas@verge.net.au, santosh.shilimkar@ti.com, arnd@arndb.de, lenb@kernel.org, nsekhar@ti.com, josephl@nvidia.com, deepthi@linux.vnet.ibm.com

dev->state_count is initialized automatically by cpuidle_register_device.

When drv->state_count is equal to dev->state_count, no need to init this
field, so removing it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Joseph Lo <josephl@nvidia.com>
Acked-by: Joseph Lo <josephl@nvidia.com>
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

