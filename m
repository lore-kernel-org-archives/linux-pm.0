From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI and power management fixes for final 3.17
Date: Fri, 3 Oct 2014 03:37:02 +0200
Message-ID: <CAJZ5v0j0msewTyUSkgFPap03BtjCxmVQABg61X_QVR6u-QtXFg@mail.gmail.com>
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
 pm+acpi-3.17-final

to receive ACPI and power management fixes for final v3.17
with top-most commit abcadddc85a4c9595b0a5ede34f2ee876fe4155f

 Merge branches 'pm-cpufreq' and 'acpi-video'

on top of commit fe82dcec644244676d55a1384c958d5f67979adb

 Linux 3.17-rc7

These are three regression fixes (cpufreq core, pcc-cpufreq,
i915 / ACPI) and one trivial fix for a callback return value
mismatch in the cpufreq integrator driver.

Specifics:

 - A recent cpufreq core fix went too far and introduced a regression
   in the system suspend code path.  Fix from Viresh Kumar.

 - An ACPI-related commit in the i915 driver that fixed backlight
   problems for some Thinkpads inadvertently broke a Dell machine
   (in 3.16).  Fix from Aaron Lu.

 - The pcc-cpufreq driver was broken during the 3.15 cycle by a
   commit that put wait_event() under a spinlock by mistake.  Fix
   that (Rafael J Wysocki).

 - The return value type of integrator_cpufreq_remove() is void, but
   should be int.  Fix from Arnd Bergmann.

Thanks!

---------------

Aaron Lu (1):
      ACPI / i915: Update the condition to ignore firmware backlight
change request

Arnd Bergmann (1):
      cpufreq: integrator: fix integrator_cpufreq_remove return type

Rafael J. Wysocki (1):
      cpufreq: pcc-cpufreq: Fix wait_event() under spinlock

Viresh Kumar (1):
      cpufreq: update 'cpufreq_suspended' after stopping governors

---------------

 drivers/cpufreq/cpufreq.c             |  7 ++++---
 drivers/cpufreq/integrator-cpufreq.c  |  4 ++--
 drivers/cpufreq/pcc-cpufreq.c         |  2 +-
 drivers/gpu/drm/i915/intel_opregion.c | 16 +++++++++++-----
 4 files changed, 18 insertions(+), 11 deletions(-)
