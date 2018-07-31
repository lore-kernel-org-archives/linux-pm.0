From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Urgent ACPI fixes for v4.18
Date: Tue, 31 Jul 2018 11:34:30 +0200
Message-ID: <CAJZ5v0jeTuS0v=9AmQz0c_qAE6ppHVKvBsa2CXJUiRf5axNuCg@mail.gmail.com>
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
 acpi-urgent-4.18

with top-most commit 5f95d39b4246c034838b10f5a4ee50be5b984b95

 Merge branch 'acpi-soc'

on top of commit 73c2a01c52b657f4a0ead6c95f64c5279efbd000

 ACPICA: AML Parser: ignore dispatcher error status during table load

to receive urgent ACPI fixes for final 4.18.

These fix a recent ACPICA regression affecting control method
execution at the table level and an earlier hibernation regression
in the ACPI driver for Intel SoCs (LPSS) that was missed by a
previous fix in this cycle.

Specifics:

 - Fix a recent ACPICA regression introduced by a previous fix
   that caused control method execution at the table level to be
   mishandled by mistake (Erik Schmauss).

 - Fix a hibernation regression from the 4.15 cycle in the ACPI
   driver for Intel SoCs (LPSS) that caused the platform firmware
   to be confused during resume from hibernation by the driver's
   PM quirks which was fixed for system-wide suspend/resume (ACPI
   S3) earlier in this cycle, but that previous fix missed the
   hibernation (ACPI S4) case (Rafael Wysocki).

Thanks!


---------------

Erik Schmauss (1):
      ACPICA: AML Parser: ignore control method status in module-level code

Rafael J. Wysocki (1):
      ACPI / LPSS: Avoid PM quirks on suspend and resume from hibernation

---------------

 drivers/acpi/acpi_lpss.c     | 26 +++++++++++++++++---------
 drivers/acpi/acpica/psloop.c | 19 ++++++++++++-------
 2 files changed, 29 insertions(+), 16 deletions(-)
