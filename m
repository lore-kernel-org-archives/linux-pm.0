From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI updates for v4.12-rc1, part 2
Date: Wed, 10 May 2017 00:59:16 +0200
Message-ID: <CAJZ5v0iv4vAzz_FEkd90pr4mT9EWn-neKX_0rG6DhaJeHx37Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35039 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751221AbdEIW7R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 May 2017 18:59:17 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-extra-4.12-rc1

with top-most commit 46436eb2f9e6ab0770c14292296d133f8907f699

 Merge branches 'acpi-soc', 'acpi-bus', 'acpi-pmic' and 'acpi-power'

on top of commit 08be881064da126b8df4b96b0b3e2e307969a4a1

 Merge tag 'acpi-4.12-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more ACPI updates for v4.12-rc1.

These update the ACPICA code in the kernel to upstream revision
20170303 which adds a few minor fixes and improvements, update
ACPI SoC drivers with new device IDs, platform-related information
and similar, fix the register information in the xpower PMIC driver,
introduce a concept of "always present" devices to the ACPI device
enumeration code and use it to fix a problem with one platform, and
fix a system resume issue related to power resources.

Specifics:

 - Update the ACPICA code in the kernel to upstream revision
   20170303 which includes:
   * Minor fixes and improvements in the core code (Bob Moore,
     Seunghun Han).
   * Debugger fixes (Colin Ian King, Lv Zheng).
   * Compiler/disassembler improvements (Bob Moore, David Box,
     Lv Zheng).
   * Build-related update (Lv Zheng).

 - Add new device IDs and platform-related information to the
   ACPI drivers for Intel (LPSS) and AMD (APD) SoCs (Hanjun Guo,
   Hans de Goede).

 - Make it possible to quirk ACPI-enumerated devices as "always
   present" on platforms where they are incorrectly reported as not
   present by the AML and add the INT0002 device ID to the list of
   "always present" devices (Hans de Goede).

 - Fix the register information in the xpower PMIC driver and add
   comments to map the registers to symbols used by AML to it
   (Hans de Goede).

 - Move the code turning off unused ACPI power resources during
   system resume to a point after all devices have been resumed
   to avoid issues with power resources that do not behave as
   expected (Hans de Goede).

There is a small conflict between this material and the already
merged changes in drivers/acpi/acpi_apd.c that went in through a
different path, but the resolution of it should be straightforward.

Thanks!

---------------

Bob Moore (9):
      ACPICA: Disassembler: Enhance resource descriptor detection
      ACPICA: Update some function headers, no funtional change
      ACPICA: Fix a module for excessive debug output
      ACPICA: Fix several incorrect invocations of ACPICA return macro
      ACPICA: Update for automatic repair code for objects returned by
evaluate_object
      ACPICA: Cleanup AML opcode definitions, no functional change
      ACPICA: Local cache support: Allow small cache objects
      ACPICA: iasl: add ASL conversion tool
      ACPICA: Update version to 20170303

Colin Ian King (1):
      ACPICA: debugger: fix memory leak on Pathname

David E. Box (1):
      ACPICA: Disassembler: Do not unconditionally remove temporary names

Hanjun Guo (2):
      ACPI / APD: Add clock frequency for Hisilicon Hip07/08 I2C controller
      i2c: designware: Add ACPI HID for Hisilicon Hip07/08 I2C controller

Hans de Goede (5):
      ACPI / bus: Introduce a list of ids for "always present" devices
      ACPI / bus: Add INT0002 to list of always-present devices
      ACPI / LPSS: Call pwm_add_table() for Bay Trail PWM device
      ACPI / PMIC: xpower: Fix power_table addresses
      ACPI / power: Delay turning off unused power resources after suspend

Lv Zheng (3):
      ACPICA: Add non-linux host build support
      ACPICA: Debugger: Add interpreter blocking mark for single-step mode
      ACPICA: iasl: Fix IORT SMMU GSI disassembling

Seunghun Han (1):
      ACPICA: Namespace: fix operand cache leak

---------------

 drivers/acpi/Makefile                       |   1 +
 drivers/acpi/acpi_apd.c                     |  12 +++
 drivers/acpi/acpi_lpss.c                    |  17 ++++
 drivers/acpi/acpica/Makefile                |   2 +-
 drivers/acpi/acpica/acconvert.h             | 144 ++++++++++++++++++++++++++++
 drivers/acpi/acpica/acglobal.h              |  53 ++++++++++
 drivers/acpi/acpica/aclocal.h               | 106 ++++++++++++++++----
 drivers/acpi/acpica/acmacros.h              |  35 +++++++
 drivers/acpi/acpica/acopcode.h              |   2 +
 drivers/acpi/acpica/amlcode.h               |  99 +++++++++----------
 drivers/acpi/acpica/dbmethod.c              |   1 +
 drivers/acpi/acpica/dbxface.c               |   5 +-
 drivers/acpi/acpica/dscontrol.c             |   2 +-
 drivers/acpi/acpica/dsmthdat.c              |   3 +-
 drivers/acpi/acpica/dsobject.c              |  15 +--
 drivers/acpi/acpica/dsopcode.c              |   4 +-
 drivers/acpi/acpica/dsutils.c               |   8 +-
 drivers/acpi/acpica/dswexec.c               |   2 +-
 drivers/acpi/acpica/dswload2.c              |   2 +-
 drivers/acpi/acpica/exmisc.c                |  16 ++--
 drivers/acpi/acpica/exnames.c               |   4 +-
 drivers/acpi/acpica/exoparg1.c              |  17 ++--
 drivers/acpi/acpica/exoparg2.c              |   4 +-
 drivers/acpi/acpica/exoparg6.c              |  16 ++--
 drivers/acpi/acpica/exresolv.c              |   3 +-
 drivers/acpi/acpica/exstore.c               |   5 +-
 drivers/acpi/acpica/exstoren.c              |   2 +-
 drivers/acpi/acpica/hwvalid.c               |  18 ++--
 drivers/acpi/acpica/nsaccess.c              |   2 +-
 drivers/acpi/acpica/nsrepair.c              |  16 +---
 drivers/acpi/acpica/nsrepair2.c             |   6 +-
 drivers/acpi/acpica/nsutils.c               |  29 +++---
 drivers/acpi/acpica/psargs.c                |  29 +++++-
 drivers/acpi/acpica/psloop.c                |  34 ++++++-
 drivers/acpi/acpica/psobject.c              |  38 ++++++++
 drivers/acpi/acpica/psopcode.c              |  15 +--
 drivers/acpi/acpica/psopinfo.c              |   2 +-
 drivers/acpi/acpica/psparse.c               |   6 +-
 drivers/acpi/acpica/pstree.c                |   9 +-
 drivers/acpi/acpica/psutils.c               |  11 +++
 drivers/acpi/acpica/utalloc.c               |  50 ++++++++++
 drivers/acpi/acpica/utcache.c               |   2 +-
 drivers/acpi/acpica/utdebug.c               |   1 +
 drivers/acpi/acpica/utresrc.c               |   9 ++
 drivers/acpi/acpica/utxferror.c             |  16 ++--
 drivers/acpi/bus.c                          |   5 +
 drivers/acpi/pmic/intel_pmic_xpower.c       |  50 +++++-----
 drivers/acpi/power.c                        |  10 ++
 drivers/acpi/sleep.c                        |   1 +
 drivers/acpi/sleep.h                        |   1 +
 drivers/acpi/x86/utils.c                    |  90 +++++++++++++++++
 drivers/i2c/busses/i2c-designware-platdrv.c |   2 +
 include/acpi/acconfig.h                     |   1 +
 include/acpi/acpi_bus.h                     |   9 ++
 include/acpi/acpixf.h                       |   2 +-
 include/acpi/actbl2.h                       |  10 ++
 56 files changed, 833 insertions(+), 221 deletions(-)
