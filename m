From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management and ACPI fixes for 4.0-rc8
Date: Fri, 10 Apr 2015 01:09:45 +0200
Message-ID: <CAJZ5v0iOnLxPjBeXSJPpg9c9AMTX-7zd8epLvjdzx4Y0tPrD6Q@mail.gmail.com>
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
 pm+acpi-4.0-rc8

to receive power management and ACPI fixes for v4.0-rc8 (if
there's one) or for final v4.0 (if there isn't) with top-most
commit b2d5fb97d37fb35708a0811af74d9e76e44d421c

 Merge branches 'pm-sleep', 'pm-cpufreq' and 'pm-cpuidle'

on top of commit f22e6e847115abc3a0e2ad7bb18d243d42275af1

 Linux 4.0-rc7

These are stable-candidate fixes of some recently reported issues
in the cpufreq core, cpuidle core, the ACPI cpuidle driver and the
hibernate core.

Specifics:

 - Revert a 3.17 hibernate commit that was supposed to fix an issue
   related to e820 reserved regions, but broke resume from hibernation
   on Lenovo x230 (Rafael J Wysocki).

 - Prevent the ACPI cpuidle driver from overwriting the name and
   description of the C0 state set by the core when the list of
   C-states changes (Thomas Schlichter).

 - Remove the no longer needed state_count field from struct cpuidle_device
   which prevents the list of C-states shown by the sysfs interface from
   becoming incorrect when the current number of them is different from
   the number of C-states on boot (Bartlomiej Zolnierkiewicz).

 - The cpufreq core updates the policy object of the only online CPU
   during system resume to make it reflect the current hardware state,
   but it always assumes that CPU to be CPU0 which need not be the
   case, so fix the code to avoid that assumption (Viresh Kumar).

Thanks!


---------------

Bartlomiej Zolnierkiewicz (1):
      cpuidle: remove state_count field from struct cpuidle_device

Rafael J. Wysocki (1):
      Revert "PM / hibernate: avoid unsafe pages in e820 reserved regions"

Thomas Schlichter (1):
      cpuidle: ACPI: do not overwrite name and description of C0

Viresh Kumar (1):
      cpufreq: Schedule work for the first-online CPU on resume

---------------

 drivers/acpi/processor_idle.c |  2 +-
 drivers/cpufreq/cpufreq.c     | 19 +++++++++++--------
 drivers/cpuidle/cpuidle.c     |  3 ---
 drivers/cpuidle/sysfs.c       |  5 +++--
 include/linux/cpuidle.h       |  1 -
 kernel/power/snapshot.c       | 21 +--------------------
 6 files changed, 16 insertions(+), 35 deletions(-)
