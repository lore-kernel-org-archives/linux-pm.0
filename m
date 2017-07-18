From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 5/5] ACPI / boot: Don't handle SCI on HW reduced platforms
Date: Tue, 18 Jul 2017 18:04:20 +0300
Message-ID: <20170718150420.61600-6-andriy.shevchenko@linux.intel.com>
References: <20170718150420.61600-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170718150420.61600-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>, linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

As per note in 5.2.9 Fixed ACPI Description Table (FADT) chapter of ACPI
specification OSPM will ignore fields related to the ACPI HW register
interface, one of which is SCI_INT.

Follow the spec and ignore any configuration done for interrupt line
defined by SCI_INT if FADT specifies HW reduced platform.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/acpi/boot.c | 4 ++--
 drivers/acpi/bus.c          | 2 +-
 drivers/acpi/osl.c          | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 71c0feae60a4..c767efa53ee0 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -489,7 +489,7 @@ acpi_parse_int_src_ovr(struct acpi_subtable_header * header,
 
 	acpi_table_print_madt_entry(header);
 
-	if (intsrc->source_irq == acpi_gbl_FADT.sci_interrupt) {
+	if (intsrc->source_irq == acpi_gbl_FADT.sci_interrupt && !acpi_gbl_reduced_hardware) {
 		acpi_sci_ioapic_setup(intsrc->source_irq,
 				      intsrc->inti_flags & ACPI_MADT_POLARITY_MASK,
 				      (intsrc->inti_flags & ACPI_MADT_TRIGGER_MASK) >> 2,
@@ -1184,7 +1184,7 @@ static int __init acpi_parse_madt_ioapic_entries(void)
 	 * If BIOS did not supply an INT_SRC_OVR for the SCI
 	 * pretend we got one so we can set the SCI flags.
 	 */
-	if (!acpi_sci_override_gsi)
+	if (!acpi_sci_override_gsi && !acpi_gbl_reduced_hardware)
 		acpi_sci_ioapic_setup(acpi_gbl_FADT.sci_interrupt, 0, 0,
 				      acpi_gbl_FADT.sci_interrupt);
 
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index af74b420ec83..1f3dde3bc8f8 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1035,7 +1035,7 @@ void __init acpi_early_init(void)
 	}
 
 #ifdef CONFIG_X86
-	if (!acpi_ioapic) {
+	if (!acpi_ioapic && !acpi_gbl_reduced_hardware) {
 		/* compatible (0) means level (3) */
 		if (!(acpi_sci_flags & ACPI_MADT_TRIGGER_MASK)) {
 			acpi_sci_flags &= ~ACPI_MADT_TRIGGER_MASK;
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index db78d353bab1..4d84118a000b 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -553,7 +553,7 @@ acpi_os_install_interrupt_handler(u32 gsi, acpi_osd_handler handler,
 	 * ACPI interrupts different from the SCI in our copy of the FADT are
 	 * not supported.
 	 */
-	if (gsi != acpi_gbl_FADT.sci_interrupt)
+	if (gsi != acpi_gbl_FADT.sci_interrupt || acpi_gbl_reduced_hardware)
 		return AE_BAD_PARAMETER;
 
 	if (acpi_irq_handler)
-- 
2.11.0

