From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 4/6] PM / OPP: Move opp core to its own directory
Date: Fri,  4 Sep 2015 13:47:25 +0530
Message-ID: <e1ff2b4e101d4ce650d634e58e43887b7326c70f.1441354424.git.viresh.kumar@linaro.org>
References: <cover.1441354424.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1441354424.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1441354424.git.viresh.kumar@linaro.org>
References: <cover.1441354424.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>, Anand Moon <moon.linux@yahoo.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

OPP code is expanding and is already present in multiple directories
(cpufreq and power). Lets move it to its own directory, to manage it
better.

This also moves/renames the cpufreq_opp file to cpu.c, as it will
contain helpers for cpu device. Its not just about cpufreq, other
frameworks can use OPPs as well.

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/Makefile                             | 2 +-
 drivers/base/power/opp/Makefile                         | 2 ++
 drivers/base/power/{opp.c => opp/core.c}                | 0
 drivers/{cpufreq/cpufreq_opp.c => base/power/opp/cpu.c} | 4 +++-
 drivers/cpufreq/Makefile                                | 1 -
 5 files changed, 6 insertions(+), 3 deletions(-)
 create mode 100644 drivers/base/power/opp/Makefile
 rename drivers/base/power/{opp.c => opp/core.c} (100%)
 rename drivers/{cpufreq/cpufreq_opp.c => base/power/opp/cpu.c} (97%)

diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
index f94a6ccfe787..5998c53280f5 100644
--- a/drivers/base/power/Makefile
+++ b/drivers/base/power/Makefile
@@ -1,7 +1,7 @@
 obj-$(CONFIG_PM)	+= sysfs.o generic_ops.o common.o qos.o runtime.o wakeirq.o
 obj-$(CONFIG_PM_SLEEP)	+= main.o wakeup.o
 obj-$(CONFIG_PM_TRACE_RTC)	+= trace.o
-obj-$(CONFIG_PM_OPP)	+= opp.o
+obj-$(CONFIG_PM_OPP)	+= opp/
 obj-$(CONFIG_PM_GENERIC_DOMAINS)	+=  domain.o domain_governor.o
 obj-$(CONFIG_HAVE_CLK)	+= clock_ops.o
 
diff --git a/drivers/base/power/opp/Makefile b/drivers/base/power/opp/Makefile
new file mode 100644
index 000000000000..33c1e18c41a4
--- /dev/null
+++ b/drivers/base/power/opp/Makefile
@@ -0,0 +1,2 @@
+ccflags-$(CONFIG_DEBUG_DRIVER)	:= -DDEBUG
+obj-y				+= core.o cpu.o
diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp/core.c
similarity index 100%
rename from drivers/base/power/opp.c
rename to drivers/base/power/opp/core.c
diff --git a/drivers/cpufreq/cpufreq_opp.c b/drivers/base/power/opp/cpu.c
similarity index 97%
rename from drivers/cpufreq/cpufreq_opp.c
rename to drivers/base/power/opp/cpu.c
index 0f5e6d5f6da0..0dd033016e9d 100644
--- a/drivers/cpufreq/cpufreq_opp.c
+++ b/drivers/base/power/opp/cpu.c
@@ -1,5 +1,5 @@
 /*
- * Generic OPP helper interface for CPUFreq drivers
+ * Generic OPP helper interface for CPU device
  *
  * Copyright (C) 2009-2014 Texas Instruments Incorporated.
  *	Nishanth Menon
@@ -20,6 +20,7 @@
 #include <linux/rcupdate.h>
 #include <linux/slab.h>
 
+#ifdef CONFIG_CPU_FREQ
 /**
  * dev_pm_opp_init_cpufreq_table() - create a cpufreq table for a device
  * @dev:	device for which we do this operation
@@ -112,3 +113,4 @@ void dev_pm_opp_free_cpufreq_table(struct device *dev,
 	*table = NULL;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_free_cpufreq_table);
+#endif	/* CONFIG_CPU_FREQ */
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 60a57ca5b22d..21d1609ae8c4 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -1,6 +1,5 @@
 # CPUfreq core
 obj-$(CONFIG_CPU_FREQ)			+= cpufreq.o freq_table.o
-obj-$(CONFIG_PM_OPP)			+= cpufreq_opp.o
 
 # CPUfreq stats
 obj-$(CONFIG_CPU_FREQ_STAT)             += cpufreq_stats.o
-- 
2.4.0
