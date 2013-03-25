From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 7/9] unicore2: cpufreq:  move cpufreq driver to drivers/cpufreq
Date: Mon, 25 Mar 2013 22:24:43 +0530
Message-ID: <27c30dd79c668dc3471d37fce2c83a4504d8b18c.1364229828.git.viresh.kumar@linaro.org>
References: <cover.1364229828.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1364229828.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1364229828.git.viresh.kumar@linaro.org>
References: <cover.1364229828.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: arvind.chauhan@arm.com, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, arnd.bergmann@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>
List-Id: linux-pm@vger.kernel.org

This patch moves cpufreq driver of UNICORE-2 architecture to drivers/cpufreq.

Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/unicore32/kernel/Makefile                                         | 1 -
 drivers/cpufreq/Makefile                                               | 1 +
 arch/unicore32/kernel/cpu-ucv2.c => drivers/cpufreq/unicore2-cpufreq.c | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/unicore32/kernel/cpu-ucv2.c => drivers/cpufreq/unicore2-cpufreq.c (96%)

diff --git a/arch/unicore32/kernel/Makefile b/arch/unicore32/kernel/Makefile
index fa497e0..607a72f 100644
--- a/arch/unicore32/kernel/Makefile
+++ b/arch/unicore32/kernel/Makefile
@@ -9,7 +9,6 @@ obj-y				+= setup.o signal.o sys.o stacktrace.o traps.o
 obj-$(CONFIG_MODULES)		+= ksyms.o module.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
-obj-$(CONFIG_CPU_FREQ)		+= cpu-ucv2.o
 obj-$(CONFIG_UNICORE_FPU_F64)	+= fpu-ucf64.o
 
 # obj-y for architecture PKUnity v3
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index e572211..ab3a054 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -85,3 +85,4 @@ obj-$(CONFIG_ETRAXFS)			+= cris-etraxfs-cpufreq.o
 obj-$(CONFIG_IA64_ACPI_CPUFREQ)		+= ia64-acpi-cpufreq.o
 obj-$(CONFIG_LOONGSON2_CPUFREQ)		+= loongson2_cpufreq.o
 obj-$(CONFIG_SH_CPU_FREQ)		+= sh-cpufreq.o
+obj-$(CONFIG_UNICORE32)			+= unicore2-cpufreq.o
diff --git a/arch/unicore32/kernel/cpu-ucv2.c b/drivers/cpufreq/unicore2-cpufreq.c
similarity index 96%
rename from arch/unicore32/kernel/cpu-ucv2.c
rename to drivers/cpufreq/unicore2-cpufreq.c
index ba5a71c..12fc904 100644
--- a/arch/unicore32/kernel/cpu-ucv2.c
+++ b/drivers/cpufreq/unicore2-cpufreq.c
@@ -1,5 +1,5 @@
 /*
- * linux/arch/unicore32/kernel/cpu-ucv2.c: clock scaling for the UniCore-II
+ * clock scaling for the UniCore-II
  *
  * Code specific to PKUnity SoC and UniCore ISA
  *
-- 
1.7.12.rc2.18.g61b472e
