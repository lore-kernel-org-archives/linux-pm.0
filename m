From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fixes for v4.12-rc4
Date: Sat, 3 Jun 2017 00:46:08 +0200
Message-ID: <CAJZ5v0jKBAgw3U=QOuGNwhqEMb0nfSUUNUotV9oyMr5NznF-Fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.12-rc4

with top-most commit 60319130254084b337e02439d3b4ec301b6328bb

 Merge branches 'acpi-button', 'acpica' and 'acpi-sysfs'

on top of commit 5ed02dbb497422bf225783f46e6eadd237d23d6b

 Linux 4.12-rc3

to receive ACPI fixes for v4.12-rc4.

These revert one more problematic commit related to the ACPI-based
handling of laptop lids and make some unuseful error messages coming
from ACPICA go away.

Specifics:

 - Revert one more commit related to the ACPI-based handling of
   laptop lids that changed the default behavior on laptops that
   booted with closed lids and introduced a regression there
   (Benjamin Tissoires).

 - Add a missing acpi_put_table() to the code implementing the
   /sys/firmware/acpi/tables interface to prevent a counter in
   the ACPICA core from overflowing (Dan Williams).

 - Drop error messages printed by ACPICA on acpi_get_table()
   reference counting mismatches as they need not indicate real
   errors at this point (Lv Zheng).

Thanks!


---------------

Benjamin Tissoires (1):
      Revert "ACPI / button: Change default behavior to lid_init_state=open"

Dan Williams (1):
      ACPI / sysfs: fix acpi_get_table() leak / acpi-sysfs denial of service

Lv Zheng (1):
      ACPICA: Tables: Fix regression introduced by a too early
mechanism enabling

---------------

 drivers/acpi/acpica/tbutils.c | 4 ----
 drivers/acpi/button.c         | 2 +-
 drivers/acpi/sysfs.c          | 7 +++++--
 3 files changed, 6 insertions(+), 7 deletions(-)
