From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI updates for v4.10-rc1 (fixed)
Date: Tue, 13 Dec 2016 02:47:03 +0100
Message-ID: <CAJZ5v0jfjM79wnL_1CZ9VHAhDtNhgqvKvi-aBggE0mBrJBBwHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wj0-f195.google.com ([209.85.210.195]:34383 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752859AbcLMBrH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Dec 2016 20:47:07 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>

Hi Linus,

The tag name was incorrect in the one I sent previously, sorry about that.

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.10-rc1

with top-most commit 80f1b3dea9d4262817b5510547b1313681669f66

 Merge branch 'device-properties'

on top of commit 69973b830859bc6529a7a0468ba0d80ee5117826

 Linux 4.9

to receive ACPI updates for v4.10-rc1.

The ACPICA code in the kernel gets updated as usual (included is
upstream revision 20160930 and a few commits from the next one,
with the rest waiting for an issue discovered in linux-next to
be addressed) which brings in a couple of fixes and cleanups.

On top of that initial support for APEI on ARM64 is added, two new
pieces of documentation are introduced, the properties-parsing code
is updated to follow changes in the (external) documentation it is
based on and there are a few updates of SoC drivers, some new
blacklist entries, plus some assorted fixes and cleanups.

Specifics:

 - ACPICA update including upstream revision 20160930 and several
   commits beyond it (Bob Moore, Lv Zheng).

 - Initial support for ACPI APEI on ARM64 (Tomasz Nowicki).

 - New document describing the handling of _OSI and _REV in Linux
   (Len Brown).

 - New document describing the usage rules for _DSD properties
   (Rafael Wysocki).

 - Update of the ACPI properties-parsing code to reflect recent
   changes in the (external) documentation it is based on (Rafael
   Wysocki).

 - Updates of the ACPI LPSS and ACPI APD SoC drivers for additional
   hardware support (Andy Shevchenko, Nehal Shah).

 - New blacklist entries for _REV and video handling (Alex Hung,
   Hans de Goede, Michael Pobega).

 - ACPI battery driver fix to fall back to _BIF if _BIX fails (Dave
   Lambley).

 - NMI notifications handling fix for APEI (Prarit Bhargava).

 - Error code path fix for the ACPI CPPC library (Dan Carpenter).

 - Assorted cleanups (Andy Shevchenko, Longpeng Mike).

Thanks!

---------------

Alex Hung (1):
      ACPI / blacklist: add _REV quirks for Dell Precision 5520 and 3520

Andy Shevchenko (3):
      ACPI / LPSS: enable hard LLP for DMA
      ACPI / osl: Propagate actual error code for kstrtoul()
      ACPI / osl: Refactor acpi_os_get_root_pointer() to drop 'else':s

Bob Moore (6):
      ACPICA: Update an info message during table load phase
      ACPICA: Increase loop limit for AE_AML_INFINITE_LOOP exception
      ACPICA: Disassembler: Fix for Divide() support, new support for test suite
      ACPICA: Move acpi_gbl_max_loop_iterations to the public globals file
      ACPICA: Update version to 20160930
      ACPICA: Utilities: Add new decode function for parser values

Dan Carpenter (1):
      ACPI / CPPC: set an error code on probe error path

Dave Lambley (1):
      ACPI / battery: If _BIX fails, retry with _BIF

Hans de Goede (3):
      ACPI / video: Move ACPI_VIDEO_NOTIFY_* defines to acpi/video.h
      ACPI / video: Add force_native quirk for Dell XPS 17 L702X
      ACPI / video: Add force_native quirk for HP Pavilion dv6

Len Brown (1):
      ACPI: Document _OSI and _REV for Linux BIOS writers

Longpeng Mike (1):
      ACPI / tebles: remove redundant declare of acpi_table_parse_entries()

Lv Zheng (8):
      ACPICA: MacOSX: Fix anonymous semaphore implementation
      ACPICA: MacOSX: Fix wrong sem_destroy definition
      ACPICA: Namespace: Add acpi_ns_handle_to_name()
      ACPICA: Back port of "ACPICA: Dispatcher: Tune interpreter lock
around AcpiEvInitializeRegion()"
      ACPICA: Events: Fix acpi_ev_initialize_region() return value
      ACPICA: Tables: Cleanup acpi_tb_install_and_load_table()
      ACPICA: Tables: Add acpi_tb_unload_table()
      ACPICA: Tables: Add an error message complaining driver bugs

Michael Pobega (1):
      ACPI / blacklist: Make Dell Latitude 3350 ethernet work

Nehal Shah (1):
      ACPI / APD: Add clock frequency for future AMD I2C controller

Prarit Bhargava (1):
      ACPI / APEI: Fix NMI notification handling

Rafael J. Wysocki (2):
      ACPI / property: Hierarchical properties support update
      ACPI / property: Document usage rules for _DSD properties

Tomasz Nowicki (1):
      ACPI / APEI / ARM64: APEI initial support for ARM64

---------------

 Documentation/acpi/DSD-properties-rules.txt        |  97 +++++++++++
 Documentation/acpi/enumeration.txt                 |   9 +
 Documentation/acpi/osi.txt                         | 187 +++++++++++++++++++++
 arch/arm64/Kconfig                                 |   1 +
 arch/arm64/include/asm/acpi.h                      |  23 ++-
 arch/x86/kernel/acpi/apei.c                        |   3 -
 drivers/acpi/acpi_apd.c                            |   7 +-
 drivers/acpi/acpi_lpss.c                           |   8 +-
 drivers/acpi/acpi_video.c                          |  11 --
 drivers/acpi/acpica/acevents.h                     |   4 +-
 drivers/acpi/acpica/acglobal.h                     |   5 +-
 drivers/acpi/acpica/aclocal.h                      |  19 ++-
 drivers/acpi/acpica/acnamesp.h                     |   3 +
 drivers/acpi/acpica/actables.h                     |   5 +-
 drivers/acpi/acpica/acutils.h                      |   2 +
 drivers/acpi/acpica/amlcode.h                      |   1 +
 drivers/acpi/acpica/dsinit.c                       |   4 +-
 drivers/acpi/acpica/dsopcode.c                     |   2 +-
 drivers/acpi/acpica/dswload2.c                     |  13 +-
 drivers/acpi/acpica/evrgnini.c                     |  59 +++----
 drivers/acpi/acpica/exconfig.c                     |  42 +----
 drivers/acpi/acpica/nsnames.c                      |  45 +++++
 drivers/acpi/acpica/nsxfname.c                     |  43 ++---
 drivers/acpi/acpica/tbdata.c                       |  81 +++++----
 drivers/acpi/acpica/tbxface.c                      |  16 ++
 drivers/acpi/acpica/tbxfload.c                     |  44 +----
 drivers/acpi/acpica/utdecode.c                     |  49 ++++++
 drivers/acpi/apei/ghes.c                           |   7 +-
 drivers/acpi/apei/hest.c                           |  13 +-
 drivers/acpi/battery.c                             |  72 +++++---
 drivers/acpi/blacklist.c                           |  28 +++
 drivers/acpi/cppc_acpi.c                           |   4 +-
 drivers/acpi/device_sysfs.c                        |   8 +-
 drivers/acpi/osl.c                                 |  19 +--
 drivers/acpi/property.c                            | 125 ++++++++++----
 drivers/acpi/video_detect.c                        |  20 +++
 include/acpi/acconfig.h                            |   2 +-
 include/acpi/acpixf.h                              |   9 +-
 include/acpi/video.h                               |  11 ++
 include/linux/acpi.h                               |   4 -
 .../acpi/os_specific/service_layers/osunixxf.c     |  13 +-
 41 files changed, 800 insertions(+), 318 deletions(-)
