From: Michael Turquette <mturquette@baylibre.com>
Subject: [PATCH v3 4/4] [RFC] sched: cfs: cpu frequency scaling policy
Date: Fri, 26 Jun 2015 16:53:44 -0700
Message-ID: <1435362824-26734-5-git-send-email-mturquette@linaro.org>
References: <1435362824-26734-1-git-send-email-mturquette@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33869 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755243AbbFZXyO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2015 19:54:14 -0400
Received: by pabvl15 with SMTP id vl15so75913797pab.1
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2015 16:54:13 -0700 (PDT)
In-Reply-To: <1435362824-26734-1-git-send-email-mturquette@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, preeti@linux.vnet.ibm.com, Morten.Rasmussen@arm.com, riel@redhat.com, efault@gmx.de, nicolas.pitre@linaro.org, daniel.lezcano@linaro.org, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, amit.kucheria@linaro.org, juri.lelli@arm.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, ashwin.chaugule@linaro.org, alex.shi@linaro.org, linux-pm@vger.kernel.org, abelvesa@gmail.com, pebolle@tiscali.nl, Michael Turquette <mturquette@baylibre.com>

From: Michael Turquette <mturquette@baylibre.com>

Implements a very simple policy to scale cpu frequency as a function of
cfs utilization. This policy is a placeholder until something better
comes along. Its purpose is to illustrate how to use the
cpufreq_sched_set_capacity api and allow interested parties to hack on
this stuff.

Signed-off-by: Michael Turquette <mturquette@baylibre.com>
---
Changes in v3:
Split out into separate patch
Capacity calculation moved from cpufreq governor to cfs
Removed use of static key. Replaced with Kconfig option

 kernel/sched/fair.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 46855d0..5ccc384 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4217,6 +4217,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
+	unsigned long utilization, capacity;
 
 	for_each_sched_entity(se) {
 		if (se->on_rq)
@@ -4252,6 +4253,19 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		update_rq_runnable_avg(rq, rq->nr_running);
 		add_nr_running(rq, 1);
 	}
+
+#ifdef CONFIG_CPU_FREQ_GOV_SCHED
+	/* add 25% margin to current utilization */
+	utilization = rq->cfs.utilization_load_avg;
+	capacity = utilization + (utilization >> 2);
+
+	/* handle rounding errors */
+	capacity = (capacity > SCHED_LOAD_SCALE) ? SCHED_LOAD_SCALE :
+		capacity;
+
+	cpufreq_sched_set_cap(cpu_of(rq), capacity);
+#endif
+
 	hrtick_update(rq);
 }
 
@@ -4267,6 +4281,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
 	int task_sleep = flags & DEQUEUE_SLEEP;
+	unsigned long utilization, capacity;
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
@@ -4313,6 +4328,19 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		sub_nr_running(rq, 1);
 		update_rq_runnable_avg(rq, 1);
 	}
+
+#ifdef CONFIG_CPU_FREQ_GOV_SCHED
+	/* add 25% margin to current utilization */
+	utilization = rq->cfs.utilization_load_avg;
+	capacity = utilization + (utilization >> 2);
+
+	/* handle rounding errors */
+	capacity = (capacity > SCHED_LOAD_SCALE) ? SCHED_LOAD_SCALE :
+		capacity;
+
+	cpufreq_sched_set_cap(cpu_of(rq), capacity);
+#endif
+
 	hrtick_update(rq);
 }
 
@@ -7806,6 +7834,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 {
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &curr->se;
+	unsigned long utilization, capacity;
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
@@ -7816,6 +7845,18 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 		task_tick_numa(rq, curr);
 
 	update_rq_runnable_avg(rq, 1);
+
+#ifdef CONFIG_CPU_FREQ_GOV_SCHED
+	/* add 25% margin to current utilization */
+	utilization = rq->cfs.utilization_load_avg;
+	capacity = utilization + (utilization >> 2);
+
+	/* handle rounding errors */
+	capacity = (capacity > SCHED_LOAD_SCALE) ? SCHED_LOAD_SCALE :
+		capacity;
+
+	cpufreq_sched_set_cap(cpu_of(rq), capacity);
+#endif
 }
 
 /*
-- 
1.9.1

