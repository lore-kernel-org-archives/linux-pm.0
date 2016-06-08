From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: governor: Drop gov_cancel_work()
Date: Thu, 09 Jun 2016 01:45:32 +0200
Message-ID: <31871585.32WEDJA5Kj@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There's no reason for gov_cancel_work() to exist at all, as it only
has one caller and the only thing done by that caller is to invoke
gov_cancel_work().

Accordingly, drop gov_cancel_work() and move its contents to the
caller.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_governor.c |   19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -336,17 +336,6 @@ static inline void gov_clear_update_util
 	synchronize_sched();
 }
 
-static void gov_cancel_work(struct cpufreq_policy *policy)
-{
-	struct policy_dbs_info *policy_dbs = policy->governor_data;
-
-	gov_clear_update_util(policy_dbs->policy);
-	irq_work_sync(&policy_dbs->irq_work);
-	cancel_work_sync(&policy_dbs->work);
-	atomic_set(&policy_dbs->work_count, 0);
-	policy_dbs->work_in_progress = false;
-}
-
 static struct policy_dbs_info *alloc_policy_dbs_info(struct cpufreq_policy *policy,
 						     struct dbs_governor *gov)
 {
@@ -544,7 +533,13 @@ EXPORT_SYMBOL_GPL(cpufreq_dbs_governor_s
 
 void cpufreq_dbs_governor_stop(struct cpufreq_policy *policy)
 {
-	gov_cancel_work(policy);
+	struct policy_dbs_info *policy_dbs = policy->governor_data;
+
+	gov_clear_update_util(policy_dbs->policy);
+	irq_work_sync(&policy_dbs->irq_work);
+	cancel_work_sync(&policy_dbs->work);
+	atomic_set(&policy_dbs->work_count, 0);
+	policy_dbs->work_in_progress = false;
 }
 EXPORT_SYMBOL_GPL(cpufreq_dbs_governor_stop);
 
