From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [PATCH v3 0/6] cpufreq: schedutil: fixes for flags updates
Date: Thu, 30 Nov 2017 11:47:17 +0000
Message-ID: <20171130114723.29210-1-patrick.bellasi@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51226 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751513AbdK3Lrq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 30 Nov 2017 06:47:46 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>

This is a re-spin of a previous posting [1], rebased on v4.15-rc1.

A detailed description of the series, as well as experimental results,
is available in the cover letter of the previous posting.
Here is a resume of the main results:

- reduces energy consumption by ~50% by ensuring that a small task is always
  running at the minimum OPP even when the sugov's RT kthread is used to change
  frequencies in the same cluster

- increase from 4% to 98% the chances for a RT task to complete its activations
  while running at the max OPP.

- The sequence of tracing events reported in a trace is much more deterministic
  and matching the expected system behaviors.  For example, as soon as a RT
  task wakes up we ask for an OPP switch to max frequency.

A detailed report for these results is available here [2].

According to the discussion in the previous posting, one patch:

   cpufreq: schedutil: ignore the sugov kthread for frequencies selections

was considered the more controversial.
That's why in this posting I'm still proposing that patch, since it
still makes sense to me, but I've moved it at the end of the series,
after the less controversial ones.

Cheers Patrick

.:: References
==============

[1] https://lkml.org/lkml/2017/7/4/495
[2] https://gist.github.com/derkling/0cd7210e4fa6f2ec3558073006e5ad70

Patrick Bellasi (6):
  cpufreq: schedutil: reset sg_cpus's flags at IDLE enter
  cpufreq: schedutil: ensure max frequency while running RT/DL tasks
  cpufreq: schedutil: update CFS util only if used
  sched/rt: fast switch to maximum frequency when RT tasks are scheduled
  cpufreq: schedutil: relax rate-limiting while running RT/DL tasks
  cpufreq: schedutil: ignore sugov kthreads

 include/linux/sched/cpufreq.h    |  1 +
 kernel/sched/cpufreq_schedutil.c | 61 ++++++++++++++++++++++++++++++++--------
 kernel/sched/idle_task.c         |  4 +++
 kernel/sched/rt.c                | 15 ++++++++--
 4 files changed, 67 insertions(+), 14 deletions(-)

-- 
2.14.1
