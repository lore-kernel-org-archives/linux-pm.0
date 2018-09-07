From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fixes for v4.19-rc3
Date: Fri, 7 Sep 2018 11:42:00 +0200
Message-ID: <CAJZ5v0ic2OFieyNQ7Ka6YhNZSZshVK3cEjCSwbOMOdbd_P+ZkA@mail.gmail.com>
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
 acpi-4.19-rc3

with top-most commit a6b7eb3b4176d9732d74d214b349932faa5524b4

 Merge branch 'acpi-bus'

on top of commit 57361846b52bc686112da6ca5368d11210796804

 Linux 4.19-rc2

to receive two ACPI fixes for 4.19-rc3.

These fix a regression from the 4.18 cycle in the ACPI driver
for Intel SoCs (LPSS) and prevent dmi_check_system() from being
called on non-x86 systems in the ACPI core.

Specifics:

 - Fix a power management regression in the ACPI driver for Intel
   SoCs (LPSS) introduced by a system-wide suspend/resume fix during
   the 4.18 cycle (Zhang Rui).

 - Prevent dmi_check_system() from being called on non-x86 systems in
   the ACPI core (Jean Delvare).

Thanks!


---------------

Jean Delvare (1):
      ACPI / bus: Only call dmi_check_system() on X86

Zhang Rui (1):
      ACPI / LPSS: Force LPSS quirks on boot

---------------

 drivers/acpi/acpi_lpss.c |  2 +-
 drivers/acpi/bus.c       | 13 +++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)
