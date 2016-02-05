From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2 2/10] cpufreq: governor: Use common mutex for dbs_data protection
Date: Fri, 05 Feb 2016 03:14:16 +0100
Message-ID: <76588769.1gWBaNHTiQ@vostro.rjw.lan>
References: <3705929.bslqXH980s@vostro.rjw.lan> <9008098.QDD8C89zDx@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9008098.QDD8C89zDx@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Every governor relying on the common code in cpufreq_governor.c
has to provide its own mutex in struct common_dbs_data.  However,
there actually is no need to have a separate mutex per governor
for this purpose, they may be using the same global mutex just
fine.  Accordingly, introduce a single common mutex for that and
drop the mutex field from struct common_dbs_data.

That at least will ensure that the mutex is always present and
initialized regardless of what the particular governors do.

Another benefit is that the common code does not need a pointer to
a governor-related structure to get to the mutex which sometimes
helps.

Finally, it makes the code generally easier to follow.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Saravana Kannan <skannan@codeaurora.org>
---
 drivers/cpufreq/cpufreq_conservative.c |    1 -
 drivers/cpufreq/cpufreq_governor.c     |    7 +++++--
 drivers/cpufreq/cpufreq_governor.h     |    6 +-----
 drivers/cpufreq/cpufreq_ondemand.c     |    5 ++---
 4 files changed, 8 insertions(+), 11 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -22,6 +22,9 @@
 
 #include "cpufreq_governor.h"
 
+DEFINE_MUTEX(dbs_data_mutex);
+EXPORT_SYMBOL_GPL(dbs_data_mutex);
+
 static struct attribute_group *get_sysfs_attr(struct dbs_data *dbs_data)
 {
 	if (have_governor_per_policy())
@@ -541,7 +544,7 @@ int cpufreq_governor_dbs(struct cpufreq_
 	int ret;
 
 	/* Lock governor to block concurrent initialization of governor */
-	mutex_lock(&cdata->mutex);
+	mutex_lock(&dbs_data_mutex);
 
 	if (have_governor_per_policy())
 		dbs_data = policy->governor_data;
@@ -574,7 +577,7 @@ int cpufreq_governor_dbs(struct cpufreq_
 	}
 
 unlock:
-	mutex_unlock(&cdata->mutex);
+	mutex_unlock(&dbs_data_mutex);
 
 	return ret;
 }
Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
+++ linux-pm/drivers/cpufreq/cpufreq_governor.h
@@ -225,11 +225,6 @@ struct common_dbs_data {
 
 	/* Governor specific ops, see below */
 	void *gov_ops;
-
-	/*
-	 * Protects governor's data (struct dbs_data and struct common_dbs_data)
-	 */
-	struct mutex mutex;
 };
 
 /* Governor Per policy data */
@@ -274,6 +269,7 @@ static ssize_t show_sampling_rate_min_go
 	return sprintf(buf, "%u\n", dbs_data->min_sampling_rate);	\
 }
 
+extern struct mutex dbs_data_mutex;
 extern struct mutex cpufreq_governor_lock;
 void gov_set_update_util(struct cpu_common_dbs_info *shared,
 			 unsigned int delay_us);
Index: linux-pm/drivers/cpufreq/cpufreq_ondemand.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_ondemand.c
+++ linux-pm/drivers/cpufreq/cpufreq_ondemand.c
@@ -249,7 +249,7 @@ static void update_sampling_rate(struct
 	/*
 	 * Lock governor so that governor start/stop can't execute in parallel.
 	 */
-	mutex_lock(&od_dbs_cdata.mutex);
+	mutex_lock(&dbs_data_mutex);
 
 	cpumask_copy(&cpumask, cpu_online_mask);
 
@@ -302,7 +302,7 @@ static void update_sampling_rate(struct
 		}
 	}
 
-	mutex_unlock(&od_dbs_cdata.mutex);
+	mutex_unlock(&dbs_data_mutex);
 }
 
 static ssize_t store_sampling_rate(struct dbs_data *dbs_data, const char *buf,
@@ -548,7 +548,6 @@ static struct common_dbs_data od_dbs_cda
 	.gov_ops = &od_ops,
 	.init = od_init,
 	.exit = od_exit,
-	.mutex = __MUTEX_INITIALIZER(od_dbs_cdata.mutex),
 };
 
 static int od_cpufreq_governor_dbs(struct cpufreq_policy *policy,
Index: linux-pm/drivers/cpufreq/cpufreq_conservative.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_conservative.c
+++ linux-pm/drivers/cpufreq/cpufreq_conservative.c
@@ -368,7 +368,6 @@ static struct common_dbs_data cs_dbs_cda
 	.gov_check_cpu = cs_check_cpu,
 	.init = cs_init,
 	.exit = cs_exit,
-	.mutex = __MUTEX_INITIALIZER(cs_dbs_cdata.mutex),
 };
 
 static int cs_cpufreq_governor_dbs(struct cpufreq_policy *policy,
