From: Henry Willard <henry.willard@oracle.com>
Subject: [PATCH] cpufreq: governor: Protect cpufreq governor_data
Date: Tue, 14 Aug 2018 17:01:02 -0700
Message-ID: <1534291262-4207-1-git-send-email-henry.willard@oracle.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, henry.willard@oracle.com
List-Id: linux-pm@vger.kernel.org

If cppc_cpufreq.ko is deleted at the same time that tuned-adm is
changing profiles, there is a small chance that a race can occur
between cpufreq_dbs_governor_exit() and cpufreq_dbs_governor_limits()
resulting in a system failure when the latter tries to use
policy->governor_data that has been freed by the former.

This patch uses gov_dbs_data_mutex to synchronize access.

Signed-off-by: Henry Willard <henry.willard@oracle.com>
---
 drivers/cpufreq/cpufreq_governor.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 1d50e97d49f1..43416ee55849 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -555,12 +555,20 @@ void cpufreq_dbs_governor_stop(struct cpufreq_policy *policy)
 
 void cpufreq_dbs_governor_limits(struct cpufreq_policy *policy)
 {
-	struct policy_dbs_info *policy_dbs = policy->governor_data;
+	struct policy_dbs_info *policy_dbs;
+
+	/* Protect gov->gdbs_data against cpufreq_dbs_governor_exit */
+	mutex_lock(&gov_dbs_data_mutex);
+	policy_dbs = policy->governor_data;
+	if (!policy_dbs)
+		goto out;
 
 	mutex_lock(&policy_dbs->update_mutex);
 	cpufreq_policy_apply_limits(policy);
 	gov_update_sample_delay(policy_dbs, 0);
 
 	mutex_unlock(&policy_dbs->update_mutex);
+out:
+	mutex_unlock(&gov_dbs_data_mutex);
 }
 EXPORT_SYMBOL_GPL(cpufreq_dbs_governor_limits);
-- 
1.8.3.1
