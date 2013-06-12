From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 04/11] cpufreq: exynos: select CPU_FREQ_TABLE
Date: Wed, 12 Jun 2013 13:45:11 +0530
Message-ID: <48f50fccfbfb6944336f49bf757798c99eb6e91c.1371022830.git.viresh.kumar@linaro.org>
References: <cover.1371022830.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1371022830.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1371022830.git.viresh.kumar@linaro.org>
References: <cover.1371022830.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com, arnd@arndb.de, Viresh Kumar <viresh.kumar@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>
List-Id: linux-pm@vger.kernel.org

CPUFreq driver of this platform uses APIs from freq_table.c and so must select
CPU_FREQ_TABLE.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/Kconfig.arm | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 6e57543..9d7e209 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -18,6 +18,7 @@ config ARM_DT_BL_CPUFREQ
 config ARM_EXYNOS_CPUFREQ
 	bool "SAMSUNG EXYNOS SoCs"
 	depends on ARCH_EXYNOS
+	select CPU_FREQ_TABLE
 	default y
 	help
 	  This adds the CPUFreq driver common part for Samsung
@@ -46,6 +47,7 @@ config ARM_EXYNOS5250_CPUFREQ
 config ARM_EXYNOS5440_CPUFREQ
 	def_bool SOC_EXYNOS5440
 	depends on HAVE_CLK && PM_OPP && OF
+	select CPU_FREQ_TABLE
 	help
 	  This adds the CPUFreq driver for Samsung EXYNOS5440
 	  SoC. The nature of exynos5440 clock controller is
-- 
1.7.12.rc2.18.g61b472e
