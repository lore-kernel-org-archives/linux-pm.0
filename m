From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fixes for v4.9-rc2
Date: Fri, 21 Oct 2016 23:16:53 +0200
Message-ID: <CAJZ5v0hFRk+OOvYsy_r1z+Cfs5_9PG3GaO0pOkqQhSbKtQZxxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.9-rc2

with top-most commit 956c8974da654016ec26e66322b5b221108468bf

 Merge branches 'acpi-wdat' and 'acpi-cppc'

on top of commit 1001354ca34179f3db924eb66672442a173147dc

 Linux 4.9-rc1

to receive ACPI fixes for v4.9-rc2.

These fix an issue related to system resume in the new WDAT-based
watchdog driver and a return value of a stub function in the ACPI
CPPC framework.

Specifics:

 - Update the ACPI WDAT-based watchdog driver to ping the hardware
   during system resume to prevent a reset from occurring after the
   resume is complete (Mika Westerberg).

 - Fix the return value of the pcc_mbox_request_channel() stub for
   CONFIG_PCC unset (Hoan Tran).

Thanks!

---------------

Hoan Tran (1):
      mailbox: PCC: Fix return value of pcc_mbox_request_channel()

Mika Westerberg (1):
      watchdog: wdat_wdt: Ping the watchdog on resume

---------------

 drivers/watchdog/wdat_wdt.c | 4 ++++
 include/acpi/pcc.h          | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)
