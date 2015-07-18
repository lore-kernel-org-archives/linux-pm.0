From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 3/5] cpufreq: governor: Avoid invalid states with additional checks
Date: Sat, 18 Jul 2015 11:31:01 +0530
Message-ID: <e769eeb7d8313244c72043541e67310ab292bed4.1437199001.git.viresh.kumar@linaro.org>
References: <2874468.iRvuV1Y9DI@vostro.rjw.lan>
 <cover.1437199001.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1437199001.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1437199001.git.viresh.kumar@linaro.org>
References: <cover.1437199001.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

There can be races where the request has come to a wrong state. For
example INIT followed by STOP (instead of START) or START followed by
EXIT (instead of STOP).

Tackle these races by comparing making sure the state-machine never gets
into any invalid state. And return error if an invalid state-transition
is requested.

Reviewed-and-tested-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_governor.c | 46 +++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 7ed0ec2ac853..f225dc975415 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -305,6 +305,10 @@ static int cpufreq_governor_init(struct cpufreq_policy *policy,
 	unsigned int latency;
 	int ret;
 
+	/* State should be equivalent to EXIT */
+	if (policy->governor_data)
+		return -EBUSY;
+
 	if (dbs_data) {
 		if (WARN_ON(have_governor_per_policy()))
 			return -EINVAL;
@@ -375,10 +379,15 @@ static int cpufreq_governor_init(struct cpufreq_policy *policy,
 	return ret;
 }
 
-static void cpufreq_governor_exit(struct cpufreq_policy *policy,
-				  struct dbs_data *dbs_data)
+static int cpufreq_governor_exit(struct cpufreq_policy *policy,
+				 struct dbs_data *dbs_data)
 {
 	struct common_dbs_data *cdata = dbs_data->cdata;
+	struct cpu_dbs_info *cdbs = cdata->get_cpu_cdbs(policy->cpu);
+
+	/* State should be equivalent to INIT */
+	if (!cdbs->shared || cdbs->shared->policy)
+		return -EBUSY;
 
 	policy->governor_data = NULL;
 	if (!--dbs_data->usage_count) {
@@ -395,6 +404,7 @@ static void cpufreq_governor_exit(struct cpufreq_policy *policy,
 	}
 
 	free_common_dbs_info(policy, cdata);
+	return 0;
 }
 
 static int cpufreq_governor_start(struct cpufreq_policy *policy,
@@ -409,6 +419,10 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
 	if (!policy->cur)
 		return -EINVAL;
 
+	/* State should be equivalent to INIT */
+	if (!shared || shared->policy)
+		return -EBUSY;
+
 	if (cdata->governor == GOV_CONSERVATIVE) {
 		struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 
@@ -465,14 +479,18 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
 	return 0;
 }
 
-static void cpufreq_governor_stop(struct cpufreq_policy *policy,
-				  struct dbs_data *dbs_data)
+static int cpufreq_governor_stop(struct cpufreq_policy *policy,
+				 struct dbs_data *dbs_data)
 {
 	struct common_dbs_data *cdata = dbs_data->cdata;
 	unsigned int cpu = policy->cpu;
 	struct cpu_dbs_info *cdbs = cdata->get_cpu_cdbs(cpu);
 	struct cpu_common_dbs_info *shared = cdbs->shared;
 
+	/* State should be equivalent to START */
+	if (!shared || !shared->policy)
+		return -EBUSY;
+
 	gov_cancel_work(dbs_data, policy);
 
 	if (cdata->governor == GOV_CONSERVATIVE) {
@@ -484,17 +502,19 @@ static void cpufreq_governor_stop(struct cpufreq_policy *policy,
 
 	shared->policy = NULL;
 	mutex_destroy(&shared->timer_mutex);
+	return 0;
 }
 
-static void cpufreq_governor_limits(struct cpufreq_policy *policy,
-				    struct dbs_data *dbs_data)
+static int cpufreq_governor_limits(struct cpufreq_policy *policy,
+				   struct dbs_data *dbs_data)
 {
 	struct common_dbs_data *cdata = dbs_data->cdata;
 	unsigned int cpu = policy->cpu;
 	struct cpu_dbs_info *cdbs = cdata->get_cpu_cdbs(cpu);
 
+	/* State should be equivalent to START */
 	if (!cdbs->shared || !cdbs->shared->policy)
-		return;
+		return -EBUSY;
 
 	mutex_lock(&cdbs->shared->timer_mutex);
 	if (policy->max < cdbs->shared->policy->cur)
@@ -505,13 +525,15 @@ static void cpufreq_governor_limits(struct cpufreq_policy *policy,
 					CPUFREQ_RELATION_L);
 	dbs_check_cpu(dbs_data, cpu);
 	mutex_unlock(&cdbs->shared->timer_mutex);
+
+	return 0;
 }
 
 int cpufreq_governor_dbs(struct cpufreq_policy *policy,
 			 struct common_dbs_data *cdata, unsigned int event)
 {
 	struct dbs_data *dbs_data;
-	int ret = 0;
+	int ret;
 
 	/* Lock governor to block concurrent initialization of governor */
 	mutex_lock(&cdata->mutex);
@@ -531,17 +553,19 @@ int cpufreq_governor_dbs(struct cpufreq_policy *policy,
 		ret = cpufreq_governor_init(policy, dbs_data, cdata);
 		break;
 	case CPUFREQ_GOV_POLICY_EXIT:
-		cpufreq_governor_exit(policy, dbs_data);
+		ret = cpufreq_governor_exit(policy, dbs_data);
 		break;
 	case CPUFREQ_GOV_START:
 		ret = cpufreq_governor_start(policy, dbs_data);
 		break;
 	case CPUFREQ_GOV_STOP:
-		cpufreq_governor_stop(policy, dbs_data);
+		ret = cpufreq_governor_stop(policy, dbs_data);
 		break;
 	case CPUFREQ_GOV_LIMITS:
-		cpufreq_governor_limits(policy, dbs_data);
+		ret = cpufreq_governor_limits(policy, dbs_data);
 		break;
+	default:
+		ret = -EINVAL;
 	}
 
 unlock:
-- 
2.4.0
