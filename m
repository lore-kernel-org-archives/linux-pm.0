From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [RFC 9/9] sched: cpufreq: enable remote sched cpufreq callbacks
Date: Thu,  9 Mar 2017 17:15:19 +0530
Message-ID: <f6fd5fb42daa4768b27a603adefd33013434ac0d.1489058244.git.viresh.kumar@linaro.org>
References: <cover.1489058244.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:34431 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932319AbdCILqN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Mar 2017 06:46:13 -0500
Received: by mail-pg0-f52.google.com with SMTP id 77so25636906pgc.1
        for <linux-pm@vger.kernel.org>; Thu, 09 Mar 2017 03:46:07 -0800 (PST)
In-Reply-To: <cover.1489058244.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1489058244.git.viresh.kumar@linaro.org>
References: <cover.1489058244.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org, Viresh Kumar <viresh.kumar@linaro.org>

From: Steve Muckle <smuckle.linux@gmail.com>

Now that all clients properly support (or ignore) remote scheduler
cpufreq callbacks, remove the restriction that such callbacks only be
made in CFS on the local CPU.

Signed-off-by: Steve Muckle <smuckle.linux@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/fair.c  | 6 ++++--
 kernel/sched/sched.h | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3e88b35ac157..12db77814814 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3188,7 +3188,9 @@ static inline void set_tg_cfs_propagate(struct cfs_rq *cfs_rq) {}
 
 static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq)
 {
-	if (&this_rq()->cfs == cfs_rq) {
+	struct rq *rq = rq_of(cfs_rq);
+
+	if (&rq->cfs == cfs_rq) {
 		/*
 		 * There are a few boundary cases this might miss but it should
 		 * get called often enough that that should (hopefully) not be
@@ -3205,7 +3207,7 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq)
 		 *
 		 * See cpu_util().
 		 */
-		cpufreq_update_util(rq_of(cfs_rq), 0);
+		cpufreq_update_util(rq, 0);
 	}
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5cbf92214ad8..30c71fc3e02e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1921,7 +1921,8 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags)
 {
 	struct update_util_data *data;
 
-	data = rcu_dereference_sched(*this_cpu_ptr(&cpufreq_update_util_data));
+	data = rcu_dereference_sched(*per_cpu_ptr(&cpufreq_update_util_data,
+						  cpu_of(rq)));
 	if (data)
 		data->func(data, rq_clock(rq), flags);
 }
-- 
2.7.1.410.g6faf27b
