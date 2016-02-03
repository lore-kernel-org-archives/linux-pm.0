From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 4/11] cpufreq: governor: Avoid passing dbs_data pointers around unnecessarily
Date: Thu, 04 Feb 2016 00:29:55 +0100
Message-ID: <3165106.aK3R20pXGV@vostro.rjw.lan>
References: <3705929.bslqXH980s@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3705929.bslqXH980s@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Do not pass struct dbs_data pointers to the family of functions
implementing governor operations in cpufreq_governor.c as they can
take that pointer from policy->governor by themselves.

The cpufreq_governor_init() case is slightly more complicated, since
policy->governor may be NULL when it is invoked, but then it can use
global_dbs_data directly just fine.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_governor.c |   74 +++++++++++++++----------------------
 1 file changed, 30 insertions(+), 44 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -330,9 +330,9 @@ static void free_common_dbs_info(struct
 }
 
 static int cpufreq_governor_init(struct cpufreq_policy *policy,
-				 struct dbs_data *dbs_data,
 				 struct common_dbs_data *cdata)
 {
+	struct dbs_data *dbs_data;
 	unsigned int latency;
 	int ret;
 
@@ -340,7 +340,7 @@ static int cpufreq_governor_init(struct
 	if (policy->governor_data)
 		return -EBUSY;
 
-	if (dbs_data) {
+	if (global_dbs_data) {
 		if (WARN_ON(have_governor_per_policy()))
 			return -EINVAL;
 
@@ -348,8 +348,8 @@ static int cpufreq_governor_init(struct
 		if (ret)
 			return ret;
 
-		dbs_data->usage_count++;
-		policy->governor_data = dbs_data;
+		global_dbs_data->usage_count++;
+		policy->governor_data = global_dbs_data;
 		return 0;
 	}
 
@@ -401,9 +401,9 @@ free_dbs_data:
 	return ret;
 }
 
-static int cpufreq_governor_exit(struct cpufreq_policy *policy,
-				 struct dbs_data *dbs_data)
+static int cpufreq_governor_exit(struct cpufreq_policy *policy)
 {
+	struct dbs_data *dbs_data = policy->governor_data;
 	struct common_dbs_data *cdata = dbs_data->cdata;
 	struct cpu_dbs_info *cdbs = cdata->get_cpu_cdbs(policy->cpu);
 
@@ -430,9 +430,9 @@ static int cpufreq_governor_exit(struct
 	return 0;
 }
 
-static int cpufreq_governor_start(struct cpufreq_policy *policy,
-				  struct dbs_data *dbs_data)
+static int cpufreq_governor_start(struct cpufreq_policy *policy)
 {
+	struct dbs_data *dbs_data = policy->governor_data;
 	struct common_dbs_data *cdata = dbs_data->cdata;
 	unsigned int sampling_rate, ignore_nice, j, cpu = policy->cpu;
 	struct cpu_dbs_info *cdbs = cdata->get_cpu_cdbs(cpu);
@@ -498,9 +498,9 @@ static int cpufreq_governor_start(struct
 	return 0;
 }
 
-static int cpufreq_governor_stop(struct cpufreq_policy *policy,
-				 struct dbs_data *dbs_data)
+static int cpufreq_governor_stop(struct cpufreq_policy *policy)
 {
+	struct dbs_data *dbs_data = policy->governor_data;
 	struct cpu_dbs_info *cdbs = dbs_data->cdata->get_cpu_cdbs(policy->cpu);
 	struct cpu_common_dbs_info *shared = cdbs->shared;
 
@@ -514,9 +514,9 @@ static int cpufreq_governor_stop(struct
 	return 0;
 }
 
-static int cpufreq_governor_limits(struct cpufreq_policy *policy,
-				   struct dbs_data *dbs_data)
+static int cpufreq_governor_limits(struct cpufreq_policy *policy)
 {
+	struct dbs_data *dbs_data = policy->governor_data;
 	struct common_dbs_data *cdata = dbs_data->cdata;
 	unsigned int cpu = policy->cpu;
 	struct cpu_dbs_info *cdbs = cdata->get_cpu_cdbs(cpu);
@@ -541,45 +541,31 @@ static int cpufreq_governor_limits(struc
 int cpufreq_governor_dbs(struct cpufreq_policy *policy,
 			 struct common_dbs_data *cdata, unsigned int event)
 {
-	struct dbs_data *dbs_data;
-	int ret;
+	int ret = -EINVAL;
 
 	/* Lock governor to block concurrent initialization of governor */
 	mutex_lock(&dbs_data_mutex);
 
-	if (have_governor_per_policy())
-		dbs_data = policy->governor_data;
-	else
-		dbs_data = global_dbs_data;
-
-	if (!dbs_data && (event != CPUFREQ_GOV_POLICY_INIT)) {
-		ret = -EINVAL;
-		goto unlock;
+	if (event == CPUFREQ_GOV_POLICY_INIT) {
+		ret = cpufreq_governor_init(policy, cdata);
+	} else if (policy->governor_data) {
+		switch (event) {
+		case CPUFREQ_GOV_POLICY_EXIT:
+			ret = cpufreq_governor_exit(policy);
+			break;
+		case CPUFREQ_GOV_START:
+			ret = cpufreq_governor_start(policy);
+			break;
+		case CPUFREQ_GOV_STOP:
+			ret = cpufreq_governor_stop(policy);
+			break;
+		case CPUFREQ_GOV_LIMITS:
+			ret = cpufreq_governor_limits(policy);
+			break;
+		}
 	}
 
-	switch (event) {
-	case CPUFREQ_GOV_POLICY_INIT:
-		ret = cpufreq_governor_init(policy, dbs_data, cdata);
-		break;
-	case CPUFREQ_GOV_POLICY_EXIT:
-		ret = cpufreq_governor_exit(policy, dbs_data);
-		break;
-	case CPUFREQ_GOV_START:
-		ret = cpufreq_governor_start(policy, dbs_data);
-		break;
-	case CPUFREQ_GOV_STOP:
-		ret = cpufreq_governor_stop(policy, dbs_data);
-		break;
-	case CPUFREQ_GOV_LIMITS:
-		ret = cpufreq_governor_limits(policy, dbs_data);
-		break;
-	default:
-		ret = -EINVAL;
-	}
-
-unlock:
 	mutex_unlock(&dbs_data_mutex);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(cpufreq_governor_dbs);
