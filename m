From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [RFC 0/3] Utilization estimation for FAIR tasks
Date: Fri, 25 Aug 2017 11:20:05 +0100
Message-ID: <20170825102008.4626-1-patrick.bellasi@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51974 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754454AbdHYKUZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 25 Aug 2017 06:20:25 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Paul Turner <pjt@google.com>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <juri.lelli@arm.com>, Tim Murray <timmurray@google.com>, Todd Kjos <tkjos@android.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Viresh Kumar <viresh.kumar@linaro.org>

This posting presents a possible solution for a problem already
discussed at last year's LPC and more recently discussed at the OSPM
Summit [1].
The aim of this proposal is to improve some PELT behaviors to make it a
better fit for the description of tasks which are common in embedded
mobile use-cases, without affecting other types of workloads.

Hereafter we start from a short description of the observed issues and then
we resume the already explored solution. Finally we introduce a possible
alternative approach which is the one proposed by this RFC. The ultimate
goal of this posting is to prepare the ground for a fruitful discussion at
the upcoming LPC.

.:: Problem description
=======================

The "Per Entity Load Tracking" (PELT) algorithm is a really good and
run-time efficient estimator of task sizes. However, it has some hardcoded
properties which makes it not completely generic to describe all possible
classes of tasks.

PELT's slow ramp-up
-------------------

For example, one such parameter is the time constant used to define the
rate of increase/decay of the geometric series. This constant is
by default defined to optimize the description of periodic tasks with a
32ms period. This means that it takes 32ms for a task's utilization to
ramp up from 0% to 50% and around 100ms to generate ~90% utilization as
shown in this figure:

  https://drive.google.com/open?id=0B5oRu4ZO-uuKb3NGa2FvWC1pZzQ

which has been obtained using the simple (python based) PELT simulator
available here [2] (if you like to play with some other settings).

This behavior is usually described as PELT having a "slow ramp-up",
especially when compared to alternative (non mainline) approaches
(e.g. Qualcomm's proposed "Window Assisted Load Tracking" (WALT) [3]),
and this is mainly affecting mobile workloads.

In the mobile world, where some of the most important tasks are
synchronized with the frame buffer refresh rate, it's quite common to
run tasks on a 16ms period. This 16ms window is the time in
which everything happens for the generation of a new frame, thus it's of
paramount importance to know exactly how much CPU bandwidth is required
by every task running in such a time frame.

Potentially, PELT ramp-up time can be reduced by redefining its time
constant for example to be 8ms. Still it will take at least two frames
for PELT to better describe a task which runs for 4ms every 16ms.
However, has it can be seen from this figure:

  https://drive.google.com/open?id=0B5oRu4ZO-uuKeEN0aGpLRlpOWjA

the utilization of such a task will keep oscillating in the range
~[140, 400] with just the average being the expected ~25%.

PELT's oscillations
-------------------

PELT oscillations are part of its design and they cannot be easily
removed by just tuning its parameters. To a certain extend they are also
required, for example when PELT is used to describe a CPU's
utilization. In this case, once a CPU becomes idle its utilization
represents what is considered its "blocked load", i.e. the utilization
which is potentially going to be reclaimed in a while by tasks
temporarily sleeping on that CPU.
The blocked load signal is(*) progressively decayed thus not allowing a
task to reserve indefinitely its utilization on the CPU where it
executed last time.

Despite being not avoidable, oscillations contributes to make PELT
sometimes a signal which is much more variable than required.
Because of these oscillations a scheduler decision risks to be wrong,
right after it has been taken. Moreover, oscillations increase the
changes to have not consistent views among different subsystems, i.e.
the FAIR scheduler and schedutil.

For example, let's consider the case of a task which wakes up with a
utilization just below a certain threshold value which is critical for a
proper CPU/frequency selection. In this case the scheduler can pick a
CPU which will not be anymore the optimal fit just 1ms after, as well as
schedutil can pick a lower then optimal OPP. This risk is increased by
the fact that the utilization of a task is pre-decayed before being
enqueued into a CPU, as we already do (sometimes) in mainline and we are
going to do even more after certain improvements [4] currently on
discussion on the list are going to be eventually merged.

One last issue of the current PELT implementation is that utilization
decay is never clamped, thus a usually long running task, which wakes up
once in a while, can have its utilization completely decayed.
Thus, it will take the longest time to ram-up from 0% while also
schedutil will have to traverse all the available OPP, from minimum to
maximum.

.:: Possible solutions
======================

As a possible solution for the aforementioned problems, at the previous
LPC, Paul Turner proposed to implement a "decay clamping" mechanism.
The fundamental idea is that, once a task is sleep-suspended, the
utilization of a task is decayed only for a certain (configurable) amount
of time, thus actually retaining at wakeup time part of the utilization we
built up during its last activation.

Such an approach has been implemented by Morten and the prototype
implementation used for testing and evaluation. Our results have been
presented at the last OSPM [1] and the overall impression was that this
approach is not up to the job.
Moreover, being a fundamental modification of how the PELT signal is
actually tracked/updated, there are many implementation details which
potentially open to subtle bugs.

As a possible alternative solution, this series presents a first prototype
for a new signal built "on top of PELT". The fundamental idea is to keep
PELT exactly as it is and use it as an "estimator" which feeds information
into an "aggregator".

>From a utilization standpoint, PELT provides the most complete description
of the bandwidth required by a task once the task completes an activation.
Indeed, once a task is going to sleep we know exactly how much CPU it
required since the PELT signal has build up all the corresponding
utilization.

It is pretty straightforward to keep track of this valuable piece of
information, each time a task is dequeued. The task's utilization can be
also aggregated considering its previous activations, thus building a
useful statistic on how much utilization a task is generally requiring
at each activation.

The aggregated values can be easily used by both the scheduler and
schedutil, via a new pair of {cpu,task}_util_est() methods which are simple
wrappers of the existing {cpu,task}_util() ones. The final result is
something which mimics some of the benefits of WALT but using a streamline
implementation on top of PELT.
Details on how these wrapper methods are implemented and used are described
in the changelog of the following patches.

To resume, what we propose here is a "kind of" simple low-pass filter on
top of PELT which main benefits are:

 1. Simple implementation on top of PELT, thus not risking to break such
    a fundamental component.

 2. Better separation of concerns, where PELT is used as a fast-dynamic
    estimator while util_est is a more low-dynamic aggregator.

 3. The proposed simple implementation can be further extended to
    introduce more advanced features related to tasks behavior profiling,
    still without requiring to modify PELT.

 4. It masks the fast decay of the utilization signal when PELT is
    speeded-up, by tuning its time constant, to reduce utilization's
    build-up time.

 5. PELT oscillation are completely masked, thus providing an overall
    smoothed and consistent representation of task requirements, thus
    reducing the risk of suboptimal or misaligned decisions among
    scheduler and schedutil.

Finally, the proposed solution is so simple since it focuses on just the
entities of interest for the major decisions involving the usage of the
utilization signal. Specifically, the new util_est signal is update just
for SE which are actual tasks and only for CPU's top-level RQs.
The first because are the only entities actually "allocated on CPUs" by the
FAIR scheduler and the last because they represents the only entities of
interest for the frequency selections operated by schedutil.
In other words, task groups related concepts are not affected at all by
the proposed implementation, which is IMHO another big advantage of the
proposed solution.

The current implementation is to be considered as an initial prototype,
which it's however already usable to run some interesting tests and
experiments as the ones which are available here:

  https://gist.github.com/derkling/0d07b97ca18cc5eac25e51404e81169f

Among the different results, when util_est is in use we observed:

  - A significant increase in residency on highest OPP for an example
    task running for 120ms every 300 (60% duty-cycle).
    Such a task, in terms of utilization, is defenitively a big one and
    with util_est schedutil immediately switch to the highest OPP as
    soon as the task wakes up, instead of pregressively scaling up.

  - A smoother OPP reduction when a task switch from being big to being
    small, which introduces an interesting hysteresis on OPP scaling
    down.

  - A perfect PELT's utilization follow-up when the task switch being
    small to being a big one, which (eventually) allows to exploit a
    reduced ramp-up PELT configuration.

  - A proper migration of the CPU's estimated utilization when a task
    migrate across different CPUs, which does not requires any
    modification to PELT itself.

Some of the open point of discussion for potential improvements are:

  - better selection of the value to aggregate
    for example by considering the average value between the task's
    utilization at enqueue and dequeue time (which is likely a better
    representation of the real task utilization)

  - extend the wrapper methods to modulate which estimation to return
    depending on task requirements

  - improve the definition of the estimated utilization of a RQ
    since in this prototype it track simply the last value without any
    kind of historical aggregation, which seems to be good enough but
    maybe it can be made more smart.

.:: Patches organization
========================

The first patch of this series introduces the util_est "aggregator" to
track the estimated utilization of both SEs (Tasks) and (top-level) RQs.
The two following patches presents a possible integration with the
scheduler's LB path and the schedutil's frequency selection policies.

Cheers Patrick

.:: References
==============
[1] slides: http://retis.sssup.it/ospm-summit/Downloads/OSPM_PELT_DecayClampingVsUtilEst.pdf
     video: http://youtu.be/adnSHPBGS-w
[2] https://gist.github.com/derkling/6d1d3a3164b0291ef64fa409f61a81cb
[3] https://lkml.org/lkml/2016/10/28/84
[4] https://patchwork.kernel.org/patch/9876769/

(*) Better saying "it should be", since this is currently not granted to
happen on NO_HZ IDLE CPUs. But this is a different issue outside of the
scope of this posting.

Patrick Bellasi (3):
  sched/fair: add util_est on top of PELT
  sched/fair: use util_est in LB
  sched/cpufreq_schedutil: use util_est for OPP selection

 include/linux/sched.h            |  48 ++++++++++++++++++
 kernel/sched/cpufreq_schedutil.c |   7 ++-
 kernel/sched/debug.c             |   8 +++
 kernel/sched/fair.c              | 106 +++++++++++++++++++++++++++++++++++++--
 kernel/sched/features.h          |   4 ++
 5 files changed, 169 insertions(+), 4 deletions(-)

-- 
2.14.1
