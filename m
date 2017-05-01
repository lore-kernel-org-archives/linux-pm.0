From: Rafael Wysocki <rjwysocki@gmail.com>
Subject: [GIT PULL] ACPI updates for v4.12-rc1, part 1
Date: Mon, 1 May 2017 22:50:37 +0200
Message-ID: <CAJZ5v0j4o+WXV7rxisP5cxT5Y1s_qkNUOTXt8EybfKTDmHf+TA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.12-rc1

with top-most commit 52e70c8af7e5d04e3fe431066f0530a17a8147c2

 Merge branches 'acpi-power', 'acpi-blacklist', 'acpi-video' and 'acpi-doc'

on top of commit 5a7ad1146caa895ad718a534399e38bd2ba721b7

 Linux 4.11-rc8

to receive the first batch of ACPI updates for v4.12-rc1.

These are some device enumeration code changes, updates of the AC
and battery drivers to help them avoid attaching to devices that
cannot be handled by them, new operation region driver for the
Intel CHT Whiskey Cove PMIC, new sysfs entries for CPPC performance
capabilities, a new _REV quirk blacklist entry and a couple of
assorted minor fixes and cleanups.

Specifics:

 - Update the core device enumeration code to make it more internally
   consistent and robust and drop the force_remove sysfs attribute
   that could be used to tell it to ignore errors on device
   hot-removal which was dangerous in general and no real and
   still relevant use cases for it could be found (Rafael Wysocki,
   Michal Hocko).

 - Make the core device enumeration code use _PXM to associate
   platform devices created by it with specific NUMA nodes (Shanker
   Donthineni).

 - Extend the CPPC library by adding more sysfs entries for
   performance capabilities to it and making it use the lowest
   nonlinear performance parameter (Prashanth Prakash).

 - Make the CPU online more consistent with CPU initialization in
   the ACPI processor driver (Prashanth Prakash).

 - Update the AC and battery drivers to help them avoid attaching to
   devices that cannot be handled by them and update the axp288_charger
   power supply driver to work correctly on ACPI systems without the
   INT3496 device (Hans de Goede).

 - Add an ACPI operation region driver for the Intel CHT Whiskey Cove
   PMIC and update the xpower operation region driver to work without
   IIO which isn't really necessary for it to work (Hans de Goede).

 - Add a new entry for Dell Inspiron 7537 to the _REV quirk blacklist
   (Kai Heng Feng).

 - Make the code in the ACPI video driver easier to follow by adding
   symbols and comments to it (Dmitry Frank).

 - Update ACPI documentation and drop a function that has no users
   from the tables-handling code (Cao jin, Baoquan He).

Thanks!

---------------

Baoquan He (1):
      ACPI / tables: Drop acpi_parse_entries() which is not used

Cao jin (1):
      ACPI / doc: linuxized-acpica.txt: fix typos

Dmitry Frank (2):
      ACPI / video: get rid of magic numbers and use enum instead
      ACPI / video: add comments about subtle cases

Hans de Goede (7):
      ACPI / utils: Add new acpi_dev_present helper
      ACPI / battery: Fix acpi_battery_exit on acpi_battery_init_async errors
      ACPI / battery: Add a blacklist with PMIC ACPI HIDs with a
native battery driver
      ACPI / AC: Add a blacklist with PMIC ACPI HIDs with a native
charger driver
      power: supply: axp288_charger: Only wait for INT3496 device if present
      ACPI / PMIC: Add opregion driver for Intel CHT Whiskey Cove PMIC
      ACPI / PMIC: Stop xpower OPRegion handler relying on IIO

Kai Heng Feng (1):
      ACPI / blacklist: add _REV quirk for Dell Inspiron 7537

Michal Hocko (1):
      ACPI / scan: Drop support for force_remove

Prakash, Prashanth (3):
      ACPI / Processor: Drop setup_max_cpus check from acpi_processor_add()
      ACPI / CPPC: Read lowest nonlinear perf in cppc_get_perf_caps()
      ACPI / CPPC: add sysfs entries for CPPC perf capabilities

Rafael J. Wysocki (2):
      ACPI / scan: Apply default enumeration to devices with ACPI drivers
      ACPI / scan: Avoid enumerating devices more than once

Shanker Donthineni (1):
      ACPI / platform: Update platform device NUMA node based on _PXM method

---------------

 Documentation/ABI/obsolete/sysfs-firmware-acpi |   8 +
 Documentation/ABI/testing/sysfs-firmware-acpi  |  10 -
 Documentation/acpi/linuxized-acpica.txt        |  10 +-
 drivers/acpi/Kconfig                           |   8 +-
 drivers/acpi/Makefile                          |   1 +
 drivers/acpi/ac.c                              |  20 ++
 drivers/acpi/acpi_platform.c                   |   5 +-
 drivers/acpi/acpi_processor.c                  |   5 -
 drivers/acpi/acpi_video.c                      | 157 ++++++++++----
 drivers/acpi/battery.c                         |  22 +-
 drivers/acpi/blacklist.c                       |   8 +
 drivers/acpi/cppc_acpi.c                       |  80 +++----
 drivers/acpi/internal.h                        |   2 -
 drivers/acpi/pmic/intel_pmic_chtwc.c           | 280 +++++++++++++++++++++++++
 drivers/acpi/pmic/intel_pmic_xpower.c          |  21 +-
 drivers/acpi/scan.c                            |  24 +--
 drivers/acpi/sysfs.c                           |   9 +-
 drivers/acpi/tables.c                          |  16 --
 drivers/acpi/utils.c                           |  66 ++++++
 drivers/power/supply/axp288_charger.c          |  28 ++-
 include/acpi/acpi_bus.h                        |   1 +
 include/acpi/cppc_acpi.h                       |   3 +-
 include/linux/acpi.h                           |   9 +-
 23 files changed, 617 insertions(+), 176 deletions(-)
