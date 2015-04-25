From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] More ACPI and power management updates for v4.1-rc1
Date: Sat, 25 Apr 2015 04:18:58 +0200
Message-ID: <CAJZ5v0iLmRNhpfgsX8_ZyKTihvFj7vs0Ho845chtDoRsqNvP4g@mail.gmail.com>
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
 pm+acpi-4.1-rc1-2

to receive additional power management and ACPI material for v4.1-rc1
with top-most commit e0155a99b28f63e007c0c74076ad8ae486a3c9d3

 Merge branches 'acpi-dock', 'acpi-ec' and 'acpi-scan'

on top of commit 0f5abd4020bfd2b1eec6975b91bd5068aa674a93

 Merge tag 'acpica-4.1-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

These are fixes mostly (intel_pstate, ACPI core, ACPI EC driver, cpupower
tool), a new CPU ID for the Intel RAPL driver and one intel_pstate driver
improvement that didn't make it to my previous pull requests due to timing.

Specifics:

 - Fix a build warning in the intel_pstate driver showing up in non-SMP
   builds (Borislav Petkov).

 - Change one of the intel_pstate's P-state selection parameters for
   Baytrail and Cherrytrail CPUs to significantly improve performance
   at the cost of a small increase in energy consumption (Kristen
   Carlson Accardi).

 - Fix a NULL pointer dereference in the ACPI EC driver due to an unsafe
   list walk in the query handler removal routine (Chris Bainbridge).

 - Get rid of a false-positive lockdep warning in the ACPI container
   hot-remove code (Rafael J Wysocki).

 - Prevent the ACPI device enumeration code from creating device
   objects of a wrong type in some cases (Rafael J Wysocki).

 - Add Skylake processors support to the Intel RAPL power capping
   driver (Brian Bian).

 - Drop the stale MAINTAINERS entry for the ACPI dock driver that is
   regarded as part of the ACPI core and maintained along with it now
   (Chao Yu).

 - Fix cpupower tool breakage caused by a library API change in libpci
   3.3.0 (Lucas Stach).

Thanks!


---------------

Borislav Petkov (1):
      cpufreq: intel_pstate: Fix an annoying !CONFIG_SMP warning

Brian Bian (1):
      powercap / RAPL: Add support for Intel Skylake processors

Chao Yu (1):
      MAINTAINERS: remove maintainship entry of docking station driver

Chris Bainbridge (1):
      ACPI / EC: fix NULL pointer dereference in acpi_ec_remove_query_handler()

Kristen Carlson Accardi (1):
      intel_pstate: Change the setpoint for Atom params

Lucas Stach (1):
      cpupower: fix breakage from libpci API change

Rafael J. Wysocki (2):
      ACPI / scan: Annotate physical_node_lock in acpi_scan_is_offline()
      ACPI / scan: Add a scan handler for PRP0001

---------------

 MAINTAINERS                              |  6 -----
 drivers/acpi/ec.c                        |  2 +-
 drivers/acpi/scan.c                      | 39 +++++++++++++++++++++++++++-----
 drivers/cpufreq/intel_pstate.c           | 14 ++++++------
 drivers/powercap/intel_rapl.c            |  1 +
 tools/power/cpupower/utils/helpers/pci.c | 11 +++++++--
 6 files changed, 51 insertions(+), 22 deletions(-)
