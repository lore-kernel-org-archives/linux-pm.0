From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI power management fix for final 3.19
Date: Wed, 4 Feb 2015 22:46:04 +0100
Message-ID: <CAJZ5v0jNMWJ0HDmpqq4fZmv9_6qr1U-ebRadeWaUdZWx9YFBpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-3.19-fin

to receive an ACPI power management fix for final v3.19 as commit
3df2da96874402722d760e5d4eb2968737e5bb01

 Revert "ACPI / LPSS: introduce a 'proxy' device to power on LPSS for DMA"

on top of commit e36f014edff70fc02b3d3d79cead1d58f289332e

 Linux 3.19-rc7

This is a revert of an ACPI Low-power Subsystem (LPSS) driver change
that was supposed to improve power management of the LPSS DMA controller,
but introduced more serious problems.

Since fixing them turns out to be non-trivial, it is better to revert
the commit in question at this point and try to fix the original issue
differently in the next cycle.

Thanks!


---------------

Rafael J. Wysocki (1):
      Revert "ACPI / LPSS: introduce a 'proxy' device to power on LPSS for DMA"

---------------

 drivers/acpi/acpi_lpss.c | 35 +++++++----------------------------
 1 file changed, 7 insertions(+), 28 deletions(-)
