From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 08/10] cpufreq: governor: Avoid invalid states with additional checks
Date: Fri, 19 Jun 2015 17:18:08 +0530
Message-ID: <2c24de3653ffb3c48a5dfcfb9ea52a753456481a.1434713657.git.viresh.kumar@linaro.org>
References: <cover.1434713657.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33652 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbbFSLs6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jun 2015 07:48:58 -0400
Received: by padev16 with SMTP id ev16so83994203pad.0
        for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2015 04:48:58 -0700 (PDT)
In-Reply-To: <cover.1434713657.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1434713657.git.viresh.kumar@linaro.org>
References: <cover.1434713657.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, ke.wang@spreadtrum.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

There can be races where the request has come to a wrong state. For
example INIT followed by STOP (instead of START) or START followed by
EXIT (instead of STOP).

Tackle these races by comparing making sure the state-machine never gets
into any invalid state. And return error if an invalid state-transition
is requested.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_governor.c | 46 +++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 441150dea078..8d4c86fa43ec 100644
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
+	if (!cdbs->ccdbs || cdbs->ccdbs->policy)
+		return -EBUSY;
 
 	policy->governor_data = NULL;
 	if (!--dbs_data->usage_count) {
@@ -395,6 +404,7 @@ static void cpufreq_governor_exit(struct cpufreq_policy *policy,
 	}
 
 	free_ccdbs(policy, cdata);
+	return 0;
 }
 
 static int cpufreq_governor_start(struct cpufreq_policy *policy,
@@ -409,6 +419,10 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
 	if (!policy->cur)
 		return -EINVAL;
 
+	/* State should be equivalent to INIT */
+	if (!ccdbs || ccdbs->policy)
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
 	struct cpu_common_dbs_info *ccdbs = cdbs->ccdbs;
 
+	/* State should be equivalent to START */
+	if (!ccdbs || !ccdbs->policy)
+		return -EBUSY;
+
 	gov_cancel_work(dbs_data, policy);
 
 	if (cdata->governor == GOV_CONSERVATIVE) {
@@ -484,17 +502,19 @@ static void cpufreq_governor_stop(struct cpufreq_policy *policy,
 
 	ccdbs->policy = NULL;
 	mutex_destroy(&ccdbs->timer_mutex);
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
 	if (!cdbs->ccdbs || !cdbs->ccdbs->policy)
-		return;
+		return -EBUSY;
 
 	mutex_lock(&cdbs->ccdbs->timer_mutex);
 	if (policy->max < cdbs->ccdbs->policy->cur)
@@ -505,13 +525,15 @@ static void cpufreq_governor_limits(struct cpufreq_policy *policy,
 					CPUFREQ_RELATION_L);
 	dbs_check_cpu(dbs_data, cpu);
 	mutex_unlock(&cdbs->ccdbs->timer_mutex);
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

--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
