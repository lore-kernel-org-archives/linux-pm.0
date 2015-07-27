From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 0/9] CPUFreq: governors: further cleanups
Date: Mon, 27 Jul 2015 17:58:05 +0530
Message-ID: <cover.1437999691.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34907 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668AbbG0M2c (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2015 08:28:32 -0400
Received: by pabkd10 with SMTP id kd10so51125307pab.2
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2015 05:28:31 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, preeti.lkml@gmail.com, Viresh Kumar <viresh.kumar@linaro.org>

Hi Rafael,

This series fixes few more possible race conditions. Over that there is
some non-trivial cleanup, in order to simplify code.

Preeti did review some of them before she left and shared concerns on
others, all that is sorted out now.

V1->V2:
- Dropped 2/10 from V1 as it wasn't required
- 3/10 saw some changes due to above patch being dropped
- 7/10 changed a bit as we check for pending work items by looking at
  shared->policy, rather than calling delayed_work_pending. We wanted to
  check if governor is operational or not and the new check is enough
  for that.

Viresh Kumar (9):
  cpufreq: Use __func__ to print function's name
  cpufreq: conservative: remove 'enable' field
  cpufreq: ondemand: only queue canceled works from
    update_sampling_rate()
  cpufreq: governor: Drop __gov_queue_work()
  cpufreq: ondemand: Drop unnecessary locks from update_sampling_rate()
  cpufreq: ondemand: queue work for policy->cpus together
  cpufreq: ondemand: update sampling rate immidiately
  cpufreq: governor: Quit work-handlers early if governor is stopped
  cpufreq: Get rid of ->governor_enabled and its lock

 drivers/cpufreq/cpufreq.c              | 27 +----------
 drivers/cpufreq/cpufreq_conservative.c | 38 +++++++++------
 drivers/cpufreq/cpufreq_governor.c     | 86 +++++++++++++++-------------------
 drivers/cpufreq/cpufreq_governor.h     |  5 +-
 drivers/cpufreq/cpufreq_ondemand.c     | 54 +++++++--------------
 include/linux/cpufreq.h                |  1 -
 6 files changed, 81 insertions(+), 130 deletions(-)

-- 
2.4.0

