From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fixes for v5.0-rc3
Date: Fri, 18 Jan 2019 12:24:25 +0100
Message-ID: <CAJZ5v0jiK=zLP4cUsw=y9ea7PLHHgy=xshAsHFhTgyDJH+kOiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.0-rc3

with top-most commit 11ee2a3808aebbec73096551a716dea03d417fcb

 Merge branch 'acpi-pci'

on top of commit 1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8

 Linux 5.0-rc2

to receive ACPI fixes for 5.0-rc3.

These fix an ACPI initialization ordering issue introduced in
the 4.17 time frame and causing functional problems to appear on
multiple systems and fix some fallout of the recent change to
enable building kernels with ACPI support and without PCI.

Specifics:

 - Restore the ACPI initialization ordering changed implicitly by the
   module-level AML handling rework during the 4.17 development cycle
   that caused the EC address space handler based on information from
   ECDT to be set up before loading AML definition blocks, making it
   effectively not accessible by AML on some systems that don't work
   as expected any more (Rafael Wysocki).

 - Add direct dependencies on PCI to Kconfig in multiple places for
   code that depends on both ACPI and PCI, but the PCI dependency
   was implicitly satisfied by the ACPI dependency before, to prevent
   invalid configurations from being created, for example by
   randconfig (Sinan Kaya).

Thanks!


---------------

Rafael J. Wysocki (1):
      ACPI: EC: Look for ECDT EC after calling acpi_load_tables()

Sinan Kaya (8):
      ACPI / LPSS: Make PCI dependency explicit
      ata: pata_acpi: Make PCI dependency explicit
      vga-switcheroo: make PCI dependency explicit
      platform/x86: intel_ips: make PCI dependency explicit
      platform/x86: intel_pmc: Make PCI dependency explicit
      platform/x86: apple-gmux: Make PCI dependency explicit
      x86/intel/lpss: Make PCI dependency explicit
      drivers: thermal: int340x_thermal: Make PCI dependency explicit

---------------

 arch/x86/Kconfig                              |  2 +-
 drivers/acpi/Makefile                         |  3 ++-
 drivers/acpi/bus.c                            | 24 ++++++++++++------------
 drivers/acpi/internal.h                       |  4 ++++
 drivers/ata/Kconfig                           |  2 +-
 drivers/gpu/vga/Kconfig                       |  1 +
 drivers/platform/x86/Kconfig                  |  6 +++---
 drivers/thermal/intel/int340x_thermal/Kconfig |  2 +-
 8 files changed, 25 insertions(+), 19 deletions(-)
