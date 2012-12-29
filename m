From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH V2] Fix problem with cpufreq_ondemand or cpufreq_conservative
Date: Fri, 28 Dec 2012 18:21:33 -0600
Message-ID: <50DE378D.4090008@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: viresh kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Since commit 2aacdff entitled "cpufreq: Move common part from governors to separate file", whenever the drivers that 
depend on this new file (cpufreq_ondemand or cpufreq_conservative) are built as modules, a new module named 
cpufreq_governor is created. It seems that kmake is smart enough to create a separate module whenever more than one 
module includes the same object file. As drivers/cpufreq/cpufreq_governor.c contains no MODULE directives, the resulting 
module has no license specified, which results in logging of a "module license 'unspecified' taints kernel". In 
addition, a number of globals are exported GPL only, and are therefore not available.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---

V2 is the more complicated version that makes clear what is happening.

Larry
---

  Kconfig            |    5 +++++
  Makefile           |    5 +++--
  cpufreq_governor.c |    5 +++++
  3 files changed, 13 insertions(+), 2 deletions(-)
---

Index: wireless-testing-new/drivers/cpufreq/Makefile
===================================================================
--- wireless-testing-new.orig/drivers/cpufreq/Makefile
+++ wireless-testing-new/drivers/cpufreq/Makefile
@@ -7,8 +7,9 @@ obj-$(CONFIG_CPU_FREQ_STAT)
  obj-$(CONFIG_CPU_FREQ_GOV_PERFORMANCE)	+= cpufreq_performance.o
  obj-$(CONFIG_CPU_FREQ_GOV_POWERSAVE)	+= cpufreq_powersave.o
  obj-$(CONFIG_CPU_FREQ_GOV_USERSPACE)	+= cpufreq_userspace.o
-obj-$(CONFIG_CPU_FREQ_GOV_ONDEMAND)	+= cpufreq_ondemand.o cpufreq_governor.o
-obj-$(CONFIG_CPU_FREQ_GOV_CONSERVATIVE)	+= cpufreq_conservative.o cpufreq_governor.o
+obj-$(CONFIG_CPU_FREQ_GOV_ONDEMAND)	+= cpufreq_ondemand.o
+obj-$(CONFIG_CPU_FREQ_GOV_CONSERVATIVE)	+= cpufreq_conservative.o
+obj-$(CONFIG_CPU_FREQ_GOVERNOR)		+= cpufreq_governor.o

  # CPUfreq cross-arch helpers
  obj-$(CONFIG_CPU_FREQ_TABLE)		+= freq_table.o
Index: wireless-testing-new/drivers/cpufreq/Kconfig
===================================================================
--- wireless-testing-new.orig/drivers/cpufreq/Kconfig
+++ wireless-testing-new/drivers/cpufreq/Kconfig
@@ -20,6 +20,9 @@ if CPU_FREQ
  config CPU_FREQ_TABLE
  	tristate

+config CPU_FREQ_GOVERNOR
+	tristate
+
  config CPU_FREQ_STAT
  	tristate "CPU frequency translation statistics"
  	select CPU_FREQ_TABLE
@@ -141,6 +144,7 @@ config CPU_FREQ_GOV_USERSPACE
  config CPU_FREQ_GOV_ONDEMAND
  	tristate "'ondemand' cpufreq policy governor"
  	select CPU_FREQ_TABLE
+	select CPU_FREQ_GOVERNOR
  	help
  	  'ondemand' - This driver adds a dynamic cpufreq policy governor.
  	  The governor does a periodic polling and
@@ -159,6 +163,7 @@ config CPU_FREQ_GOV_ONDEMAND
  config CPU_FREQ_GOV_CONSERVATIVE
  	tristate "'conservative' cpufreq governor"
  	depends on CPU_FREQ
+	select CPU_FREQ_GOVERNOR
  	help
  	  'conservative' - this driver is rather similar to the 'ondemand'
  	  governor both in its source code and its purpose, the difference is
Index: wireless-testing-new/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- wireless-testing-new.orig/drivers/cpufreq/cpufreq_governor.c
+++ wireless-testing-new/drivers/cpufreq/cpufreq_governor.c
@@ -316,3 +316,8 @@ second_time:
  	return 0;
  }
  EXPORT_SYMBOL_GPL(cpufreq_governor_dbs);
+
+MODULE_AUTHOR("Alexander Clouter <alex@digriz.org.uk>");
+MODULE_DESCRIPTION("'cpufreq_governor' - A mini-module containing common code "
+		   "for cpufreq_conservative and cpufreq_ondemand");
+MODULE_LICENSE("GPL");
