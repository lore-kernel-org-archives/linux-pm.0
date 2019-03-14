From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] More power management updates for v5.1-rc1
Date: Thu, 14 Mar 2019 12:34:51 +0100
Message-ID: <CAJZ5v0h0y40_bVqOyD-+hkCQmVv1vruO0donzjE7FOZ8jteubQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.1-rc1-2

with top-most commit b444e1aa3e48e13aea22162918bd6140c85142de

 Merge branches 'pm-opp' and 'pm-tools'

on top of commit ef8006846a3a97d9d8bf49e63dba948d0d2dbbf0

 Merge tag 'pm-5.1-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive additional power management updates for 5.1-rc1.

These are mostly fixes and cleanups on top of the previously merged
power management material for 5.1-rc1 with one cpupower utility
update that wasn't pushed earlier due to unfortunate timing.

Specifics:

 - Fix registration of new cpuidle governors partially broken during
   the 5.0 development cycle by mistake (Rafael Wysocki).

 - Avoid integer overflows in the menu cpuidle governor by making
   it discard the overflowing data points upfront (Rafael Wysocki).

 - Fix minor mistake in the recent update of the iowait boost
   computation in the intel_pstate driver (Rafael Wysocki).

 - Drop incorrect __init annotation from one function in the pxa2xx
   cpufreq driver (Arnd Bergmann).

 - Fix the operating performance points (OPP) framework
   initialization for devices in multiple power domains if
   only one of them is scalable (Rajendra Nayak).

 - Fix mistake in dev_pm_opp_set_rate() which causes it to skip
   updating the performance state if the new frequency is the same
   as the old one (Viresh Kumar).

 - Rework the cancellation of wakeup source timers to avoid
   potential issues with it and do some cleanups unlocked by
   that change (Viresh Kumar, Rafael Wysocki).

 - Clean up the code computing the active/suspended time of devices
   in the PM-runtime framework after recent changes (Ulf Hansson).

 - Make the power management infrastructure code use pr_fmt()
   consistently (Joe Perches).

 - Clean up the generic power domains (genpd) framework somewhat
   (Aisheng Dong).

 - Improve kerneldoc comments for two functions in the cpufreq core
   (Rafael Wysocki).

 - Fix typo in a PM QoS file description comment (Aisheng Dong).

 - Update the handling of CPU boost frequencies in the cpupower
   utility (Abhishek Goel).

Thanks!


---------------

Abhishek Goel (1):
      tools/power/cpupower: Display boost frequency separately

Aisheng Dong (4):
      PM / QoS: Fix typo in file description
      PM / Domains: Improve warn for multiple states but no governor
      PM / Domains: Return early for all errors in _genpd_power_off()
      PM / domains: Remove one unnecessary blank line

Arnd Bergmann (1):
      cpufreq: pxa2xx: remove incorrect __init annotation

Joe Perches (1):
      PM: Add and use pr_fmt()

Rafael J. Wysocki (5):
      cpuidle: menu: Avoid overflows when computing variance
      cpufreq: Improve kerneldoc comments for cpufreq_cpu_get/put()
      PM / wakeup: Drop wakeup_source_drop()
      cpufreq: intel_pstate: Fix up iowait_boost computation
      cpuidle: governor: Add new governors to cpuidle_governors again

Rajendra Nayak (1):
      OPP: Fix handling of multiple power domains

Ulf Hansson (2):
      PM-runtime: Consolidate code to get active/suspended time
      PM-runtime: Call pm_runtime_active|suspended_time() from sysfs

Viresh Kumar (2):
      PM / wakeup: Rework wakeup source timer cancellation
      PM / OPP: Update performance state when freq == old_freq

---------------

 drivers/base/power/domain.c               | 20 ++++++++-------
 drivers/base/power/domain_governor.c      |  1 -
 drivers/base/power/main.c                 | 21 ++++++++--------
 drivers/base/power/power.h                |  1 +
 drivers/base/power/qos.c                  |  2 +-
 drivers/base/power/runtime.c              | 16 +++++++++---
 drivers/base/power/sysfs.c                | 12 ++-------
 drivers/base/power/trace.c                |  2 ++
 drivers/base/power/wakeup.c               | 30 ++++++++--------------
 drivers/cpufreq/cpufreq.c                 | 24 +++++++-----------
 drivers/cpufreq/intel_pstate.c            |  2 +-
 drivers/cpufreq/pxa2xx-cpufreq.c          |  4 +--
 drivers/cpuidle/governor.c                |  1 +
 drivers/cpuidle/governors/menu.c          |  2 +-
 drivers/opp/core.c                        |  2 +-
 drivers/opp/of.c                          | 16 ++++++++++--
 include/linux/pm.h                        |  1 -
 include/linux/pm_wakeup.h                 |  9 -------
 tools/power/cpupower/lib/cpufreq.c        | 19 ++++++++------
 tools/power/cpupower/lib/cpufreq.h        | 16 ++++++------
 tools/power/cpupower/utils/cpufreq-info.c | 42 +++++++++++++++++++++++--------
 21 files changed, 131 insertions(+), 112 deletions(-)
