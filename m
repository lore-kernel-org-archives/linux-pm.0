From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management updates for v5.0-rc2
Date: Fri, 11 Jan 2019 11:21:11 +0100
Message-ID: <CAJZ5v0gs=38z8y67j8Y-qbAComzfyucouK0-T7YL1ajoTK3RhQ@mail.gmail.com>
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
 pm-5.0-rc2

with top-most commit 343e60e52a3a093bb7baeca441789724fcac4bb5

 Merge branches 'pm-cpuidle', 'pm-cpufreq' and 'pm-sleep'

on top of commit bfeffd155283772bbe78c6a05dec7c0128ee500c

 Linux 5.0-rc1

to receive power management updates for 5.0-rc2.

These fix fallout after starting to use hrtimers in the runtime PM
framework, fix a few cpufreq issues, fix a recently broken reference
to cpuidle documentation, update MAINTAINERS entries for cpufreq and
cpuidle and make the recently added system suspend and resume support
in devfreq actually work.

Specifics:

 - Prevent integer overflows from occurring on 32-bit when
   converting milliseconds to nanoseconds in the runtime PM
   framework and update comments that still refer to jiffies
   in it (Vincent Guittot, Ladislav Michl).

 - Fix the SCMI cpufreq driver to always use the same frequency
   units for arch_set_freq_scale() and make the scale-invariant
   load tracking acutally work with this driver (Quentin Perret).

 - Fix freeing of dynamic OPPs in the SCPI and SCMI cpufreq drivers
   broken during the 4.20 defelopment cycle (Viresh Kumar).

 - Prevent the cpufreq core from attempting to return the current
   frequency of offline CPUs (Sudeep Holla).

 - Add devfreq suspend and resume hooks (missed previously) to the
   PM core to make the recently added system suspend and resume
   support in devfreq actually work (Lukasz Luba).

 - Update MAINTAINERS entries for cpufreq and cpuidle, mostly to add
   references to new/current documentation to them (Rafael Wysocki).

 - Fix a recently broken reference to cpuidle documentation (Otto
   Sabart).

Thanks!


---------------

Ladislav Michl (1):
      PM-runtime: Fix 'jiffies' in comments after switch to hrtimers

Lukasz Luba (1):
      PM: sleep: call devfreq suspend/resume

Otto Sabart (1):
      doc: trace: fix reference to cpuidle documentation file

Quentin Perret (1):
      cpufreq: scmi: Fix frequency invariance in slow path

Rafael J. Wysocki (2):
      cpufreq / Documentation: Update cpufreq MAINTAINERS entry
      cpuidle / Documentation: Update cpuidle MAINTAINERS entry

Sudeep Holla (1):
      cpufreq: check if policy is inactive early in __cpufreq_get()

Vincent Guittot (1):
      PM-runtime: Fix autosuspend_delay on 32bits arch

Viresh Kumar (1):
      cpufreq: scpi/scmi: Fix freeing of dynamic OPPs

---------------

 Documentation/trace/coresight-cpu-debug.txt |  2 +-
 MAINTAINERS                                 |  7 +++-
 drivers/base/power/main.c                   |  3 ++
 drivers/base/power/runtime.c                | 11 +++--
 drivers/cpufreq/cpufreq.c                   | 12 ++----
 drivers/cpufreq/scmi-cpufreq.c              |  8 ++--
 drivers/cpufreq/scpi-cpufreq.c              |  4 +-
 drivers/opp/core.c                          | 63 ++++++++++++++++++++++++++---
 include/linux/pm_opp.h                      |  5 +++
 9 files changed, 89 insertions(+), 26 deletions(-)
