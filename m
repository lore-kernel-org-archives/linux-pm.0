From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fixes for v4.13-rc1
Date: Fri, 14 Jul 2017 15:05:14 +0200
Message-ID: <CAJZ5v0h+9TP=Bt+0HzOj28oq=MiBKfjzknp9-Hbaiu04Xy-RHQ@mail.gmail.com>
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
 acpi-fixes-4.13-rc1

with top-most commit 9636603da3c3367139b46e19a38fb2e4850e7420

 Merge branches 'acpi-ec', 'acpi-irq' and 'acpi-quirks'

on top of commit 322618684353315e14f586b33d8a016286ffa700

 Merge tag 'acpi-extra-4.13-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive ACPI fixes for v4.13-rc1.

These fix the return value of an IRQ mapping routine in the ACPI
core, fix an EC driver issue causing abnormal fan behavior after
system resume on some systems and add quirks for ACPI device objects
that need to be treated as "always present" to work around bogus
implementations of the _STA control method.

Specifics:

 - Fix the return value of acpi_gsi_to_irq() to make the GSI to
   IRQ mapping work on the Mustang (ARM64) platform (Mark Salter).

 - Fix an EC driver issue that causes fans to behave abnormally
   after system resume on some systems which turns out to be
   related to switching over the EC into the polling mode during
   the noirq stages of system suspend and resume (Lv Zheng).

 - Add quirks for ACPI device objects that need to be treated as
   "always present", because their _STA methods are designed to
   work around Windows driver bugs and return garbage from our
   perspective (Hans de Goede).

Thanks!


---------------

Hans de Goede (3):
      ACPI / x86: Allow matching always_present_id array entries by DMI
      ACPI / x86: Add Dell Venue 11 Pro 7130 touchscreen to always_present_ids
      ACPI / x86: Add KIOX000A accelerometer on GPD win to
always_present_ids array

Lv Zheng (2):
      ACPI / EC: Drop EC noirq hooks to fix a regression
      Revert "ACPI / EC: Enable event freeze mode..." to fix a regression

Mark Salter (1):
      ACPI / irq: Fix return code of acpi_gsi_to_irq()

---------------

 drivers/acpi/ec.c        | 21 +--------------------
 drivers/acpi/irq.c       |  4 ++--
 drivers/acpi/x86/utils.c | 41 +++++++++++++++++++++++++++++++++++++----
 3 files changed, 40 insertions(+), 26 deletions(-)
