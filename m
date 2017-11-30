From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fixes for v4.15-rc2
Date: Thu, 30 Nov 2017 22:47:36 +0100
Message-ID: <CAJZ5v0jh+WnNDcrf5-Uqf9XXgTZMHAum6FqrspA-vbnyY2jnTw@mail.gmail.com>
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
 acpi-4.15-rc2

with top-most commit b6c70268723bc89743b8aaaa7d17f6889d72497a

 Merge branch 'acpi-ec' into acpi

on top of commit 190b10367b0d311f68dc71e40b254fd4427affc2

 Merge tag 'acpi-fix-4.15-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive ACPI fixes for 4.15-rc2.

These fix a regression related to the ACPI EC handling during system
suspend/resume on some platforms and prevent modalias from being
exposed to user space for ACPI device object with "not functional
and not present" status.

Specifics:

 - Fix an ACPI EC driver regression (from the 4.9 cycle) causing
   the driver's power management operations to be omitted during
   system suspend/resume on platforms where the EC instance from the
   ECDT table is used instead of the one from the DSDT (Lv Zheng).

 - Prevent modalias from being exposed to user space for ACPI device
   objects with _STA returning 0 (not present and not functional) to
   prevent driver modules from being loaded automatically for
   hardware that is not actually present on some platforms (Hans
   de Goede).

Thanks!


---------------

Hans de Goede (1):
      ACPI / bus: Leave modalias empty for devices which are not present

Lv Zheng (1):
      ACPI / EC: Fix regression related to PM ops support in ECDT device

---------------

 drivers/acpi/device_sysfs.c |  4 +++
 drivers/acpi/ec.c           | 69 +++++++++++++++++++++++++++++----------------
 drivers/acpi/internal.h     |  1 +
 drivers/acpi/scan.c         | 21 ++++++++++++++
 include/acpi/acpi_bus.h     |  1 +
 include/acpi/acpi_drivers.h |  1 +
 6 files changed, 73 insertions(+), 24 deletions(-)
