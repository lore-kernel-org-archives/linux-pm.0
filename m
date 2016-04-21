From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/8] cpufreq: berlin: Use generic platdev driver
Date: Thu, 21 Apr 2016 14:13:47 +0530
Message-ID: <4be5e8c38aed34a4aae08db2cae39ca8ece54d29.1461228081.git.viresh.kumar@linaro.org>
References: <cover.1461228081.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1461228081.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1461228081.git.viresh.kumar@linaro.org>
References: <cover.1461228081.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, Antoine Tenart <antoine.tenart@free-electrons.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The cpufreq-dt-platdev driver supports creation of cpufreq-dt platform
device now, reuse that and remove similar code from platform code.

Cc: Antoine Tenart <antoine.tenart@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-berlin/berlin.c        | 6 ------
 drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-berlin/berlin.c b/arch/arm/mach-berlin/berlin.c
index 25d73870ccca..ac181c6797ee 100644
--- a/arch/arm/mach-berlin/berlin.c
+++ b/arch/arm/mach-berlin/berlin.c
@@ -18,11 +18,6 @@
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 
-static void __init berlin_init_late(void)
-{
-	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
-}
-
 static const char * const berlin_dt_compat[] = {
 	"marvell,berlin",
 	NULL,
@@ -30,7 +25,6 @@ static const char * const berlin_dt_compat[] = {
 
 DT_MACHINE_START(BERLIN_DT, "Marvell Berlin")
 	.dt_compat	= berlin_dt_compat,
-	.init_late	= berlin_init_late,
 	/*
 	 * with DT probing for L2CCs, berlin_init_machine can be removed.
 	 * Note: 88DE3005 (Armada 1500-mini) uses pl310 l2cc
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index f2ae7ad99a3c..3b3e6804cf14 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -12,6 +12,8 @@
 #include <linux/platform_device.h>
 
 static const struct of_device_id machines[] = {
+	{ .compatible = "marvell,berlin", },
+
 	{ .compatible = "samsung,exynos3250", },
 	{ .compatible = "samsung,exynos4210", },
 	{ .compatible = "samsung,exynos4212", },
-- 
2.7.1.410.g6faf27b
