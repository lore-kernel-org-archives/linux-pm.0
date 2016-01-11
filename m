From: Juri Lelli <juri.lelli@arm.com>
Subject: [RFC PATCH 05/19] cpufreq: assert locking when accessing cpufreq_policy_list
Date: Mon, 11 Jan 2016 17:35:46 +0000
Message-ID: <1452533760-13787-6-git-send-email-juri.lelli@arm.com>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, juri.lelli@arm.com
List-Id: linux-pm@vger.kernel.org

cpufreq_policy_list is guarded by cpufreq_driver_lock. Add appropriate
locking assertions to check that we always access the list while holding
the associated lock.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 drivers/cpufreq/cpufreq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 00a00cd..63d6efb 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -65,6 +65,7 @@ static bool suitable_policy(struct cpufreq_policy *policy, bool active)
 static struct cpufreq_policy *next_policy(struct cpufreq_policy *policy,
 					  bool active)
 {
+	lockdep_assert_held(&cpufreq_driver_lock);
 	do {
 		policy = list_next_entry(policy, policy_list);
 
@@ -80,6 +81,7 @@ static struct cpufreq_policy *first_policy(bool active)
 {
 	struct cpufreq_policy *policy;
 
+	lockdep_assert_held(&cpufreq_driver_lock);
 	/* No policies in the list */
 	if (list_empty(&cpufreq_policy_list))
 		return NULL;
@@ -2430,6 +2432,7 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 	if (ret)
 		goto err_boost_unreg;
 
+	lockdep_assert_held(&cpufreq_driver_lock);
 	if (!(cpufreq_driver->flags & CPUFREQ_STICKY) &&
 	    list_empty(&cpufreq_policy_list)) {
 		/* if all ->init() calls failed, unregister */
-- 
2.2.2
