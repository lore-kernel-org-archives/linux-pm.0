From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 0/3] sched: cpufreq: Allow remote callbacks
Date: Wed, 26 Jul 2017 14:52:31 +0530
Message-ID: <cover.1501060871.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:36883 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbdGZJX2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jul 2017 05:23:28 -0400
Received: by mail-pg0-f44.google.com with SMTP id y129so81777101pgy.4
        for <linux-pm@vger.kernel.org>; Wed, 26 Jul 2017 02:23:28 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org, Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Hi,

I had some IRC discussions with Peter and V4 is based on his feedback.
Here is the diff between V3 and V4:

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index d64754fb912e..df9aa1ee53ff 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -79,6 +79,10 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
        s64 delta_ns;
        bool update;
 
+       /* Allow remote callbacks only on the CPUs sharing cpufreq policy */
+       if (!cpumask_test_cpu(smp_processor_id(), sg_policy->policy->cpus))
+               return false;
+
        if (sg_policy->work_in_progress)
                return false;
 
@@ -225,10 +229,6 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
        unsigned int next_f;
        bool busy;
 
-       /* Remote callbacks aren't allowed for policies which aren't shared */
-       if (smp_processor_id() != hook->cpu)
-               return;
-
        sugov_set_iowait_boost(sg_cpu, time, flags);
        sg_cpu->last_update = time;
 
@@ -298,14 +298,9 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 {
        struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
        struct sugov_policy *sg_policy = sg_cpu->sg_policy;
-       struct cpufreq_policy *policy = sg_policy->policy;
        unsigned long util, max;
        unsigned int next_f;
 
-       /* Allow remote callbacks only on the CPUs sharing cpufreq policy */
-       if (!cpumask_test_cpu(smp_processor_id(), policy->cpus))
-               return;
-
        sugov_get_util(&util, &max, hook->cpu);
 
        raw_spin_lock(&sg_policy->update_lock);

-------------------------8<-------------------------

With Android UI and benchmarks the latency of cpufreq response to
certain scheduling events can become very critical. Currently, callbacks
into schedutil are only made from the scheduler if the target CPU of the
event is the same as the current CPU. This means there are certain
situations where a target CPU may not run schedutil for some time.

One testcase to show this behavior is where a task starts running on
CPU0, then a new task is also spawned on CPU0 by a task on CPU1. If the
system is configured such that new tasks should receive maximum demand
initially, this should result in CPU0 increasing frequency immediately.
Because of the above mentioned limitation though this does not occur.
This is verified using ftrace with the sample [1] application.

Maybe the ideal solution is to always allow remote callbacks but that
has its own challenges:

o There is no protection required for single CPU per policy case today,
  and adding any kind of locking there, to supply remote callbacks,
  isn't really a good idea.

o If is local CPU isn't part of the same cpufreq policy as the target
  CPU, then we wouldn't be able to do fast switching at all and have to
  use some kind of bottom half to schedule work on the target CPU to do
  real switching. That may be overkill as well.


And so this series only allows remote callbacks for target CPUs that
share the cpufreq policy with the local CPU.

This series is tested with couple of usecases (Android: hackbench,
recentfling, galleryfling, vellamo, Ubuntu: hackbench) on ARM hikey
board (64 bit octa-core, single policy). Only galleryfling showed minor
improvements, while others didn't had much deviation.

The reason being that this patchset only targets a corner case, where
following are required to be true to improve performance and that
doesn't happen too often with these tests:

- Task is migrated to another CPU.
- The task has maximum demand initially, and should take the CPU to
  higher OPPs.
- And the target CPU doesn't call into schedutil until the next tick.

V3->V4:
- Respect iowait boost flag and util updates for the all remote
  callbacks.
- Minor updates in commit log of 2/3.

V2->V3:
- Rearranged/merged patches as suggested by Rafael (looks much better
  now)
- Also handle new hook added to intel-pstate driver.
- The final code remains the same as V2, except for the above hook.

V1->V2:
- Don't support remote callbacks for unshared cpufreq policies.
- Don't support remote callbacks where local CPU isn't part of the
  target CPU's cpufreq policy.
- Dropped dvfs_possible_from_any_cpu flag.

--
viresh

Viresh Kumar (3):
  sched: cpufreq: Allow remote cpufreq callbacks
  cpufreq: schedutil: Process remote callback for shared policies
  cpufreq: governor: Process remote callback for shared policies

 drivers/cpufreq/cpufreq_governor.c |  4 ++++
 drivers/cpufreq/intel_pstate.c     |  8 ++++++++
 include/linux/sched/cpufreq.h      |  1 +
 kernel/sched/cpufreq.c             |  1 +
 kernel/sched/cpufreq_schedutil.c   | 14 +++++++++-----
 kernel/sched/deadline.c            |  2 +-
 kernel/sched/fair.c                |  8 +++++---
 kernel/sched/rt.c                  |  2 +-
 kernel/sched/sched.h               | 10 ++--------
 9 files changed, 32 insertions(+), 18 deletions(-)

-- 
2.13.0.71.gd7076ec9c9cb
