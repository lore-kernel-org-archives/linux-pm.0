From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fixes for v4.12-rc5
Date: Fri, 9 Jun 2017 02:19:20 +0200
Message-ID: <CAJZ5v0jQ03WFNOs9n=rzTanmhwLmNG4fkjenD+gZ3SzdrtJWxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.12-rc5

with top-most commit fbd78afe34d9cc3a86aff7cc214d9f06e815e63e

 Merge branches 'intel_pstate' and 'pm-sleep'

on top of commit 3c2993b8c6143d8a5793746a54eba8f86f95240f

 Linux 4.12-rc4

to receive power management fixes for v4.12-rc5.

These revert one problematic commit related to system sleep and fix
one recent intel_pstate regression.

Specifics:

 - Revert a recent commit that attempted to avoid spurious wakeups
   from suspend-to-idle via ACPI SCI, but introduced regressions on
   some systems (Rafael Wysocki).

   We will get back to the problem it tried to address in the next
   cycle.

 - Fix a possible division by 0 during intel_pstate initialization
   due to a missing check (Rafael Wysocki).

Thanks!


---------------

Rafael J. Wysocki (2):
      cpufreq: intel_pstate: Avoid division by 0 in min_perf_pct_min()
      Revert "ACPI / sleep: Ignore spurious SCI wakeups from suspend-to-idle"

---------------

 drivers/acpi/battery.c         |  2 +-
 drivers/acpi/button.c          |  5 ++---
 drivers/acpi/device_pm.c       |  3 +--
 drivers/acpi/sleep.c           | 28 ----------------------------
 drivers/base/power/main.c      |  5 +++++
 drivers/base/power/wakeup.c    | 18 ++++++------------
 drivers/cpufreq/intel_pstate.c |  5 +++--
 include/linux/suspend.h        |  7 ++-----
 kernel/power/process.c         |  2 +-
 kernel/power/suspend.c         | 29 ++++-------------------------
 10 files changed, 25 insertions(+), 79 deletions(-)
