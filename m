From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [RFC 0/9] cpufreq: schedutil: Allow remote wakeups
Date: Thu,  9 Mar 2017 17:15:10 +0530
Message-ID: <cover.1489058244.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi,

This is based of the work done by Steve Muckle [1] before he left Linaro
and most of the patches are still under his authorship. I have done
couple of improvements (detailed in individual patches) and removed the
late callback support [2] as I wasn't sure of the value it adds. We can
include it separately if others feel it is required. This series is
based on pm/linux-next with patches [3] and [4] applied on top of it.

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
This is verified using ftrace with the sample [5] application.

This patchset updates the scheduler to call cpufreq callbacks for remote
CPUs as well and updates schedutil governor to deal with it. An
additional flag is added to cpufreq policies to avoid sending IPIs to
remote CPUs to update the frequency, if CPUs on the platform can change
frequency of any other CPU.

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
- And the target CPU doesn't call into schedutil until the next tick,
  without this patchset.

--
viresh

[1] https://git.linaro.org/people/steve.muckle/kernel.git/log/?h=pmwg-integration
[2] https://git.linaro.org/people/steve.muckle/kernel.git/commit/?h=pmwg-integration&id=8f2ba60cde7e8ce9f9e5994bf8887371d7d6569c
[3] https://marc.info/?l=linux-kernel&m=148766093718487&w=2
[4] https://marc.info/?l=linux-kernel&m=148903231720432&w=2
[5] http://pastebin.com/7LkMSRxE

Steve Muckle (8):
  sched: cpufreq: add cpu to update_util_data
  irq_work: add irq_work_queue_on for !CONFIG_SMP
  sched: cpufreq: extend irq work to support fast switches
  sched: cpufreq: remove smp_processor_id() in remote paths
  sched: cpufreq: detect, process remote callbacks
  cpufreq: governor: support scheduler cpufreq callbacks on remote CPUs
  intel_pstate: ignore scheduler cpufreq callbacks on remote CPUs
  sched: cpufreq: enable remote sched cpufreq callbacks

Viresh Kumar (1):
  cpufreq: Add dvfs_possible_from_any_cpu policy flag

 drivers/cpufreq/cpufreq-dt.c       |  1 +
 drivers/cpufreq/cpufreq_governor.c |  2 +-
 drivers/cpufreq/intel_pstate.c     |  3 ++
 include/linux/cpufreq.h            |  9 +++++
 include/linux/irq_work.h           |  7 ++++
 include/linux/sched/cpufreq.h      |  1 +
 kernel/sched/cpufreq.c             |  1 +
 kernel/sched/cpufreq_schedutil.c   | 80 +++++++++++++++++++++++++++++---------
 kernel/sched/fair.c                |  6 ++-
 kernel/sched/sched.h               |  3 +-
 10 files changed, 90 insertions(+), 23 deletions(-)

-- 
2.7.1.410.g6faf27b
