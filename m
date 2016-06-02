From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 0/6] cpufreq: cleanups and reorganization
Date: Thu,  2 Jun 2016 19:34:54 +0530
Message-ID: <cover.1464876229.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35601 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978AbcFBOFJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jun 2016 10:05:09 -0400
Received: by mail-pf0-f179.google.com with SMTP id g64so31856473pfb.2
        for <linux-pm@vger.kernel.org>; Thu, 02 Jun 2016 07:05:09 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Hi Rafael,

This cleans up cpufreq core and few platform drivers a bit. Its mostly
around cleaning up the usage of cpufreq_frequency_table_target(), which
will be optimized in a separate series.

This is just preparatory cleanup for that.

V1->V2:
- Dropped one powernv patch which wasn't really required.
- Dropped one more patch as its already applied by the ARM mach
  maintainer.
- Added Reviewed-by in the first patch
- Just rebased otherwise, no other changes.

Viresh Kumar (6):
  cpufreq: s3c24xx: Remove useless checks
  cpufreq: Remove cpufreq_frequency_get_table()
  cpufreq: ondemand: Don't keep a copy of freq_table pointer
  cpufreq: Drop freq-table param to cpufreq_frequency_table_target()
  cpufreq: Drop 'freq_table' argument of __target_index()
  cpufreq: Return index from cpufreq_frequency_table_target()

 Documentation/cpu-freq/cpu-drivers.txt |  8 ++---
 drivers/cpufreq/amd_freq_sensitivity.c | 10 +++---
 drivers/cpufreq/cpufreq.c              | 66 ++++++++++++----------------------
 drivers/cpufreq/cpufreq_ondemand.c     | 25 ++++++-------
 drivers/cpufreq/cpufreq_ondemand.h     |  1 -
 drivers/cpufreq/cpufreq_stats.c        |  3 +-
 drivers/cpufreq/freq_table.c           | 35 +++++++++---------
 drivers/cpufreq/powernv-cpufreq.c      |  5 ++-
 drivers/cpufreq/ppc_cbe_cpufreq_pmi.c  |  3 +-
 drivers/cpufreq/s3c24xx-cpufreq.c      | 33 ++++-------------
 drivers/cpufreq/s5pv210-cpufreq.c      |  8 ++---
 drivers/thermal/cpu_cooling.c          | 22 +++++++++---
 include/linux/cpufreq.h                |  6 +---
 13 files changed, 88 insertions(+), 137 deletions(-)

-- 
2.7.1.410.g6faf27b

