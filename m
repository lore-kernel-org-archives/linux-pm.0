From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH][experimantal] cpufreq: governor: Use an atomic variable for synchronization
Date: Tue, 08 Dec 2015 01:39:53 +0100
Message-ID: <4910771.IIQSzHPqps@vostro.rjw.lan>
References: <cover.1449115453.git.viresh.kumar@linaro.org> <3999637.u4UiK7zxOR@vostro.rjw.lan> <2389125.q3qMOpRs8O@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50998 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753016AbbLHAJ4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2015 19:09:56 -0500
In-Reply-To: <2389125.q3qMOpRs8O@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Cc: linaro-kernel@lists.linaro.org, ashwin.chaugule@linaro.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, LKML <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Use the observation that if skip_work in struct cpu_common_dbs_info
is an atomic_t variable, the code may be rearranged to avoid using
the timer_lock spinlock in which case that lock is not necessary any
more.

Make that change and drop timer_lock.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is on top of my current linux-next branch.  Completely experimental and
untested.

---
 drivers/cpufreq/cpufreq_governor.c |   29 +++++++----------------------
 drivers/cpufreq/cpufreq_governor.h |    9 ++-------
 2 files changed, 9 insertions(+), 29 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -186,22 +186,15 @@ static inline void gov_cancel_timers(str
 
 void gov_cancel_work(struct cpu_common_dbs_info *shared)
 {
-	unsigned long flags;
-
 	/*
 	 * No work will be queued from timer handlers after skip_work is
 	 * updated. And so we can safely cancel the work first and then the
 	 * timers.
 	 */
-	spin_lock_irqsave(&shared->timer_lock, flags);
-	shared->skip_work++;
-	spin_unlock_irqrestore(&shared->timer_lock, flags);
-
+	atomic_inc(&shared->skip_work);
 	cancel_work_sync(&shared->work);
-
 	gov_cancel_timers(shared->policy);
-
-	shared->skip_work = 0;
+	atomic_set(&shared->skip_work, 0);
 }
 
 /* Will return if we need to evaluate cpu load again or not */
@@ -229,7 +222,6 @@ static void dbs_work_handler(struct work
 	struct cpufreq_policy *policy;
 	struct dbs_data *dbs_data;
 	unsigned int sampling_rate, delay;
-	unsigned long flags;
 	bool eval_load;
 
 	policy = shared->policy;
@@ -258,9 +250,7 @@ static void dbs_work_handler(struct work
 	delay = dbs_data->cdata->gov_dbs_timer(policy, eval_load);
 	mutex_unlock(&shared->timer_mutex);
 
-	spin_lock_irqsave(&shared->timer_lock, flags);
-	shared->skip_work--;
-	spin_unlock_irqrestore(&shared->timer_lock, flags);
+	atomic_dec(&shared->skip_work);
 
 	gov_add_timers(policy, delay);
 }
@@ -269,9 +259,6 @@ static void dbs_timer_handler(unsigned l
 {
 	struct cpu_dbs_info *cdbs = (struct cpu_dbs_info *)data;
 	struct cpu_common_dbs_info *shared = cdbs->shared;
-	unsigned long flags;
-
-	spin_lock_irqsave(&shared->timer_lock, flags);
 
 	/*
 	 * Timer handler isn't allowed to queue work at the moment, because:
@@ -279,12 +266,10 @@ static void dbs_timer_handler(unsigned l
 	 * - We are stopping the governor
 	 * - Or we are updating the sampling rate of ondemand governor
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
@@ -315,7 +300,7 @@ static int alloc_common_dbs_info(struct
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
 

