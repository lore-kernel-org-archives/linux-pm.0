From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH 1/2] sched/fair: move cpufreq hook to
 update_cfs_rq_load_avg()
Date: Tue, 12 Apr 2016 17:08:24 -0700
Message-ID: <20160413000824.GB22643@graphite.smuckle.net>
References: <56F97856.4040804@arm.com>
 <56F98832.3030207@linaro.org>
 <20160330193544.GD407@worktop>
 <56FC807C.80204@linaro.org>
 <20160331073743.GF3408@twins.programming.kicks-ass.net>
 <56FD95EE.6090007@linaro.org>
 <20160401092019.GN3430@twins.programming.kicks-ass.net>
 <570BFAE2.4080301@linaro.org>
 <CAJZ5v0imtij-smQBds1aTNMuFsNbbzvoyAJ5-=Pp8Ae1GSNWvQ@mail.gmail.com>
 <CAJZ5v0gNt5kMV8jjQuASTxUBE=FZ45x2Go0RNsyaZMLk+dAsKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VS++wcV0S1rZb1Fb"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35532 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbcDMAIa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Apr 2016 20:08:30 -0400
Received: by mail-pf0-f170.google.com with SMTP id n1so23023815pfn.2
        for <linux-pm@vger.kernel.org>; Tue, 12 Apr 2016 17:08:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gNt5kMV8jjQuASTxUBE=FZ45x2Go0RNsyaZMLk+dAsKQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Tue, Apr 12, 2016 at 04:29:06PM +0200, Rafael J. Wysocki wrote:
> This is rather fundamental.
> 
> For example, if you look at cpufreq_update_util(), it does this:
> 
> data = rcu_dereference_sched(*this_cpu_ptr(&cpufreq_update_util_data));
> 
> meaning that it will run the current CPU's utilization update
> callback.  Of course, that won't work cross-CPU, because in principle
> different CPUs may use different governors and therefore different
> util update callbacks.

Will something like the attached (unfinished patches) work? It seems
to for me, but I haven't tested it much beyond confirming the hook is
working on remote wakeups.

I'm relying on the previous comment that it's up to cpufreq drivers to
run stuff on the target policy's CPUs if the driver needs that.

There's still some more work, fixing up some more smp_processor_id()
usage in schedutil, but it should be easy (trace, slow path irq_work
target).

> If you want to do remote updates, I guess that will require an
> irq_work to run the update on the target CPU, but then you'll probably
> want to neglect the rate limit on it as well, so it looks like a
> "need_update" flag in struct update_util_data will be useful for that.

Why is it required to run the update on the target CPU?

thanks,
Steve

--VS++wcV0S1rZb1Fb
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="0001-sched-cpufreq_sched-remove-smp_processor_id-usage.patch"

>From 925cdc4a72334e7ed8551d5ba41138ea7a3aede9 Mon Sep 17 00:00:00 2001
From: Steve Muckle <smuckle@linaro.org>
Date: Tue, 12 Apr 2016 16:08:20 -0700
Subject: [PATCH 1/2] sched/cpufreq_sched: remove smp_processor_id() usage

To prepare for supporting cpufreq hook callbacks during remote
wakeups, remove the usage of smp_processor_id() in
sugov_next_freq_shared(), since that function may now not be called on
the CPU being updated.

Signed-off-by: Steve Muckle <smuckle@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index b283b7554486..43ae972eb55a 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -145,9 +145,10 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	sugov_update_commit(sg_policy, time, next_f);
 }
 
-static unsigned int sugov_next_freq_shared(struct sugov_policy *sg_policy,
+static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu,
 					   unsigned long util, unsigned long max)
 {
+	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	struct cpufreq_policy *policy = sg_policy->policy;
 	unsigned int max_f = policy->cpuinfo.max_freq;
 	u64 last_freq_update_time = sg_policy->last_freq_update_time;
@@ -161,10 +162,10 @@ static unsigned int sugov_next_freq_shared(struct sugov_policy *sg_policy,
 		unsigned long j_util, j_max;
 		u64 delta_ns;
 
-		if (j == smp_processor_id())
+		j_sg_cpu = &per_cpu(sugov_cpu, j);
+		if (j_sg_cpu == sg_cpu)
 			continue;
 
-		j_sg_cpu = &per_cpu(sugov_cpu, j);
 		/*
 		 * If the CPU utilization was last updated before the previous
 		 * frequency update and the time elapsed between the last update
@@ -204,7 +205,7 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 	sg_cpu->last_update = time;
 
 	if (sugov_should_update_freq(sg_policy, time)) {
-		next_f = sugov_next_freq_shared(sg_policy, util, max);
+		next_f = sugov_next_freq_shared(sg_cpu, util, max);
 		sugov_update_commit(sg_policy, time, next_f);
 	}
 
-- 
2.4.10


--VS++wcV0S1rZb1Fb
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="0002-sched-fair-call-cpufreq-hook-for-remote-wakeups.patch"

>From ae6eb75162f11674cbdc569466e3def4e0eed077 Mon Sep 17 00:00:00 2001
From: Steve Muckle <smuckle@linaro.org>
Date: Tue, 12 Apr 2016 15:19:34 -0700
Subject: [PATCH 2/2] sched/fair: call cpufreq hook for remote wakeups

Without calling the cpufreq hook for a remote wakeup it is possible
for such a wakeup to go unnoticed by cpufreq on the target CPU for up
to a full tick.

Signed-off-by: Steve Muckle <smuckle@linaro.org>
---
 kernel/sched/fair.c  | 8 +++-----
 kernel/sched/sched.h | 7 ++++---
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b06c1e938cb9..d21a80a44b6e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2826,15 +2826,13 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	int cpu = cpu_of(rq);
 
-	if (cpu == smp_processor_id() && &rq->cfs == cfs_rq) {
+	if (&rq->cfs == cfs_rq) {
 		unsigned long max = rq->cpu_capacity_orig;
 
 		/*
 		 * There are a few boundary cases this might miss but it should
 		 * get called often enough that that should (hopefully) not be
-		 * a real problem -- added to that it only calls on the local
-		 * CPU, so if we enqueue remotely we'll miss an update, but
-		 * the next tick/schedule should update.
+		 * a real problem.
 		 *
 		 * It will not get called when we go idle, because the idle
 		 * thread is a different class (!fair), nor will the utilization
@@ -2845,7 +2843,7 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq)
 		 *
 		 * See cpu_util().
 		 */
-		cpufreq_update_util(rq_clock(rq),
+		cpufreq_update_util(cpu, rq_clock(rq),
 				    min(cfs_rq->avg.util_avg, max), max);
 	}
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 921d6e5d33b7..01faa0781099 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1808,11 +1808,12 @@ DECLARE_PER_CPU(struct update_util_data *, cpufreq_update_util_data);
  *
  * It can only be called from RCU-sched read-side critical sections.
  */
-static inline void cpufreq_update_util(u64 time, unsigned long util, unsigned long max)
+static inline void cpufreq_update_util(int cpu, u64 time, unsigned long util,
+				       unsigned long max)
 {
        struct update_util_data *data;
 
-       data = rcu_dereference_sched(*this_cpu_ptr(&cpufreq_update_util_data));
+       data = rcu_dereference_sched(per_cpu(cpufreq_update_util_data, cpu));
        if (data)
                data->func(data, time, util, max);
 }
@@ -1835,7 +1836,7 @@ static inline void cpufreq_update_util(u64 time, unsigned long util, unsigned lo
  */
 static inline void cpufreq_trigger_update(u64 time)
 {
-	cpufreq_update_util(time, ULONG_MAX, 0);
+	cpufreq_update_util(smp_processor_id(), time, ULONG_MAX, 0);
 }
 #else
 static inline void cpufreq_update_util(u64 time, unsigned long util, unsigned long max) {}
-- 
2.4.10


--VS++wcV0S1rZb1Fb--
