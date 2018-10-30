From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] More power management updates for v4.20-rc1
Date: Tue, 30 Oct 2018 09:28:01 +0100
Message-ID: <CAJZ5v0g7iRUA2=fi3+rkJcsx38YTE6fx26bnnpjeMHwv_CSMVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.20-rc1-2

with top-most commit c4ac6889930d027ffa5cf77e0c202e7e97a4be06

 Merge branches 'pm-cpuidle' and 'pm-cpufreq'

on top of commit bd6bf7c10484f026505814b690104cdef27ed460

 Merge tag 'pci-v4.20-changes' of
git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci

to receive additional power management updates for 4.20-rc1.

These remove a questionable heuristic from the menu cpuidle governor,
fix a recent build regression in the intel_pstate driver, clean up
ARM big-Little support in cpufreq and fix up hung task watchdog's
interaction with system-wide power management transitions.

Specifics:

 - Fix build regression in the intel_pstate driver that doesn't
   build without CONFIG_ACPI after recent changes (Dominik Brodowski).

 - One of the heuristics in the menu cpuidle governor is based on a
   function returning 0 most of the time, so drop it and clean up
   the scheduler code related to it (Daniel Lezcano).

 - Prevent the arm_big_little cpufreq driver from being used on ARM64
   which is not suitable for it and drop the arm_big_little_dt driver
   that is not used any more (Sudeep Holla).

 - Prevent the hung task watchdog from triggering during resume from
   system-wide sleep states by disabling it before freezing tasks and
   enabling it again after they have been thawed (Vitaly Kuznetsov).

There is a merge conflict between the menu governor changes included
here and the (already merged) material from Andrew, but it should be
straightforward to resolve [1].

Thanks!

[1] https://lore.kernel.org/lkml/20181029130124.290346e9@canb.auug.org.au/

---------------

Daniel Lezcano (2):
      sched: Factor out nr_iowait and nr_iowait_cpu
      cpuidle: menu: Remove get_loadavg() from the performance multiplier

Dominik Brodowski (1):
      cpufreq: intel_pstate: Fix compilation for !CONFIG_ACPI

Sudeep Holla (2):
      cpufreq: drop ARM_BIG_LITTLE_CPUFREQ support for ARM64
      cpufreq: remove unused arm_big_little_dt driver

Vitaly Kuznetsov (1):
      kernel: hung_task.c: disable on suspend

---------------

 MAINTAINERS                         |   1 -
 drivers/cpufreq/Kconfig.arm         |   9 +---
 drivers/cpufreq/Makefile            |   3 --
 drivers/cpufreq/arm_big_little_dt.c | 100 ------------------------------------
 drivers/cpufreq/intel_pstate.c      |  20 ++++----
 drivers/cpuidle/governors/menu.c    |  25 +++------
 include/linux/sched/stat.h          |   1 -
 kernel/hung_task.c                  |  30 ++++++++++-
 kernel/sched/core.c                 |  34 +++++-------
 9 files changed, 60 insertions(+), 163 deletions(-)
