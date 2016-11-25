From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [SchedTune] Summary of LPC SchedTune discussion in Santa Fe
Date: Fri, 25 Nov 2016 11:28:01 +0000
Message-ID: <20161125112801.GB6016@e105326-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:43620 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751041AbcKYLhq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 25 Nov 2016 06:37:46 -0500
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tejun Heo <tj@kernel.org>, Paul Turner <pjt@google.com>, Todd Kjos <tkjos@google.com>, Srinath Sridharan <srinathsr@google.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Vincent Guittot <vincent.guittot@linaro.org>, Leo Yan <leo.yan@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, John Stultz <john.stultz@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <juri.lelli@arm.com>, Chris Redpath <chris.redpath@armcom>, Robin Randhawa <robin.randhawa@arm.com>

The topic of a single simple power-performance tunable, that is wholly
scheduler centric, and has well defined and predictable properties has
come up on several occasions in the past. With techniques such as
scheduler driven DVFS available in the mainline kernel via the
schedutil cpufreq governor, we now have a good framework for
implementing such a tunable.

I posted v2 of a proposal for such a tunable just before the LPC.
This was unfortunately too late but despite that, thanks to Peter
Zijlstra, Paul Turner and Tejun Heo, I was able to collect some
valuable feedback during the LPC week.

The aim of this post is to summarize the feedback so the community is
aware and bought in. The ultimate goal is to get feedback from
involved maintainers and interested stakeholders on what we would like
to present as "SchedTune" in a future re-spin of this patch set.

The previous SchedTune proposal is described in detail in the
documentation patch [1] of the previously posted series [2].
Interested readers are advised to go through that documentation patch
whenever it's necessary to build context.

The following sections resume the main points of the previous proposal
and relative concerns we collected so far. The last section will wrap
things up and present an alternative proposal which is the outcome of
the discussions with PeterZ and PaulT at the LPC.

Main concerns with the previous proposal
========================================


A) Introduction of a new CGroup controller

   Our previous proposal introduced a new CGroup controller which
   allows "informed run-times" (e.g. Android, ChromeOS) to classify
   tasks by assigning them different boost values.  In the solution
   previously proposed, the boost value is used just to affect how
   schedutil selects the OPP. However, in the complete solution we
   have internally, the same boost value has been used to bias task
   placement, in the wakeup path, with the goal to improve the
   power/performance awareness of the Energy-Aware scheduler.

   Since the boost value is affecting the availability of the CPU
   resource (i.e. CPU's bandwidth), Tejun and PaulT suggested that we
   should avoid adding another controller, which is dedicated just for
   CPU boosting and instead try to integrate the boosting concept into
   the existing CPU controller, i.e. under CONFIG_GROUP_SCHED.

   According to them this should provide not only a more
   mainline-aligned solution but also a more coherent view on what is
   the status of the CPU resource and it's partitioning among
   different tasks.  More on that point is also discussed in the
   following section C (usage of a single knob)


B) Usage of a flat hierarchy

   The SchedTune controller in our previous attempt provided support
   only for a "flat grouping" of boosted tasks. This was a deliberate
   design choice, since we considered it reasonable to have, for
   example:
    - GroupA: tasks boosted 60%
    - GroupB: tasks boosted 10%

   While a grouping where:
    - GroupA: tasks boosted 60%
    - GroupB: subset of TasksA which are boosted only 10%
   does not seem to be very interesting. At least not for the
   use-cases we based our design on, i.e. mainly related to mobile
   workloads available in Android and ChromeOS devices.

   Tejun's concern on this point was:
   a) a flat hierarchy does not match the expected "generic behaviors" of
      the CGroup interface
   b) more specifically, such a controller cannot be easily used in
      a CGroup v2 solution


C) Usage of a single knob

   The mechanism we proposed aims at supporting the translation of a
   single boost value into a set of sensible (and possibly coherent)
   behaviors bias for existing kernel frameworks. More specifically,
   the patches we posted transparently integrate with schedutil by
   artificially inflating the CPU's utilization signal (i.e.
   rq->cfs.avg.util_avg) by a certain quantity. This quantity, namely
   margin, is internally defined to be proportional to the boost value
   itself and the spare CPU's bandwidth.

   According to comments from PaulT, the topic of a "single tunable"
   has been kind-of demoted, mainly based on the consideration that a
   single knob cannot really be used to provide a complete and granted
   performance tuning support.

   What PaulT observed is that the inflation of the CPU's utilization,
   based on the boost value, does not guarantee that a task will
   get the expected boost in performance. For example we cannot
   guarantee that a 10% boosted task will run 10% faster and/or
   complete 10% sooner.

   PaulT also argued that the actual performance boost a task will get
   depends on the specific combination of boost value and available
   OPPs. For example, a 10% inflated CPU utilization may not be
   sufficient to trigger an OPP switch, thus having the task running
   as if it was not boosted, while even just a 11% boost can produce
   an OPP switch.
   Finally, he was arguing also that a spare-capacity boosting feature
   is almost useless for tasks which are already quite big. For
   example the same 30% SPC boost [1] translates into a big margin
   (~30%) for a small 10% task but it's just a negligible margin (~6%)
   for an already big 80% task.

   Most of these arguments are mainly referring to implementation
   details, which can be fixed by improving the previous solution to
   be more aware about the set of available OPPs.
   However, it's also true that the previous SchedTune implementation
   is not designed to guarantee performance but instead to provide a
   "best effort" solution while seamlessly integrating into existing
   frameworks.

   What we agreed in the discussion with PaulT is that there can be a
   possible different implementation, which is more "aligned" to
   existing mainline controllers, to better achieve a similar
   "best-effort" solution for task boosting. Such a solution requires
   a major re-design of SchedTune which is covered in the next
   section.

Alternative proposal
====================

Based on the previous observations we had an interesting discussion
with PaulT and PeterZ which ended up in the design of a possible
alternative proposal. The idea is to better exploit the features of
the existing CPU controller as well as to extend it to provide some
additional features on top of it.
We call it an "alternative proposal" because we still want to use the
previous SchedTune implementation as a benchmark to verify if we are
able with the new design to achieve the same performance levels with
the new design.

The following list enumerates how SchedTune concepts in the previously
posted implementation are translated into a new design as a result of
the LPC discussion:

A) Boost value

   Instead of adding a new custom controller, to boost the performance of
   a task, we can use the existing CPU controller and specifically its
   cpu.shares attribute as a _relative_ priority tuning.
   Indeed, it's worth noting that the actual boost for a task
   depends on the cpu.shares of all other groups in the system.

   One possible way of using cpu.shares for tasks boosting is:

    - by default all task groups have a 1024 share
    - boosted task groups will get a share >1024,
      which translates into more CPU time to run
    - negative boosted task groups will get a share <1024,
      which translates into less CPU time to run

   A proper configuration of CPUs shares should allow to reduce
   chances to preempt boosted tasks by non-boosted tasks.  It's worth
   to notice that the previous solution was targeting only OPP
   boosting and, thus, it's just a part of a more complete solution
   which also tries to mitigate preemption. However, being an
   extension of mainline code, the proposed alternative seems to be
   more simple to extend in order to get similar benefits.

   Finally, it's worth to notice that we are not playing with the
   bandwidth controller. The usage of cpu.shares is intentional since
   it's a more fair approach to repartition the "spare" CPU bandwidth
   of a CPU, thus not penalizing unnecessary tasks with smaller shares
   while there are not high shares values runnable tasks.


B) OPP biasing

   The usage of cpu.shares is not directly usable to bias OPP
   selection.

   The new proposal is to add a new cpu.min_capacity attribute and
   ensure that tasks in the cgroup are always scheduled on a CPU which
   provides at least the required minimum capacity.

   The proper minimum capacity to enforce on a CPU depends on which
   tasks are RUNNABLE on that CPU. This requires the implementation of
   task accounting support within the CPU controller. The goal is to
   know exactly how many tasks are runnable on that CPU per each
   different task group. This support is already provided by the
   existing SchedTune implementation and it can be reused for the new
   proposal.


C) Negative boosting

   The previous proposal allows also to force run tasks of a group on
   an OPP lower than the one normally selected by schedutil.

   To implement such a feature without using the margin concept
   introduced in [1], a new cpu.max_capacity attribute needs to be
   added to the CPU controller.

   Tasks in a task cgroup with a max_capacity constraint will be
   (possibly) scheduled on a CPU providing at least that capacity,
   regardless of the actual utilization of the task.

D) Latency reduction

   Tasks with a higher cpu.shares value are entitled more CPU time and
   this gives them a better chance to run to completion when scheduled
   by not being preempted by other tasks with lower shares.  However,
   there are no "granted" effects of shares on reducing the wakeup
   latency.

   A latency reduction effect for fair tasks has to be considered a
   more experimental feature which can be (eventually) achieved by a
   further extension of the CFS scheduler. A possible extension can be
   investigated to eventually preempt a currently running low-share
   task when a task with a higher share wakes up.

   NOTE: such a solution aims at improving latency responsiveness of the
         "best-effort" CFS scheduler. For any more real-time usage
         scenarios the FIFO and DEADLINE scheduling classes should be
         used to properly manage their tasks.

   NOTE: the CPU bandwidth not consumed by high cpu.shares value tasks
         is still available for tasks with lower shares.


E) CPU selection (i.e. task packing vs spreading strategy)

   A further extension (not yet posted on LKML) of the SchedTune
   proposal was targeting the biasing of the CPU selection in the
   wakeup path based on the boost value. The fundamental idea is that
   task placement considers the utilization value of a task to decide
   in which CPU it should be scheduled.  For example, boosted tasks
   can be scheduled on an idle CPU, to further reduce latency, while
   non boosted tasks are scheduled in the best CPU/OPP to improve
   energy efficiency.

   In the new proposal, the cpu.shares value can be used as a “flag”
   to know when a task is boosted. For example, if cpu.shares > 1024
   we look for an idle CPU, otherwise we use the energy-aware
   scheduling wakeup path. That's intentionally an oversimplified
   description since we would like to better elaborate on this topic,
   based on real use-case scenarios, as well as because we believe the
   new alternative SchedTune proposal has a value independently from
   its possible integration with the energy-aware scheduler.

   In addition to these heuristics, the cpu.min_capacity can also bias
   the wakeup path toward the selection of a more capable CPU, as well
   as the cpu.max_capacity can bias the selection of a lower capacity
   CPU.


Conclusions and future works
============================

We would really like to get a general consensus on the soundness of
the new proposed SchedTune design. This consensus should ideally
include key maintainers (Tejun, Ingo, Peter and Rafael) as well as
interested key stakeholders (PaulT and other Google/Android/ChromeOS
folks, Linaro folks, etc..).

>From our (ARM Ltd) side the next steps are:

1) collect further feedback to properly refine the design of
   what will be the next RFCv3 of SchedTune

2) develop and present on LKML the RFCv3 for SchedTune which should
   implement the consensus driven design from the previous step


References
==========

[1] https://marc.info/?i=20161027174108.31139-2-patrick.bellasi@arm.com
[2] https://marc.info/?i=20161027174108.31139-1-patrick.bellasi@arm.com

-- 
#include <best/regards.h>

Patrick Bellasi
