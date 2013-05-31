From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 07/15] cpufreq: spear needs cpufreq table
Date: Sat,  1 Jun 2013 00:22:44 +0200
Message-ID: <1370038972-2318779-8-git-send-email-arnd@arndb.de>
References: <1370038972-2318779-1-git-send-email-arnd@arndb.de>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1370038972-2318779-1-git-send-email-arnd@arndb.de>
Sender: cpufreq-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: patches@lists.linaro.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Like a lot of the other cpufreq drivers, this one needs to
select CONFIG_CPU_FREQ_TABLE to avoid a build error like

drivers/built-in.o: In function `spear_cpufreq_exit':
spear-cpufreq.c:198: undefined reference to `cpufreq_frequency_table_put_attr'
drivers/built-in.o: In function `spear_cpufreq_verify':
spear-cpufreq.c:35: undefined reference to `cpufreq_frequency_table_verify'
drivers/built-in.o: In function `spear_cpufreq_init':
spear-cpufreq.c:181: undefined reference to `cpufreq_frequency_table_cpuinfo'
spear-cpufreq.c:187: undefined reference to `cpufreq_frequency_table_get_attr'
drivers/built-in.o: In function `spear_cpufreq_target':
spear-cpufreq.c:120: undefined reference to `cpufreq_frequency_table_target'
drivers/built-in.o:(.data+0x5e63c): undefined reference to `cpufreq_freq_attr_scaling_available_freqs'

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: cpufreq@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 drivers/cpufreq/Kconfig.arm | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index a924408..d3f2c6b 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -205,6 +205,7 @@ config ARM_SA1110_CPUFREQ
 config ARM_SPEAR_CPUFREQ
 	bool "SPEAr CPUFreq support"
 	depends on PLAT_SPEAR
+	select CPU_FREQ_TABLE
 	default y
 	help
 	  This adds the CPUFreq driver support for SPEAr SOCs.
-- 
1.8.1.2

