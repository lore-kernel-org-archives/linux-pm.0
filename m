From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: schedutil: Update last_update from sugov_set_iowait_boost()
Date: Tue, 18 Jul 2017 10:24:32 +0530
Message-ID: <4927469221fa6b2ea7efffb2da923dac930ab313.1500353473.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:36628 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbdGREyh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jul 2017 00:54:37 -0400
Received: by mail-pg0-f44.google.com with SMTP id u5so5799910pgq.3
        for <linux-pm@vger.kernel.org>; Mon, 17 Jul 2017 21:54:37 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, joelaf@google.com, Juri Lelli <Juri.Lelli@arm.com>, linux-kernel@vger.kernel.org

sg_cpu->last_update is always updated right after we call
sugov_set_iowait_boost() and its better to update it from that routine
itself. This makes it more readable.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 29a397067ffa..63557b9f36b6 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -177,6 +177,8 @@ static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
 		if (delta_ns > TICK_NSEC)
 			sg_cpu->iowait_boost = 0;
 	}
+
+	sg_cpu->last_update = time;
 }
 
 static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, unsigned long *util,
@@ -219,7 +221,6 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	bool busy;
 
 	sugov_set_iowait_boost(sg_cpu, time, flags);
-	sg_cpu->last_update = time;
 
 	if (!sugov_should_update_freq(sg_policy, time))
 		return;
@@ -299,7 +300,6 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 	sg_cpu->flags = flags;
 
 	sugov_set_iowait_boost(sg_cpu, time, flags);
-	sg_cpu->last_update = time;
 
 	if (sugov_should_update_freq(sg_policy, time)) {
 		if (flags & SCHED_CPUFREQ_RT_DL)
-- 
2.13.0.71.gd7076ec9c9cb
