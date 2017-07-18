From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 0/5] ACPI / boot: Few amendments
Date: Tue, 18 Jul 2017 18:04:15 +0300
Message-ID: <20170718150420.61600-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>, linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

This series does few amendments to architectural ACPI code related to
boot, in particularly to arch/x86/kernel/acpi/boot.c.

First two patches are amendments to satisfy compiler and static analyzer
(the order is changed from first version which had been applied; in case
  of partial update first patch is already in tree).

Third patch might be useful on platforms when debugging *PIC related
code path to see how many legacy IRQs are registered.

Fourth and fifth patches are preparation for some interesting
implementation of ACPI HW reduced platforms (note, this does not mean
it's against specification, patch 5 actually about following
specification).

Fifth patch might be subject to additional discussions.

Series has been tested on ASuS T100ta transformer
(ACPI HW reduced bit is set). No regressions found.

In v3:
- fix compilation error on ia64
- extend patch 5 and drop WIP status
- append RB tag for patch 2 (hope it stays for slightly fixed ia64 code)

In v2:
- fix function declarations in ia64 and arm64 as well (Hanjun)
- add three more patches

Andy Shevchenko (5):
  ACPI / boot: Don't define unused variables
  ACPI / boot: Correct address space of __acpi_map_table()
  ACPI / boot: Add number of legacy IRQs to debug output
  ACPI / boot: Not all platform require acpi_reduced_hw_init()
  ACPI / boot: Don't handle SCI on HW reduced platforms

 arch/arm64/kernel/acpi.c    |  4 ++--
 arch/ia64/kernel/acpi.c     |  6 +++---
 arch/x86/kernel/acpi/boot.c | 17 ++++++++++-------
 drivers/acpi/bus.c          |  2 +-
 drivers/acpi/osl.c          |  2 +-
 include/linux/acpi.h        |  7 +++++--
 6 files changed, 22 insertions(+), 16 deletions(-)

-- 
2.11.0
