From: Juri Lelli <juri.lelli@arm.com>
Subject: [RFC PATCH 17/19] cpufreq: stop checking for cpufreq_driver being present in cpufreq_cpu_get
Date: Mon, 11 Jan 2016 17:35:58 +0000
Message-ID: <1452533760-13787-18-git-send-email-juri.lelli@arm.com>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, juri.lelli@arm.com
List-Id: linux-pm@vger.kernel.org

After cpufreq_driver_lock() is acquired in cpufreq_cpu_get() we are sure
we can't race with cpufreq_policy_free() (which is in the path that ends
up removing cpufreq_driver). We can thus safely remove check for
cpufreq_driver being present (which is a leftover from commit
6eed9404ab3c ("cpufreq: Use rwsem for protecting critical sections")).

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 drivers/cpufreq/cpufreq.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 797bfae..6c9bef7 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -282,15 +282,15 @@ struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
 	if (WARN_ON(cpu >= nr_cpu_ids))
 		return NULL;
 
-	/* get the cpufreq driver */
 	read_lock_irqsave(&cpufreq_driver_lock, flags);
 
-	if (cpufreq_driver) {
-		/* get the CPU */
-		policy = cpufreq_cpu_get_raw(cpu);
-		if (policy)
-			kobject_get(&policy->kobj);
-	}
+	/*
+	 * If we get a policy, cpufreq_policy_free() didn't
+	 * yet run.
+	 */
+	policy = cpufreq_cpu_get_raw(cpu);
+	if (policy)
+		kobject_get(&policy->kobj);
 
 	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
-- 
2.2.2
