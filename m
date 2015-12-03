From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 3/6] cpufreq: governor: Pass policy as argument to ->gov_dbs_timer()
Date: Thu,  3 Dec 2015 09:37:51 +0530
Message-ID: <58060974dfb6759c9fda2ed3c1649ff7d75df5ad.1449115453.git.viresh.kumar@linaro.org>
References: <cover.1449115453.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34167 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757441AbbLCEIM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Dec 2015 23:08:12 -0500
Received: by padhx2 with SMTP id hx2so59446623pad.1
        for <linux-pm@vger.kernel.org>; Wed, 02 Dec 2015 20:08:11 -0800 (PST)
In-Reply-To: <cover.1449115453.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1449115453.git.viresh.kumar@linaro.org>
References: <cover.1449115453.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ashwin.chaugule@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>

Pass 'policy' as argument to ->gov_dbs_timer() instead of cdbs and
dbs_data.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_conservative.c | 6 +++---
 drivers/cpufreq/cpufreq_governor.c     | 2 +-
 drivers/cpufreq/cpufreq_governor.h     | 3 +--
 drivers/cpufreq/cpufreq_ondemand.c     | 5 ++---
 4 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index 1fa1deb6e91f..606ad74abe6e 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -115,13 +115,13 @@ static void cs_check_cpu(int cpu, unsigned int load)
 	}
 }
 
-static unsigned int cs_dbs_timer(struct cpu_dbs_info *cdbs,
-				 struct dbs_data *dbs_data, bool modify_all)
+static unsigned int cs_dbs_timer(struct cpufreq_policy *policy, bool modify_all)
 {
+	struct dbs_data *dbs_data = policy->governor_data;
 	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 
 	if (modify_all)
-		dbs_check_cpu(dbs_data, cdbs->shared->policy->cpu);
+		dbs_check_cpu(dbs_data, policy->cpu);
 
 	return delay_for_sampling_rate(cs_tuners->sampling_rate);
 }
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index b260576ddb12..cdcb56a49b28 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -253,7 +253,7 @@ static void dbs_timer(struct work_struct *work)
 	if (!need_load_eval(cdbs->shared, sampling_rate))
 		modify_all = false;
 
-	delay = dbs_data->cdata->gov_dbs_timer(cdbs, dbs_data, modify_all);
+	delay = dbs_data->cdata->gov_dbs_timer(policy, modify_all);
 	gov_queue_work(dbs_data, policy, delay, modify_all);
 
 unlock:
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 5621bb03e874..0c7589016b6c 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -209,8 +209,7 @@ struct common_dbs_data {
 
 	struct cpu_dbs_info *(*get_cpu_cdbs)(int cpu);
 	void *(*get_cpu_dbs_info_s)(int cpu);
-	unsigned int (*gov_dbs_timer)(struct cpu_dbs_info *cdbs,
-				      struct dbs_data *dbs_data,
+	unsigned int (*gov_dbs_timer)(struct cpufreq_policy *policy,
 				      bool modify_all);
 	void (*gov_check_cpu)(int cpu, unsigned int load);
 	int (*init)(struct dbs_data *dbs_data, bool notify);
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 08f2aa602f9e..fc0384b4d02d 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -191,10 +191,9 @@ static void od_check_cpu(int cpu, unsigned int load)
 	}
 }
 
-static unsigned int od_dbs_timer(struct cpu_dbs_info *cdbs,
-				 struct dbs_data *dbs_data, bool modify_all)
+static unsigned int od_dbs_timer(struct cpufreq_policy *policy, bool modify_all)
 {
-	struct cpufreq_policy *policy = cdbs->shared->policy;
+	struct dbs_data *dbs_data = policy->governor_data;
 	unsigned int cpu = policy->cpu;
 	struct od_cpu_dbs_info_s *dbs_info = &per_cpu(od_cpu_dbs_info,
 			cpu);
-- 
2.6.2.198.g614a2ac

