From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fixes for v4.20-rc4
Date: Fri, 23 Nov 2018 11:10:58 +0100
Message-ID: <CAJZ5v0hpS244DB8nT82TyGFyyNkwg4rgHg834ocrt=+c7wa5CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.20-rc4

with top-most commit 1d50088ca3956e5dcd2751a658e7869b9af10bb4

 Merge branches 'pm-cpufreq' and 'pm-sleep'

on top of commit 9ff01193a20d391e8dbce4403dd5ef87c7eaaca6

 Linux 4.20-rc3

to receive power management fixes for 4.20-rc4.

These fix two issues in the Operating Performance Points (OPP)
framework, one cpufreq driver issue, one problem related to the
tasks freezer and a few build-related issues in the cpupower
utility.

Specifics:

 - Fix tasks freezer deadlock in de_thread() that occurs if one
   of its sub-threads has been frozen already (Chanho Min).

 - Avoid registering a platform device by the ti-cpufreq driver
   on platforms that cannot use it (Dave Gerlach).

 - Fix a mistake in the ti-opp-supply operating performance points
   (OPP) driver that caused an incorrect reference voltage to be
   used and make it adjust the minimum voltage dynamically to avoid
   hangs or crashes in some cases (Keerthy).

 - Fix issues related to compiler flags in the cpupower utility
   and correct a linking problem in it by renaming a file with
   a duplicate name (Jiri Olsa, Konstantin Khlebnikov).

Thanks!


---------------

Chanho Min (1):
      exec: make de_thread() freezable

Dave Gerlach (1):
      cpufreq: ti-cpufreq: Only register platform_device when supported

Jiri Olsa (2):
      tools cpupower debug: Allow to use outside build flags
      tools cpupower: Override CFLAGS assignments

Keerthy (2):
      opp: ti-opp-supply: Dynamically update u_volt_min
      opp: ti-opp-supply: Correct the supply in _get_optimal_vdd_voltage call

Konstantin Khlebnikov (1):
      tools/power/cpupower: fix compilation with STATIC=true

---------------

 drivers/cpufreq/ti-cpufreq.c               | 26 +++++++++++++++++++++-----
 drivers/opp/ti-opp-supply.c                |  5 ++++-
 fs/exec.c                                  |  5 +++--
 tools/power/cpupower/Makefile              | 12 ++++++------
 tools/power/cpupower/bench/Makefile        |  2 +-
 tools/power/cpupower/debug/x86_64/Makefile |  4 ++--
 tools/power/cpupower/lib/cpufreq.c         |  2 +-
 tools/power/cpupower/lib/cpuidle.c         |  2 +-
 tools/power/cpupower/lib/cpupower.c        |  4 ++--
 tools/power/cpupower/lib/cpupower_intern.h |  2 +-
 10 files changed, 42 insertions(+), 22 deletions(-)
