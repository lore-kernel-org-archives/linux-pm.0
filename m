From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management and ACPI fixes for v4.5-rc3
Date: Sat, 6 Feb 2016 00:52:14 +0100
Message-ID: <CAJZ5v0iSgy+t+QoNvK3vtnAWJpd2Sjtvv+fcs2N3G8vEJ1z3rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-4.5-rc3

to receive power management and ACPI fixes for v4.5-rc3 with top-most
commit 79e2f8dd522873614eb31001745af487451a10de

 Merge branches 'pm-core' and 'pm-domains'

on top of commit 36f90b0a2ddd60823fe193a85e60ff1906c2a9b3

 Linux 4.5-rc2

These are: a fix for a recently introduced false-positive
warnings about PM domain pointers being changed inappropriately
(harmless but annoying), an MCH size workaround quirk for one
more platform, a compiler warning fix (generic power domains
framework), an ACPI LPSS (Intel SoCs) driver fixup and a cleanup
of the ACPI CPPC core code.

Specifics:

 - PM core fix to avoid false-positive warnings generated when
   the pm_domain field is cleared for a device that appears to
   be bound to a driver (Rafael Wysocki).

 - New MCH size workaround quirk for Intel Haswell-ULT (Josh Boyer).

 - Fix for an "unused function" compiler warning in the generic
   power domains framework (Ulf Hansson).

 - Fixup for the ACPI driver for Intel SoCs (acpi-lpss) to set
   the PM domain pointer of a device properly in one place that
   was overlooked by a recent PM core update (Andy Shevchenko).

 - Removal of a redundant function declaration in the ACPI CPPC
   core code (Timur Tabi).

Thanks!

---------------

Andy Shevchenko (1):
      ACPI / LPSS: set PM domain via helper setter

Josh Boyer (1):
      PNP: Add Haswell-ULT to Intel MCH size workaround

Rafael J. Wysocki (1):
      PM: Avoid false-positive warnings in dev_pm_domain_set()

Timur Tabi (1):
      ACPI / CPPC: remove redundant mbox_send_message() declaration

Ulf Hansson (1):
      PM / Domains: Silence compiler warning for an unused function

---------------

 drivers/acpi/acpi_lpss.c    |  2 +-
 drivers/base/power/common.c |  2 +-
 drivers/base/power/domain.c | 27 +++++++--------------------
 drivers/pnp/quirks.c        |  1 +
 include/acpi/cppc_acpi.h    |  1 -
 5 files changed, 10 insertions(+), 23 deletions(-)
