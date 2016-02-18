From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 11/12] cpufreq: governor: Make dbs_data_mutex static
Date: Thu, 18 Feb 2016 02:33:43 +0100
Message-ID: <1655404.H6dIaK3J3n@vostro.rjw.lan>
References: <2938006.67J0esUvOA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2938006.67J0esUvOA@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

That mutex is only used by cpufreq_governor_dbs() and it doesn't
need to be exported to modules, so make it static and drop the
export incantation.

No functional changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_governor.c |    3 +--
 drivers/cpufreq/cpufreq_governor.h |    1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -24,8 +24,7 @@
 
 static DEFINE_PER_CPU(struct cpu_dbs_info, cpu_dbs);
 
-DEFINE_MUTEX(dbs_data_mutex);
-EXPORT_SYMBOL_GPL(dbs_data_mutex);
+static DEFINE_MUTEX(dbs_data_mutex);
 
 /* Common sysfs tunables */
 /**
Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
+++ linux-pm/drivers/cpufreq/cpufreq_governor.h
@@ -178,7 +178,6 @@ struct od_ops {
 			unsigned int freq_next, unsigned int relation);
 };
 
-extern struct mutex dbs_data_mutex;
 unsigned int dbs_update(struct cpufreq_policy *policy);
 int cpufreq_governor_dbs(struct cpufreq_policy *policy, unsigned int event);
 void od_register_powersave_bias_handler(unsigned int (*f)
