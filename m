From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 0/3] sched: cpufreq: Allow remote callbacks
Date: Thu, 13 Jul 2017 12:14:36 +0530
Message-ID: <cover.1499927699.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org, Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Hi,

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

[1] http://pastebin.com/7LkMSRxE

Viresh Kumar (3):
  sched: cpufreq: Allow remote cpufreq callbacks
  cpufreq: schedutil: Process remote callback for shared policies
  cpufreq: governor: Process remote callback for shared policies

 drivers/cpufreq/cpufreq_governor.c |  4 ++++
 drivers/cpufreq/intel_pstate.c     |  8 ++++++++
 include/linux/sched/cpufreq.h      |  1 +
 kernel/sched/cpufreq.c             |  1 +
 kernel/sched/cpufreq_schedutil.c   | 19 ++++++++++++++-----
 kernel/sched/deadline.c            |  2 +-
 kernel/sched/fair.c                |  8 +++++---
 kernel/sched/rt.c                  |  2 +-
 kernel/sched/sched.h               | 10 ++--------
 9 files changed, 37 insertions(+), 18 deletions(-)

-- 
2.13.0.71.gd7076ec9c9cb
