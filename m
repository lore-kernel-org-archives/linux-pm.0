From: Juri Lelli <juri.lelli@arm.com>
Subject: [RFC PATCH 18/19] cpufreq: remove transition_lock
Date: Mon, 11 Jan 2016 17:35:59 +0000
Message-ID: <1452533760-13787-19-git-send-email-juri.lelli@arm.com>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, juri.lelli@arm.com
List-Id: linux-pm@vger.kernel.org

From: Michael Turquette <mturquette@baylibre.com>

transition_lock was introduced to serialize cpufreq transition
notifiers. Instead of using a different lock for protecting concurrent
modifications of policy, it is better to require that callers of
transition notifiers implement appropriate locking (this is already the
case AFAICS). Removing transition_lock also simplifies current locking
scheme.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
Signed-off-by: Michael Turquette <mturquette@baylibre.com>
---
 drivers/cpufreq/cpufreq.c | 19 ++++++++++---------
 include/linux/cpufreq.h   |  1 -
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 6c9bef7..78b1e2f 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -421,10 +421,15 @@ static void cpufreq_notify_post_transition(struct cpufreq_policy *policy,
 	cpufreq_notify_transition(policy, freqs, CPUFREQ_POSTCHANGE);
 }
 
+/*
+ * Callers must ensure proper mutual exclusion on policy (for transition_
+ * ongoing/transition_task handling). While holding policy->rwsem is
+ * sufficient, other scheme might work as well (e.g., cpufreq_governor.c
+ * holds timer_mutex while entering the path that generates transitions).
+ */
 void cpufreq_freq_transition_begin(struct cpufreq_policy *policy,
 		struct cpufreq_freqs *freqs)
 {
-
 	/*
 	 * Catch double invocations of _begin() which lead to self-deadlock.
 	 * ASYNC_NOTIFICATION drivers are left out because the cpufreq core
@@ -439,22 +444,19 @@ void cpufreq_freq_transition_begin(struct cpufreq_policy *policy,
 wait:
 	wait_event(policy->transition_wait, !policy->transition_ongoing);
 
-	spin_lock(&policy->transition_lock);
-
-	if (unlikely(policy->transition_ongoing)) {
-		spin_unlock(&policy->transition_lock);
+	if (unlikely(policy->transition_ongoing))
 		goto wait;
-	}
 
 	policy->transition_ongoing = true;
 	policy->transition_task = current;
 
-	spin_unlock(&policy->transition_lock);
-
 	cpufreq_notify_transition(policy, freqs, CPUFREQ_PRECHANGE);
 }
 EXPORT_SYMBOL_GPL(cpufreq_freq_transition_begin);
 
+/*
+ * As above, callers must ensure proper mutual exclusion on policy.
+ */
 void cpufreq_freq_transition_end(struct cpufreq_policy *policy,
 		struct cpufreq_freqs *freqs, int transition_failed)
 {
@@ -1057,7 +1059,6 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	kobject_init(&policy->kobj, &ktype_cpufreq);
 	INIT_LIST_HEAD(&policy->policy_list);
 	init_rwsem(&policy->rwsem);
-	spin_lock_init(&policy->transition_lock);
 	init_waitqueue_head(&policy->transition_wait);
 	init_completion(&policy->kobj_unregister);
 	INIT_WORK(&policy->update, handle_update);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 79b87ce..6bbb88f 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -105,7 +105,6 @@ struct cpufreq_policy {
 
 	/* Synchronization for frequency transitions */
 	bool			transition_ongoing; /* Tracks transition status */
-	spinlock_t		transition_lock;
 	wait_queue_head_t	transition_wait;
 	struct task_struct	*transition_task; /* Task which is doing the transition */
 
-- 
2.2.2
