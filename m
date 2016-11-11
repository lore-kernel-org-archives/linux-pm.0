From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 3/3] cpufreq: schedutil: irq-work is used only in slow path
Date: Fri, 11 Nov 2016 15:52:23 +0530
Message-ID: <8435d76015786b26b343a5588e2758b4caf6760e.1478858983.git.viresh.kumar@linaro.org>
References: <cover.1478858983.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33569 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755708AbcKKKWn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Nov 2016 05:22:43 -0500
Received: by mail-pf0-f176.google.com with SMTP id d2so10121055pfd.0
        for <linux-pm@vger.kernel.org>; Fri, 11 Nov 2016 02:22:42 -0800 (PST)
In-Reply-To: <cover.1478858983.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1478858983.git.viresh.kumar@linaro.org>
References: <cover.1478858983.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Robin Randhawa <robin.randhawa@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>

Execute the irq-work specific initialization/exit code only when fast
path isn't available.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 045ce0a4e6d1..219e717bcd15 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -371,9 +371,9 @@ static void sugov_policy_free(struct sugov_policy *sg_policy)
 	if (!sg_policy->policy->fast_switch_enabled) {
 		kthread_flush_worker(&sg_policy->worker);
 		kthread_stop(sg_policy->thread);
+		mutex_destroy(&sg_policy->work_lock);
 	}
 
-	mutex_destroy(&sg_policy->work_lock);
 	kfree(sg_policy);
 }
 
@@ -389,8 +389,6 @@ static struct sugov_policy *sugov_policy_alloc(struct cpufreq_policy *policy)
 		return NULL;
 
 	sg_policy->policy = policy;
-	init_irq_work(&sg_policy->irq_work, sugov_irq_work);
-	mutex_init(&sg_policy->work_lock);
 	raw_spin_lock_init(&sg_policy->update_lock);
 
 	/* kthread only required for slow path */
@@ -402,7 +400,6 @@ static struct sugov_policy *sugov_policy_alloc(struct cpufreq_policy *policy)
 	thread = kthread_create(kthread_worker_fn, &sg_policy->worker,
 			"sugov:%d", cpumask_first(policy->related_cpus));
 	if (IS_ERR(thread)) {
-		mutex_destroy(&sg_policy->work_lock);
 		kfree(sg_policy);
 		pr_err("failed to create sugov thread: %ld\n", PTR_ERR(thread));
 		return NULL;
@@ -416,6 +413,9 @@ static struct sugov_policy *sugov_policy_alloc(struct cpufreq_policy *policy)
 		return NULL;
 	}
 
+	init_irq_work(&sg_policy->irq_work, sugov_irq_work);
+	mutex_init(&sg_policy->work_lock);
+
 	kthread_bind_mask(thread, policy->related_cpus);
 	wake_up_process(thread);
 
@@ -578,8 +578,10 @@ static void sugov_stop(struct cpufreq_policy *policy)
 
 	synchronize_sched();
 
-	irq_work_sync(&sg_policy->irq_work);
-	kthread_cancel_work_sync(&sg_policy->work);
+	if (!policy->fast_switch_enabled) {
+		irq_work_sync(&sg_policy->irq_work);
+		kthread_cancel_work_sync(&sg_policy->work);
+	}
 }
 
 static void sugov_limits(struct cpufreq_policy *policy)
-- 
2.7.1.410.g6faf27b

