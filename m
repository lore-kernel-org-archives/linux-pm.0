From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management and ACPI fixes for v4.6-rc7
Date: Fri, 6 May 2016 14:46:02 +0200
Message-ID: <CAJZ5v0jFHHdxzY8_3wXdYKPXKhXM0Em50sniauO8SEZrN0XP3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-4.6-rc7

to receive power management and ACPI fixes for v4.6-rc7 with top-most
commit 5f2f88e330e7ee2d2d7c5e0984b86108b00ac800

 Merge branches 'pm-opp-fixes', 'pm-cpufreq-fixes' and 'pm-cpuidle-fixes'

on top of commit 04974df8049fc4240d22759a91e035082ccd18b4

 Linux 4.6-rc6

Fixes for problems introduced or discovered recently (intel_pstate,
sti-cpufreq, ARM64 cpuidle, Operating Performance Points framework,
generic device properties framework) and one fix for a hotplug-related
deadlock in ACPICA that's been there forever, but is nasty enough.

Specifics:

 - Fix for a recent regression in the intel_pstate driver causing
   it to fail to restore the HWP (HW-managed P-states) configuration
   of the boot CPU after suspend-to-RAM (Rafael Wysocki).

 - Fix for two recent regressions in the intel_pstate driver, one
   that can trigger a divide by zero if the driver is accessed via
   sysfs before it manages to take the first sample and one causing
   it to fail to update a structure field used in a trace point, so
   the information coming from it is less useful (Rafael Wysocki).

 - Fix for a problem in the sti-cpufreq driver introduced during
   the 4.5 cycle that causes it to break CPU PM in multi-platform
   kernels by registering cpufreq-dt (which subsequently doesn't
   work) unconditionally and preventing the driver that would
   actually work from registering (Sudeep Holla).

 - Stable-candidate fix for an ARM64 cpuidle issue causing idle
   state usage counters to be incorrectly updated for idle states
   that were not entered due to errors (James Morse).

 - Fix for a recently introduced issue in the OPP (Operating
   Performance Points) framework causing it to print bogus error
   messages for missing optional regulators (Viresh Kumar).

 - Fix for a recently introduced issue in the generic device
   properties framework that may cause it to attempt to dereferece
   and invalid pointer in some cases (Heikki Krogerus).

 - Fix for a deadlock in the ACPICA core that may be triggered
   by device (eg. Thunderbolt) hotplug (Prarit Bhargava).

Thanks!

---------------

Heikki Krogerus (1):
      device property: Avoid potential dereferences of invalid pointers

James Morse (1):
      ARM: cpuidle: Pass on arm_cpuidle_suspend()'s return value

Prarit Bhargava (1):
      ACPICA: Dispatcher: Update thread ID for recursive method calls

Rafael J. Wysocki (2):
      cpufreq: intel_pstate: Fix HWP on boot CPU after system resume
      intel_pstate: Fix intel_pstate_get()

Sudeep Holla (1):
      cpufreq: st: enable selective initialization based on the platform

Viresh Kumar (1):
      PM / OPP: Remove useless check

---------------

 drivers/acpi/acpica/dsmethod.c |  3 +++
 drivers/base/power/opp/core.c  |  3 ---
 drivers/base/property.c        |  2 +-
 drivers/cpufreq/cpufreq.c      | 26 +++++++++++++++-----------
 drivers/cpufreq/intel_pstate.c | 26 ++++++++++++++++++--------
 drivers/cpufreq/sti-cpufreq.c  |  4 ++++
 drivers/cpuidle/cpuidle-arm.c  |  2 +-
 include/acpi/acpi_bus.h        |  4 ++--
 include/linux/of.h             |  2 +-
 9 files changed, 45 insertions(+), 27 deletions(-)
