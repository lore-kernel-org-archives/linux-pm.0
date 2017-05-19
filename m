From: Joel Fernandes <joelaf@google.com>
Subject: [PATCH v2 0/2] Make iowait_boost optional and default to policy
Date: Thu, 18 May 2017 23:23:42 -0700
Message-ID: <20170519062344.27692-1-joelaf@google.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35867 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755107AbdESGX4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 May 2017 02:23:56 -0400
Received: by mail-pf0-f176.google.com with SMTP id m17so34986539pfg.3
        for <linux-pm@vger.kernel.org>; Thu, 18 May 2017 23:23:56 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Joel Fernandes <joelaf@google.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>

iowait_boost is causing power regression on our arm64 SoC. Really going to max
frequency is bad for power on mobile devices and not wise.
These patches make it optional and default to what the policy suggests coming
from the cpufreq driver as input to the governor.

Here are some power numbers collected on an arm64 based Qualcomm SoC on a mobile
device running a YouTube video for 30 seconds:

Before: 8.042533 mWh
After: 7.948377 mWh
Energy savings is ~1.2%

Joel Fernandes (2):
  cpufreq: Make iowait boost a policy option
  sched: Use iowait boost policy option in schedutil

 drivers/cpufreq/intel_pstate.c   |  1 +
 include/linux/cpufreq.h          |  3 +++
 kernel/sched/cpufreq_schedutil.c | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+)

Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
-- 
2.13.0.303.g4ebf302169-goog
