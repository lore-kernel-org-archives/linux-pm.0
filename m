From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] More ACPI updates for v4.19-rc1
Date: Wed, 22 Aug 2018 11:41:24 +0200
Message-ID: <CAJZ5v0gJYBtH2P3oS-hGxk0p1Vy6jcv-ZzggoDS3PSS+S9k_ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.19-rc1-2

with top-most commit d1f3ab5b13c03b6f32d5379cd3cd5c7e50ce612c

 Merge branch 'acpi-pmic'

on top of commit 2c20443ec221dcb76484b30933593e8ecd836bbd

 Merge tag 'acpi-4.19-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more ACPI updates for 4.19-rc1.

These update the ACPICA code in the kernel to the most recent
upstream revision (which includes a regression fix and other
improvements), make ACPICA clear the status of all ACPI events
when entering sleep states (to restore the previous behavior)
and update the ACPI operation region driver for the CrystalCove
PMIC.

Specifics:

 - Update the ACPICA code in the kernel to upstream revision 20180810
   including:
   * Fix for AML parser regression causing it to mishandle opcodes
     that open a scope upon parse failures (Erik Schmauss).
   * Fix for a reference counting issue on large systems (Erik
     Schmauss).
   * Fix to discard values coming from register reads that have
     failed (Erik Schmauss).
   * Two acpiexec fixes (Bob Moore, Erik Schmauss).
   * Debugger cleanup (Bob Moore).
   * Cleanup of duplicate table error message (Bob Moore).
   * Cleanup of hex detection in the utilities (Erik Schmauss).

 - Make ACPICA clear the status of all ACPI events when entering
   sleep states again to avoid functional regressions (Rafael Wysocki).

 - Update the ACPI operation region driver for the CrystalCove PMIC
   to cover all of the known operation region fields (Hans de Goede).

Thanks!


---------------

Bob Moore (4):
      ACPICA: Update an error message for a duplicate table
      ACPICA: Debugger: Cleanup interface to the AML disassembler
      ACPICA: acpiexec: fix a small memory leak regression
      ACPICA: Update version to 20180810

Erik Schmauss (7):
      ACPICA: AML Parser: ignore all exceptions resulting from
incorrect AML during table load
      ACPICA: ACPICA: add status check for acpi_hw_read before
assigning return value
      ACPICA: Utilities: split hex detection into smaller functions
      ACPICA: AML Parser: skip opcodes that open a scope upon parse failure
      ACPICA: acpi_exec: fixing -fi option
      ACPICA: Reference count: add additional debugging details
      ACPICA: Reference Counts: increase max to 0x4000 for large servers

Hans de Goede (1):
      ACPI / PMIC: CrystalCove: Extend PMOP support to support all
possible fields

Rafael J. Wysocki (1):
      ACPICA: Clear status of all events when entering sleep states

---------------

 drivers/acpi/acpica/aclocal.h      |   1 +
 drivers/acpi/acpica/acnamesp.h     |  17 +++---
 drivers/acpi/acpica/acutils.h      |   2 +
 drivers/acpi/acpica/dbinput.c      |  10 ++++
 drivers/acpi/acpica/dbmethod.c     |   8 +--
 drivers/acpi/acpica/dbxface.c      |  10 +++-
 drivers/acpi/acpica/dsfield.c      |  34 +++++++++++-
 drivers/acpi/acpica/hwregs.c       |   9 ++-
 drivers/acpi/acpica/hwsleep.c      |  11 +---
 drivers/acpi/acpica/nsaccess.c     |  13 +++++
 drivers/acpi/acpica/psloop.c       |  43 ++++++++-------
 drivers/acpi/acpica/tbdata.c       |   4 +-
 drivers/acpi/acpica/utdelete.c     |   7 ++-
 drivers/acpi/acpica/utstrsuppt.c   |  26 ++++++++-
 drivers/acpi/acpica/utstrtoul64.c  |   2 +-
 drivers/acpi/pmic/intel_pmic_crc.c | 109 ++++++++++++++++++++++++++++++++++++-
 include/acpi/acconfig.h            |   2 +-
 include/acpi/acexcep.h             |   6 ++
 include/acpi/acpixf.h              |   2 +-
 19 files changed, 260 insertions(+), 56 deletions(-)
