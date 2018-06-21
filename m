From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fixes for v4.18-rc2
Date: Thu, 21 Jun 2018 15:31:17 +0200
Message-ID: <CAJZ5v0iUU3WUZQ7NDR2dbxzOSGf3vrXr=7r5zQzSEwh1qokxgQ@mail.gmail.com>
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
 acpi-4.18-rc2

with top-most commit e50f182c9094f95ecfd52a7f33e7e7320e85eb49

 Merge branches 'acpi-soc' and 'acpi-processor'

on top of commit ce397d215ccd07b8ae3f71db689aedb85d56ab40

 Linux 4.18-rc1

to receive ACPI fixes for 4.18-rc2.

These fix a suspend/resume regression in the ACPI driver for Intel
SoCs (LPSS), add a new system wakeup quirk to the ACPI EC driver and
fix an inline stub of a function in the ACPI processor driver that
diverged from the original.

Specifics:

 - Fix a suspend/resume regression in the ACPI driver for Intel SoCs
   (LPSS) to make it work on systems where some power management
   quirks should only be applied for runtime PM and suspend-to-idle
   and not for suspend-to-RAM (Rafael Wysocki).

 - Add a system wakeup quirk for Thinkpad X1 Carbon 6th to the ACPI
   EC driver to avoid drainig battery too fast while suspended to
   idle on those systems (Mika Westerberg).

 - Fix an inline stub of acpi_processor_ppc_has_changed() to match
   the original function definition (Brian Norris).

Thanks!


---------------

Brian Norris (1):
      ACPI / processor: Finish making acpi_processor_ppc_has_changed() void

Mika Westerberg (1):
      ACPI / EC: Use ec_no_wakeup on Thinkpad X1 Carbon 6th

Rafael J. Wysocki (1):
      ACPI / LPSS: Avoid PM quirks on suspend and resume from S3

---------------

 drivers/acpi/acpi_lpss.c | 18 +++++++++++-------
 drivers/acpi/ec.c        | 20 ++++++++++++++++++++
 include/acpi/processor.h |  3 +--
 3 files changed, 32 insertions(+), 9 deletions(-)
