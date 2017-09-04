From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI updates for v4.14-rc1
Date: Mon, 4 Sep 2017 23:39:49 +0200
Message-ID: <CAJZ5v0jpiiUQSX+tNvUvhH9OyG8Hi+-kRExgQ8J_5cbjGE3-3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.14-rc1

with top-most commit 298bd7fb26cb2797a8b19b66a68389b3f27ae7e2

 Merge branches 'acpi-sysfs', 'acpi-apei' and 'acpi-blacklist'

on top of commit 569dbb88e80deb68974ef6fdd6a13edb9d686261

 Linux 4.13

to receive ACPI updates for v4.14-rc1.

These include a usual ACPICA code update (this time to upstream
revision 20170728), a fix for a boot crash on some systems with
Thunderbolt devices connected at boot time, a rework of the handling
of PCI bridges when setting up device wakeup, new support for Apple
device properties, support for DMA configurations reported via ACPI
on ARM64, APEI-related updates, ACPI EC driver updates and assorted
minor modifications in several places.

Specifics:

 - Update the ACPICA code in the kernel to upstream revision 20170728
   including:
   * Alias operator handling update (Bob Moore).
   * Deferred resolution of reference package elements (Bob Moore).
   * Support for the _DMA method in walk resources (Bob Moore).
   * Tables handling update and support for deferred table
     verification (Lv Zheng).
   * Update of SMMU models for IORT (Robin Murphy).
   * Compiler and disassembler updates (Alex James, Erik Schmauss,
     Ganapatrao Kulkarni, James Morse).
   * Tools updates (Erik Schmauss, Lv Zheng).
   * Assorted minor fixes and cleanups (Bob Moore, Kees Cook,
     Lv Zheng, Shao Ming).

 - Rework the initialization of non-wakeup GPEs with method handlers
   in order to address a boot crash on some systems with Thunderbolt
   devices connected at boot time where we miss an early hotplug
   event due to a delay in GPE enabling (Rafael Wysocki).

 - Rework the handling of PCI bridges when setting up ACPI-based
   device wakeup in order to avoid disabling wakeup for bridges
   prematurely (Rafael Wysocki).

 - Consolidate Apple DMI checks throughout the tree, add support for
   Apple device properties to the device properties framework and
   use these properties for the handling of I2C and SPI devices on
   Apple systems (Lukas Wunner).

 - Add support for _DMA to the ACPI-based device properties lookup
   code and make it possible to use the information from there to
   configure DMA regions on ARM64 systems (Lorenzo Pieralisi).

 - Fix several issues in the APEI code, add support for exporting
   the BERT error region over sysfs and update APEI MAINTAINERS
   entry with reviewers information (Borislav Petkov, Dongjiu Geng,
   Loc Ho, Punit Agrawal, Tony Luck, Yazen Ghannam).

 - Fix a potential initialization ordering issue in the ACPI EC
   driver and clean it up somewhat (Lv Zheng).

 - Update the ACPI SPCR driver to extend the existing XGENE 8250
   workaround in it to a new platform (m400) and to work around
   an Xgene UART clock issue (Graeme Gregory).

 - Add a new utility function to the ACPI core to support using
   ACPI OEM ID / OEM Table ID / Revision for system identification
   in blacklisting or similar and switch over the existing code
   already using this information to this new interface (Toshi Kani).

 - Fix an xpower PMIC issue related to GPADC reads that always return
   0 without extra pin manipulations (Hans de Goede).

 - Add statements to print debug messages in a couple of places in
   the ACPI core for easier diagnostics (Rafael Wysocki).

 - Clean up the ACPI processor driver slightly (Colin Ian King,
   Hanjun Guo).

 - Clean up the ACPI x86 boot code somewhat (Andy Shevchenko).

 - Add a quirk for Dell OptiPlex 9020M to the ACPI backlight
   driver (Alex Hung).

 - Assorted fixes, cleanups and updates related to ACPI (Amitoj Kaur
   Chawla, Bhumika Goyal, Frank Rowand, Jean Delvare, Punit Agrawal,
   Ronald Tschal=C3=A4r, Sumeet Pawnikar).

There were merge conflicts of the Apple properties material with the
spi tree and of the ACPI blacklisting changes with the dmi tree in
linux-next and the Stephen's resolutions of them are appended.

Thanks!


---------------

Alex Hung (1):
      ACPI / video: Add force_none quirk for Dell OptiPlex 9020M

Alex James (1):
      ACPICA: iASL: Ensure that the target node is valid in acpi_ex_create_=
alias

Amitoj Kaur Chawla (1):
      ACPI / dock: constify attribute_group structure

Andy Shevchenko (3):
      ACPI / boot: Don't define unused variables
      ACPI / boot: Correct address space of __acpi_map_table()
      ACPI / boot: Add number of legacy IRQs to debug output

Bhumika Goyal (1):
      ACPI: make device_attribute const

Bob Moore (11):
      ACPICA: Small indentation changes, no functional change
      ACPICA: Update resource descriptor handling
      ACPICA: Update version to 20170629
      ACPICA: Namespace: Update/fix an error message
      ACPICA: Add a comment, no functional change
      ACPICA: Interpreter: Update handling for Alias operator
      ACPICA: Debugger: Improve support for Alias objects
      ACPICA: Implement deferred resolution of reference package elements
      ACPICA: Ensure all instances of AE_AML_INTERNAL have error messages
      ACPICA: Resources: Allow _DMA method in walk resources
      ACPICA: Update version to 20170728

Borislav Petkov (1):
      MAINTAINERS: Add Tony and Boris as ACPI/APEI reviewers

Colin Ian King (1):
      ACPI / processor: make function acpi_processor_check_duplicates() sta=
tic

Dongjiu Geng (1):
      ACPI: APEI: fix the wrong iteration of generic error status block

Erik Schmauss (4):
      ACPICA: Tools: Deallocate memory allocated by
ac_get_all_tables_from_file via ac_delete_table_list
      ACPICA: iASL compiler: allow compilation of externals with paths
that refer to existing names
      ACPICA: Disassembler: skip parsing of incorrect external declarations
      ACPICA: Revert "Update resource descriptor handling"

Frank Rowand (1):
      MAINTAINERS: device property: ACPI: add fwnode.h

Ganapatrao Kulkarni (1):
      ACPICA: iasl: Update to IORT SMMUv3 disassembling

Graeme Gregory (2):
      ACPI: SPCR: extend XGENE 8250 workaround to m400
      ACPI: SPCR: work around clock issue on xgene UART

Hanjun Guo (1):
      ACPI: processor: use dev_dbg() instead of dev_warn() when CPPC
probe failed

Hans de Goede (1):
      ACPI / PMIC: xpower: Do pinswitch magic when reading GPADC

James Morse (1):
      ACPICA: iASL: Add support for the SDEI table

Jean Delvare (1):
      ACPI / sleep: Make acpi_sleep_syscore_init() static

Kees Cook (1):
      Back port of "ACPICA: Use designated initializers"

Loc Ho (1):
      ACPI: APEI: Enable APEI multiple GHES source to share a single
external IRQ

Lorenzo Pieralisi (4):
      ACPI: Make acpi_dev_get_resources() method agnostic
      ACPI: Introduce DMA ranges parsing
      ACPI: Make acpi_dma_configure() DMA regions aware
      ACPI/IORT: Add IORT named component memory address limits

Lukas Wunner (5):
      treewide: Consolidate Apple DMI checks
      ACPI / property: Don't evaluate objects for devices w/o handle
      ACPI / property: Support Apple _DSM properties
      ACPI / scan: Recognize Apple SPI and I2C slaves
      spi: Use Apple device properties in absence of ACPI resources

Lv Zheng (13):
      ACPICA: linuxize: cleanup typedef definitions
      ACPICA: Tables: Add sanity check in acpi_put_table()
      ACPICA: Tables: Cleanup table handler invokers
      ACPICA: Tables: Do not validate signature for dynamic table load
      ACPICA: Tables: Change table duplication check to be related to
acpi_gbl_verify_table_checksum
      ACPICA: Tables: Combine checksum/duplication verification together
      ACPICA: Tables: Add deferred table verification support
      ACPICA: Divergences: reduce access size definitions
      ACPICA: CLib: Add short multiply/shift support
      ACPICA: acpidump: Add DSDT/FACS instance support for Linux and EFI
      ACPICA: EFI/EDK2: Cleanup to enable /WX for MSVC builds
      ACPI: EC: Fix possible issues related to EC initialization order
      ACPI / EC: Clean up EC GPE mask flag

Punit Agrawal (2):
      mailbox: pcc: Drop uninformative output during boot
      ACPI / APEI: Suppress message if HEST not present

Rafael J. Wysocki (8):
      PCI / PM: Skip bridges in pci_enable_wake()
      ACPI / PM: Split acpi_device_wakeup()
      ACPI / PCI / PM: Rework acpi_pci_propagate_wakeup()
      ACPICA: Dispatch active GPEs at init time
      ACPICA: Make it possible to enable runtime GPEs earlier
      ACPI / scan: Enable GPEs before scanning the namespace
      ACPI: Add debug statements to acpi_global_event_handler()
      ACPI / PM: Add debug statements to acpi_pm_notify_handler()

Robin Murphy (1):
      ACPICA: IORT: Update SMMU models for revision C

Ronald Tschal=C3=A4r (1):
      ACPI / LPSS: Don't abort ACPI scan on missing mem resource

Shao Ming (1):
      ACPICA: EFI/EDK2: Sort acpi.h inclusion order

Sumeet Pawnikar (1):
      ACPI / lpat: Fix typos in comments and kerneldoc style

Tony Luck (1):
      ACPI / sysfs: Extend ACPI sysfs to provide access to boot error regio=
n

Toshi Kani (2):
      ACPI / blacklist: add acpi_match_platform_list()
      intel_pstate: convert to use acpi_match_platform_list()

Yazen Ghannam (1):
      ACPI, APEI, EINJ: Subtract any matching Register Region from
Trigger resources

---------------

 MAINTAINERS                                        |   9 +
 arch/arm64/kernel/acpi.c                           |   4 +-
 arch/ia64/kernel/acpi.c                            |   6 +-
 arch/x86/include/asm/setup.h                       |   1 +
 arch/x86/kernel/acpi/boot.c                        |  11 +-
 arch/x86/kernel/early-quirks.c                     |   4 +-
 arch/x86/kernel/quirks.c                           |  10 +
 arch/x86/kernel/setup.c                            |   2 +
 drivers/acpi/Makefile                              |   1 +
 drivers/acpi/acpi_lpat.c                           |   6 +-
 drivers/acpi/acpi_lpss.c                           |   3 +-
 drivers/acpi/acpi_processor.c                      |   2 +-
 drivers/acpi/acpica/Makefile                       |   1 +
 drivers/acpi/acpica/acapps.h                       |   2 +
 drivers/acpi/acpica/acdispat.h                     |  13 +
 drivers/acpi/acpica/aclocal.h                      |   7 +-
 drivers/acpi/acpica/acobject.h                     |  15 +-
 drivers/acpi/acpica/actables.h                     |   5 +-
 drivers/acpi/acpica/acutils.h                      |   9 +-
 drivers/acpi/acpica/dbdisply.c                     |  37 +-
 drivers/acpi/acpica/dsfield.c                      |   2 +
 drivers/acpi/acpica/dsobject.c                     | 398 +++--------------
 drivers/acpi/acpica/dsopcode.c                     |   9 +
 drivers/acpi/acpica/dspkginit.c                    | 496 +++++++++++++++++=
++++
 drivers/acpi/acpica/evgpeblk.c                     |  30 +-
 drivers/acpi/acpica/evxfgpe.c                      |   8 +
 drivers/acpi/acpica/excreate.c                     |  62 +--
 drivers/acpi/acpica/exdump.c                       |  34 +-
 drivers/acpi/acpica/exmisc.c                       |   9 +
 drivers/acpi/acpica/exoparg2.c                     |   3 +
 drivers/acpi/acpica/hwregs.c                       |   2 +-
 drivers/acpi/acpica/hwxfsleep.c                    |   9 +-
 drivers/acpi/acpica/nsaccess.c                     |  28 +-
 drivers/acpi/acpica/nsarguments.c                  |  21 +-
 drivers/acpi/acpica/nsinit.c                       |  14 +
 drivers/acpi/acpica/nsnames.c                      |   9 +-
 drivers/acpi/acpica/nsprepkg.c                     |   2 +
 drivers/acpi/acpica/psloop.c                       |  14 +
 drivers/acpi/acpica/psobject.c                     |  26 ++
 drivers/acpi/acpica/rsxface.c                      |   7 +-
 drivers/acpi/acpica/tbdata.c                       | 230 ++++++++--
 drivers/acpi/acpica/tbinstal.c                     | 161 +------
 drivers/acpi/acpica/tbxface.c                      |  39 +-
 drivers/acpi/acpica/tbxfload.c                     |   2 +-
 drivers/acpi/acpica/uthex.c                        |   4 +-
 drivers/acpi/acpica/utmath.c                       | 222 ++++++++-
 drivers/acpi/acpica/utmisc.c                       |  10 +-
 drivers/acpi/acpica/utobject.c                     |   5 +
 drivers/acpi/acpica/utprint.c                      |   8 +-
 drivers/acpi/acpica/utresrc.c                      |   7 +
 drivers/acpi/acpica/utstate.c                      |   2 +-
 drivers/acpi/acpica/utstrtoul64.c                  |   9 +-
 drivers/acpi/acpica/uttrack.c                      |   9 +-
 drivers/acpi/apei/apei-internal.h                  |   5 -
 drivers/acpi/apei/einj.c                           |   2 +-
 drivers/acpi/apei/ghes.c                           |  10 +-
 drivers/acpi/apei/hest.c                           |  13 +-
 drivers/acpi/arm64/iort.c                          |  57 ++-
 drivers/acpi/battery.c                             |   2 +-
 drivers/acpi/blacklist.c                           |  83 +---
 drivers/acpi/bus.c                                 |   3 -
 drivers/acpi/device_pm.c                           | 175 +++++---
 drivers/acpi/dock.c                                |   2 +-
 drivers/acpi/ec.c                                  |  48 +-
 drivers/acpi/internal.h                            |   6 +
 drivers/acpi/osi.c                                 |  37 +-
 drivers/acpi/pci_root.c                            |   4 +-
 drivers/acpi/pmic/intel_pmic_xpower.c              |  21 +-
 drivers/acpi/processor_driver.c                    |   2 +-
 drivers/acpi/property.c                            |   6 +
 drivers/acpi/resource.c                            |  82 +++-
 drivers/acpi/sbs.c                                 |  27 +-
 drivers/acpi/scan.c                                | 104 ++++-
 drivers/acpi/sleep.c                               |   2 +-
 drivers/acpi/spcr.c                                |  36 +-
 drivers/acpi/sysfs.c                               |  91 +++-
 drivers/acpi/tables.c                              |   4 +-
 drivers/acpi/utils.c                               |  36 ++
 drivers/acpi/video_detect.c                        |  14 +
 drivers/acpi/x86/apple.c                           | 141 ++++++
 drivers/cpufreq/intel_pstate.c                     |  64 ++-
 drivers/firmware/efi/apple-properties.c            |   5 +-
 drivers/firmware/efi/cper.c                        |  12 +-
 drivers/mailbox/pcc.c                              |   4 +-
 drivers/pci/pci-acpi.c                             |   4 +-
 drivers/pci/pci-driver.c                           |   4 +-
 drivers/pci/pci.c                                  |   7 +
 drivers/pci/quirks.c                               |   5 +-
 drivers/spi/spi.c                                  |  32 ++
 drivers/thunderbolt/icm.c                          |  13 +-
 drivers/thunderbolt/tb.c                           |   4 +-
 include/acpi/acnames.h                             |   1 +
 include/acpi/acpi.h                                |   4 +-
 include/acpi/acpi_bus.h                            |   9 +-
 include/acpi/acpixf.h                              |  15 +-
 include/acpi/acrestyp.h                            |   7 -
 include/acpi/actbl.h                               |   1 +
 include/acpi/actbl2.h                              |  30 +-
 include/acpi/actypes.h                             |  11 +-
 include/acpi/apei.h                                |   8 +-
 include/acpi/ghes.h                                |   5 +
 include/acpi/platform/acenv.h                      |   9 +-
 include/acpi/platform/acgcc.h                      |   4 +
 include/acpi/platform/aclinux.h                    |   5 +
 include/linux/acpi.h                               |  31 +-
 include/linux/acpi_iort.h                          |   5 +-
 include/linux/platform_data/x86/apple.h            |  13 +
 .../acpi/os_specific/service_layers/oslinuxtbl.c   | 105 +++--
 tools/power/acpi/tools/acpidump/apfiles.c          |   2 +-
 tools/power/acpi/tools/acpidump/apmain.c           |   2 +-
 110 files changed, 2433 insertions(+), 1040 deletions(-)


diff --cc drivers/spi/spi.c
index 7d920ea19957,43cb8b98e953..000000000000
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@@ -40,7 -40,7 +40,8 @@@
  #include <linux/ioport.h>
  #include <linux/acpi.h>
  #include <linux/highmem.h>
 +#include <linux/platform_data/x86/apple.h>
+ #include <linux/idr.h>

  #define CREATE_TRACE_POINTS
  #include <trace/events/spi.h>

diff --cc drivers/acpi/blacklist.c
index f58bbc368f88,037fd537bbf6..995c4d8922b1
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@@ -30,24 -30,7 +30,7 @@@

  #include "internal.h"

- enum acpi_blacklist_predicates {
-     all_versions,
-     less_than_or_equal,
-     equal,
-     greater_than_or_equal,
- };
-
- struct acpi_blacklist_item {
-     char oem_id[7];
-     char oem_table_id[9];
-     u32 oem_revision;
-     char *table;
-     enum acpi_blacklist_predicates oem_revision_predicate;
-     char *reason;
-     u32 is_critical_error;
- };
-
 -static struct dmi_system_id acpi_rev_dmi_table[] __initdata;
 +static const struct dmi_system_id acpi_rev_dmi_table[] __initconst;

  /*
   * POLICY: If *anything* doesn't work, put it on the blacklist.
