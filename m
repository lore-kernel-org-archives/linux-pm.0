From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 2/4] ACPI / boot: Get rid of ACPI_INVALID_GSI
Date: Fri, 15 Dec 2017 23:25:09 +0200
Message-ID: <20171215212511.52155-3-andriy.shevchenko@linux.intel.com>
References: <20171215212511.52155-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171215212511.52155-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>, linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jiang Liu <jiang.liu@linux.intel.com>, Chen Yu <yu.c.chen@intel.com>
List-Id: linux-pm@vger.kernel.org

The commit 49e4b84333f3
("ACPI: Use correct IRQ when uninstalling ACPI interrupt handler")
brings a new definition for invalid ACPI IRQ, i.e. INVALID_ACPI_IRQ,
which is defined to 0xffffffff (or -1 for unsigned value).

Get rid of former one, which was brought by the commit 2c0a6894df19
("x86, ACPI, irq: Enhance error handling in function acpi_register_gsi()"),
in favour of latter.

To clarify the rationale of changing from INT_MIN to ((unsigned)-1)
definition consider the following:
- IRQ 0 is valid one in hardware, so, better not to use it everywhere
  (Linux uses 0 as NO IRQ, though it's another story)
- INT_MIN splits the range into two, while 0xffffffff reserves only the
  last item
- when type casting is done in most cases 0xff, 0xffff is naturally used
  as a marker of invalid HW IRQ: for example PCI INT line 0xff means
  no IRQ assigned by BIOS

Cc: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/acpi/boot.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index bd556b0a48f3..c6a6b82882b2 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -115,8 +115,6 @@ static u32 isa_irq_to_gsi[NR_IRQS_LEGACY] __read_mostly = {
 	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
 };
 
-#define	ACPI_INVALID_GSI		INT_MIN
-
 /*
  * This is just a simple wrapper around early_memremap(),
  * with sanity checks for phys == 0 and size == 0.
@@ -375,7 +373,7 @@ static void __init mp_override_legacy_irq(u8 bus_irq, u8 polarity, u8 trigger,
 	 * and acpi_isa_irq_to_gsi() may give wrong result.
 	 */
 	if (gsi < nr_legacy_irqs() && isa_irq_to_gsi[gsi] == gsi)
-		isa_irq_to_gsi[gsi] = ACPI_INVALID_GSI;
+		isa_irq_to_gsi[gsi] = INVALID_ACPI_IRQ;
 	isa_irq_to_gsi[bus_irq] = gsi;
 }
 
@@ -640,7 +638,7 @@ EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
 int acpi_isa_irq_to_gsi(unsigned isa_irq, u32 *gsi)
 {
 	if (isa_irq < nr_legacy_irqs() &&
-	    isa_irq_to_gsi[isa_irq] != ACPI_INVALID_GSI) {
+	    isa_irq_to_gsi[isa_irq] != INVALID_ACPI_IRQ) {
 		*gsi = isa_irq_to_gsi[isa_irq];
 		return 0;
 	}
-- 
2.15.1
