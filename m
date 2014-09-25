From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI and power management fixes for 3.17-rc7
Date: Thu, 25 Sep 2014 23:56:18 +0200
Message-ID: <CAJZ5v0hsuZ-Xhsqvz=1SnL1438nyhiBvd+GTZa16OkWmxz=F2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-3.17-rc7

to receive ACPI and power management fixes for v3.17-rc7 (or
for the final v3.17 if there's no -rc7) with top-most commit
381e63da44301f49be5876d56a5da2434f132dff

 Merge branches 'pm-cpufreq' and 'pm-sleep'

on top of commit 0f33be009b89d2268e94194dc4fd01a7851b6d51

 Linux 3.17-rc6

These are regression fixes (ACPI hotplug, cpufreq, hibernation, ACPI
LPSS driver), fixes for stuff that never worked correctly (ACPI GPIO
support in some cases and a wrong sign of an error code in the ACPI
core in one place), and one blacklist item for ACPI backlight handling.

Specifics:

 - Revert of a recent hibernation core commit that introduced
   a NULL pointer dereference during resume for at least one user
   (Rafael J Wysocki).

 - Fix for the ACPI LPSS (Low-Power Subsystem) driver to disable
   asynchronous PM callback execution for LPSS devices during system
   suspend/resume (introduced in 3.16) which turns out to break
   ordering expectations on some systems.  From Fu Zhonghui.

 - cpufreq core fix related to the handling of sysfs nodes during
   system suspend/resume that has been broken for intel_pstate
   since 3.15 from Lan Tianyu.

 - Restore the generation of "online" uevents for ACPI container
   devices that was removed in 3.14, but some user space utilities
   turn out to need them (Rafael J Wysocki).

 - The cpufreq core fails to release a lock in an error code path
   after changes made in 3.14.  Fix from Prarit Bhargava.

 - ACPICA and ACPI/GPIO fixes to make the handling of ACPI GPIO
   operation regions (which means AML using GPIOs) work correctly
   in all cases from Bob Moore and Srinivas Pandruvada.

 - Fix for a wrong sign of the ACPI core's create_modalias() return
   value in case of an error from Mika Westerberg.

 - ACPI backlight blacklist entry for ThinkPad X201s from Aaron Lu.

Thanks!


---------------

Aaron Lu (1):
      ACPI / video: disable native backlight for ThinkPad X201s

Bob Moore (1):
      ACPICA: Update to GPIO region handler interface.

Fu Zhonghui (1):
      ACPI / platform / LPSS: disable async suspend/resume of LPSS devices

Lan Tianyu (1):
      cpufreq: fix cpufreq suspend/resume for intel_pstate

Mika Westerberg (1):
      ACPI / scan: Correct error return value of create_modalias()

Prarit Bhargava (1):
      cpufreq: release policy->rwsem on error

Rafael J. Wysocki (2):
      ACPI / hotplug: Generate online uevents for ACPI containers
      Revert "PM / Hibernate: Iterate over set bits instead of PFNs in
swsusp_free()"

Srinivas Pandruvada (1):
      gpio / ACPI: Use pin index and bit length

---------------

 drivers/acpi/acpi_lpss.c       |  1 -
 drivers/acpi/acpica/aclocal.h  |  1 +
 drivers/acpi/acpica/acobject.h |  1 +
 drivers/acpi/acpica/dsfield.c  |  2 ++
 drivers/acpi/acpica/evregion.c | 47 +++++++++++++++++++----------
 drivers/acpi/acpica/exfield.c  | 67 ++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/exprep.c   |  2 ++
 drivers/acpi/container.c       |  8 +++++
 drivers/acpi/scan.c            |  5 +++-
 drivers/acpi/video.c           |  8 +++++
 drivers/cpufreq/cpufreq.c      | 10 ++++---
 drivers/gpio/gpiolib-acpi.c    |  5 +++-
 include/acpi/acpi_bus.h        |  1 +
 kernel/power/snapshot.c        | 50 ++++++++++---------------------
 14 files changed, 150 insertions(+), 58 deletions(-)
