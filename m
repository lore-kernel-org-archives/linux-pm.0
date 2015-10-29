From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 3/6] cpufreq: governor: Pass policy as argument to ->gov_dbs_timer()
Date: Thu, 29 Oct 2015 17:57:22 +0530
Message-ID: <594333ba3495aed2571f032af306d891994cf31c.1446121217.git.viresh.kumar@linaro.org>
References: <cover.1446121217.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1446121217.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1446121217.git.viresh.kumar@linaro.org>
References: <cover.1446121217.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

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
index edab71528b8b..0848c8ac6847 100644
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
