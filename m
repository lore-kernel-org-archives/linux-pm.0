From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: [PATCH] Remove unselectable rule for arm-exynos-cpufreq.o
Date: Thu, 13 Aug 2015 12:32:21 +0200
Message-ID: <1439461941-13953-1-git-send-email-jonas.rabenstein@studium.uni-erlangen.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki\"" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
List-Id: linux-pm@vger.kernel.org

With commit 2907ed4377d9 ("cpufreq: exynos: remove Exynos4x12 specific
cpufreq driver support"), the last specific Exynos-cpufreq driver
depending on ARM_EXYNOS_CPUFREQ was removed. As there is no
Exynos-specific cpufreq driver depending on the code in
drivers/cpufreq/exynos-cpufreq.c (selected by ARM_EXYNOS_CPUFREQ),
this file was deleted and ARM_EXYNOS_CPUFREQ removed from Kconfig.
After all, the rule in drivers/cpufreq/Makefile, to combine all
specific cpufreq drivers depending on the generic code for Exynos into
one objectfile is obsolete and can be removed.

Remove unselectable rule for arm-exynos-cpufreq.o from
drivers/cpufreq/Makefile, which - if selectable - would generate an
always empty objectfile.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
---
I found this inconsistency using the undertaker and
undertaker-checkpatch tools (https://undertaker.cs.fau.de/).

 drivers/cpufreq/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index bbc4a9f..958be2b 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -52,7 +52,6 @@ obj-$(CONFIG_ARM_DT_BL_CPUFREQ)		+= arm_big_little_dt.o
 
 obj-$(CONFIG_ARCH_DAVINCI)		+= davinci-cpufreq.o
 obj-$(CONFIG_UX500_SOC_DB8500)		+= dbx500-cpufreq.o
-obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)	+= arm-exynos-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS5440_CPUFREQ)	+= exynos5440-cpufreq.o
 obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)	+= highbank-cpufreq.o
 obj-$(CONFIG_ARM_HISI_ACPU_CPUFREQ)	+= hisi-acpu-cpufreq.o
-- 
2.5.0
