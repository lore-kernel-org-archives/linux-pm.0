From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] More power management updates for v4.19-rc1
Date: Wed, 22 Aug 2018 11:40:07 +0200
Message-ID: <CAJZ5v0ifNDOGwtMo7mQvv2eJYmUjDk=GUiQYeG4scNxrP2MsKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.19-rc1-2

with top-most commit 01ac7c4c2e035bc8d0d47dc880bbc25bf562a648

 Merge branches 'pm-cpufreq', 'pm-pci' and 'pm-sleep'

on top of commit b018fc9800557bd14a40d69501e19c340eb2c521

 Merge tag 'pm-4.19-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more power management updates for 4.19-rc1.

These fix the main idle loop and the menu cpuidle governor, clean up
the latter, fix a mistake in the PCI bus type's support for system
suspend and resume, fix the ondemand and conservative cpufreq
governors, address a build issue in the system wakeup framework and
make the ACPI C-states desciptions less confusing.

Specifics:

 - Make the idle loop handle stopped scheduler tick correctly (Rafael
   Wysocki).

 - Prevent the menu cpuidle governor from letting CPUs spend too much
   time in shallow idle states when it is invoked with scheduler tick
   stopped and clean it up somewhat (Rafael Wysocki).

 - Avoid invoking the platform firmware to make the platform enter
   the ACPI S3 sleep state with suspended PCIe root ports which may
   confuse the firmware and cause it to crash (Rafael Wysocki).

 - Fix sysfs-related race in the ondemand and conservative cpufreq
   governors which may cause the system to crash if the governor
   module is removed during an update of CPU frequency limits (Henry
   Willard).

 - Select SRCU when building the system wakeup framework to avoid a
   build issue in it (zhangyi).

 - Make the descriptions of ACPI C-states vendor-neutral to avoid
   confusion (Prarit Bhargava).

Thanks!


---------------

Henry Willard (1):
      cpufreq: governor: Avoid accessing invalid governor_data

Prarit Bhargava (1):
      x86/ACPI/cstate: Make APCI C1 FFH MWAIT C-state description vendor-neutral

Rafael J. Wysocki (5):
      cpuidle: menu: Fix white space
      cpuidle: menu: Update stale polling override comment
      PCI / ACPI / PM: Resume all bridges on suspend-to-RAM
      sched: idle: Avoid retaining the tick when it has been stopped
      cpuidle: menu: Handle stopped tick more aggressively

zhangyi (F) (1):
      PM / sleep: wakeup: Fix build error caused by missing SRCU support

---------------

 arch/x86/kernel/acpi/cstate.c      |  2 +-
 drivers/cpufreq/cpufreq_governor.c | 12 ++++++++--
 drivers/cpuidle/governors/menu.c   | 45 ++++++++++++++++++++++++--------------
 drivers/pci/pci-acpi.c             |  6 ++---
 kernel/power/Kconfig               |  1 +
 kernel/sched/idle.c                |  2 +-
 6 files changed, 43 insertions(+), 25 deletions(-)
