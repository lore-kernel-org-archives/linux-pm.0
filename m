From: Steve Muckle <steve.muckle@linaro.org>
Subject: [PATCH 1/5] sched: cpufreq: add cpu to update_util_data
Date: Mon,  9 May 2016 14:20:10 -0700
Message-ID: <1462828814-32530-2-git-send-email-smuckle@linaro.org>
References: <1462828814-32530-1-git-send-email-smuckle@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34424 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752320AbcEIVUT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 May 2016 17:20:19 -0400
Received: by mail-pa0-f54.google.com with SMTP id r5so78442272pag.1
        for <linux-pm@vger.kernel.org>; Mon, 09 May 2016 14:20:19 -0700 (PDT)
In-Reply-To: <1462828814-32530-1-git-send-email-smuckle@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>

Upcoming support for scheduler cpufreq callbacks on remote wakeups
will require the client to know what the target CPU is that the
callback is being invoked for. Add this information into the callback
data structure.

Signed-off-by: Steve Muckle <smuckle@linaro.org>
---
 include/linux/sched.h  | 1 +
 kernel/sched/cpufreq.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8344e1947eec..81aba7dc5966 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -3238,6 +3238,7 @@ static inline unsigned long rlimit_max(unsigned int limit)
 struct update_util_data {
 	void (*func)(struct update_util_data *data,
 		     u64 time, unsigned long util, unsigned long max);
+	int cpu;
 };
 
 void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
diff --git a/kernel/sched/cpufreq.c b/kernel/sched/cpufreq.c
index 1141954e73b4..d88a78ea805d 100644
--- a/kernel/sched/cpufreq.c
+++ b/kernel/sched/cpufreq.c
@@ -42,6 +42,7 @@ void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
 		return;
 
 	data->func = func;
+	data->cpu = cpu;
 	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), data);
 }
 EXPORT_SYMBOL_GPL(cpufreq_add_update_util_hook);
-- 
2.4.10

