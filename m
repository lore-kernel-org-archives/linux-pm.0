From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: [PATCH] cpufreq: Fix checkpatch errors and warnings
Date: Wed, 19 Mar 2014 23:29:17 +0200
Message-ID: <532A0C2D.9010600@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Fix 2 checkpatch errors about using assignment in if condition,
1 checkpatch error about a required space after comma
and 3 warnings about line over 80 characters.

Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
---
 drivers/cpufreq/cpufreq.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e3aa9de..1eafd8c 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -939,8 +939,10 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy,
 	up_write(&policy->rwsem);
 
 	if (has_target()) {
-		if ((ret = __cpufreq_governor(policy, CPUFREQ_GOV_START)) ||
-			(ret = __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS))) {
+		ret = __cpufreq_governor(policy, CPUFREQ_GOV_START);
+		if (!ret)
+			ret = __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
+		if (ret) {
 			pr_err("%s: Failed to start governor\n", __func__);
 			return ret;
 		}
@@ -1394,14 +1396,13 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
 
 		if (!cpufreq_suspended)
 			cpufreq_policy_free(policy);
-	} else {
-		if (has_target()) {
-			if ((ret = __cpufreq_governor(policy, CPUFREQ_GOV_START)) ||
-					(ret = __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS))) {
-				pr_err("%s: Failed to start governor\n",
-				       __func__);
-				return ret;
-			}
+	} else if (has_target()) {
+		ret = __cpufreq_governor(policy, CPUFREQ_GOV_START);
+		if (!ret)
+			ret = __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
+		if (ret) {
+			pr_err("%s: Failed to start governor\n", __func__);
+			return ret;
 		}
 	}
 
@@ -2086,7 +2087,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	if (old_gov) {
 		__cpufreq_governor(policy, CPUFREQ_GOV_STOP);
 		up_write(&policy->rwsem);
-		__cpufreq_governor(policy,CPUFREQ_GOV_POLICY_EXIT);
+		__cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
 		down_write(&policy->rwsem);
 	}
 
-- 
1.8.5.3

