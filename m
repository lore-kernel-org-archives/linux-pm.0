From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] ACPI and power management fixes for v3.12-rc3
Date: Sat, 28 Sep 2013 01:31:08 +0200
Message-ID: <1720906.nJEUKiKuDL@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the git repository at

  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm+acpi-3.12-rc3

to receive ACPI and power management fixes for v3.12-rc3 with
top-most commit dcc7bc3f3d91bbd5c15409a92317c2c24449a285

  Merge branch 'pm-cpufreq-fixes'

on top of commit 4a10c2ac2f368583138b774ca41fac4207911983

  Linux 3.12-rc2

These fix one recent cpufreq regression, a few older bugs that may
harm users and a kerneldoc typo.

Specifics:

 1) After recent locking changes in the cpufreq core it is possible
    to trigger BUG_ON(!policy) in lock_policy_rwsem_read() if
    cpufreq_get() is called before registering a cpufreq driver.
    Fix from Viresh Kumar.

 2) If intel_pstate has been loaded already, it doesn't make sense
    to do anything in acpi_cpufreq_init() and moreover doing something
    in there in that case may be harmful, so make that function return
    immediately if another cpufreq driver is already present.  From
    Yinghai Lu.

 3) The ACPI IPMI driver sometimes attempts to acquire a mutex from
    interrupt context, which can be avoided by replacing that mutex
    with a spinlock.  From Lv Zheng.

 4) A NULL pointer may be dereferenced by the exynos5440 cpufreq
    driver if a memory allocation made by it fails.  Fix from
    Sachin Kamat.

 5) Hanjun Guo's commit fixes a typo in the kerneldoc comment
    documenting acpi_bus_unregister_driver().

Thanks!


---------------

Hanjun Guo (1):
      ACPI / scan: fix typo in comments of acpi_bus_unregister_driver()

Lv Zheng (1):
      ACPI / IPMI: Fix atomic context requirement of ipmi_msg_handler()

Sachin Kamat (1):
      cpufreq: exynos5440: Fix potential NULL pointer dereference

Viresh Kumar (1):
      cpufreq: check cpufreq driver is valid and cpufreq isn't disabled in cpufreq_get()

Yinghai Lu (1):
      acpi-cpufreq: skip loading acpi_cpufreq after intel_pstate

---------------

 drivers/acpi/acpi_ipmi.c             |   24 ++++++++++++++----------
 drivers/acpi/scan.c                  |    2 +-
 drivers/cpufreq/acpi-cpufreq.c       |    4 ++++
 drivers/cpufreq/cpufreq.c            |    3 +++
 drivers/cpufreq/exynos5440-cpufreq.c |    2 +-
 5 files changed, 23 insertions(+), 12 deletions(-)
