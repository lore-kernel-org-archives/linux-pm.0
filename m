From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 0/4] sched: cpufreq: Allow remote callbacks
Date: Thu, 29 Jun 2017 10:56:29 +0530
Message-ID: <cover.1498712046.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:32997 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751596AbdF2F1y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jun 2017 01:27:54 -0400
Received: by mail-pg0-f49.google.com with SMTP id f127so42323456pgc.0
        for <linux-pm@vger.kernel.org>; Wed, 28 Jun 2017 22:27:54 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org

Hi,

Here is the second version of this series. The first [1] version was
sent several months back.

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
This is verified using ftrace with the sample [2] application.

Maybe the ideal solution is to always allow remote callbacks but that
has its own challenges:

o There is no protection required for single CPU per policy case today,
  and adding any kind of locking there, to supply remote callbacks,
  isn't really a good idea.

o If is local CPU isn't part of the same cpufreq policy as the target
  CPU, then we wouldn't be able to do fast switching at all and have to
  use some kind of bottom half to schedule work on the target CPU to do
  real switching. That may be overkill as well.


Taking above challenges into consideration, this version proposes a much
simpler diff as compared to the first version.

This series only allows remote callbacks for target CPUs that share the
cpufreq policy with the local CPU. Locking is mostly in place everywhere
and we wouldn't be required to change a lot of things.

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


V1->V2:
- Don't support remote callbacks for unshared cpufreq policies.
- Don't support remote callbacks where local CPU isn't part of the
  target CPU's cpufreq policy.
- Dropped dvfs_possible_from_any_cpu flag.

--
viresh

[1] https://marc.info/?l=linux-pm&m=148906015927796&w=2
[2] http://pastebin.com/7LkMSRxE


Steve Muckle (1):
  intel_pstate: Ignore scheduler cpufreq callbacks on remote CPUs

Viresh Kumar (3):
  cpufreq: schedutil: Process remote callback for shared policies
  cpufreq: governor: Process remote callback for shared policies
  sched: cpufreq: Enable remote sched cpufreq callbacks

 drivers/cpufreq/cpufreq_governor.c |  4 ++++
 drivers/cpufreq/intel_pstate.c     |  3 +++
 include/linux/sched/cpufreq.h      |  1 +
 kernel/sched/cpufreq.c             |  1 +
 kernel/sched/cpufreq_schedutil.c   | 19 ++++++++++++++-----
 kernel/sched/deadline.c            |  2 +-
 kernel/sched/fair.c                |  8 +++++---
 kernel/sched/rt.c                  |  2 +-
 kernel/sched/sched.h               | 10 ++--------
 9 files changed, 32 insertions(+), 18 deletions(-)

-- 
2.13.0.71.gd7076ec9c9cb
