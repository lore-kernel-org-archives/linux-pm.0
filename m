From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/6] cpufreq: transition-latency cleanups
Date: Thu, 29 Jun 2017 16:29:03 +0530
Message-ID: <cover.1498733506.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:32880 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752440AbdF2K7O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jun 2017 06:59:14 -0400
Received: by mail-pf0-f175.google.com with SMTP id e7so48763719pfk.0
        for <linux-pm@vger.kernel.org>; Thu, 29 Jun 2017 03:59:14 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

Hi,

This series tries to cleanup the code around transition-latency and its
users. Some of the old legacy code, which may not make much sense now,
is being dropped as.

Some code consolidation also happens across governors.

Based of: pm/linux-next
Tested on: ARM64 Hikey board.

--
viresh

Viresh Kumar (6):
  cpufreq: Don't check for max_transition_latency
  cpufreq: Remove (now) unused code related to max_transition_latency
  cpufreq: governor: Drop min_sampling_rate
  cpufreq: Use transition_delay_us for legacy governors as well
  cpufreq: Cap the default transition delay value to 10 ms
  cpufreq: arm_big_little: Make ->get_transition_latency() mandatory

 Documentation/admin-guide/pm/cpufreq.rst |  8 --------
 drivers/cpufreq/arm_big_little.c         | 10 ++++-----
 drivers/cpufreq/cpufreq.c                | 19 -----------------
 drivers/cpufreq/cpufreq_conservative.c   |  6 ------
 drivers/cpufreq/cpufreq_governor.c       | 17 ++--------------
 drivers/cpufreq/cpufreq_governor.h       |  2 --
 drivers/cpufreq/cpufreq_ondemand.c       | 12 -----------
 drivers/cpufreq/cpufreq_performance.c    |  6 ------
 include/linux/cpufreq.h                  | 35 +++++++++++++++++++++++---------
 kernel/sched/cpufreq_schedutil.c         | 11 +---------
 10 files changed, 32 insertions(+), 94 deletions(-)

-- 
2.13.0.71.gd7076ec9c9cb
