From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 3/4] cpufreq: schedutil: Don't pass flags to sugov_set_iowait_boost()
Date: Wed, 13 Dec 2017 15:23:22 +0530
Message-ID: <4ec5562b1a87e146ebab11fb5dde1ca9c763a7fb.1513158452.git.viresh.kumar@linaro.org>
References: <cover.1513158452.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43937 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752625AbdLMJxi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Dec 2017 04:53:38 -0500
Received: by mail-pf0-f193.google.com with SMTP id e3so1096280pfi.10
        for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2017 01:53:37 -0800 (PST)
In-Reply-To: <cover.1513158452.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1513158452.git.viresh.kumar@linaro.org>
References: <cover.1513158452.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, juri.lelli@redhat.com, tkjos@android.com, joelaf@google.com, linux-kernel@vger.kernel.org

We are already passing sg_cpu as argument to sugov_set_iowait_boost()
helper and the same can be used to retrieve the flags value. Get rid of
the redundant argument.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 60a2dea4c8cc..7edfdc59ee8f 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -187,10 +187,9 @@ static void sugov_get_util(unsigned long *util, unsigned long *max, int cpu)
 	*max = cfs_max;
 }
 
-static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
-				   unsigned int flags)
+static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time)
 {
-	if (flags & SCHED_CPUFREQ_IOWAIT) {
+	if (sg_cpu->flags & SCHED_CPUFREQ_IOWAIT) {
 		sg_cpu->flags &= ~SCHED_CPUFREQ_IOWAIT;
 
 		if (sg_cpu->iowait_boost_pending)
@@ -273,7 +272,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 
 	sg_cpu->flags |= flags;
 
-	sugov_set_iowait_boost(sg_cpu, time, flags);
+	sugov_set_iowait_boost(sg_cpu, time);
 	sg_cpu->last_update = time;
 
 	if (!sugov_should_update_freq(sg_policy, time))
@@ -363,7 +362,7 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 	sg_cpu->max = max;
 	sg_cpu->flags |= flags;
 
-	sugov_set_iowait_boost(sg_cpu, time, flags);
+	sugov_set_iowait_boost(sg_cpu, time);
 	sg_cpu->last_update = time;
 
 	if (sugov_should_update_freq(sg_policy, time)) {
-- 
2.15.0.194.g9af6a3dea062
