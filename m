From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/8] ARM: s3c24xx: Sort cpufreq tables
Date: Wed,  1 Jun 2016 16:04:15 +0530
Message-ID: <872a8b970ce7eabb06b988680eaf6b1154fe99fa.1464776797.git.viresh.kumar@linaro.org>
References: <cover.1464776797.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1464776797.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1464776797.git.viresh.kumar@linaro.org>
References: <cover.1464776797.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Some later changes in cpufreq core require these tables to be sorted
based on ascending order of their frequencies. There was only one
offender. Fix it and add comments over the arrays.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-s3c24xx/pll-s3c2410.c          | 3 ++-
 arch/arm/mach-s3c24xx/pll-s3c2440-12000000.c | 1 +
 arch/arm/mach-s3c24xx/pll-s3c2440-16934400.c | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-s3c24xx/pll-s3c2410.c b/arch/arm/mach-s3c24xx/pll-s3c2410.c
index 5e37d368594b..7ee4924a543d 100644
--- a/arch/arm/mach-s3c24xx/pll-s3c2410.c
+++ b/arch/arm/mach-s3c24xx/pll-s3c2410.c
@@ -32,11 +32,12 @@
 #include <plat/cpu.h>
 #include <plat/cpu-freq-core.h>
 
+/* This array should be sorted in ascending order of the frequencies */
 static struct cpufreq_frequency_table pll_vals_12MHz[] = {
     { .frequency = 34000000,  .driver_data = PLLVAL(82, 2, 3),   },
     { .frequency = 45000000,  .driver_data = PLLVAL(82, 1, 3),   },
-    { .frequency = 51000000,  .driver_data = PLLVAL(161, 3, 3),  },
     { .frequency = 48000000,  .driver_data = PLLVAL(120, 2, 3),  },
+    { .frequency = 51000000,  .driver_data = PLLVAL(161, 3, 3),  },
     { .frequency = 56000000,  .driver_data = PLLVAL(142, 2, 3),  },
     { .frequency = 68000000,  .driver_data = PLLVAL(82, 2, 2),   },
     { .frequency = 79000000,  .driver_data = PLLVAL(71, 1, 2),   },
diff --git a/arch/arm/mach-s3c24xx/pll-s3c2440-12000000.c b/arch/arm/mach-s3c24xx/pll-s3c2440-12000000.c
index b355fca6cc2e..a3fbfed75e28 100644
--- a/arch/arm/mach-s3c24xx/pll-s3c2440-12000000.c
+++ b/arch/arm/mach-s3c24xx/pll-s3c2440-12000000.c
@@ -20,6 +20,7 @@
 #include <plat/cpu.h>
 #include <plat/cpu-freq-core.h>
 
+/* This array should be sorted in ascending order of the frequencies */
 static struct cpufreq_frequency_table s3c2440_plls_12[] = {
 	{ .frequency = 75000000,	.driver_data = PLLVAL(0x75, 3, 3),  }, 	/* FVco 600.000000 */
 	{ .frequency = 80000000,	.driver_data = PLLVAL(0x98, 4, 3),  }, 	/* FVco 640.000000 */
diff --git a/arch/arm/mach-s3c24xx/pll-s3c2440-16934400.c b/arch/arm/mach-s3c24xx/pll-s3c2440-16934400.c
index be9a248b5ce9..bcff89fd9871 100644
--- a/arch/arm/mach-s3c24xx/pll-s3c2440-16934400.c
+++ b/arch/arm/mach-s3c24xx/pll-s3c2440-16934400.c
@@ -20,6 +20,7 @@
 #include <plat/cpu.h>
 #include <plat/cpu-freq-core.h>
 
+/* This array should be sorted in ascending order of the frequencies */
 static struct cpufreq_frequency_table s3c2440_plls_169344[] = {
 	{ .frequency = 78019200,	.driver_data = PLLVAL(121, 5, 3), 	}, 	/* FVco 624.153600 */
 	{ .frequency = 84067200,	.driver_data = PLLVAL(131, 5, 3), 	}, 	/* FVco 672.537600 */
-- 
2.7.1.410.g6faf27b
