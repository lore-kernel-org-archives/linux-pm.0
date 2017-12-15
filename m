From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 0/4] ACPI / boot: Don't handle SCI on HW reduced platforms
Date: Fri, 15 Dec 2017 23:25:07 +0200
Message-ID: <20171215212511.52155-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>, linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

The series improves handling of invalid IRQs in ACPI glue layer along with
preventing setup SCI on HW reduced platforms as it prescribed by the spec.

Patch 1 is just convenient to add to the series.

Patches 2 and 3 make consistent value and variable types for SCI and GSI in
ACPI code.

Patch 4 prevents setting up SCI on HW reduced platforms.

The series has been tested on T100TA (HW reduced platform) and
on Intel Kabylake.

In v4:
- drop upstreamed patches
- drop patch which belongs to other (future) series
- rework approach to address Rafael's comment

Andy Shevchenko (4):
  ACPI / boot: Swap variables in condition in acpi_register_gsi_ioapic()
  ACPI / boot: Get rid of ACPI_INVALID_GSI
  ACPI / boot: Use INVALID_ACPI_IRQ instead of 0 for
    acpi_sci_override_gsi
  ACPI / boot: Don't setup SCI on HW reduced platforms

 arch/x86/include/asm/acpi.h |  2 +-
 arch/x86/kernel/acpi/boot.c | 15 +++++++--------
 2 files changed, 8 insertions(+), 9 deletions(-)

-- 
2.15.1

