From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 00/17] thermal: cpu_cooling: improve interaction with cpufreq core
Date: Mon, 17 Apr 2017 11:31:45 +0530
Message-ID: <cover.1492408342.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linaro-kernel@lists.linaro.org, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Guys,

The cpu_cooling driver is designed to use CPU frequency scaling to avoid
high thermal states for a platform. But it wasn't glued really well with
cpufreq core.

This series tries to improve interactions between cpufreq core and
cpu_cooling driver and does some fixes/cleanups to the cpu_cooling
driver.

I have tested it on ARM 32 (exynos) and 64 bit (hikey) boards and have
pushed them for 0-day build bot and kernel CI testing as well. We should
know if something is broken with these.

@Javi: It would be good if you can give them a test, specially because
of your work on the "power" specific bits in the driver.

Pushed here as well:

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git thermal/cooling

V1->V2:
- Name cpufreq cooling dev as cpufreq_cdev everywhere (Eduardo).

--
viresh

Viresh Kumar (17):
  thermal: cpu_cooling: Avoid accessing potentially freed structures
  thermal: cpu_cooling: rearrange globals
  thermal: cpu_cooling: Name cpufreq cooling devices as cpufreq_cdev
  thermal: cpu_cooling: replace cool_dev with cdev
  thermal: cpu_cooling: remove cpufreq_cooling_get_level()
  thermal: cpu_cooling: get rid of a variable in cpufreq_set_cur_state()
  thermal: cpu_cooling: use cpufreq_policy to register cooling device
  cpufreq: create cpufreq_table_count_valid_entries()
  thermal: cpu_cooling: store cpufreq policy
  thermal: cpu_cooling: OPPs are registered for all CPUs
  thermal: cpu_cooling: get rid of 'allowed_cpus'
  thermal: cpu_cooling: merge frequency and power tables
  thermal: cpu_cooling: create structure for idle time stats
  thermal: cpu_cooling: get_level() can't fail
  thermal: cpu_cooling: don't store cpu_dev in cpufreq_cdev
  thermal: cpu_cooling: 'freq' can't be zero in cpufreq_state2power()
  thermal: cpu_cooling: Rearrange struct cpufreq_cooling_device

 drivers/cpufreq/arm_big_little.c                   |   2 +-
 drivers/cpufreq/cpufreq-dt.c                       |   2 +-
 drivers/cpufreq/cpufreq_stats.c                    |  13 +-
 drivers/cpufreq/dbx500-cpufreq.c                   |   2 +-
 drivers/cpufreq/mt8173-cpufreq.c                   |   4 +-
 drivers/cpufreq/qoriq-cpufreq.c                    |   3 +-
 drivers/thermal/cpu_cooling.c                      | 579 ++++++++-------------
 drivers/thermal/imx_thermal.c                      |  22 +-
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  22 +-
 include/linux/cpu_cooling.h                        |  32 +-
 include/linux/cpufreq.h                            |  14 +
 11 files changed, 297 insertions(+), 398 deletions(-)

-- 
2.12.0.432.g71c3a4f4ba37
