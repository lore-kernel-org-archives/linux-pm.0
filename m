From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 07/11] cpufreq: powerpc: CBE_RAS: select CPU_FREQ_TABLE
Date: Wed, 12 Jun 2013 13:45:14 +0530
Message-ID: <601f678e73c3a5fbcc392ac480a2d12b155d0485.1371022830.git.viresh.kumar@linaro.org>
References: <cover.1371022830.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1371022830.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1371022830.git.viresh.kumar@linaro.org>
References: <cover.1371022830.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com, arnd@arndb.de, Viresh Kumar <viresh.kumar@linaro.org>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-pm@vger.kernel.org

CPUFreq driver of this platform uses APIs from freq_table.c and so must select
CPU_FREQ_TABLE.

Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/Kconfig.powerpc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/Kconfig.powerpc b/drivers/cpufreq/Kconfig.powerpc
index 9c926ca..68c1abc 100644
--- a/drivers/cpufreq/Kconfig.powerpc
+++ b/drivers/cpufreq/Kconfig.powerpc
@@ -1,6 +1,7 @@
 config CPU_FREQ_CBE
 	tristate "CBE frequency scaling"
 	depends on CBE_RAS && PPC_CELL
+	select CPU_FREQ_TABLE
 	default m
 	help
 	  This adds the cpufreq driver for Cell BE processors.
-- 
1.7.12.rc2.18.g61b472e
