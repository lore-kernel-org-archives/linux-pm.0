From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 0/7] cpufreq: governors: Fix ABBA lockups
Date: Wed,  3 Feb 2016 19:32:16 +0530
Message-ID: <cover.1454507872.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, juri.lelli@arm.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

Here is the V2 with updated patches as suggested by you guys.

These are pushed here:
git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/governor-kobject

The first four patches are for 4.5, if possible and others you can keep
for 4.6.

V1->V2:
- Improved changelogs, thanks Rafael.
- Added new dbs_data->mutex to avoid concurrent updates to tunables.
- Moved kobj_type to common_dbs_data.
- Updated macros to static inline routines
- s/show/governor_show
- s/store/governor_store
- Improved comments

@Juri: More testing requested :)

Viresh Kumar (7):
  cpufreq: governor: Treat min_sampling_rate as a governor-specific
    tunable
  cpufreq: governor: New sysfs show/store callbacks for governor
    tunables
  cpufreq: governor: Drop unused macros for creating governor tunable
    attributes
  Revert "cpufreq: Drop rwsem lock around CPUFREQ_GOV_POLICY_EXIT"
  cpufreq: Merge cpufreq_offline_prepare/finish routines
  cpufreq: Call __cpufreq_governor() with policy->rwsem held
  cpufreq: Remove cpufreq_governor_lock

 drivers/cpufreq/cpufreq.c              |  93 +++++++++++++----------------
 drivers/cpufreq/cpufreq_conservative.c |  79 +++++++++----------------
 drivers/cpufreq/cpufreq_governor.c     | 105 +++++++++++++++++++++++++--------
 drivers/cpufreq/cpufreq_governor.h     | 104 ++++++++------------------------
 drivers/cpufreq/cpufreq_ondemand.c     |  79 +++++++++----------------
 include/linux/cpufreq.h                |   4 --
 6 files changed, 203 insertions(+), 261 deletions(-)

-- 
2.7.0.79.gdc08a19
