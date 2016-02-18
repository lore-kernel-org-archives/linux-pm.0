From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 3/12] cpufreq: governor: Add a ->start callback for governors
Date: Thu, 18 Feb 2016 02:21:21 +0100
Message-ID: <2775883.CEf9mEMdYv@vostro.rjw.lan>
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

To avoid having to check the governor type explicitly in the common
code in order to initialize data structures specific to the governor
type properly, add a ->start callback to struct dbs_governor and
use it to initialize those data structures for the ondemand and
conservative governors.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_conservative.c |    9 +++++++++
 drivers/cpufreq/cpufreq_governor.c     |   16 ++--------------
 drivers/cpufreq/cpufreq_governor.h     |    1 +
 drivers/cpufreq/cpufreq_ondemand.c     |   10 ++++++++++
 4 files changed, 22 insertions(+), 14 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -517,7 +517,7 @@ static int cpufreq_governor_start(struct
 	struct dbs_governor *gov = dbs_governor_of(policy);
 	struct policy_dbs_info *policy_dbs = policy->governor_data;
 	struct dbs_data *dbs_data = policy_dbs->dbs_data;
-	unsigned int sampling_rate, ignore_nice, j, cpu = policy->cpu;
+	unsigned int sampling_rate, ignore_nice, j;
 	unsigned int io_busy;
 
 	if (!policy->cur)
@@ -543,19 +543,7 @@ static int cpufreq_governor_start(struct
 			j_cdbs->prev_cpu_nice = kcpustat_cpu(j).cpustat[CPUTIME_NICE];
 	}
 
-	if (gov->governor == GOV_CONSERVATIVE) {
-		struct cs_cpu_dbs_info_s *cs_dbs_info =
-			gov->get_cpu_dbs_info_s(cpu);
-
-		cs_dbs_info->down_skip = 0;
-		cs_dbs_info->requested_freq = policy->cur;
-	} else {
-		struct od_ops *od_ops = gov->gov_ops;
-		struct od_cpu_dbs_info_s *od_dbs_info = gov->get_cpu_dbs_info_s(cpu);
-
-		od_dbs_info->sample_type = OD_NORMAL_SAMPLE;
-		od_ops->powersave_bias_init_cpu(cpu);
-	}
+	gov->start(policy);
 
 	gov_set_update_util(policy_dbs, sampling_rate);
 	return 0;
Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
+++ linux-pm/drivers/cpufreq/cpufreq_governor.h
@@ -205,6 +205,7 @@ struct dbs_governor {
 	unsigned int (*gov_dbs_timer)(struct cpufreq_policy *policy);
 	int (*init)(struct dbs_data *dbs_data, bool notify);
 	void (*exit)(struct dbs_data *dbs_data, bool notify);
+	void (*start)(struct cpufreq_policy *policy);
 
 	/* Governor specific ops, see below */
 	void *gov_ops;
Index: linux-pm/drivers/cpufreq/cpufreq_ondemand.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_ondemand.c
+++ linux-pm/drivers/cpufreq/cpufreq_ondemand.c
@@ -410,6 +410,15 @@ static void od_exit(struct dbs_data *dbs
 	kfree(dbs_data->tuners);
 }
 
+static void od_start(struct cpufreq_policy *policy)
+{
+	unsigned int cpu = policy->cpu;
+	struct od_cpu_dbs_info_s *dbs_info = &per_cpu(od_cpu_dbs_info, cpu);
+
+	dbs_info->sample_type = OD_NORMAL_SAMPLE;
+	od_ops.powersave_bias_init_cpu(cpu);
+}
+
 define_get_cpu_dbs_routines(od_cpu_dbs_info);
 
 static struct od_ops od_ops = {
@@ -432,6 +441,7 @@ static struct dbs_governor od_dbs_gov =
 	.gov_ops = &od_ops,
 	.init = od_init,
 	.exit = od_exit,
+	.start = od_start,
 };
 
 #define CPU_FREQ_GOV_ONDEMAND	(&od_dbs_gov.gov)
Index: linux-pm/drivers/cpufreq/cpufreq_conservative.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_conservative.c
+++ linux-pm/drivers/cpufreq/cpufreq_conservative.c
@@ -279,6 +279,14 @@ static void cs_exit(struct dbs_data *dbs
 	kfree(dbs_data->tuners);
 }
 
+static void cs_start(struct cpufreq_policy *policy)
+{
+	struct cs_cpu_dbs_info_s *dbs_info = &per_cpu(cs_cpu_dbs_info, policy->cpu);
+
+	dbs_info->down_skip = 0;
+	dbs_info->requested_freq = policy->cur;
+}
+
 define_get_cpu_dbs_routines(cs_cpu_dbs_info);
 
 static struct dbs_governor cs_dbs_gov = {
@@ -295,6 +303,7 @@ static struct dbs_governor cs_dbs_gov =
 	.gov_dbs_timer = cs_dbs_timer,
 	.init = cs_init,
 	.exit = cs_exit,
+	.start = cs_start,
 };
 
 #define CPU_FREQ_GOV_CONSERVATIVE	(&cs_dbs_gov.gov)
