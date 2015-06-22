From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 05/10] cpufreq: governor: Drop __gov_queue_work()
Date: Mon, 22 Jun 2015 13:32:52 +0530
Message-ID: <c4dfd8121fd454a04a8d700a5a0f8b7858f7aed3.1434959517.git.viresh.kumar@linaro.org>
References: <cover.1434959517.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34770 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755999AbbFVIDZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2015 04:03:25 -0400
Received: by pabvl15 with SMTP id vl15so82801642pab.1
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2015 01:03:25 -0700 (PDT)
In-Reply-To: <cover.1434959517.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1434959517.git.viresh.kumar@linaro.org>
References: <cover.1434959517.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

__gov_queue_work() isn't required anymore and can be merged with
gov_queue_work(). Do it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_governor.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 416a8c5665dd..ac288f0efb06 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -158,25 +158,20 @@ void dbs_check_cpu(struct dbs_data *dbs_data, int cpu)
 }
 EXPORT_SYMBOL_GPL(dbs_check_cpu);
 
-static inline void __gov_queue_work(int cpu, struct dbs_data *dbs_data,
-		unsigned int delay)
-{
-	struct cpu_dbs_info *cdbs = dbs_data->cdata->get_cpu_cdbs(cpu);
-
-	mod_delayed_work_on(cpu, system_wq, &cdbs->dwork, delay);
-}
-
 void gov_queue_work(struct dbs_data *dbs_data, struct cpufreq_policy *policy,
 		    unsigned int delay, const struct cpumask *cpus)
 {
-	int i;
+	struct cpu_dbs_info *cdbs;
+	int cpu;
 
 	mutex_lock(&cpufreq_governor_lock);
 	if (!policy->governor_enabled)
 		goto out_unlock;
 
-	for_each_cpu(i, cpus)
-		__gov_queue_work(i, dbs_data, delay);
+	for_each_cpu(cpu, cpus) {
+		cdbs = dbs_data->cdata->get_cpu_cdbs(cpu);
+		mod_delayed_work_on(cpu, system_wq, &cdbs->dwork, delay);
+	}
 
 out_unlock:
 	mutex_unlock(&cpufreq_governor_lock);
-- 
2.4.0

--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
