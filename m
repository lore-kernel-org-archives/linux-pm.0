From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V5 0/2] cpufreq: Sorted policy->freq_table
Date: Mon, 27 Jun 2016 09:59:32 +0530
Message-ID: <cover.1467001203.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, steve.muckle@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

This series is aimed to make traversing of cpufreq table more efficient
for platforms that already sort the frequency tables. The cpufreq core
now checks if the freq table is sorted and applies a different set of
helpers on such tables while traversing them.

All the patches are pushed here for testing in case anyone wants to try:
git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/sorted-freq-table

V4->V4:
- s/cpufreq_table_find_index_unsorted/cpufreq_table_index_unsorted
- return error for duplicate frequencies
- freq-table-sorted is an enum now
- Remove freq_is_invalid() and clamp the frequencies at the top of few
  helpers.
- Remove few checks which were impossible to hit (best == -1)

Viresh Kumar (2):
  cpufreq: Handle sorted frequency tables more efficiently
  cpufreq: Reuse new freq-table helpers

 drivers/cpufreq/acpi-cpufreq.c         |  14 +-
 drivers/cpufreq/amd_freq_sensitivity.c |   4 +-
 drivers/cpufreq/cpufreq_ondemand.c     |   6 +-
 drivers/cpufreq/freq_table.c           |  73 ++++++++--
 drivers/cpufreq/powernv-cpufreq.c      |   3 +-
 drivers/cpufreq/s5pv210-cpufreq.c      |   3 +-
 include/linux/cpufreq.h                | 234 ++++++++++++++++++++++++++++++++-
 7 files changed, 306 insertions(+), 31 deletions(-)

-- 
2.7.4
