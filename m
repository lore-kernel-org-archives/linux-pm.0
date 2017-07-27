From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fixes for v4.13-rc3
Date: Thu, 27 Jul 2017 23:44:15 +0200
Message-ID: <CAJZ5v0iV=qc297eDjTWDGQx_O1sNDjMRbCCGp0tqs3pmH+RvuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.13-rc3

with top-most commit f6248dd88dba3aeb19351410a027d92eee7ceb72

 Merge branches 'acpi-pm' and 'acpi-numa'

on top of commit 520eccdfe187591a51ea9ab4c1a024ae4d0f68d9

 Linux 4.13-rc2

to receive ACPI fixes for v4.13-rc3.

These are two fixups for the suspend-to-idle handling in the ACPI
subsystem after recent changes in that area and two simple fixes
of the ACPI NUMA code.

Specifics:

 - Add an ACPI module parameter to allow users to override the
   new default behavior on some systems where the EC GPE is not
   disabled during suspend-to-idle in case the EC on their systems
   generates excessive wakeup events and they want to sacrifice
   some functionality (like power button wakeups) for extra battery
   life while suspended (Rafael Wysocki).

 - Fix flushing of the outstanding EC work in the ACPI core
   suspend-to-idle code (Rafael Wysocki).

 - Add a missing include and fix a messed-up comment in the ACPI
   NUMA code (Ross Zwisler).

Thanks!


---------------

Rafael J. Wysocki (2):
      ACPI / EC: Add parameter to force disable the GPE on suspend
      ACPI / PM / EC: Flush all EC work in acpi_freeze_sync()

Ross Zwisler (2):
      ACPI: NUMA: add missing include in acpi_numa.h
      ACPI: NUMA: Fix typo in the full name of SRAT

---------------

 drivers/acpi/ec.c        | 39 +++++++++++++++++++++++++++++++++++++++
 drivers/acpi/internal.h  |  4 ++++
 drivers/acpi/numa.c      |  2 +-
 drivers/acpi/sleep.c     |  6 +++---
 include/acpi/acpi_numa.h |  1 +
 5 files changed, 48 insertions(+), 4 deletions(-)
