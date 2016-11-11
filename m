From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/3] cpufreq: schedutil: enable fast switch earlier
Date: Fri, 11 Nov 2016 15:52:21 +0530
Message-ID: <1acfffe798c0371e69ec1171f485499e7b49ed6d.1478858983.git.viresh.kumar@linaro.org>
References: <cover.1478858983.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1478858983.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1478858983.git.viresh.kumar@linaro.org>
References: <cover.1478858983.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Robin Randhawa <robin.randhawa@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

The fast_switch_enabled flag will be used a bit earlier while converting
the schedutil governor to use kthread worker.

Prepare for that by moving the call to enable it to the beginning of
sugov_init().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 69e06898997d..ccb2ab89affb 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -416,9 +416,13 @@ static int sugov_init(struct cpufreq_policy *policy)
 	if (policy->governor_data)
 		return -EBUSY;
 
+	cpufreq_enable_fast_switch(policy);
+
 	sg_policy = sugov_policy_alloc(policy);
-	if (!sg_policy)
-		return -ENOMEM;
+	if (!sg_policy) {
+		ret = -ENOMEM;
+		goto disable_fast_switch;
+	}
 
 	mutex_lock(&global_tunables_lock);
 
@@ -456,8 +460,6 @@ static int sugov_init(struct cpufreq_policy *policy)
 
  out:
 	mutex_unlock(&global_tunables_lock);
-
-	cpufreq_enable_fast_switch(policy);
 	return 0;
 
  fail:
@@ -468,6 +470,10 @@ static int sugov_init(struct cpufreq_policy *policy)
 	mutex_unlock(&global_tunables_lock);
 
 	sugov_policy_free(sg_policy);
+
+ disable_fast_switch:
+	cpufreq_disable_fast_switch(policy);
+
 	pr_err("initialization failed (error %d)\n", ret);
 	return ret;
 }
@@ -478,8 +484,6 @@ static void sugov_exit(struct cpufreq_policy *policy)
 	struct sugov_tunables *tunables = sg_policy->tunables;
 	unsigned int count;
 
-	cpufreq_disable_fast_switch(policy);
-
 	mutex_lock(&global_tunables_lock);
 
 	count = gov_attr_set_put(&tunables->attr_set, &sg_policy->tunables_hook);
@@ -490,6 +494,7 @@ static void sugov_exit(struct cpufreq_policy *policy)
 	mutex_unlock(&global_tunables_lock);
 
 	sugov_policy_free(sg_policy);
+	cpufreq_disable_fast_switch(policy);
 }
 
 static int sugov_start(struct cpufreq_policy *policy)
-- 
2.7.1.410.g6faf27b
