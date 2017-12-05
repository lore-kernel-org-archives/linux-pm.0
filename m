From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [PATCH v2 0/4] Utilization estimation (util_est) for FAIR tasks
Date: Tue,  5 Dec 2017 17:10:14 +0000
Message-ID: <20171205171018.9203-1-patrick.bellasi@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52268 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752357AbdLERKf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 5 Dec 2017 12:10:35 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>

This is a respin of:
   https://lkml.org/lkml/2017/11/9/546
which has been rebased on v4.15-rc2 to have util_est now working on top
of the recent PeterZ's:
   [PATCH -v2 00/18] sched/fair: A bit of a cgroup/PELT overhaul

The aim of this series is to improve some PELT behaviors to make it a
better fit for the scheduling of tasks common in embedded mobile
use-cases, without affecting other classes of workloads.

A complete description of these behaviors has been presented in the
previous RFC [1] and further discussed during the last OSPM Summit [2]
as well as during the last two LPCs.

This series presents an implementation which improves the initial RFC's
prototype. Specifically, this new implementation has been verified to
not impact in any noticeable way the performance of:

    perf bench sched messaging --pipe --thread --group 8 --loop 50000

when running 30 iterations on a dual socket, 10 cores (20 threads) per
socket Intel(R) Xeon(R) CPU E5-2690 v2 @ 3.00GHz, whit the
sched_feat(SCHED_UTILEST) set to False.
With this feature enabled, the measured overhead is in the range of ~1%
on the same HW/SW test configuration.

That's the main reason why this sched feature is disabled by default.
A possible improvement can be the addition of a KConfig option to toggle
the sched_feat default value on systems where a 1% overhead on hackbench
is not a concern, e.g. mobile systems, especially considering the
benefits coming from estimated utilization on workloads of interest.

>From a functional standpoint, this implementation shows a more stable
utilization signal, compared to mainline, when running synthetics
benchmarks describing a set of interesting target use-cases.
This allows for a better selection of the target CPU as well as a
faster selection of the most appropriate OPP.
A detailed description of the used functional tests has been already
covered in the previous RFC [1].

This series is based on v4.15-rc2 and is composed of four patches:
 1) a small refactoring preparing the ground
 2) introducing the required data structures to track util_est of both
    TASKs and CPUs
 3) make use of util_est in the wakeup and load balance paths
 4) make use of util_est in schedutil for frequency selection

Cheers Patrick

.:: References
==============
[1] https://lkml.org/lkml/2017/8/25/195
[2] slides: http://retis.sssup.it/ospm-summit/Downloads/OSPM_PELT_DecayClampingVsUtilEst.pdf
     video: http://youtu.be/adnSHPBGS-w

Changes v1->v2:
 - rebase on top of v4.15-rc2
 - tested that overhauled PELT code does not affect the util_est

Patrick Bellasi (4):
  sched/fair: always used unsigned long for utilization
  sched/fair: add util_est on top of PELT
  sched/fair: use util_est in LB and WU paths
  sched/cpufreq_schedutil: use util_est for OPP selection

 include/linux/sched.h            |  21 +++++
 kernel/sched/cpufreq_schedutil.c |   6 +-
 kernel/sched/debug.c             |   4 +
 kernel/sched/fair.c              | 184 ++++++++++++++++++++++++++++++++++++---
 kernel/sched/features.h          |   5 ++
 kernel/sched/sched.h             |   1 +
 6 files changed, 209 insertions(+), 12 deletions(-)

-- 
2.14.1
