From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/4] CPUFreq: Implement per policy instances of governors
Date: Mon,  4 Feb 2013 17:08:50 +0530
Message-ID: <cover.1359976493.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35198 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753525Ab3BDLjI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Feb 2013 06:39:08 -0500
Received: by mail-pa0-f51.google.com with SMTP id hz1so2355315pad.24
        for <linux-pm@vger.kernel.org>; Mon, 04 Feb 2013 03:39:07 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, Viresh Kumar <viresh.kumar@linaro.org>

Currently, there can't be multiple instances of single governor_type. If we have
a multi-package system, where we have multiple instances of struct policy (per
package), we can't have multiple instances of same governor. i.e. We can't have
multiple instances of ondemand governor for multiple packages.

Governors directory in sysfs is created at /sys/devices/system/cpu/cpufreq/
governor-name/. Which again reflects that there can be only one instance of a
governor_type in the system.

This is a bottleneck for multicluster system, where we want different packages
to use same governor type, but with different tunables.

This patchset is inclined towards fixing this issue.

Viresh Kumar (4):
  cpufreq: Don't check cpu_online(policy->cpu)
  cpufreq: stats: Get rid of CPUFREQ_STATDEVICE_ATTR
  cpufreq: Add per policy governor-init/exit infrastructure
  cpufreq: governor: Implement per policy instances of governors

 drivers/cpufreq/cpufreq.c              |  41 ++++---
 drivers/cpufreq/cpufreq_conservative.c | 142 +++++++++++++----------
 drivers/cpufreq/cpufreq_governor.c     | 140 +++++++++++++---------
 drivers/cpufreq/cpufreq_governor.h     |  42 ++++---
 drivers/cpufreq/cpufreq_ondemand.c     | 205 +++++++++++++++++++--------------
 drivers/cpufreq/cpufreq_stats.c        |  18 +--
 drivers/cpufreq/cpufreq_userspace.c    |   2 -
 drivers/cpufreq/freq_table.c           |   6 -
 include/linux/cpufreq.h                |  26 +----
 9 files changed, 346 insertions(+), 276 deletions(-)

-- 
1.7.12.rc2.18.g61b472e

