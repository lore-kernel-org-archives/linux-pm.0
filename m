From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI and power management fixes for v3.14-rc6
Date: Sat, 8 Mar 2014 02:51:09 +0100
Message-ID: <CAJZ5v0hwn2L5sFiNYgDu1yLypaKOS9RD7=xfUuqXU6QnfbT3QA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the git repository at

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-3.14-rc6

to receive ACPI and power management fixes for v3.14-rc6
with top-most commit 19bc45a59caf0ed2c2576da4d89c0ef8a8be1f63

  Merge branch 'pm-cpufreq'

on top of commit 0414855fdc4a40da05221fc6062cccbc0c30f169

  Linux 3.14-rc5

These fix bugs that have been present for quite some time, but either
they took a lot of effort to debug and address, or they have been
spotted recently and the fixes are rather straightforward, so it
doesn't seem useful to wait with them for the next couple of weeks.
Two of them fix the ACPI core, one fixes the Embedded Controller (EC)
driver and three fix concurrency-related issues in cpufreq.

Specifics:

 - ACPI tables in some BIOSes list device resources with size equal
   to 0, which doesn't make sense, so we should ignore them, but
   instead we try to use them and mangle things completely.  Fix
   from Zhang Rui.

 - Several models of Samsung laptops accumulate EC events when they
   are in sleep states which leads to EC buffer overflows that prevent
   new events from being signaled after system resume or reboot.  This
   has been affecting many users for quite a while and is addressed
   by clearing the EC buffer during system resume and system startup on
   those machines.  From Kieran Clancy.

 - If the ACPI sleep control and status registers are not present
   (which  happens if the Hardware Reduced ACPI mode bit is set in
   the ACPI tables, but also may result from BIOS bugs), we should
   not try to use ACPI to power off the system and ACPI S5 should
   not be listed as supported.  Fix from Aubrey Li.

 - There's a race condition in cpufreq_get() that leads to a kernel
   crash if that function is called at a wrong time.  Fix from
   Aaron Plattner.

 - cpufreq policy objects have to be initialized entirely before
   they are first accessed by their users which isn't the case
   currently and that potentially leads to various kinds of
   breakage that is difficult to debug.  Fix from Viresh Kumar.

 - Locking is missing in __cpufreq_add_dev() which leads to a race
   condition that may trigger a kernel crash.  Fix from Viresh Kumar.

Thanks!


---------------

Aaron Plattner (1):
      cpufreq: use cpufreq_cpu_get() to avoid cpufreq_get() race conditions

Kieran Clancy (1):
      ACPI / EC: Clear stale EC events on Samsung systems

Li, Aubrey (1):
      ACPI / sleep: pm_power_off needs more sanity checks to be installed

Viresh Kumar (2):
      cpufreq: Initialize policy before making it available for others to use
      cpufreq: Initialize governor for a new policy under policy->rwsem

Zhang Rui (1):
      ACPI / resources: ignore invalid ACPI device resources

---------------

 drivers/acpi/ec.c         | 64 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/resource.c   | 10 ++++++++
 drivers/acpi/sleep.c      |  7 +++++-
 drivers/cpufreq/cpufreq.c | 51 +++++++++++++++++--------------------
 4 files changed, 103 insertions(+), 29 deletions(-)
