From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fixes for v4.13-rc4
Date: Thu, 3 Aug 2017 21:13:30 +0200
Message-ID: <CAJZ5v0hLmeVDX5ezv+rs6hPBh-HXoP+vk2J1T9vh1qO=4p4=7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.13-rc4

with top-most commit 78aa904a773bfd008606c2065709e23173180ace

 Merge branches 'pm-core' and 'pm-misc'

on top of commit 16f73eb02d7e1765ccab3d2018e0bd98eb93d973

 Linux v4.13-rc3

to receive power management fixes for v4.13-rc4.

These fix two cpufreq issues, one introduced recently and one
related to recent changes, fix cpufreq documentation, fix up
recently added code in the Thunderbolt driver and update runtime
PM framework documentation.

Specifics:

 - Fix the handling of the scaling_cur_freq cpufreq policy attribute
   on x86 systems with the MPERF/APERF registers present to make it
   behave more as expected after recent changes (Rafael Wysocki).

 - Drop a leftover callback from the intel_pstate driver which also
   prevents the cpuinfo_cur_freq cpufreq policy attribute from being
   incorrectly exposed when intel_pstate works in the active mode
   (Rafael Wysocki).

 - Add a missing piece describing the cpuinfo_cur_freq policy
   attribute to cpufreq documentation (Rafael Wysocki).

 - Fix up a recently added part of the Thunderbolt driver to avoid
   aborting system suspends if its mailbox commands time out (Rafael
   Wysocki).

 - Update device runtime PM framework documentation to reflect the
   current behavior of the code (Johan Hovold).

Thanks!


---------------

Johan Hovold (1):
      PM / runtime: Document new pm_runtime_set_suspended() constraint

Rafael J. Wysocki (4):
      cpufreq: intel_pstate: Drop ->get from intel_pstate structure
      cpufreq: docs: Add missing cpuinfo_cur_freq description
      cpufreq: x86: Make scaling_cur_freq behave more as expected
      thunderbolt: icm: Ignore mailbox errors in icm_suspend()

---------------

 Documentation/admin-guide/pm/cpufreq.rst |  8 +++++++
 Documentation/power/runtime_pm.txt       |  3 ++-
 arch/x86/kernel/cpu/aperfmperf.c         | 40 +++++++++++++++++++++-----------
 drivers/cpufreq/intel_pstate.c           |  8 -------
 drivers/thunderbolt/icm.c                |  9 ++++++-
 5 files changed, 44 insertions(+), 24 deletions(-)
