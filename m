From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fix for v4.18-rc5
Date: Wed, 11 Jul 2018 11:37:58 +0200
Message-ID: <CAJZ5v0g6TncQk+GZJ1UTYHkyvOphdn=_B5kwL1nbMU6GaE6nCw@mail.gmail.com>
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
 acpi-4.18-rc5

with top-most commit fa85015c0d95884c8dc42f38e2f2d6137d436b67

 ACPICA: Clear status of all events when entering S5

on top of commit 1e4b044d22517cae7047c99038abb444423243ca

 Linux 4.18-rc4

to receive an ACPI regression fix for 4.18-rc5.

This addresses a regression in ACPICA that ceased to clear the
status of GPEs and fixed events before entering the ACPI S5 (off)
system state during the 4.17 cycle which caused some systems to
power up immediately after they had been turned off.

Thanks!


---------------

Rafael J. Wysocki (1):
      ACPICA: Clear status of all events when entering S5

---------------

 drivers/acpi/acpica/hwsleep.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)
