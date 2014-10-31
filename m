From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI and power management fixes for 3.18-rc3
Date: Fri, 31 Oct 2014 23:09:52 +0100
Message-ID: <CAJZ5v0g_imW9B56qZQJBpuYybeEPguybMcnnC5RbAB+fLB5d5A@mail.gmail.com>
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
 pm+acpi-3.18-rc3

to receive ACPI and power management fixes for v3.18-rc3 with
top-most commit 7d627280b359a965105bcdd8f08224dfa14a3961

 Merge branches 'pm-cpufreq' and 'pm-sleep'

on top of commit cac7f2429872d3733dc3f9915857b1691da2eb2f

 Linux 3.18-rc2

These are fixes received after my previous pull request plus
one that has been in the works for quite a while, but its
previous version caused problems to happen, so it's been deferred
till now.

Fixed are 2 recent regressions (MFD enumeration and cpufreq-dt),
ACPI EC regression introduced in 3.17, system suspend error code
path regression introduced in 3.15, an older bug related to
recovery from failing resume from hibernation and a cpufreq-dt
driver issue related to operation performance points.

Specifics:

 - Fix a crash on r8a7791/koelsch during resume from system suspend
   caused by a recent cpufreq-dt commit (Geert Uytterhoeven).

 - Fix an MFD enumeration problem introduced by a recent commit
   adding ACPI support to the MFD subsystem that exposed a weakness
   in the ACPI core causing ACPI enumeration to be applied to all
   devices associated with one ACPI companion object, although it
   should be used for one of them only (Mika Westerberg).

 - Fix an ACPI EC regression introduced during the 3.17 cycle
   causing some Samsung laptops to misbehave as a result of a
   workaround targeted at some Acer machines.  That includes
   a revert of a commit that went too far and a quirk for the
   Acer machines in question.  From Lv Zheng.

 - Fix a regression in the system suspend error code path introduced
   during the 3.15 cycle that causes it to fail to take errors from
   asychronous execution of "late" suspend callbacks into account
   (Imre Deak).

 - Fix a long-standing bug in the hibernation resume error code path
   that fails to roll back everything correcty on "freeze" callback
   errors and leaves some devices in a "suspended" state causing more
   breakage to happen subsequently (Imre Deak).

 - Make the cpufreq-dt driver disable operation performance points
   that are not supported by the VR connected to the CPU voltage
   plane with acceptable tolerance instead of constantly failing
   voltage scaling later on (Lucas Stach).

Thanks!


---------------

Geert Uytterhoeven (1):
      cpufreq: cpufreq-dt: Restore default cpumask_setall(policy->cpus)

Imre Deak (2):
      PM / Sleep: fix async suspend_late/freeze_late error handling
      PM / Sleep: fix recovery during resuming from hibernation

Lucas Stach (1):
      cpufreq: cpufreq-dt: disable unsupported OPPs

Lv Zheng (2):
      Revert "ACPI / EC: Add support to disallow QR_EC to be issued
before completing previous QR_EC"
      ACPI / EC: Fix regression due to conflicting firmware behavior
between Samsung and Acer.

Mika Westerberg (1):
      ACPI: Use ACPI companion to match only the first physical device

---------------

 drivers/acpi/ec.c            | 31 +++++++++++++-------
 drivers/acpi/scan.c          | 70 ++++++++++++++++++++++++++++++++++----------
 drivers/base/power/main.c    |  2 ++
 drivers/cpufreq/cpufreq-dt.c | 68 ++++++++++++++++++++++++++----------------
 kernel/power/hibernate.c     |  8 ++++-
 5 files changed, 126 insertions(+), 53 deletions(-)
