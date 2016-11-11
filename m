From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fixes for v4.9-rc5
Date: Sat, 12 Nov 2016 00:52:36 +0100
Message-ID: <CAJZ5v0h_BXB2j42FGM47q7RYCRrVf_UfC5_6gLEcepJ+6-o23A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.9-rc5

with top-most commit cd16f3dcdb1817956277fbeee0746ae1eb4f851a

 Merge branches 'pm-tools-fixes' and 'pm-sleep-fixes'

on top of commit bc33b0ca11e3df467777a4fa7639ba488c9d4911

 Linux 4.9-rc4

to receive power management fixes for v4.9-rc5.

These fix two bugs in error code paths in the PM core (system-wide
suspend of devices), a device reference leak in the boot-time suspend
test code and a cpupower utility regression from the 4.7 cycle.

Specifics:

 - Prevent the PM core from attempting to suspend parent devices
   if any of their children, whose suspend callbacks were invoked
   asynchronously, have failed to suspend during the "late" and
   "noirq" phases of system-wide suspend of devices (Brian Norris).

 - Prevent the boot-time system suspend test code from leaking a
   reference to the RTC device used by it (Johan Hovold).

 - Fix cpupower to use the return value of one of its library
   functions correctly and restore the correct behavior of it
   when used for setting cpufreq tunables broken during the 4.7
   development cycle (Laura Abbott).

Thanks!


---------------

Brian Norris (1):
      PM / sleep: don't suspend parent when async child
suspend_{noirq, late} fails

Johan Hovold (1):
      PM / sleep: fix device reference leak in test_suspend

Laura Abbott (1):
      cpupower: Correct return type of cpu_power_is_cpu_online() in cpufreq-set

---------------

 drivers/base/power/main.c                | 8 ++++----
 kernel/power/suspend_test.c              | 4 +++-
 tools/power/cpupower/utils/cpufreq-set.c | 7 ++-----
 3 files changed, 9 insertions(+), 10 deletions(-)
