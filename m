From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fixes for v4.14-rc2
Date: Sat, 23 Sep 2017 01:08:51 +0200
Message-ID: <CAJZ5v0j_irgwegZ4Q4V7tEqOaYVazXutp065CzyZ0KZru=s9=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:32981 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752041AbdIVXIz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Sep 2017 19:08:55 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.14-rc2

with top-most commit 672d0e4502a22364b298f9307f651c1b8313514b

 Merge branches 'acpi-pmic', 'acpi-bus', 'acpi-wdat' and 'acpi-properties'

on top of commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e

 Linux 4.14-rc1

to receive ACPI fixes for v4.14-rc2.

These fix the initialization of resources in the ACPI WDAT watchdog
driver, a recent regression in the ACPI device properties handling,
a recent change in behavior causing the ACPI_HANDLE() macro to only
work for GPL code and create a MAINTAINERS entry for ACPI PMIC
drivers in order to specify the official reviewers for that code.

Specifics:

 - Fix the initialization of resources in the ACPI WDAT watchdog
   driver that uses unititialized memory which causes compiler
   warnings to be triggered (Arnd Bergmann).

 - Fix a recent regression in the ACPI device properties handling
   that causes some device properties data to be skipped during
   enumeration (Sakari Ailus).

 - Fix a recent change in behavior that caused the ACPI_HANDLE()
   macro to stop working for non-GPL code which is a problem for
   the NVidia binary graphics driver, for example (John Hubbard).

 - Add a MAINTAINERS entry for the ACPI PMIC drivers to specify
   the official reviewers for that code (Rafael Wysocki).

Thanks!


---------------

Arnd Bergmann (1):
      ACPI / watchdog: properly initialize resources

John Hubbard (1):
      ACPI / bus: Make ACPI_HANDLE() work for non-GPL code again

Rafael Wysocki (1):
      ACPI / PMIC: Add code reviewers to MAINTAINERS

Sakari Ailus (1):
      ACPI: properties: Return _DSD hierarchical extension (data)
sub-nodes correctly

---------------

 MAINTAINERS                  | 12 ++++++++++++
 drivers/acpi/acpi_watchdog.c |  2 +-
 drivers/acpi/property.c      | 24 +++++++++++++++++++-----
 include/acpi/acpi_bus.h      | 18 ++++--------------
 4 files changed, 36 insertions(+), 20 deletions(-)
