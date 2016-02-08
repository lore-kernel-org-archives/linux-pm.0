From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 11/13] cpufreq: governor: Keep list of policy_dbs within dbs_data
Date: Mon,  8 Feb 2016 17:09:25 +0530
Message-ID: <b260aaa932e50d6f00eaa3d8f2422a29e061286b.1454931189.git.viresh.kumar@linaro.org>
References: <cover.1454931188.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1454931188.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1454931188.git.viresh.kumar@linaro.org>
References: <cover.1454931188.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, juri.lelli@arm.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, shilpa.bhat@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

An instance of 'struct dbs_data' can support multiple 'struct
policy_dbs_info' instances. To traverse all policy_dbs supported by a
dbs_data, create a list of policy_dbs within dbs_data.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_governor.c | 12 ++++++++++++
 drivers/cpufreq/cpufreq_governor.h |  7 ++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index ee3c2d92da53..e267acc67067 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -489,6 +489,11 @@ static int cpufreq_governor_init(struct cpufreq_policy *policy)
 		dbs_data->usage_count++;
 		policy_dbs->dbs_data = dbs_data;
 		policy->governor_data = policy_dbs;
+
+		mutex_lock(&dbs_data->mutex);
+		list_add(&policy_dbs->list, &dbs_data->policy_dbs_list);
+		mutex_unlock(&dbs_data->mutex);
+
 		return 0;
 	}
 
@@ -500,8 +505,11 @@ static int cpufreq_governor_init(struct cpufreq_policy *policy)
 
 	dbs_data->usage_count = 1;
 	dbs_data->gov = gov;
+	INIT_LIST_HEAD(&dbs_data->policy_dbs_list);
 	mutex_init(&dbs_data->mutex);
 
+	list_add(&policy_dbs->list, &dbs_data->policy_dbs_list);
+
 	ret = gov->init(dbs_data, !policy->governor->initialized);
 	if (ret)
 		goto free_policy_dbs_info;
@@ -554,6 +562,10 @@ static int cpufreq_governor_exit(struct cpufreq_policy *policy)
 	struct policy_dbs_info *policy_dbs = policy->governor_data;
 	struct dbs_data *dbs_data = policy_dbs->dbs_data;
 
+	mutex_lock(&dbs_data->mutex);
+	list_del(&policy_dbs->list);
+	mutex_unlock(&dbs_data->mutex);
+
 	if (!--dbs_data->usage_count) {
 		kobject_put(&dbs_data->kobj);
 
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index ced34ba5a18d..b740633c2fbe 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -74,7 +74,11 @@ struct dbs_data {
 	unsigned int up_threshold;
 
 	struct kobject kobj;
-	/* Protect concurrent updates to governor tunables from sysfs */
+	struct list_head policy_dbs_list;
+	/*
+	 * Protect concurrent updates to governor tunables from sysfs and
+	 * policy_dbs_list.
+	 */
 	struct mutex mutex;
 };
 
@@ -132,6 +136,7 @@ struct policy_dbs_info {
 	struct work_struct work;
 	/* dbs_data may be shared between multiple policy objects */
 	struct dbs_data *dbs_data;
+	struct list_head list;
 };
 
 static inline void gov_update_sample_delay(struct policy_dbs_info *policy_dbs,
-- 
2.7.1.370.gb2aa7f8
