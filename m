From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 3/7] cpufreq: Remove cpufreq_governor_lock
Date: Tue,  9 Feb 2016 09:16:15 +0530
Message-ID: <c8245033beab5fd4601439a9ef1b2d9dd802f9e4.1454988792.git.viresh.kumar@linaro.org>
References: <cover.1454988792.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1454988792.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1454988792.git.viresh.kumar@linaro.org>
References: <cover.1454988792.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, juri.lelli@arm.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, shilpa.bhat@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

We used to drop policy->rwsem just before calling __cpufreq_governor()
in some cases earlier and so it was possible that __cpufreq_governor()
runs concurrently via separate threads.

In order to guarantee valid state transitions for governors,
'governor_enabled' was required to be protected using some locking and
we created cpufreq_governor_lock for that.

But now, __cpufreq_governor() is always called from within policy->rwsem
held and so 'governor_enabled' is protected against races even without
cpufreq_governor_lock.

Get rid of the extra lock now.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Juri Lelli <juri.lelli@arm.com>
Tested-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 drivers/cpufreq/cpufreq.c          | 8 --------
 drivers/cpufreq/cpufreq_governor.h | 1 -
 2 files changed, 9 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 51fb47cd38a0..745da90d7b38 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -146,8 +146,6 @@ void cpufreq_update_util(u64 time, unsigned long util, unsigned long max)
 	rcu_read_unlock();
 }
 
-DEFINE_MUTEX(cpufreq_governor_lock);
-
 /* Flag to suspend/resume CPUFreq governors */
 static bool cpufreq_suspended;
 
@@ -2014,11 +2012,9 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
 
 	pr_debug("%s: for CPU %u, event %u\n", __func__, policy->cpu, event);
 
-	mutex_lock(&cpufreq_governor_lock);
 	if ((policy->governor_enabled && event == CPUFREQ_GOV_START)
 	    || (!policy->governor_enabled
 	    && (event == CPUFREQ_GOV_LIMITS || event == CPUFREQ_GOV_STOP))) {
-		mutex_unlock(&cpufreq_governor_lock);
 		return -EBUSY;
 	}
 
@@ -2027,8 +2023,6 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
 	else if (event == CPUFREQ_GOV_START)
 		policy->governor_enabled = true;
 
-	mutex_unlock(&cpufreq_governor_lock);
-
 	ret = policy->governor->governor(policy, event);
 
 	if (!ret) {
@@ -2038,12 +2032,10 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
 			policy->governor->initialized--;
 	} else {
 		/* Restore original values */
-		mutex_lock(&cpufreq_governor_lock);
 		if (event == CPUFREQ_GOV_STOP)
 			policy->governor_enabled = true;
 		else if (event == CPUFREQ_GOV_START)
 			policy->governor_enabled = false;
-		mutex_unlock(&cpufreq_governor_lock);
 	}
 
 	if (((event == CPUFREQ_GOV_POLICY_INIT) && ret) ||
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 4e77efb7db67..02885e353dfc 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -232,7 +232,6 @@ static inline int delay_for_sampling_rate(unsigned int sampling_rate)
 }
 
 extern struct mutex dbs_data_mutex;
-extern struct mutex cpufreq_governor_lock;
 void dbs_check_cpu(struct cpufreq_policy *policy);
 int cpufreq_governor_dbs(struct cpufreq_policy *policy, unsigned int event);
 void od_register_powersave_bias_handler(unsigned int (*f)
-- 
2.7.1.370.gb2aa7f8
