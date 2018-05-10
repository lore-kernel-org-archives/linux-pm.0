From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [PATCH 0/3] Improve schedutil integration for FAIR tasks
Date: Thu, 10 May 2018 16:05:50 +0100
Message-ID: <20180510150553.28122-1-patrick.bellasi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
List-Id: linux-pm@vger.kernel.org

This is a follow up of:

   https://lkml.org/lkml/2018/4/6/935

where the original patch has been split into three to better address the
different issues discussed in the previous posting.

The first two patches of this series are fixes for:
 - FAIR utilization aggregation
   based on blocked utilization decay instead of cfs.h_nr_running
 - Estimated utilization updates
   which needs to be updated before schedutil is at enqueue time

The last patch provides the remaining bits of the original one in a self
contained re-factoring of how we update schedutil for FAIR tasks.

Cheers Patrick

Patrick Bellasi (3):
  sched/cpufreq: always consider blocked FAIR utilization
  sched/fair: util_est: update before schedutil
  sched/fair: schedutil: explicit update only when required

 kernel/sched/cpufreq_schedutil.c | 17 ++++----
 kernel/sched/fair.c              | 83 ++++++++++++++++++----------------------
 2 files changed, 46 insertions(+), 54 deletions(-)

-- 
2.15.1
