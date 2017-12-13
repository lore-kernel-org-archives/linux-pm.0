From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/4] sched: cpufreq: Track util update flags
Date: Wed, 13 Dec 2017 15:23:19 +0530
Message-ID: <cover.1513158452.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45635 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752330AbdLMJx2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Dec 2017 04:53:28 -0500
Received: by mail-pl0-f68.google.com with SMTP id o2so696831plk.12
        for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2017 01:53:28 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, juri.lelli@redhat.com, tkjos@android.com, joelaf@google.com, linux-kernel@vger.kernel.org

Hi,

Currently the schedutil governor overwrites the sg_cpu->flags field on
every call to the utilization handler. It was pretty good as the initial
implementation of utilization handlers, there are several drawbacks
though.

The biggest drawback is that the sg_cpu->flags field doesn't always
represent the correct type of tasks that are enqueued on a CPU's rq. For
example, if a fair task is enqueued while a RT or DL task is running, we
will overwrite the flags with value 0 and that may take the CPU to lower
OPPs unintentionally. There can be other corner cases as well which we
aren't aware of currently.

This patchset tries to solve these problems by taking a different
approach than overwriting flags, i.e. set and reset them. The second
patch does that transition, other three patches are minor optimizations
here and there, but related to this work.

Tested these on hikey620 with cyclictest, perf-pipe, hackbench and
ebizzy and no obvious regressions were seen.

Based over linux-next/master (as I wanted both tip/master and
pm/linux-next).

--
viresh

Viresh Kumar (4):
  cpufreq: schedutil: Initialize sg_cpu->flags to 0
  sched: cpufreq: Keep track of cpufreq utilization update flags
  cpufreq: schedutil: Don't pass flags to sugov_set_iowait_boost()
  cpufreq: schedutil: Don't call sugov_get_util() unnecessarily

 include/linux/sched/cpufreq.h    |  7 ++++++-
 kernel/sched/cpufreq_schedutil.c | 36 +++++++++++++++++++++++++-----------
 kernel/sched/deadline.c          |  4 ++++
 kernel/sched/fair.c              |  8 ++++++--
 kernel/sched/rt.c                |  4 ++++
 5 files changed, 45 insertions(+), 14 deletions(-)

-- 
2.15.0.194.g9af6a3dea062
