From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 1/6] cpufreq: ondemand: Update sampling rate only for concerned policies
Date: Thu,  3 Dec 2015 09:37:49 +0530
Message-ID: <c33ac949188af81735956c6c9e43204646b9f49a.1449115453.git.viresh.kumar@linaro.org>
References: <cover.1449115453.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33534 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755716AbbLCEIE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Dec 2015 23:08:04 -0500
Received: by pabfh17 with SMTP id fh17so61124251pab.0
        for <linux-pm@vger.kernel.org>; Wed, 02 Dec 2015 20:08:04 -0800 (PST)
In-Reply-To: <cover.1449115453.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1449115453.git.viresh.kumar@linaro.org>
References: <cover.1449115453.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ashwin.chaugule@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>

We are comparing policy->governor against cpufreq_gov_ondemand to make
sure that we update sampling rate only for the concerned CPUs. But that
isn't enough.

In case of governor_per_policy, there can be multiple instances of
ondemand governor and we will always end up updating all of them with
current code. What we rather need to do, is to compare dbs_data with
poilcy->governor_data, which will match only for the policies governed
by dbs_data.

This code is also racy as the governor might be getting stopped at that
time and we may end up scheduling work for a policy, which we have just
disabled.

Fix that by protecting the entire function with &od_dbs_cdata.mutex,
which will prevent against races with policy START/STOP/etc.

After these locks are in place, we can safely get the policy via per-cpu
dbs_info.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_ondemand.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 03ac6ce54042..089ca6a6ca02 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -252,20 +252,39 @@ static void update_sampling_rate(struct dbs_data *dbs_data,
 	od_tuners->sampling_rate = new_rate = max(new_rate,
 			dbs_data->min_sampling_rate);
 
+	/*
+	 * Lock governor so that governor start/stop can't execute in parallel.
+	 */
+	mutex_lock(&od_dbs_cdata.mutex);
+
 	for_each_online_cpu(cpu) {
 		struct cpufreq_policy *policy;
 		struct od_cpu_dbs_info_s *dbs_info;
+		struct cpu_dbs_info *cdbs;
+		struct cpu_common_dbs_info *shared;
 		unsigned long next_sampling, appointed_at;
 
-		policy = cpufreq_cpu_get(cpu);
-		if (!policy)
+		dbs_info = &per_cpu(od_cpu_dbs_info, cpu);
+		cdbs = &dbs_info->cdbs;
+		shared = cdbs->shared;
+
+		/*
+		 * A valid shared and shared->policy means governor hasn't
+		 * stopped or exited yet.
+		 */
+		if (!shared || !shared->policy)
 			continue;
-		if (policy->governor != &cpufreq_gov_ondemand) {
-			cpufreq_cpu_put(policy);
+
+		policy = shared->policy;
+
+		/*
+		 * Update sampling rate for CPUs whose policy is governed by
+		 * dbs_data. In case of governor_per_policy, only a single
+		 * policy will be governed by dbs_data, otherwise there can be
+		 * multiple policies that are governed by the same dbs_data.
+		 */
+		if (dbs_data != policy->governor_data)
 			continue;
-		}
-		dbs_info = &per_cpu(od_cpu_dbs_info, cpu);
-		cpufreq_cpu_put(policy);
 
 		if (!delayed_work_pending(&dbs_info->cdbs.dwork))
 			continue;
@@ -281,6 +300,8 @@ static void update_sampling_rate(struct dbs_data *dbs_data,
 
 		}
 	}
+
+	mutex_unlock(&od_dbs_cdata.mutex);
 }
 
 static ssize_t store_sampling_rate(struct dbs_data *dbs_data, const char *buf,
-- 
2.6.2.198.g614a2ac

