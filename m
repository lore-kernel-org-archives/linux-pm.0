From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [PATCH v3 0/3] Utilization estimation (util_est) for FAIR tasks
Date: Tue, 23 Jan 2018 18:08:44 +0000
Message-ID: <20180123180847.4477-1-patrick.bellasi@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45112 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751907AbeAWSJL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Jan 2018 13:09:11 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>

Hi,

This is a respin of [1], rebased on today's tip/sche/core [2], which
gives the util_est series now working on top of Juri's series [3] integrating
SCHED_DEADLINE into schedutil.

Thanks to everyone who provided feedback on the previous version,
all of the feedbacks have been addressed.

Specifically, as Peter suggested, util_est signals for sched_entity's have been
moved into sched_entity::sched_avg. This way util_est now fits into a single 64B
cacheline along with its required util_avg signal.
On the other hand, I've kept instead the EWMA conditional update, which Peter
suggested to remove, since it turns out to save a bit more of overhead
compared to not having it.

This version has been verified to not have any noticeable overhead, despite
the sched_feat(UTIL_EST) being enabled, by using:

    perf bench sched messaging --pipe --thread --group 8 --loop 50000

running 30 iterations on a 40 cores machine:

    Intel(R) Xeon(R) CPU E5-2690 v2 @ 3.00GHz
    dual socket, 10 cores (20 threads) per socket

In the previous version, with this feature enabled, the measured overhead was
instead in the range of ~1% on the same HW/SW test configuration.

This series still keeps the sched feature disabled by default, but given the
new performance figures we could now consider to have it always enabled, or
even just covered by a dedicated KConfig option.

Additional experiments [4] have been done by back-porting these patches to the
v4.4 based kernel running on a Google's Pixel 2 phone. This allowed us to
verify that the proposed modifications contribute to the improvement of PELT by
either matching or outperforming WALT [5], an out-of-tree load tracking
solution currently used by some high-end Android devices, in a representative
set of interactive workloads and industrial benchmarks.

Changes in v3:
 - rebased on today's tip/sched/core (0788116)
 - moved util_est into sched_avg (Peter)
 - use {READ,WRITE}_ONCE() for EWMA updates (Peter)
 - using unsigned int to fit all sched_avg into a single 64B cache line
 - schedutil integration using Juri's cpu_util_cfs()
 - first patch dropped since it's already queued in tip/sched/core

Changes in v2:
 - rebased on top of v4.15-rc2
 - tested that overhauled PELT code does not affect the util_est

Cheers Patrick

.:: References
==============
[1] https://lkml.org/lkml/2017/12/5/634
    20171205171018.9203-1-patrick.bellasi@arm.com
[2] git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
    sched/core (commit 07881166a892)
[3] https://lkml.org/lkml/2017/12/4/173
    20171204102325.5110-1-juri.lelli@redhat.com
[4] https://gist.github.com/derkling/e087e1d028ef200f51ca356acdf68664
[5] Window Assisted Load Tracking
    https://lwn.net/Articles/704903/

Patrick Bellasi (3):
  sched/fair: add util_est on top of PELT
  sched/fair: use util_est in LB and WU paths
  sched/cpufreq_schedutil: use util_est for OPP selection

 include/linux/sched.h   |  16 +++++
 kernel/sched/debug.c    |   4 ++
 kernel/sched/fair.c     | 156 +++++++++++++++++++++++++++++++++++++++++++++---
 kernel/sched/features.h |   5 ++
 kernel/sched/sched.h    |   8 ++-
 5 files changed, 181 insertions(+), 8 deletions(-)

-- 
2.15.1
