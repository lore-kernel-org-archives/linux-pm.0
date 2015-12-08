From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH][experimantal] cpufreq: governor: Use an atomic variable for synchronization
Date: Tue, 08 Dec 2015 17:42:37 +0100
Message-ID: <5332935.yle75kNJGs@vostro.rjw.lan>
References: <cover.1449115453.git.viresh.kumar@linaro.org> <1843141.WbisoTkq1u@vostro.rjw.lan> <20151208145658.GG3692@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55992 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756988AbbLHQMj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2015 11:12:39 -0500
In-Reply-To: <20151208145658.GG3692@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, ashwin.chaugule@linaro.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, LKML <linux-kernel@vger.kernel.org>

On Tuesday, December 08, 2015 08:26:58 PM Viresh Kumar wrote:
> On 08-12-15, 15:30, Rafael J. Wysocki wrote:
> > It doesn't look nice, but then having a lockless timer function is worth
> > it in my view.
> > 
> > The code in gov_cancel_work() runs relatively rarely, but the timer
> > function can run very often, so avoiding the lock in there is a priority
> > to me.
> > 
> > Plus we can avoid disabling interrupts in two places this way.
> 
> Okay, that's good enough then. I hope you will be sending these
> patches now, right? And ofcourse, we need documentation in this case
> as well.

Your series is in my linux-next branch now, so that's just one patch on top
of it.  The current version of it is appended.  Unfortunately, I can't test
it here, but I'll do that later today.

I have updated the comments too, so please let me know if they are clear enough.

Thanks,
Rafael


---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] cpufreq: governor: Use lockless timer function

It is possible to get rid of the timer_lock spinlock used by the
governor timer function for synchronization, but a couple of races
need to be avoided.

The first race is between multiple dbs_timer_handler() instances
that may be running in parallel with each other on different
CPUs.  Namely, one of them has to queue up the work item, but it
cannot be queued up more than once.  To achieve that,
atomic_inc_return() can be used on the skip_work field of
struct cpu_common_dbs_info.

The second race is between an already running dbs_timer_handler()
and gov_cancel_work().  In that case the dbs_timer_handler() might
not notice the skip_work incrementation in gov_cancel_work() and
it might queue up its work item after gov_cancel_work() had
returned (and that work item would corrupt skip_work going
forward).  To prevent that from happening, gov_cancel_work()
can be made wait for the timer function to complete (on all CPUs)
right after skip_work has been incremented.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_governor.c |   49 ++++++++++++++++---------------------
 drivers/cpufreq/cpufreq_governor.h |    9 +-----
 2 files changed, 24 insertions(+), 34 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -186,22 +186,24 @@ static inline void gov_cancel_timers(str
 
 void gov_cancel_work(struct cpu_common_dbs_info *shared)
 {
-	unsigned long flags;
-
+	/* Tell dbs_timer_handler() to skip queuing up work items. */
+	atomic_inc(&shared->skip_work);
 	/*
-	 * No work will be queued from timer handlers after skip_work is
-	 * updated. And so we can safely cancel the work first and then the
-	 * timers.
+	 * If dbs_timer_handler() is already running, it may not notice the
+	 * incremented skip_work, so wait for it to complete to prevent its work
+	 * item from being queued up after the cancel_work_sync() below.
+	 */
+	gov_cancel_timers(shared->policy);
+	/*
+	 * In case dbs_timer_handler() managed to run and spawn a work item
+	 * before the timers have been canceled, wait for that work item to
+	 * complete and then cancel all of the timers set up by it.  If
+	 * dbs_timer_handler() runs again at that point, it will see the
+	 * positive value of skip_work and won't spawn any more work items.
 	 */
-	spin_lock_irqsave(&shared->timer_lock, flags);
-	shared->skip_work++;
-	spin_unlock_irqrestore(&shared->timer_lock, flags);
-
 	cancel_work_sync(&shared->work);
-
 	gov_cancel_timers(shared->policy);
-
-	shared->skip_work = 0;
+	atomic_set(&shared->skip_work, 0);
 }
 
 /* Will return if we need to evaluate cpu load again or not */
@@ -229,7 +231,6 @@ static void dbs_work_handler(struct work
 	struct cpufreq_policy *policy;
 	struct dbs_data *dbs_data;
 	unsigned int sampling_rate, delay;
-	unsigned long flags;
 	bool eval_load;
 
 	policy = shared->policy;
@@ -258,9 +259,7 @@ static void dbs_work_handler(struct work
 	delay = dbs_data->cdata->gov_dbs_timer(policy, eval_load);
 	mutex_unlock(&shared->timer_mutex);
 
-	spin_lock_irqsave(&shared->timer_lock, flags);
-	shared->skip_work--;
-	spin_unlock_irqrestore(&shared->timer_lock, flags);
+	atomic_dec(&shared->skip_work);
 
 	gov_add_timers(policy, delay);
 }
@@ -269,22 +268,18 @@ static void dbs_timer_handler(unsigned l
 {
 	struct cpu_dbs_info *cdbs = (struct cpu_dbs_info *)data;
 	struct cpu_common_dbs_info *shared = cdbs->shared;
-	unsigned long flags;
-
-	spin_lock_irqsave(&shared->timer_lock, flags);
 
 	/*
-	 * Timer handler isn't allowed to queue work at the moment, because:
+	 * Timer handler may not be allowed to queue the work at the moment,
+	 * because:
 	 * - Another timer handler has done that
 	 * - We are stopping the governor
-	 * - Or we are updating the sampling rate of ondemand governor
+	 * - Or we are updating the sampling rate of the ondemand governor
 	 */
-	if (!shared->skip_work) {
-		shared->skip_work++;
+	if (atomic_inc_return(&shared->skip_work) > 1)
+		atomic_dec(&shared->skip_work);
+	else
 		queue_work(system_wq, &shared->work);
-	}
-
-	spin_unlock_irqrestore(&shared->timer_lock, flags);
 }
 
 static void set_sampling_rate(struct dbs_data *dbs_data,
@@ -315,7 +310,7 @@ static int alloc_common_dbs_info(struct
 		cdata->get_cpu_cdbs(j)->shared = shared;
 
 	mutex_init(&shared->timer_mutex);
-	spin_lock_init(&shared->timer_lock);
+	atomic_set(&shared->skip_work, 0);
 	INIT_WORK(&shared->work, dbs_work_handler);
 	return 0;
 }
Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
+++ linux-pm/drivers/cpufreq/cpufreq_governor.h
@@ -17,6 +17,7 @@
 #ifndef _CPUFREQ_GOVERNOR_H
 #define _CPUFREQ_GOVERNOR_H
 
+#include <linux/atomic.h>
 #include <linux/cpufreq.h>
 #include <linux/kernel_stat.h>
 #include <linux/module.h>
@@ -137,14 +138,8 @@ struct cpu_common_dbs_info {
 	 */
 	struct mutex timer_mutex;
 
-	/*
-	 * Per policy lock that serializes access to queuing work from timer
-	 * handlers.
-	 */
-	spinlock_t timer_lock;
-
 	ktime_t time_stamp;
-	unsigned int skip_work;
+	atomic_t skip_work;
 	struct work_struct work;
 };
 

