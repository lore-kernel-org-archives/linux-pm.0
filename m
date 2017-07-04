From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [PATCH v2 0/6] cpufreq: schedutil: fixes for flags updates
Date: Tue,  4 Jul 2017 18:34:05 +0100
Message-ID: <1499189651-18797-1-git-send-email-patrick.bellasi@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48072 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751982AbdGDReX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 4 Jul 2017 13:34:23 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Joel Fernandes <joelaf@google.com>, Andres Oportus <andresoportus@google.com>, Todd Kjos <tkjos@android.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>

Each time a CPU utilisation update is issued by the scheduler a flag, which
mainly defines which scheduling class is asking for the update, is used by the
frequency selection policy to support the selection of the most appropriate
OPP.
 
In the current implementation, CPU flags are overridden each time the scheduler
calls schedutil for an update. Such a behavior seems to be sub-optimal,
especially on systems where frequency domains span across multiple CPUs.
 
Indeed, assuming CPU1 and CPU2 share the same frequency domain, there can be
the following issues:
 
 A) Small FAIR task running at MAX OPP.
    A RT task, which just executed on CPU1, can keep the domain at the
    max frequency for a prolonged period of time after its completion,
    even if there are no longer RT tasks running on CPUs of its domain.
 
 B) FAIR wakeup reducing the OPP of the current RT task.
    A FAIR task enqueued in a CPU where a RT task is running overrides the flag
    configured by the RT task thus potentially causing an unwanted frequency
    drop.
 
 C) RT wakeup not running at max OPP.
    An RT task waking up on a CPU which has recently updated its OPP can
    be forced to run at a lower frequency because of the throttling
    enforced by schedutil, even if there are not OPP transitions
    currently in progress.

.:: Patches organization
========================
 
This series proposes a set of fixes for the aforementioned issues and it's an
update addressing all the main comments collected from the previous posting
[1].
 
Patches have been re-ordered to have the "less controversial" bits at the
beginning and also to better match the order of the three main issues described
above. These are the relative patches:
 
 A) Fix small FAIR task running at MAX OPP:
    cpufreq: schedutil: ignore the sugov kthread for frequencies selections
    cpufreq: schedutil: reset sg_cpus's flags at IDLE enter
 
 B) FAIR wakeup reducing the OPP of the current RT task.
    cpufreq: schedutil: ensure max frequency while running RT/DL tasks
 
 C) RT wakeup not running at max OPP.
    sched/rt: fast switch to maximum frequency when RT tasks are scheduled
    cpufreq: schedutil: relax rate-limiting while running RT/DL tasks
    cpufreq: schedutil: avoid utilisation update when not necessary

.:: Experimental Results
========================
 
The misbehavior have been verified using a set of simple rt-app based synthetic
workloads, running on a ARM's Juno R2 board where the CPUs of the big cluster
(CPU1 and CPU2) have been reserved to run the workload tasks in isolation from
other system tasks.
 
A detailed description of the experiments executed, and the corresponding
collected results, is available [2] online.
 
Short highlights for these experiments are:
 
 - Patches in group A reduce energy consumption by ~50% by ensuring that
   a small task is always running at the minimum OPP even when the
   sugov's RT kthread is used to change frequencies in the same cluster.
 
 - Patches in group B increase from 4% to 98% the chances for a RT
   task to complete its activations while running at the max OPP.
 
 - Patches in group C do not show measurable differences mainly because of the
   slow OPP switching support available on the JUNO board used for testing.
   However, a trace inspection shows that the sequence of traced events is much
   more deterministic and it better matches the expected system behaviors.
   For example, as soon as a RT task wakeup the scheduler ask for an OPP switch
   to max frequency.
 
Cheers Patrick
 
.:: References
==============
 
[1] https://lkml.org/lkml/2017/3/2/385
[2] https://gist.github.com/derkling/0cd7210e4fa6f2ec3558073006e5ad70


Patrick Bellasi (6):
  cpufreq: schedutil: ignore sugov kthreads
  cpufreq: schedutil: reset sg_cpus's flags at IDLE enter
  cpufreq: schedutil: ensure max frequency while running RT/DL tasks
  cpufreq: schedutil: update CFS util only if used
  sched/rt: fast switch to maximum frequency when RT tasks are scheduled
  cpufreq: schedutil: relax rate-limiting while running RT/DL tasks

 include/linux/sched/cpufreq.h    |  1 +
 kernel/sched/cpufreq_schedutil.c | 61 ++++++++++++++++++++++++++++++++--------
 kernel/sched/idle_task.c         |  4 +++
 kernel/sched/rt.c                | 15 ++++++++--
 4 files changed, 67 insertions(+), 14 deletions(-)

--
2.7.4
