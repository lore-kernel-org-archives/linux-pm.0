From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fixes for v4.9-rc6
Date: Fri, 18 Nov 2016 22:06:52 +0100
Message-ID: <CAJZ5v0jC+iPnnB5sHE+6JMJxCLD6Mq8OKNuqKtFra_BzhiA2=g@mail.gmail.com>
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
 acpi-4.9-rc6

with top-most commit aab0b243b9a2fab7dcee0ce6e13789d3ab0394bf

 Merge branches 'acpica-fixes', 'acpi-cppc-fixes' and 'acpi-tools-fixes'

on top of commit a25f0944ba9b1d8a6813fd6f1a86f1bd59ac25a6

 Linux 4.9-rc5

to receive ACPI fixes for v4.9-rc6.

They fix an ACPI thermal management regression introduced by a recent
FADT handling cleanup, an ACPI tools build issue introduced by a
recent ACPICA commit and a PCC mailbox initialization bug causing
lockdep to complain loudly.

Specifics:

 - Revert a recent ACPICA cleanup that attempted to get rid of all
   FADT version 2 legacy, but broke ACPI thermal management on at
   least one system (Rafael Wysocki).

 - Fix cross-compiled builds of ACPI tools that stopped working
   after a recent cleanup related to the handling of header files
   in ACPICA (Lv Zheng).

 - Fix a locking issue in the PCC channel initialization code that
   invokes devm_request_irq() under a spinlock (among other things)
   and causes lockdep to complain (Hoan Tran).

Thanks!

---------------

Hoan Tran (1):
      mailbox: PCC: Fix lockdep warning when request PCC channel

Lv Zheng (1):
      tools/power/acpi: Remove direct kernel source include reference

Rafael J. Wysocki (1):
      Revert "ACPICA: FADT support cleanup"

---------------

 drivers/acpi/acpica/tbfadt.c             |  10 +-
 drivers/mailbox/pcc.c                    |  13 +--
 include/acpi/actbl.h                     | 164 +++++++++++++------------------
 include/acpi/platform/aclinux.h          |   3 +
 tools/power/acpi/Makefile.config         |  23 ++---
 tools/power/acpi/Makefile.rules          |  40 +++++---
 tools/power/acpi/tools/acpidbg/Makefile  |   4 +-
 tools/power/acpi/tools/acpidbg/acpidbg.c |   8 +-
 tools/power/acpi/tools/acpidump/Makefile |  12 +--
 9 files changed, 137 insertions(+), 140 deletions(-)
