From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 3/4] ACPI / boot: Use INVALID_ACPI_IRQ instead of 0 for acpi_sci_override_gsi
Date: Fri, 15 Dec 2017 23:25:10 +0200
Message-ID: <20171215212511.52155-4-andriy.shevchenko@linux.intel.com>
References: <20171215212511.52155-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171215212511.52155-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>, linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

0 is valid hardware interrupt which might be in some cases overridden.
Due to this, switch to INVALID_ACPI_IRQ to mark SCI override not set.

While here, change type of the variable from int to u32 to be in align
with GSI type used in the rest of the code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/include/asm/acpi.h | 2 +-
 arch/x86/kernel/acpi/boot.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 8d0ec9df1cbe..44f5d79d5105 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -49,7 +49,7 @@ extern int acpi_fix_pin2_polarity;
 extern int acpi_disable_cmcff;
 
 extern u8 acpi_sci_flags;
-extern int acpi_sci_override_gsi;
+extern u32 acpi_sci_override_gsi;
 void acpi_pic_sci_set_trigger(unsigned int, u16);
 
 struct device;
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index c6a6b82882b2..6302a931fe9b 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -71,8 +71,9 @@ int acpi_ioapic;
 int acpi_strict;
 int acpi_disable_cmcff;
 
+/* ACPI SCI override configuration */
 u8 acpi_sci_flags __initdata;
-int acpi_sci_override_gsi __initdata;
+u32 acpi_sci_override_gsi __initdata = INVALID_ACPI_IRQ;
 int acpi_skip_timer_override __initdata;
 int acpi_use_timer_override __initdata;
 int acpi_fix_pin2_polarity __initdata;
@@ -1212,7 +1213,7 @@ static int __init acpi_parse_madt_ioapic_entries(void)
 	 * If BIOS did not supply an INT_SRC_OVR for the SCI
 	 * pretend we got one so we can set the SCI flags.
 	 */
-	if (!acpi_sci_override_gsi)
+	if (acpi_sci_override_gsi == INVALID_ACPI_IRQ)
 		acpi_sci_ioapic_setup(acpi_gbl_FADT.sci_interrupt, 0, 0,
 				      acpi_gbl_FADT.sci_interrupt);
 
-- 
2.15.1

