From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management and ACPI material for v4.2-rc2
Date: Thu, 9 Jul 2015 01:09:32 +0200
Message-ID: <CAJZ5v0iuZgXwDOAW1bHN3cKWF+LNOD--bcycM4dqburR1iqjYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:35934 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbbGHXJe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2015 19:09:34 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-4.2-rc2

to receive power management and ACPI material for v4.2-rc2 with
top-most commit 8076ca480f40c51ab87d8301c830a817b900b4d1

 Merge branch 'acpi-scan'

on top of commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754

 Linux 4.2-rc1

These are fixes on top of the previous PM+ACPI pull requests
(including one fix for a 4.1 regression) and two commits adding
_CLS-based device enumeration support to the ACPI core and the
ATA subsystem that waited for the latest ACPICA changes to be
merged.

Specifics:

 - Fix for an ACPI resources management regression introduced
   during the 4.1 cycle (that unfortunately went into -stable)
   effectively reverting the bad commit along with the recent
   fixups on top of it and using an alternative approach to
   address the underlying issue (Rafael J Wysocki).

 - Fix for a memory leak and an incorrect return value in an
   error code path in the ACPI LPSS (Low-Power Subsystem) driver
   (Rafael J Wysocki).

 - Fix for a leftover dangling pointer in an error code path in
   the new wakeup IRQ support code (Rafael J Wysocki).

 - Fix to prevent infinite loops (due to errors in other places)
   from happening in the core generic PM domains support code
   (Geert Uytterhoeven).

 - Hibernation documentation update/clarification (Uwe Geuder).

 - Support for _CLS-based device enumeration in the ACPI core
   and in the ATA subsystem (Suravee Suthikulpanit).

Thanks!


---------------

Geert Uytterhoeven (1):
      PM / Domains: Avoid infinite loops in attach/detach code

Rafael J. Wysocki (3):
      ACPI / PNP: Reserve ACPI resources at the fs_initcall_sync stage
      ACPI / LPSS: Fix up acpi_lpss_create_device()
      PM / wakeirq: Avoid setting power.wakeirq too hastily

Suthikulpanit, Suravee (2):
      ACPI / scan: Add support for ACPI _CLS device matching
      ata: ahci_platform: Add ACPI _CLS matching

Uwe Geuder (1):
      PM / hibernate: clarify resume documentation

---------------

 Documentation/power/swsusp.txt    |  13 ++-
 drivers/acpi/acpi_lpss.c          |   7 +-
 drivers/acpi/osl.c                |  12 ++-
 drivers/acpi/resource.c           | 162 --------------------------------------
 drivers/acpi/scan.c               |  32 +++++++-
 drivers/ata/Kconfig               |   2 +-
 drivers/ata/ahci_platform.c       |   9 +++
 drivers/base/power/domain.c       |  13 ++-
 drivers/base/power/wakeirq.c      |  12 ++-
 drivers/base/power/wakeup.c       |  31 +++-----
 drivers/pnp/system.c              |  35 +++-----
 include/linux/acpi.h              |  24 +++---
 include/linux/mod_devicetable.h   |   2 +
 scripts/mod/devicetable-offsets.c |   2 +
 scripts/mod/file2alias.c          |  32 +++++++-
 15 files changed, 148 insertions(+), 240 deletions(-)
