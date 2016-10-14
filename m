From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] More power management updates for v4.9-rc1
Date: Fri, 14 Oct 2016 15:26:24 +0200
Message-ID: <CAJZ5v0j6kvykKPaucTC2kX1PB70s3mAy-HvB3NrHYK9ipJC6Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-extra-4.9-rc1

with top-most commit 383731d98e768e15f4a8d69ae87957b933323ed7

 Merge branches 'pm-cpufreq' and 'pm-devfreq'

on top of commit 08895a8b6b06ed2323cd97a36ee40a116b3db8ed

 Merge tag 'pm-4.9-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive additional power management updates for v4.9-rc1.

This includes a couple of fixes for cpufreq regressions introduced
in 4.8, a rework of the intel_pstate algorithm used on Atom processors
(that took some time to test) plus a fix and a couple of cleanups in
that driver, a CPPC cpufreq driver fix, and a some devfreq fixes and
cleanups (core and exynos-nocp).

Specifics:

 - Fix two cpufreq regressions causing undesirable changes in
   behavior to appear (one in the core and one in the conservative
   governor) introduced during the 4.8 cycle (Aaro Koskinen, Rafael
   Wysocki).

 - Fix the way the intel_pstate driver accesses MSRs related to the
   hardware-managed P-states (HWP) feature during the initialization
   which currently is unsafe and may cause the processor to generate
   a general protection fault (Srinivas Pandruvada).

 - Rework the intel_pstate's P-state selection algorithm used on Atom
   processors to avoid known problems with the current one and to
   make the computation more straightforward, which also happens to
   improve performance in multiple benchmarks a bit (Rafael Wysocki).

 - Improve two comments in the intel_pstate driver (Rafael Wysocki).

 - Fix the desired performance computation in the CPPC cpufreq driver
   (Hoan Tran).

 - Fix the devfreq core to avoid printing misleading error messages
   in some cases (Tobias Jakobi).

 - Fix the error code path in devfreq_add_device() to use proper
   locking around list modifications (Axel Lin).

 - Fix a build failure and remove a couple of redundant updates of
   variables in the exynos-nocp devfreq driver (Axel Lin).

Thanks!

---------------

Aaro Koskinen (1):
      cpufreq: skip invalid entries when searching the frequency

Axel Lin (3):
      PM / devfreq: exynos-nocp: Select REGMAP_MMIO
      PM / devfreq: exynos-nocp: Remove redundant code
      PM / devfreq: Add proper locking around list_del()

Hoan Tran (1):
      cpufreq: CPPC: Correct desired_perf calculation

Rafael J. Wysocki (4):
      cpufreq: intel_pstate: Clarify comment in
get_target_pstate_use_performance()
      cpufreq: intel_pstate: Proportional algorithm for Atom
      cpufreq: intel_pstate: Fix struct pstate_adjust_policy kerneldoc
      cpufreq: conservative: Fix next frequency selection

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Fix unsafe HWP MSR access

Tobias Jakobi (1):
      PM / devfreq: Skip status update on uninitialized previous_freq

---------------

 drivers/cpufreq/cppc_cpufreq.c         |   8 ++-
 drivers/cpufreq/cpufreq_conservative.c |  19 +++++-
 drivers/cpufreq/intel_pstate.c         |  43 ++++++++++----
 drivers/devfreq/devfreq.c              |   8 ++-
 drivers/devfreq/event/Kconfig          |   1 +
 drivers/devfreq/event/exynos-nocp.c    |   3 -
 include/linux/cpufreq.h                | 104 ++++++++++++++++-----------------
 7 files changed, 115 insertions(+), 71 deletions(-)
