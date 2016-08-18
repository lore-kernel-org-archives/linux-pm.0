From: WEN Pingbo <pingbo.wen@linaro.org>
Subject: [PATCH] cpufreq: schedutil: set cpu freq to min in idle state
Date: Thu, 18 Aug 2016 16:55:31 +0800
Message-ID: <1471510531-7330-1-git-send-email-pingbo.wen@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35447 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbcHRIzp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Aug 2016 04:55:45 -0400
Received: by mail-pa0-f49.google.com with SMTP id i5so4669373pat.2
        for <linux-pm@vger.kernel.org>; Thu, 18 Aug 2016 01:55:44 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, steve.muckle@linaro.org, WEN Pingbo <pingbo.wen@linaro.org>

The schedutil will keep the frequency high until next thread is arrived,
when the cpu/cluster enter idle state, which is obviously abnormal and
inefficient.

This patch added a idle_timer, which will re-feed in every util
callback. When cpu enter idle state, the idle_timer expires, and will
pull down the frequency.

Signed-off-by: WEN Pingbo <pingbo.wen@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index a84641b..41cd74e 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -34,6 +34,7 @@ struct sugov_policy {
 	s64 freq_update_delay_ns;
 	unsigned int next_freq;
 
+	struct timer_list idle_timer;
 	/* The next fields are only needed if fast switch cannot be used. */
 	struct irq_work irq_work;
 	struct work_struct work;
@@ -152,6 +153,8 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	struct cpufreq_policy *policy = sg_policy->policy;
 	unsigned int next_f;
 
+	mod_timer(&sg_policy->idle_timer, jiffies + 1);
+
 	if (!sugov_should_update_freq(sg_policy, time))
 		return;
 
@@ -215,6 +218,8 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 
 	raw_spin_lock(&sg_policy->update_lock);
 
+	mod_timer(&sg_policy->idle_timer, jiffies + 1);
+
 	sg_cpu->util = util;
 	sg_cpu->max = max;
 	sg_cpu->last_update = time;
@@ -247,6 +252,18 @@ static void sugov_irq_work(struct irq_work *irq_work)
 	schedule_work_on(smp_processor_id(), &sg_policy->work);
 }
 
+static void sugov_idle_timer(unsigned long data)
+{
+	struct sugov_policy *sg_policy = (struct sugov_policy *)data;
+	struct cpufreq_policy *policy = sg_policy->policy;
+	struct sugov_cpu *sg_cpu = &per_cpu(sugov_cpu, smp_processor_id());
+
+	/* CPU is in idle state, set to min directly to save power. */
+	if (!sg_policy->work_in_progress && (policy->min != policy->cur))
+		sugov_update_commit(sg_policy, sg_cpu->last_update,
+				policy->min);
+}
+
 /************************** sysfs interface ************************/
 
 static struct sugov_tunables *global_tunables;
@@ -310,6 +327,11 @@ static struct sugov_policy *sugov_policy_alloc(struct cpufreq_policy *policy)
 	init_irq_work(&sg_policy->irq_work, sugov_irq_work);
 	INIT_WORK(&sg_policy->work, sugov_work);
 	mutex_init(&sg_policy->work_lock);
+
+	init_timer_pinned(&sg_policy->idle_timer);
+	sg_policy->idle_timer.function = sugov_idle_timer;
+	sg_policy->idle_timer.data = (unsigned long)sg_policy;
+
 	raw_spin_lock_init(&sg_policy->update_lock);
 	return sg_policy;
 }
@@ -468,6 +490,7 @@ static void sugov_stop(struct cpufreq_policy *policy)
 
 	synchronize_sched();
 
+	del_timer_sync(&sg_policy->idle_timer);
 	irq_work_sync(&sg_policy->irq_work);
 	cancel_work_sync(&sg_policy->work);
 }
-- 
1.9.1

