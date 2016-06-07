From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 0/2] cpufreq: Sort policy->freq_table
Date: Tue,  7 Jun 2016 15:55:13 +0530
Message-ID: <cover.1465295033.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, steve.muckle@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

I have spent some more time on this stuff and finally came out with a
very simple solution. I hope you will like it more than the previous
versions.

Instead of trying to sort the freq-table passed by the drivers, which
was complicated and would have broken some drivers for sure, this patch
just checks if the freq-table is sorted or not.

If it is sorted, then we just use a different set of helpers for it. The
table can be sorted in both ascending and descending orders now and
helpers are present for both the cases.

All the patches are pushed here for testing in case anyone wants to try:
git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/sorted-freq-table

V3->V4:
- Written from scratch really, completely different approach.

Thanks

Viresh Kumar (2):
  cpufreq: Handle sorted frequency tables more efficiently
  cpufreq: Reuse new freq-table helpers

 drivers/cpufreq/acpi-cpufreq.c         |  14 +-
 drivers/cpufreq/amd_freq_sensitivity.c |   4 +-
 drivers/cpufreq/cpufreq_ondemand.c     |   6 +-
 drivers/cpufreq/freq_table.c           |  67 +++++++-
 drivers/cpufreq/powernv-cpufreq.c      |   3 +-
 drivers/cpufreq/s5pv210-cpufreq.c      |   3 +-
 include/linux/cpufreq.h                | 284 ++++++++++++++++++++++++++++++++-
 7 files changed, 353 insertions(+), 28 deletions(-)

-- 
2.7.1.410.g6faf27b
