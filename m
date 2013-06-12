From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 01/11] cpufreq: blackfin: enable driver for CONFIG_BFIN_CPU_FREQ
Date: Wed, 12 Jun 2013 13:45:08 +0530
Message-ID: <257a5d42e71bcec9fa9c8d09e1ad2c781db7c083.1371022830.git.viresh.kumar@linaro.org>
References: <cover.1371022830.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1371022830.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1371022830.git.viresh.kumar@linaro.org>
References: <cover.1371022830.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com, arnd@arndb.de, Viresh Kumar <viresh.kumar@linaro.org>, Steven Miao <realmz6@gmail.com>, uclinux-dist-devel@blackfin.uclinux.org
List-Id: linux-pm@vger.kernel.org

By mistake blackfin's cpufreq driver is enabled when CONFIG_BLACKFIN was
present, whereas it should have been enabled only when CONFIG_BFIN_CPU_FREQ is
present.

Fix it.

Cc: Steven Miao <realmz6@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 315b923..13c3f83 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -83,7 +83,7 @@ obj-$(CONFIG_CPU_FREQ_MAPLE)		+= maple-cpufreq.o
 ##################################################################################
 # Other platform drivers
 obj-$(CONFIG_AVR32_AT32AP_CPUFREQ)	+= at32ap-cpufreq.o
-obj-$(CONFIG_BLACKFIN)			+= blackfin-cpufreq.o
+obj-$(CONFIG_BFIN_CPU_FREQ)		+= blackfin-cpufreq.o
 obj-$(CONFIG_CRIS_MACH_ARTPEC3)		+= cris-artpec3-cpufreq.o
 obj-$(CONFIG_ETRAXFS)			+= cris-etraxfs-cpufreq.o
 obj-$(CONFIG_IA64_ACPI_CPUFREQ)		+= ia64-acpi-cpufreq.o
-- 
1.7.12.rc2.18.g61b472e

