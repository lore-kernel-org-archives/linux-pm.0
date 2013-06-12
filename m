From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 09/11] cpufreq: S3C2416/S3C64XX: select CPU_FREQ_TABLE
Date: Wed, 12 Jun 2013 13:45:16 +0530
Message-ID: <2bac52af214503f7678288c8a1372915190621da.1371022830.git.viresh.kumar@linaro.org>
References: <cover.1371022830.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1371022830.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1371022830.git.viresh.kumar@linaro.org>
References: <cover.1371022830.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com, arnd@arndb.de, Viresh Kumar <viresh.kumar@linaro.org>, Heiko Stuebner <heiko@sntech.de>
List-Id: linux-pm@vger.kernel.org

CPUFreq driver of this platform uses APIs from freq_table.c and so must select
CPU_FREQ_TABLE.

Cc: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/Kconfig.arm | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index dc26303..d52261b 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -101,6 +101,7 @@ config ARM_OMAP2PLUS_CPUFREQ
 config ARM_S3C2416_CPUFREQ
 	bool "S3C2416 CPU Frequency scaling support"
 	depends on CPU_S3C2416
+	select CPU_FREQ_TABLE
 	help
 	  This adds the CPUFreq driver for the Samsung S3C2416 and
 	  S3C2450 SoC. The S3C2416 supports changing the rate of the
@@ -123,6 +124,7 @@ config ARM_S3C2416_CPUFREQ_VCORESCALE
 config ARM_S3C64XX_CPUFREQ
 	bool "Samsung S3C64XX"
 	depends on CPU_S3C6410
+	select CPU_FREQ_TABLE
 	default y
 	help
 	  This adds the CPUFreq driver for Samsung S3C6410 SoC.
-- 
1.7.12.rc2.18.g61b472e
