From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 0/8] cpufreq: cleanups and reorganization
Date: Fri,  3 Jun 2016 10:58:44 +0530
Message-ID: <cover.1464931080.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36530 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036AbcFCF3D (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jun 2016 01:29:03 -0400
Received: by mail-pa0-f43.google.com with SMTP id te7so7991198pab.3
        for <linux-pm@vger.kernel.org>; Thu, 02 Jun 2016 22:29:02 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Hi Rafael,

This cleans up cpufreq core and few platform drivers a bit. Its mostly
around cleaning up the usage of cpufreq_frequency_table_target(), which
will be optimized in a separate series.

V2->V3:
- Fixed an issue with cpu_cooling.c (Javi)
- Included 2 new patches from the other cleanup series.
- Added Acked-by: from Javi for cpu_cooling.c

Viresh Kumar (8):
  ARM: davinci: Sort frequency table
  cpufreq: s3c24xx: Remove useless checks
  cpufreq: Remove cpufreq_frequency_get_table()
  cpufreq: ondemand: Don't keep a copy of freq_table pointer
  cpufreq: Drop freq-table param to cpufreq_frequency_table_target()
  cpufreq: Drop 'freq_table' argument of __target_index()
  cpufreq: Return index from cpufreq_frequency_table_target()
  cpufreq: davinci: Reuse cpufreq_generic_frequency_table_verify()

 Documentation/cpu-freq/cpu-drivers.txt |  8 ++---
 arch/arm/mach-davinci/da850.c          | 16 +++++----
 drivers/cpufreq/amd_freq_sensitivity.c | 10 +++---
 drivers/cpufreq/cpufreq.c              | 66 ++++++++++++----------------------
 drivers/cpufreq/cpufreq_ondemand.c     | 25 ++++++-------
 drivers/cpufreq/cpufreq_ondemand.h     |  1 -
 drivers/cpufreq/cpufreq_stats.c        |  3 +-
 drivers/cpufreq/davinci-cpufreq.c      | 22 +-----------
 drivers/cpufreq/freq_table.c           | 35 +++++++++---------
 drivers/cpufreq/powernv-cpufreq.c      |  5 ++-
 drivers/cpufreq/ppc_cbe_cpufreq_pmi.c  |  3 +-
 drivers/cpufreq/s3c24xx-cpufreq.c      | 33 ++++-------------
 drivers/cpufreq/s5pv210-cpufreq.c      |  8 ++---
 drivers/thermal/cpu_cooling.c          | 24 ++++++++++---
 include/linux/cpufreq.h                |  6 +---
 15 files changed, 100 insertions(+), 165 deletions(-)

-- 
2.7.1.410.g6faf27b

