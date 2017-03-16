From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 00/17] thermal: cpu_cooling: improve interaction with cpufreq core
Date: Thu, 16 Mar 2017 10:56:58 +0530
Message-ID: <cover.1489639999.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Guys,

The cpu_cooling driver is designed to use CPU frequency scaling to avoid
high thermal states for a platform. But it wasn't glued really well with
cpufreq core.

This series tries to improve interactions between cpufreq core and
cpu_cooling driver and does some fixes/cleanups to the cpu_cooling
driver.

I am a bit confused about which tree this series should go through, PM
or thermal.

This series has dependency on few other patches which are already merged
in the PM [1] tree and thermal [2] tree. As this is 4.12 material, all
of this should go through only one tree to avoid conflicts.

I assume that one of Rafael and Rui have to drop the existing patch(es)
from their trees and let the other one apply all of these. I would let
you guys decide on that. Sorry for the trouble.

I have tested it on ARM 32 (exynos) and 64 bit (hikey) boards and have
pushed them for 0-day build bot and kernel CI testing as well. We should
know if something is broken with these.

@Javi: It would be good if you can give them a test, specially because
of your work on the "power" specific bits in the driver.

Pushed here as well:

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git thermal/cooling

--
viresh

[1] https://marc.info/?l=linux-kernel&m=148946890403271&w=2
[2] https://marc.info/?l=linux-kernel&m=148644060126593&w=2

Viresh Kumar (17):
  thermal: cpu_cooling: Avoid accessing potentially freed structures
  thermal: cpu_cooling: rearrange globals
  thermal: cpu_cooling: Replace cpufreq_device with cpufreq_dev
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
  thermal: cpu_cooling: don't store cpu_dev in cpufreq_dev
  thermal: cpu_cooling: 'freq' can't be zero in cpufreq_state2power()
  thermal: cpu_cooling: Rearrange struct cpufreq_cooling_device

 drivers/cpufreq/arm_big_little.c                   |   2 +-
 drivers/cpufreq/cpufreq-dt.c                       |   2 +-
 drivers/cpufreq/cpufreq_stats.c                    |  13 +-
 drivers/cpufreq/dbx500-cpufreq.c                   |   2 +-
 drivers/cpufreq/mt8173-cpufreq.c                   |   4 +-
 drivers/cpufreq/qoriq-cpufreq.c                    |   3 +-
 drivers/thermal/cpu_cooling.c                      | 530 ++++++++-------------
 drivers/thermal/imx_thermal.c                      |  22 +-
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  22 +-
 include/linux/cpu_cooling.h                        |  32 +-
 include/linux/cpufreq.h                            |  14 +
 11 files changed, 272 insertions(+), 374 deletions(-)

-- 
2.7.1.410.g6faf27b
