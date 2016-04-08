From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management and ACPI material for v4.6-rc3
Date: Fri, 8 Apr 2016 23:22:13 +0200
Message-ID: <CAJZ5v0i4t99+ATUSECMJnVotAEm7vaMY=9-wDfQdc80sCzAajw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-4.6-rc3

to receive power management and ACPI material for v4.6-rc3 with top-most
commit 73659be769a4f0ac26a6b3fc6699754adba36485

 Merge branches 'pm-core', 'powercap' and 'pm-tools'

on top of commit 9735a22799b9214d17d3c231fe377fc852f042e9

 Linux 4.6-rc2

Fixes for some issues discovered after recent changes and for
some that have just been found lately regardless of those changes
(intel_pstate, intel_idle, PM core, mailbox/pcc, turbostat) plus
support for some new CPU models (intel_idle, Intel RAPL driver,
turbostat) and documentation updates (intel_pstate, PM core).

Specifics:

 - intel_pstate fixes for two issues exposed by the recent switch
   over from using timers and for one issue introduced during the
   4.4 cycle plus new comments describing data structures used by
   the driver (Rafael Wysocki, Srinivas Pandruvada).

 - intel_idle fixes related to CPU offline/online (Richard Cochran).

 - intel_idle support (new CPU IDs and state definitions mostly) for
   Skylake-X and Kabylake processors (Len Brown).

 - PCC mailbox driver fix for an out-of-bounds memory access that
   may cause the kernel to panic() (Shanker Donthineni).

 - New (missing) CPU ID for one apparently overlooked Haswell model
   in the Intel RAPL power capping driver (Srinivas Pandruvada).

 - Fix for the PM core's wakeup IRQs framework to make it work after
   wakeup settings reconfiguration from sysfs (Grygorii Strashko).

 - Runtime PM documentation update to make it describe what needs
   to be done during device removal more precisely (Krzysztof
   Kozlowski).

 - Stale comment removal cleanup in the cpufreq-dt driver (Viresh
   Kumar).

 - turbostat utility fixes and support for Broxton, Skylake-X
   and Kabylake processors (Len Brown).

Thanks!


---------------

Krzysztof Kozlowski (1):
      PM / runtime: Document steps for device removal

Len Brown (9):
      intel_idle: Add SKX support
      intel_idle: Add KBL support
      tools/power turbostat: SGX state should print only if --debug
      tools/power turbostat: print IRTL MSRs
      tools/power turbostat: initial BXT support
      tools/power turbostat: decode BXT TSC frequency via CPUID
      tools/power turbostat: initial SKX support
      tools/power turbostat: initial KBL support
      tools/power turbostat: work around RC6 counter wrap

Rafael J. Wysocki (2):
      intel_pstate: Do not set utilization update hook too early
      intel_pstate: Avoid extra invocation of intel_pstate_sample()

Richard Cochran (10):
      intel_idle: remove useless return from void function.
      intel_idle: Fix a helper function's return value.
      intel_idle: Remove redundant initialization calls.
      intel_idle: Fix deallocation order on the driver exit path.
      intel_idle: Fix dangling registration on error path.
      intel_idle: Avoid a double free of the per-CPU data.
      intel_idle: Setup the timer broadcast only on successful driver load.
      intel_idle: Don't overreact to a cpuidle registration failure.
      intel_idle: Propagate hot plug errors.
      intel_idle: Clean up all registered devices on exit.

Shanker Donthineni (1):
      mailbox: pcc: Don't access an unmapped memory address space

Srinivas Pandruvada (3):
      cpufreq: intel_pstate: fix inconsistency in setting policy limits
      cpufreq: intel_pstate: Documenation for structures
      powercap: intel_rapl: Add missing Haswell model

Strashko, Grygorii (1):
      PM / wakeirq: fix wakeirq setting after wakup re-configuration from sysfs

Viresh Kumar (1):
      cpufreq: dt: Drop stale comment

---------------

 Documentation/power/runtime_pm.txt    |   4 +
 arch/x86/include/asm/msr-index.h      |   8 ++
 drivers/base/power/wakeup.c           |   2 +
 drivers/cpufreq/cpufreq-dt.c          |   3 -
 drivers/cpufreq/intel_pstate.c        | 206 +++++++++++++++++++++++++++++++---
 drivers/idle/intel_idle.c             |  97 +++++++++++-----
 drivers/mailbox/pcc.c                 |   4 +-
 drivers/powercap/intel_rapl.c         |   1 +
 tools/power/x86/turbostat/turbostat.c | 117 +++++++++++++++++--
 9 files changed, 380 insertions(+), 62 deletions(-)
