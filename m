From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 05/11] cpufreq: highbank: remove select CPU_FREQ_TABLE
Date: Wed, 12 Jun 2013 13:45:12 +0530
Message-ID: <7e4ee3926630a243a8e69835011cf9c6c4673eb9.1371022830.git.viresh.kumar@linaro.org>
References: <cover.1371022830.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1371022830.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1371022830.git.viresh.kumar@linaro.org>
References: <cover.1371022830.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com, arnd@arndb.de, Viresh Kumar <viresh.kumar@linaro.org>, Mark Langsdorf <mark.langsdorf@calxeda.com>
List-Id: linux-pm@vger.kernel.org

Highbank cpufreq driver doesn't use any APIs from freq_table.c and so must not
select CPU_FREQ_TABLE.

Cc: Mark Langsdorf <mark.langsdorf@calxeda.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/Kconfig.arm | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 9d7e209..891dd1c 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -57,7 +57,6 @@ config ARM_EXYNOS5440_CPUFREQ
 config ARM_HIGHBANK_CPUFREQ
 	tristate "Calxeda Highbank-based"
 	depends on ARCH_HIGHBANK
-	select CPU_FREQ_TABLE
 	select GENERIC_CPUFREQ_CPU0
 	select PM_OPP
 	select REGULATOR
-- 
1.7.12.rc2.18.g61b472e
