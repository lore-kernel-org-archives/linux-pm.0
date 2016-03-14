From: Michael Turquette <mturquette@baylibre.com>
Subject: [PATCH 1/8] sched/cpufreq: remove cpufreq_trigger_update()
Date: Sun, 13 Mar 2016 22:22:05 -0700
Message-ID: <1457932932-28444-2-git-send-email-mturquette+renesas@baylibre.com>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36357 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933217AbcCNF0P (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Mar 2016 01:26:15 -0400
Received: by mail-pf0-f182.google.com with SMTP id u190so98870520pfb.3
        for <linux-pm@vger.kernel.org>; Sun, 13 Mar 2016 22:26:14 -0700 (PDT)
In-Reply-To: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri.Lelli@arm.com, steve.muckle@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>

cpufreq_trigger_update() was introduced in "cpufreq: Rework the
scheduler hooks for triggering updates"[0]. Consensus is that this
helper is not needed and removing it will aid in experimenting with
deadline and rt capacity requests.

Instead of reverting the above patch, which includes useful renaming of
data structures and related functions, simply remove the function,
update affected kerneldoc and change rt.c and deadline.c to use
cpufreq_update_util().

[0] lkml.kernel.org/r/7541372.ciUW4go8Ux@vostro.rjw.lan

Signed-off-by: Michael Turquette <mturquette+renesas@baylibre.com>
---
 kernel/sched/cpufreq.c  | 28 ++--------------------------
 kernel/sched/deadline.c |  2 +-
 kernel/sched/rt.c       |  2 +-
 kernel/sched/sched.h    |  2 --
 4 files changed, 4 insertions(+), 30 deletions(-)

diff --git a/kernel/sched/cpufreq.c b/kernel/sched/cpufreq.c
index eecaba4..bd012c2 100644
--- a/kernel/sched/cpufreq.c
+++ b/kernel/sched/cpufreq.c
@@ -20,8 +20,8 @@ static DEFINE_PER_CPU(struct freq_update_hook *, cpufreq_freq_update_hook);
  *
  * Set and publish the freq_update_hook pointer for the given CPU.  That pointer
  * points to a struct freq_update_hook object containing a callback function
- * to call from cpufreq_trigger_update().  That function will be called from
- * an RCU read-side critical section, so it must not sleep.
+ * to call from cpufreq_update_util().  That function will be called from an
+ * RCU read-side critical section, so it must not sleep.
  *
  * Callers must use RCU-sched callbacks to free any memory that might be
  * accessed via the old update_util_data pointer or invoke synchronize_sched()
@@ -87,27 +87,3 @@ void cpufreq_update_util(u64 time, unsigned long util, unsigned long max)
 	if (hook)
 		hook->func(hook, time, util, max);
 }
-
-/**
- * cpufreq_trigger_update - Trigger CPU performance state evaluation if needed.
- * @time: Current time.
- *
- * The way cpufreq is currently arranged requires it to evaluate the CPU
- * performance state (frequency/voltage) on a regular basis.  To facilitate
- * that, cpufreq_update_util() is called by update_load_avg() in CFS when
- * executed for the current CPU's runqueue.
- *
- * However, this isn't sufficient to prevent the CPU from being stuck in a
- * completely inadequate performance level for too long, because the calls
- * from CFS will not be made if RT or deadline tasks are active all the time
- * (or there are RT and DL tasks only).
- *
- * As a workaround for that issue, this function is called by the RT and DL
- * sched classes to trigger extra cpufreq updates to prevent it from stalling,
- * but that really is a band-aid.  Going forward it should be replaced with
- * solutions targeted more specifically at RT and DL tasks.
- */
-void cpufreq_trigger_update(u64 time)
-{
-	cpufreq_update_util(time, ULONG_MAX, 0);
-}
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 1a035fa..3fd5bc4 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -728,7 +728,7 @@ static void update_curr_dl(struct rq *rq)
 
 	/* Kick cpufreq (see the comment in drivers/cpufreq/cpufreq.c). */
 	if (cpu_of(rq) == smp_processor_id())
-		cpufreq_trigger_update(rq_clock(rq));
+		cpufreq_update_util(rq_clock(rq), ULONG_MAX, 0);
 
 	/*
 	 * Consumed budget is computed considering the time as
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 9dd1c09..53ad077 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -947,7 +947,7 @@ static void update_curr_rt(struct rq *rq)
 
 	/* Kick cpufreq (see the comment in drivers/cpufreq/cpufreq.c). */
 	if (cpu_of(rq) == smp_processor_id())
-		cpufreq_trigger_update(rq_clock(rq));
+		cpufreq_update_util(rq_clock(rq), ULONG_MAX, 0);
 
 	delta_exec = rq_clock_task(rq) - curr->se.exec_start;
 	if (unlikely((s64)delta_exec <= 0))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7ae012e..f06dfca 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1742,9 +1742,7 @@ static inline u64 irq_time_read(int cpu)
 
 #ifdef CONFIG_CPU_FREQ
 void cpufreq_update_util(u64 time, unsigned long util, unsigned long max);
-void cpufreq_trigger_update(u64 time);
 #else
 static inline void cpufreq_update_util(u64 time, unsigned long util,
 				       unsigned long max) {}
-static inline void cpufreq_trigger_update(u64 time) {}
 #endif /* CONFIG_CPU_FREQ */
-- 
2.1.4

