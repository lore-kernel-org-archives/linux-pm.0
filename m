From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fixes for v4.10-rc6
Date: Fri, 27 Jan 2017 01:02:04 +0100
Message-ID: <CAJZ5v0gJyNezgWcVetJb70HWM5wvuyZcDz_ghiD+hp=yw_9gzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.10-rc6

with top-most commit ff7e593c9cf3ccceaab7ac600cbd52cb9ff4c57a

 Merge branches 'pm-sleep' and 'pm-cpufreq'

on top of commit 7a308bb3016f57e5be11a677d15b821536419d36

 Linux 4.10-rc5

to receive power management fixes for v4.10-rc6.

These fix two regressions introduced recently, one by reverting the
problematic commit and one by fixing up the behavior in an overlooked
case.

Specifics:

 - Revert the recent change that caused suspend-to-idle to be used
   as the default suspend method on systems where it is indicated to
   be efficient by the ACPI tables, as that turned out to be premature
   and introduced suspend regressions on some systems with missing
   power management support in device drivers (Rafael Wysocki).

 - Fix up the intel_pstate driver to take changes of the global
   limits via sysfs correctly when the performance policy is used
   which has been broken by a recent change in it (Srinivas Pandruvada).

Thanks!

---------------

Rafael J. Wysocki (1):
      Revert "PM / sleep / ACPI: Use the ACPI_FADT_LOW_POWER_S0 flag"

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Fix sysfs limits enforcement for performance policy

---------------

 Documentation/power/states.txt |  4 +---
 drivers/acpi/sleep.c           |  8 --------
 drivers/cpufreq/intel_pstate.c | 14 +++++++++++++-
 include/linux/suspend.h        |  2 --
 kernel/power/suspend.c         |  4 ++--
 5 files changed, 16 insertions(+), 16 deletions(-)
