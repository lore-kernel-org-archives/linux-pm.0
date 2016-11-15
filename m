From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 4/4] cpufreq: schedutil: irq-work and mutex are only used in slow path
Date: Tue, 15 Nov 2016 13:53:23 +0530
Message-ID: <a099804224d5e980a78668fa111e0564b0f44029.1479197311.git.viresh.kumar@linaro.org>
References: <cover.1479197311.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34825 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965962AbcKOIXw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Nov 2016 03:23:52 -0500
Received: by mail-pf0-f177.google.com with SMTP id i88so34969869pfk.2
        for <linux-pm@vger.kernel.org>; Tue, 15 Nov 2016 00:23:52 -0800 (PST)
In-Reply-To: <cover.1479197311.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1479197311.git.viresh.kumar@linaro.org>
References: <cover.1479197311.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Robin Randhawa <robin.randhawa@arm.com>, Steve Muckle <smuckle.linux@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>

Execute the irq-work specific initialization/exit code only when the
fast path isn't available.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index f165ba0f0766..42a220e78f00 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -390,15 +390,12 @@ static struct sugov_policy *sugov_policy_alloc(struct cpufreq_policy *policy)
 		return NULL;
 
 	sg_policy->policy = policy;
-	init_irq_work(&sg_policy->irq_work, sugov_irq_work);
-	mutex_init(&sg_policy->work_lock);
 	raw_spin_lock_init(&sg_policy->update_lock);
 	return sg_policy;
 }
 
 static void sugov_policy_free(struct sugov_policy *sg_policy)
 {
-	mutex_destroy(&sg_policy->work_lock);
 	kfree(sg_policy);
 }
 
@@ -432,6 +429,9 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
 
 	sg_policy->thread = thread;
 	kthread_bind_mask(thread, policy->related_cpus);
+	init_irq_work(&sg_policy->irq_work, sugov_irq_work);
+	mutex_init(&sg_policy->work_lock);
+
 	wake_up_process(thread);
 
 	return 0;
@@ -445,6 +445,7 @@ static void sugov_kthread_stop(struct sugov_policy *sg_policy)
 
 	kthread_flush_worker(&sg_policy->worker);
 	kthread_stop(sg_policy->thread);
+	mutex_destroy(&sg_policy->work_lock);
 }
 
 static struct sugov_tunables *sugov_tunables_alloc(struct sugov_policy *sg_policy)
@@ -611,8 +612,10 @@ static void sugov_stop(struct cpufreq_policy *policy)
 
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

