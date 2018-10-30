From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] More ACPI updates for v4.20-rc1
Date: Tue, 30 Oct 2018 09:30:15 +0100
Message-ID: <CAJZ5v0ihPs+sU+s357sYNYBVmqd1CC2JH6_XvRsJQx1A_J7wJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.20-rc1-2

with top-most commit 6a9b593d4b6f5994209456de7a3c2db0974b5dda

 ACPI / PMIC: xpower: Add depends on IOSF_MBI to Kconfig entry

on top of commit bd6bf7c10484f026505814b690104cdef27ed460

 Merge tag 'pci-v4.20-changes' of
git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci

to receive additional ACPI updates for 4.20-rc1.

These rework the handling of the P-unit semaphore on Intel
Baytrail and Cherrytrail systems to avoid race conditions and
excessive overhead related to it (Hans de Goede).

There was a merge conflict between this material and the i2c
tree (merged now) in linux-next that should be straightforward
to resolve [1].

Thanks!

[1] https://lore.kernel.org/lkml/20181029130925.60ea7830@canb.auug.org.au/


---------------

Hans de Goede (4):
      x86: baytrail/cherrytrail: Rework and move P-Unit PMIC bus semaphore code
      ACPI / PMIC: xpower: Block P-Unit I2C access during read-modify-write
      i2c: designware: Cleanup bus lock handling
      ACPI / PMIC: xpower: Add depends on IOSF_MBI to Kconfig entry

---------------

 arch/x86/include/asm/iosf_mbi.h              |  39 +++--
 arch/x86/platform/intel/iosf_mbi.c           | 217 ++++++++++++++++++++++++---
 drivers/acpi/Kconfig                         |   2 +-
 drivers/acpi/pmic/intel_pmic_xpower.c        |  21 ++-
 drivers/i2c/busses/i2c-designware-baytrail.c | 139 +----------------
 drivers/i2c/busses/i2c-designware-common.c   |   4 +-
 drivers/i2c/busses/i2c-designware-core.h     |   9 +-
 drivers/i2c/busses/i2c-designware-platdrv.c  |   2 -
 8 files changed, 250 insertions(+), 183 deletions(-)
