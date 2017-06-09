From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/3] cpufreq: schedutil: Fix 4.12 regressions
Date: Fri,  9 Jun 2017 15:45:53 +0530
Message-ID: <cover.1497002895.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34840 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751524AbdFIKQG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jun 2017 06:16:06 -0400
Received: by mail-pg0-f46.google.com with SMTP id k71so25273000pgd.2
        for <linux-pm@vger.kernel.org>; Fri, 09 Jun 2017 03:16:06 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, patrick.bellasi@arm.com, john.ettedgui@gmail.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>

Hi Rafael,

I have identified some regressions with the schedutil governor which
happen due to one of your patches that got merged in 4.12-rc1.

This series fixes all the drivers which provide a ->target_index()
callback but doesn't fix the drivers which provide ->target() callback.

Such platforms need to implement the ->resolve_freq() callback in order
to get this fixed and I only had hardware for testing intel_pstate,
which I fixed in this series.

I am wondering if there is another way to fix this issue (than what I
tried) or if we should revert the offending commit (39b64aa1c007) and
look for other solutions.

Anyway, this series has the necessary patches to fix it.

Viresh Kumar (3):
  cpufreq: schedutil: Restore cached_raw_freq behavior
  cpufreq: schedutil: Fix selection algorithm while reducing frequency
  cpufreq: intel_pstate: Provide resolve_freq() to fix regression

 drivers/cpufreq/intel_pstate.c   | 14 +++++++++++++
 kernel/sched/cpufreq_schedutil.c | 45 +++++++++++++++++++++++++++++++++-------
 2 files changed, 52 insertions(+), 7 deletions(-)

-- 
2.13.0.70.g6367777092d9
