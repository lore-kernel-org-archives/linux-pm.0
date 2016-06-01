From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/8] cpufreq: cleanups and reorganization
Date: Wed,  1 Jun 2016 16:04:14 +0530
Message-ID: <cover.1464776797.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35534 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750697AbcFAKec (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jun 2016 06:34:32 -0400
Received: by mail-pf0-f175.google.com with SMTP id g64so12931890pfb.2
        for <linux-pm@vger.kernel.org>; Wed, 01 Jun 2016 03:34:31 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Hi Rafael,

This cleans up cpufreq core and few platform drivers a bit. Its mostly
around cleaning up the usage of cpufreq_frequency_table_target(), which
will be optimized in a later series.

This is just preparatory cleanup for that.

Also note that the 4th patch was sent earlier as well in a different
form and this is V3 of that.

Viresh Kumar (8):
  ARM: s3c24xx: Sort cpufreq tables
  cpufreq: s3c24xx: Remove useless checks
  cpufreq: powerenv: Fix memory leak
  cpufreq: Remove cpufreq_frequency_get_table()
  cpufreq: ondemand: Don't keep a copy of freq_table pointer
  cpufreq: Drop freq-table param to cpufreq_frequency_table_target()
  cpufreq: Drop 'freq_table' argument of __target_index()
  cpufreq: Return index from cpufreq_frequency_table_target()

 Documentation/cpu-freq/cpu-drivers.txt       |  8 ++--
 arch/arm/mach-s3c24xx/pll-s3c2410.c          |  3 +-
 arch/arm/mach-s3c24xx/pll-s3c2440-12000000.c |  1 +
 arch/arm/mach-s3c24xx/pll-s3c2440-16934400.c |  1 +
 drivers/cpufreq/amd_freq_sensitivity.c       | 10 ++---
 drivers/cpufreq/cpufreq.c                    | 66 ++++++++++------------------
 drivers/cpufreq/cpufreq_ondemand.c           | 25 +++++------
 drivers/cpufreq/cpufreq_ondemand.h           |  1 -
 drivers/cpufreq/cpufreq_stats.c              |  3 +-
 drivers/cpufreq/freq_table.c                 | 35 +++++++--------
 drivers/cpufreq/powernv-cpufreq.c            | 18 ++++----
 drivers/cpufreq/ppc_cbe_cpufreq_pmi.c        |  3 +-
 drivers/cpufreq/s3c24xx-cpufreq.c            | 33 +++-----------
 drivers/cpufreq/s5pv210-cpufreq.c            |  8 +---
 drivers/thermal/cpu_cooling.c                | 22 +++++++---
 include/linux/cpufreq.h                      |  6 +--
 16 files changed, 100 insertions(+), 143 deletions(-)

-- 
2.7.1.410.g6faf27b

