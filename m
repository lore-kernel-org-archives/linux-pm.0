From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH RESEND 00/11] CPUFreq: Cleanups/fixes for v3.13
Date: Wed,  2 Oct 2013 14:13:08 +0530
Message-ID: <cover.1380703248.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

As asked by you the first patch is rebased over your bleeding edge. Other minor
patches are also added in this series (sent earlier too) which can also go in.
Let me know if you see/face any issues with them.

Viresh Kumar (11):
  cpufreq: make return type of lock_policy_rwsem_{read|write}() as void
  cpufreq: create per policy rwsem instead of per cpu cpu_policy_rwsem
  cpufreq: remove invalid comment from __cpufreq_remove_dev()
  cpufreq: Remove extra blank line
  cpufreq: don't break string in print statements
  cpufreq: remove __cpufreq_remove_dev()
  cpufreq: Optimize cpufreq_frequency_table_verify()
  cpufreq: rename __cpufreq_set_policy() as cpufreq_set_policy()
  cpufreq: rewrite cpufreq_driver->flags using shift operator
  cpufreq: use cpufreq_driver->flags to mark
    CPUFREQ_HAVE_GOVERNOR_PER_POLICY
  cpufreq: add new routine cpufreq_verify_within_cpu_limits()

 drivers/cpufreq/arm_big_little.c     |   4 +-
 drivers/cpufreq/cpufreq-nforce2.c    |   4 +-
 drivers/cpufreq/cpufreq.c            | 189 ++++++++++-------------------------
 drivers/cpufreq/cpufreq_governor.h   |   5 +-
 drivers/cpufreq/davinci-cpufreq.c    |   4 +-
 drivers/cpufreq/freq_table.c         |  27 +++--
 drivers/cpufreq/integrator-cpufreq.c |   9 +-
 drivers/cpufreq/intel_pstate.c       |   4 +-
 drivers/cpufreq/longrun.c            |   4 +-
 drivers/cpufreq/pcc-cpufreq.c        |   3 +-
 drivers/cpufreq/sh-cpufreq.c         |   7 +-
 drivers/cpufreq/unicore2-cpufreq.c   |   4 +-
 include/linux/cpufreq.h              |  51 +++++++---
 13 files changed, 120 insertions(+), 195 deletions(-)

-- 
1.7.12.rc2.18.g61b472e

