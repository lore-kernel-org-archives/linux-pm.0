From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] More ACPI and power management updates for 3.20-rc1
Date: Fri, 13 Feb 2015 22:22:23 +0100
Message-ID: <CAJZ5v0hXWU-NX8TTMcQEEurFxpk6sQuf7br=HiWoGfs59Me9_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-3.20-rc1-2

to receive more ACPI and power management material for v3.20-rc1 with
top-most commit c7fb90dfbef49b03e6f3fd6a32338e59cbcf34ee

 Merge branches 'pm-cpufreq', 'pm-cpuidle', 'pm-devfreq', 'pm-opp' and
'pm-tools'

on top of commit 872912352c5be930e9568e5f3b6d73107d9f278d

 Merge tag 'pm+acpi-3.20-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

These are two reverts related to system suspend breakage by one of
a recent commits, a fix for a recently introduced bug in devfreq
and a bunch of other things that didn't make it into my previous
pull request, but otherwise are ready to go.

Specifics:

 - Revert two ACPI EC driver commits, one that broke system suspend
   on Acer Aspire S5 and one that depends on it (Rafael J Wysocki).

 - Fix a typo leading to an incorrect check in the exynos-ppmu devfreq
   driver (Dan Carpenter).

 - Add support for one more Broadwell CPU model to intel_idle (Len Brown).

 - Fix an obscure problem with state transitions related to interrupts
   in the speedstep-smi cpufreq driver (Mikulas Patocka).

 - Remove some unnecessary messages related to the "out of memory"
   condition from the core PM code (Quentin Lambert).

 - Update turbostat parameters and documentation, add support for
   one more Broadwell CPU model to it and modify it to skip
   printing disabled package C-states (Len Brown).

Thanks!


---------------

Dan Carpenter (1):
      PM / devfreq: event: testing the wrong variable

Len Brown (4):
      tools/power turbostat: Skip printing disabled package C-states
      tools/power turbostat: update parameters, documentation
      intel_idle: support additional Broadwell model
      tools/power turbostat: support additional Broadwell model

Mikulas Patocka (1):
      cpufreq: speedstep-smi: enable interrupts when waiting

Quentin Lambert (1):
      PM / OPP / clk: Remove unnecessary OOM message

Rafael J. Wysocki (2):
      Revert "ACPI / EC: Add GPE reference counting debugging messages"
      Revert "ACPI / EC: Add query flushing support"

---------------

 drivers/acpi/ec.c                     | 125 ++----------
 drivers/base/firmware_class.c         |   1 -
 drivers/base/power/clock_ops.c        |   4 +-
 drivers/base/power/opp.c              |   8 +-
 drivers/cpufreq/speedstep-lib.c       |   3 +
 drivers/cpufreq/speedstep-smi.c       |  12 ++
 drivers/devfreq/event/exynos-ppmu.c   |   4 +-
 drivers/idle/intel_idle.c             |   1 +
 tools/power/x86/turbostat/turbostat.8 |  68 ++++---
 tools/power/x86/turbostat/turbostat.c | 344 +++++++++++++++++++++-------------
 10 files changed, 293 insertions(+), 277 deletions(-)
