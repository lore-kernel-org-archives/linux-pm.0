From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] ACPI and power management fixes for v3.8-rc3
Date: Tue, 08 Jan 2013 00:53:14 +0100
Message-ID: <1839593.9xn3VhCMTU@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the git repository at

  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm+=
acpi-for-3.8-rc3

to receive ACPI and power management fixes for v3.8-rc3 with top-most c=
ommit
f67ffa95836b31be5d8fe336aee3bfc6412c5696

  Merge branch 'pm-sleep'

on top of commit d1c3ed669a2d452cacfb48c2d171a1f364dae2ed

  Linux 3.8-rc2

Included are:

* Removal of some ACPICA code that the kernel will never use from Lv Zh=
eng.

* APEI fix for erst_dbg_read() return value when persistent store is em=
pty
  initially from Adrian Huang.

* Removal of some unnecessary code from ACPI memory hotplug driver from
  Liu Jinsong.

* ACPI power management fixes preventing useless messages from being pr=
inted
  and correcting acpi_bus_get_device() result check.

* ACPI debug code fix to prevent some debug messages from being printed
  with levels greater than KERN_DEBUG from Joe Perches.

* ACPI namespace scanning code fix to make system bus device nodes (lik=
e _SB)
  get the right names (-stable material).

* PNP resources handling fixes from Witold Szczeponik.

* cpuidle fix for a recent regression stalling boot on systems with gre=
at
  numbers (like hundreds) of CPUs from Daniel Lezcano.

* cpuidle fixes (one of them being -stable material) from Sivaram Nair.

* intel_idle debug message fix from Youquan Song.

* cpufreq build regression fix from Larry Finger.

* cpufreq fix for an obscure initialization race related to statistics =
from
  Konstantin Khlebnikov.

* cpufreq change disabling the Longhaul driver by default (which appare=
ntly
  is hopless to debug and fix) from Rafa=C5=82 Bilski.

* PM core fix preventing device suspend errors from happening during sy=
stem
  suspend due to obscure race conditions (-stable material).

* PM QoS local variable name cleanup.

Thanks!


 Documentation/power/runtime_pm.txt |   9 +-
 drivers/acpi/acpi_memhotplug.c     |  18 --
 drivers/acpi/acpica/Makefile       |   2 +-
 drivers/acpi/acpica/utclib.c       | 749 -----------------------------=
----------------
 drivers/acpi/apei/erst-dbg.c       |  11 +-
 drivers/acpi/device_pm.c           |   3 +-
 drivers/acpi/glue.c                |   9 +-
 drivers/acpi/power.c               |  11 +-
 drivers/acpi/scan.c                |   2 +-
 drivers/base/power/main.c          |   9 +-
 drivers/base/power/qos.c           |  10 +-
 drivers/cpufreq/Kconfig            |   5 +
 drivers/cpufreq/Makefile           |   5 +-
 drivers/cpufreq/cpufreq_stats.c    |  11 +-
 drivers/cpufreq/longhaul.c         |  10 +-
 drivers/cpuidle/coupled.c          |   2 +-
 drivers/cpuidle/cpuidle.c          |   2 +-
 drivers/cpuidle/driver.c           |   8 +-
 drivers/cpuidle/governors/menu.c   |   2 +-
 drivers/idle/intel_idle.c          |   2 +-
 drivers/pnp/interface.c            | 105 ++++---
 drivers/pnp/manager.c              |  25 +-
 22 files changed, 154 insertions(+), 856 deletions(-)

---------------

Adrian Huang (1):
      ACPI / APEI: Fix the returned value in erst_dbg_read

Daniel Lezcano (1):
      cpuidle: fix lock contention in the idle path

Joe Perches (1):
      ACPI / glue: Update DBG macro to include KERN_DEBUG

Konstantin Khlebnikov (1):
      cpufreq / stats: fix race between stats allocation and first usag=
e

Larry Finger (1):
      cpufreq / governor: Fix problem with cpufreq_ondemand or cpufreq_=
conservative

Liu Jinsong (1):
      ACPI / memhotplug: remove redundant logic of acpi memory hotadd

Lv Zheng (1):
      ACPICA: Remove useless mini-C library.

Rafael J. Wysocki (5):
      ACPI / PM: Do not apply ACPI_SUCCESS() to acpi_bus_get_device() r=
esult
      ACPI / power: Remove useless message from device registering rout=
ine
      ACPI / scan: Do not use dummy HID for system bus ACPI nodes
      PM / QoS: Rename local variable in dev_pm_qos_add_ancestor_reques=
t()
      PM: Move disabling/enabling runtime PM to late suspend/early resu=
me

Rafa=C5=82 Bilski (1):
      cpufreq / Longhaul: Disable driver by default

Sivaram Nair (2):
      cpuidle: Fix finding state with min power_usage
      cpuidle / coupled: fix ready counter decrement

Witold Szczeponik (2):
      PNP: Simplify setting of resources
      PNP: Handle IORESOURCE_BITS in resource allocation

Youquan Song (1):
      intel_idle: pr_debug information need separated


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
