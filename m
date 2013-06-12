From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 11/11] cpufreq: X86_AMD_FREQ_SENSITIVITY: select CPU_FREQ_TABLE
Date: Wed, 12 Jun 2013 13:45:18 +0530
Message-ID: <3f143e3112c038c805ea4e66ea91d12c5800acdf.1371022830.git.viresh.kumar@linaro.org>
References: <cover.1371022830.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1371022830.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1371022830.git.viresh.kumar@linaro.org>
References: <cover.1371022830.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com, arnd@arndb.de, Viresh Kumar <viresh.kumar@linaro.org>, Jacob Shin <jacob.shin@amd.com>
List-Id: linux-pm@vger.kernel.org

This CPUFreq driver uses APIs from freq_table.c and so must select
CPU_FREQ_TABLE.

Cc: Jacob Shin <jacob.shin@amd.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/Kconfig.x86 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index 6bd63d6..e2b6eab 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -132,6 +132,7 @@ config X86_POWERNOW_K8
 config X86_AMD_FREQ_SENSITIVITY
 	tristate "AMD frequency sensitivity feedback powersave bias"
 	depends on CPU_FREQ_GOV_ONDEMAND && X86_ACPI_CPUFREQ && CPU_SUP_AMD
+	select CPU_FREQ_TABLE
 	help
 	  This adds AMD-specific powersave bias function to the ondemand
 	  governor, which allows it to make more power-conscious frequency
-- 
1.7.12.rc2.18.g61b472e
