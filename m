From: Steve Muckle <steve.muckle@linaro.org>
Subject: [PATCH 0/5] cpufreq: schedutil: improve latency of response
Date: Mon,  9 May 2016 14:20:09 -0700
Message-ID: <1462828814-32530-1-git-send-email-smuckle@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>
List-Id: linux-pm@vger.kernel.org

The cpufreq update hook is presently not called when the target CPU is not the
current CPU. This may cause a delay in adjusting the frequency of the target
CPU to accommodate new task load since the target CPU may not run the scheduler
hook until the next tick.

In order to test this series I wrote a small sample program that reproduces a
scenario susceptible to the problem above. I ran this on x86 since ARM
currently lacks both fast switch support and a high priority (RT/DL) slow path
switch context. With HZ set to 100 I was easily able to see an unnecessary
latency of 7ms in the target CPU frequency being re-evaluated and adjusted.
This latency is eliminated with this series.

This is the second version of a patch series initially posted here:
http://thread.gmane.org/gmane.linux.power-management.general/74977
The approach is quite different though. The dbs and intel_pstate governors are
not modified to take remote callbacks and the scheduler modifications are
rather different so as to avoid redundant IPIs.

Having the governor invoke the switch on a remote CPU means sending an IPI.
Unfortunately if the scheduler event also results in preemption, the scheduler
(and consequently the cpufreq hook) will run soon on the target CPU anyway. A
resched IPI may also be sent. In short it is desirable to not run the cpufreq
hook remotely if preemption will occur as a result of the scheduler event. To
achieve this, remote cpufreq callbacks are processed after preemption is
decided in check_preempt_curr().

Another optimization is to process callbacks from remote CPUs within a target
CPU's cpufreq policy on the remote CPU, since any CPU within a frequency domain
should be able to update the frequency there.

Legacy behavior of the cpufreq hook, where the callback only occurs on the
target CPU, is maintained via special usage of a new parameter to
cpufreq_add_update_util_hook(). That function now takes a fourth parameter,
cpumask_var_t *policy_cpus. If NULL then the hook is not called remotely.
Otherwise it is expected to point to the cpumask for the frequency domain so
the scheduler may differentiate between local and remote callbacks as above.
Clients of the hook other than schedutil are configured to only receive local
callbacks so their behavior does not change.

The above logic did not alone fix the original issue because currently,
schedutil does not assign the raw required frequency to a target-supported
frequency. This means that even small variations in raw required frequency will
result in an attempted frequency switch and a corresponding advance of the rate
limit timestamp, last_freq_update_time. If the actual target-supported
frequency is unchanged then this is not necessary; furthermore, schedutil
will now be rate limited causing any imminent and more substantial updates to
have to wait.

To address this the required target-supported frequency is now calculated in
schedutil. Also last_freq_update_time is not advanced if there is no change in
the requested target-supported frequency. I expect the mapping to
target-supported frequency to require discussion since acpu_cpufreq_fast_switch
also performs this mapping.

I attempted to look for general performance regression but results seemed to be
inconclusive (tried a couple passes each).

model name      : Intel(R) Core(TM) i7-3630QM CPU @ 2.40GHz
Performance counter stats for 'perf bench sched messaging -g 50 -l 5000' (30 runs):
baseline w/perf gov:
 20.847382649 seconds time elapsed ( +-  0.14% )
 20.701305631 seconds time elapsed ( +-  0.17% )
patched w/perf gov:
 20.665433861 seconds time elapsed ( +-  0.19% )
 20.606157659 seconds time elapsed ( +-  0.19% )
baseline w/sched gov:
 20.893686693 seconds time elapsed ( +-  0.12% )
 20.639752039 seconds time elapsed ( +-  0.12% )
patched w/sched gov:
 20.847845042 seconds time elapsed ( +-  0.14% )
 20.644003401 seconds time elapsed ( +-  0.14% )

Steve Muckle (5):
  sched: cpufreq: add cpu to update_util_data
  cpufreq: schedutil: support scheduler cpufreq callbacks on remote CPUs
  sched: cpufreq: call cpufreq hook from remote CPUs
  cpufreq: schedutil: map raw required frequency to CPU-supported
    frequency
  cpufreq: schedutil: do not update rate limit ts when freq is unchanged

 drivers/cpufreq/cpufreq_governor.c |   2 +-
 drivers/cpufreq/intel_pstate.c     |   2 +-
 include/linux/sched.h              |   5 +-
 kernel/sched/core.c                |   4 ++
 kernel/sched/cpufreq.c             |  14 ++++-
 kernel/sched/cpufreq_schedutil.c   | 105 +++++++++++++++++++++++++++---------
 kernel/sched/fair.c                |  40 +++++++-------
 kernel/sched/sched.h               | 106 +++++++++++++++++++++++++++++--------
 8 files changed, 206 insertions(+), 72 deletions(-)

-- 
2.4.10
