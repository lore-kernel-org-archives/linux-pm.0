From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 4/6] cpufreq: governor: initialize/destroy timer_mutex with 'shared'
Date: Thu, 29 Oct 2015 17:57:23 +0530
Message-ID: <f773d1e27b2221afb76dcfcfef2f0c5e6ae28c79.1446121217.git.viresh.kumar@linaro.org>
References: <cover.1446121217.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1446121217.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1446121217.git.viresh.kumar@linaro.org>
References: <cover.1446121217.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

timer_mutex is required to be initialized only while memory for 'shared'
is allocated and in a similar way it is required to be destroyed only
when memory for 'shared' is freed.

There is no need to do the same every time we start/stop the governor.
Move code to initialize/destroy timer_mutex to the relevant places.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_governor.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index cdcb56a49b28..999e1f6addf9 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -287,6 +287,7 @@ static int alloc_common_dbs_info(struct cpufreq_policy *policy,
 	for_each_cpu(j, policy->related_cpus)
 		cdata->get_cpu_cdbs(j)->shared = shared;
 
+	mutex_init(&shared->timer_mutex);
 	return 0;
 }
 
@@ -297,6 +298,8 @@ static void free_common_dbs_info(struct cpufreq_policy *policy,
 	struct cpu_common_dbs_info *shared = cdbs->shared;
 	int j;
 
+	mutex_destroy(&shared->timer_mutex);
+
 	for_each_cpu(j, policy->cpus)
 		cdata->get_cpu_cdbs(j)->shared = NULL;
 
@@ -433,7 +436,6 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
 
 	shared->policy = policy;
 	shared->time_stamp = ktime_get();
-	mutex_init(&shared->timer_mutex);
 
 	for_each_cpu(j, policy->cpus) {
 		struct cpu_dbs_info *j_cdbs = cdata->get_cpu_cdbs(j);
@@ -493,8 +495,6 @@ static int cpufreq_governor_stop(struct cpufreq_policy *policy,
 	mutex_unlock(&shared->timer_mutex);
 
 	gov_cancel_work(dbs_data, policy);
-
-	mutex_destroy(&shared->timer_mutex);
 	return 0;
 }
 
-- 
2.6.2.198.g614a2ac
