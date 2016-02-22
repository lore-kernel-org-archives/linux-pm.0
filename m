From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v10 1/3] cpufreq: Add mechanism for registering
 utilization update callbacks
Date: Mon, 22 Feb 2016 16:31:32 +0100
Message-ID: <20160222153132.GI6357@twins.programming.kicks-ass.net>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
 <2044559.7ypXocW9OZ@vostro.rjw.lan>
 <3499355.2JlaSruvOa@vostro.rjw.lan>
 <16016177.YFqb4gVNBo@vostro.rjw.lan>
 <CAJZ5v0jthTo8rXMp_ad=k5EcFBcwLgKRMnwPsznqDhois84uYA@mail.gmail.com>
 <20160219080917.GE22643@pablo>
 <1455900129.7375.231.camel@linux.intel.com>
 <56C750B7.6090701@linaro.org>
 <20160222105224.GE6356@twins.programming.kicks-ass.net>
 <CAKfTPtBEREXmhOdZSsY0DM76YdZg=WJn7TN1ADTfAQ806+YN5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:52971 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341AbcBVPbg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Feb 2016 10:31:36 -0500
Content-Disposition: inline
In-Reply-To: <CAKfTPtBEREXmhOdZSsY0DM76YdZg=WJn7TN1ADTfAQ806+YN5w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Mon, Feb 22, 2016 at 03:33:02PM +0100, Vincent Guittot wrote:

> > Right, so I had a wee look at that again, and had a quick chat with Juri
> > on IRC. So the main difference seems to be that you guys want to know
> > why the utilization changed, as opposed to purely _that_ it changed.
> 
> Yes, the main goal was to be able to filter the useful and useless
> update of rq's utilization in order to minimize/optimize the trig of
> an update of the frequency. These patches have been made for a cpufreq
> driver that reacts far slower than scheduler. It's might worth
> starting with a simple solution and update it after

Right, always start simple :-)

> > And hence you have callbacks all over the place.
> >
> > I'm not too sure I really like that too much, it bloats the code and
> > somewhat obfuscates the point.
> >
> > So I would really like there to be just the one callback when we
> > actually compute a new number, and that is update_load_avg().
> >
> > Now I think we can 'easily' propagate the information you want into
> > update_load_avg() (see below), but I would like to see actual arguments
> > for why you would need this.
> 
> Your proposal is interesting except that we are interested in the rq's
> utilization more that se's ones so we should better use
> update_cfs_rq_load_avg and few additional place like
> attach_entity_load_avg which bypasses update_cfs_rq_load_avg to update
> rq's utilization and load

Ah, so the intent was to use the rq->cfs util, but I might have gotten
a little lost in the load update code (I always get confused by that
code if I haven't looked at it for a while).

We can put the hook in update_cfs_rq_load_avg(), that shouldn't be a
problem.

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2859,29 +2859,6 @@ static inline int update_cfs_rq_load_avg
 	cfs_rq->load_last_update_time_copy = sa->last_update_time;
 #endif
 
-	return decayed || removed;
-}
-
-/* Update task and its cfs_rq load average */
-static inline void update_load_avg(struct sched_entity *se, int update_tg,
-				   enum load_update_type type)
-{
-	struct cfs_rq *cfs_rq = cfs_rq_of(se);
-	u64 now = cfs_rq_clock_task(cfs_rq);
-	struct rq *rq = rq_of(cfs_rq);
-	int cpu = cpu_of(rq);
-
-	/*
-	 * Track task load average for carrying it to new CPU after migrated, and
-	 * track group sched_entity load average for task_h_load calc in migration
-	 */
-	__update_load_avg(now, cpu, &se->avg,
-			  se->on_rq * scale_load_down(se->load.weight),
-			  cfs_rq->curr == se, NULL);
-
-	if (update_cfs_rq_load_avg(now, cfs_rq) && update_tg)
-		update_tg_load_avg(cfs_rq, 0);
-
 	if (cpu == smp_processor_id() && &rq->cfs == cfs_rq) {
 		unsigned long max = rq->cpu_capacity_orig;
 
@@ -2904,6 +2881,29 @@ static inline void update_load_avg(struc
 		cpufreq_update_util(rq_clock(rq),
 				    min(cfs_rq->avg.util_avg, max), max);
 	}
+
+	return decayed || removed;
+}
+
+/* Update task and its cfs_rq load average */
+static inline void update_load_avg(struct sched_entity *se, int update_tg,
+				   enum load_update_type type)
+{
+	struct cfs_rq *cfs_rq = cfs_rq_of(se);
+	u64 now = cfs_rq_clock_task(cfs_rq);
+	struct rq *rq = rq_of(cfs_rq);
+	int cpu = cpu_of(rq);
+
+	/*
+	 * Track task load average for carrying it to new CPU after migrated, and
+	 * track group sched_entity load average for task_h_load calc in migration
+	 */
+	__update_load_avg(now, cpu, &se->avg,
+			  se->on_rq * scale_load_down(se->load.weight),
+			  cfs_rq->curr == se, NULL);
+
+	if (update_cfs_rq_load_avg(now, cfs_rq) && update_tg)
+		update_tg_load_avg(cfs_rq, 0);
 }
 
 static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
