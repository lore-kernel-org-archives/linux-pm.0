From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] cpufreq: exynos: Disable on multiplatform build
Date: Wed,  2 Apr 2014 16:33:47 +0530
Message-ID: <1396436627-22744-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: cpufreq@vger.kernel.org
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, sachin.kamat@linaro.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-pm@vger.kernel.org

The current exynos cpufreq drivers are not multiplatform compliant
and give build errors as they refer to header files from machine
directory. Work to migrate them to generic cpufreq framework is under
progress. Till such time disable the build on multiplatform so that
other multiplatform ready features get tested.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 drivers/cpufreq/Kconfig.arm |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 1e2b9db563ec..0e9cce82844b 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -30,7 +30,7 @@ config ARM_EXYNOS_CPUFREQ
 
 config ARM_EXYNOS4210_CPUFREQ
 	bool "SAMSUNG EXYNOS4210"
-	depends on CPU_EXYNOS4210
+	depends on CPU_EXYNOS4210 && !ARCH_MULTIPLATFORM
 	default y
 	select ARM_EXYNOS_CPUFREQ
 	help
@@ -41,7 +41,7 @@ config ARM_EXYNOS4210_CPUFREQ
 
 config ARM_EXYNOS4X12_CPUFREQ
 	bool "SAMSUNG EXYNOS4x12"
-	depends on (SOC_EXYNOS4212 || SOC_EXYNOS4412)
+	depends on (SOC_EXYNOS4212 || SOC_EXYNOS4412) && !ARCH_MULTIPLATFORM
 	default y
 	select ARM_EXYNOS_CPUFREQ
 	help
@@ -52,7 +52,7 @@ config ARM_EXYNOS4X12_CPUFREQ
 
 config ARM_EXYNOS5250_CPUFREQ
 	bool "SAMSUNG EXYNOS5250"
-	depends on SOC_EXYNOS5250
+	depends on SOC_EXYNOS5250 && !ARCH_MULTIPLATFORM
 	default y
 	select ARM_EXYNOS_CPUFREQ
 	help
-- 
1.7.9.5

