From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 0/6] cpufreq: Fix ABBA lockdeps
Date: Tue,  9 Feb 2016 09:01:30 +0530
Message-ID: <cover.1454988295.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, juri.lelli@arm.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, shilpa.bhat@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

As suggested, I have kept only what you suggested and fixed them based
on your review comments.

@Juri and Shilpa: I have also added your Tested-by's, please let me know
if you don't prefer to add them here.

V3->V4:
- Keep only relevant patches for lockdep, will send cleanups patches
  separately.
- kobj_name is dropped
- Comment over update_sampling_rate is kept intact, with minor
  additions.
- s/global/common for common tunables

Viresh Kumar (6):
  cpufreq: governor: Create generic macro for global tuners
  cpufreq: governor: Move common tunables to 'struct dbs_data'
  cpufreq: governor: New sysfs show/store callbacks for governor
    tunables
  cpufreq: governor: Drop unused macros for creating governor tunable
    attributes
  Revert "cpufreq: Drop rwsem lock around CPUFREQ_GOV_POLICY_EXIT"
  cpufreq: governor: Create and traverse list of policy_dbs to fix
    lockdep

 drivers/cpufreq/cpufreq.c              |   5 -
 drivers/cpufreq/cpufreq_conservative.c | 102 +++++++----------
 drivers/cpufreq/cpufreq_governor.c     | 127 ++++++++++++++-------
 drivers/cpufreq/cpufreq_governor.h     | 143 ++++++++----------------
 drivers/cpufreq/cpufreq_ondemand.c     | 194 ++++++++++++---------------------
 include/linux/cpufreq.h                |   4 -
 6 files changed, 239 insertions(+), 336 deletions(-)

-- 
2.7.1.370.gb2aa7f8
