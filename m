From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V5 0/6] cpufreq: Locking fixes and cleanups
Date: Thu, 11 Feb 2016 17:31:10 +0530
Message-ID: <cover.1455191663.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, juri.lelli@arm.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, shilpa.bhat@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

These are rest of the patches that fix some more locking issues with
policy->rwsem and do some minor optimization/cleanups.

V4->V5:
- Changelog updated for 1-2 as suggested by Rafael
- 4th patch is dropped, which moved common tunable callbacks to
  cpufreq_governor.c
- 5-7 are resend on the V5 sent earlier, as reply to V4 of the series.

Viresh Kumar (6):
  cpufreq: Merge cpufreq_offline_prepare/finish routines
  cpufreq: Call __cpufreq_governor() with policy->rwsem held
  cpufreq: Remove cpufreq_governor_lock
  cpufreq: governor: No need to manage state machine now
  cpufreq: conservative: Update sample_delay_ns immediately
  cpufreq: ondemand: Rearrange od_dbs_timer() to avoid updating delay

 drivers/cpufreq/cpufreq.c              | 93 ++++++++++++++++------------------
 drivers/cpufreq/cpufreq_conservative.c | 14 -----
 drivers/cpufreq/cpufreq_governor.c     | 90 ++++++++++++++++++++++++--------
 drivers/cpufreq/cpufreq_governor.h     |  3 +-
 drivers/cpufreq/cpufreq_ondemand.c     | 78 ++--------------------------
 5 files changed, 117 insertions(+), 161 deletions(-)

-- 
2.7.1.370.gb2aa7f8
