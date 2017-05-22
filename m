From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management updates for v4.12-rc3
Date: Mon, 22 May 2017 21:48:33 +0200
Message-ID: <CAJZ5v0jPWqHqM7dunxZyD2acai--y77gkWKYQCHAbELS_1v+pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.12-rc3

with top-most commit bb47e964175e5fb4c163066e4373fac055fe5da0

 Merge branches 'pm-sleep' and 'powercap'

on top of commit 08332893e37af6ae779367e78e444f8f9571511d

 Linux 4.12-rc2

to receive power management updates for v4.12-rc3.

These fix RTC wakeup from suspend-to-idle broken recently, fix CPU
idleness detection condition in the schedutil cpufreq governor, fix
a cpufreq driver build failure, fix an error code path in the power
capping framework, clean up the hibernate core and update the
intel_pstate documentation.

Specifics:

 - Fix RTC wakeup from suspend-to-idle broken by the recent rework
   of ACPI wakeup handling (Rafael Wysocki).

 - Update intel_pstate driver documentation to reflect the current
   code and explain how it works in more detail (Rafael Wysocki).

   That had dependencies in both the PM and documentation trees
   which all have been merged now.

 - Fix an issue related to CPU idleness detection on systems with
   shared cpufreq policies in the schedutil governor (Juri Lelli).

 - Fix a possible build issue in the dbx500 cpufreq driver (Arnd
   Bergmann).

 - Fix a function in the power capping framework core to return
   an error code instead of 0 when there's an error (Dan Carpenter).

 - Clean up variable definition in the hibernation core (Pushkar
   Jambhlekar).

Thanks!


---------------

Arnd Bergmann (1):
      cpufreq: dbx500: add a Kconfig symbol

Dan Carpenter (1):
      PowerCap: Fix an error code in powercap_register_zone()

Juri Lelli (1):
      cpufreq: schedutil: use now as reference when aggregating shared
policy requests

Pushkar Jambhlekar (1):
      PM / hibernate: Declare variables as static

Rafael J. Wysocki (3):
      cpufreq: intel_pstate: Document the current behavior and user interface
      PM / wakeup: Fix up wakeup_source_report_event()
      RTC: rtc-cmos: Fix wakeup from suspend-to-idle

---------------

 Documentation/admin-guide/pm/cpufreq.rst      |  19 +-
 Documentation/admin-guide/pm/index.rst        |   1 +
 Documentation/admin-guide/pm/intel_pstate.rst | 755 ++++++++++++++++++++++++++
 Documentation/cpu-freq/intel-pstate.txt       | 281 ----------
 drivers/base/power/wakeup.c                   |  11 +-
 drivers/cpufreq/Kconfig.arm                   |   9 +
 drivers/cpufreq/Makefile                      |   2 +-
 drivers/powercap/powercap_sys.c               |   1 +
 drivers/rtc/rtc-cmos.c                        |   2 +-
 kernel/power/snapshot.c                       |   2 +-
 kernel/sched/cpufreq_schedutil.c              |   7 +-
 11 files changed, 787 insertions(+), 303 deletions(-)
