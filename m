From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [RFC V2 0/6] cpufreq: transition-latency cleanups
Date: Thu, 13 Jul 2017 11:10:51 +0530
Message-ID: <cover.1499853492.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33100 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750854AbdGMFla (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jul 2017 01:41:30 -0400
Received: by mail-pf0-f178.google.com with SMTP id e7so23991769pfk.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2017 22:41:29 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux@dominikbrodowski.net, Ingo Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Sudeep Holla <sudeep.holla@arm.com>

Hi Rafael,

Here is the V2 and sending it as RFC this time.

This series tries to cleanup the code around transition-latency and its
users.  Some of the old legacy code, which may not make much sense now,
is dropped as well.

Some code consolidation also done across governors.

Based of: pm/linux-next
Tested on: ARM64 Hikey board.

V1->V2:
- While we still get rid of the limitation of 10ms for using
  ondemand/conservative, but we preserve the earlier behavior where the
  transition latency set to CPUFREQ_ETERNAL would not allow use of
  ondemand/conservative governors. Thanks to Dominik for his feedback on
  that.

--
viresh

Viresh Kumar (6):
  cpufreq: Replace "max_transition_latency" with "dynamic_switching"
  cpufreq: schedutil: Set dynamic_switching to true
  cpufreq: governor: Drop min_sampling_rate
  cpufreq: Use transition_delay_us for legacy governors as well
  cpufreq: Cap the default transition delay value to 10 ms
  cpufreq: arm_big_little: Make ->get_transition_latency() mandatory

 Documentation/admin-guide/pm/cpufreq.rst |  8 -------
 drivers/cpufreq/arm_big_little.c         | 10 ++++-----
 drivers/cpufreq/cpufreq.c                |  8 +++----
 drivers/cpufreq/cpufreq_conservative.c   |  6 ------
 drivers/cpufreq/cpufreq_governor.c       | 17 ++-------------
 drivers/cpufreq/cpufreq_governor.h       |  3 +--
 drivers/cpufreq/cpufreq_ondemand.c       | 12 -----------
 include/linux/cpufreq.h                  | 36 ++++++++++++++++++++++++--------
 kernel/sched/cpufreq_schedutil.c         | 12 ++---------
 9 files changed, 40 insertions(+), 72 deletions(-)

-- 
2.13.0.71.gd7076ec9c9cb
