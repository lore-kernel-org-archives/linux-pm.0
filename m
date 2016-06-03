From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 0/9] cpufreq: Sort policy->freq_table
Date: Fri,  3 Jun 2016 19:05:06 +0530
Message-ID: <cover.1464960877.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34670 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865AbcFCNf2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jun 2016 09:35:28 -0400
Received: by mail-pf0-f180.google.com with SMTP id 62so43917252pfd.1
        for <linux-pm@vger.kernel.org>; Fri, 03 Jun 2016 06:35:28 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, steve.muckle@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Shawn Guo <shawn.guo@freescale.com>, Steven Miao <realmz6@gmail.com>

Hi Rafael,

So all my patches are contained in two series. The first one is:

[PATCH V3 0/8] cpufreq: cleanups and reorganization

which I have sent this morning. It does some cleanup and shall be
applied regardless of this series.

This series improves the performance of cpufreq_frequency_table_target()
routine by storing the policy->freq_table sorted in ascending order. On
one hand it shall improve the performance of current governors for
drivers providing freq-table to cpufreq core and on another hand this
API can be used directly from schedutil governor as well.

As Steve has requested earlier, these APIs are moved to a .h file to
avoid function calls.

Steve's series can use this API now without any performance lag.

The first 7 patches makes sure that current drivers wouldn't break because
of reordering of policy->freq_table and the 8th patch updates cpufreq
core to sort policy->freq_table and make
cpufreq_frequency_table_target() much more efficient.

This series is tested on ARM exynos platform and all the frequencies are
switching properly with both ondemand and schedutil governor.

V2->V3:
- Combined two series as you suggested
- Moved the new APIs and cpufreq_frequency_table_target() to a .h

All the patches are pushed here for testing in case anyone wants to try:

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/sorted-freq-table

Thanks

--
viresh

Viresh Kumar (9):
  cpufreq: Use policy->freq_table in ->target_index()
  cpufreq: blackfin: Use 'index' only to index into policy->freq_table
  cpufreq: elanfreq: Use 'index' only to index into policy->freq_table
  cpufreq: exynos: Use 'index' only to index into policy->freq_table
  cpufreq: ia64: Use 'index' only to index into policy->freq_table
  cpufreq: imx: Use 'index' only to index into policy->freq_table
  cpufreq: maple: Use 'index' only to index into policy->freq_table
  cpufreq: Keep policy->freq_table sorted in ascending order
  cpufreq: drivers: Free frequency tables after being used

 MAINTAINERS                            |   1 +
 drivers/cpufreq/acpi-cpufreq.c         |  23 ++---
 drivers/cpufreq/arm_big_little.c       |   2 +-
 drivers/cpufreq/at32ap-cpufreq.c       |   8 +-
 drivers/cpufreq/blackfin-cpufreq.c     |  17 +++-
 drivers/cpufreq/cpufreq-dt.c           |   9 +-
 drivers/cpufreq/cpufreq.c              |  20 ++--
 drivers/cpufreq/cpufreq_ondemand.h     |   1 +
 drivers/cpufreq/cris-artpec3-cpufreq.c |   2 +-
 drivers/cpufreq/cris-etraxfs-cpufreq.c |   2 +-
 drivers/cpufreq/dbx500-cpufreq.c       |   3 +-
 drivers/cpufreq/e_powersaver.c         |  26 +++---
 drivers/cpufreq/elanfreq.c             |   8 +-
 drivers/cpufreq/exynos5440-cpufreq.c   |  13 ++-
 drivers/cpufreq/freq_table.c           | 163 +++++++++++++--------------------
 drivers/cpufreq/ia64-acpi-cpufreq.c    |  16 +++-
 drivers/cpufreq/imx6q-cpufreq.c        |  13 ++-
 drivers/cpufreq/kirkwood-cpufreq.c     |   2 +-
 drivers/cpufreq/loongson1-cpufreq.c    |  10 +-
 drivers/cpufreq/loongson2_cpufreq.c    |   5 +-
 drivers/cpufreq/maple-cpufreq.c        |   6 ++
 drivers/cpufreq/powernv-cpufreq.c      |   1 +
 drivers/cpufreq/s3c24xx-cpufreq.c      |   1 +
 drivers/cpufreq/s5pv210-cpufreq.c      |   1 +
 include/linux/cpufreq.h                |   3 -
 include/linux/cpufreq_table.h          | 139 ++++++++++++++++++++++++++++
 26 files changed, 317 insertions(+), 178 deletions(-)
 create mode 100644 include/linux/cpufreq_table.h

-- 
2.7.1.410.g6faf27b

