From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 5/5] ACPI / boot: Don't handle SCI on HW reduced platforms
Date: Mon, 17 Jul 2017 16:29:46 +0300
Message-ID: <20170717132946.20892-6-andriy.shevchenko@linux.intel.com>
References: <20170717132946.20892-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170717132946.20892-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>, linux-acpi@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

WIP

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/acpi/boot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 71c0feae60a4..4413cc2f7c3c 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1184,7 +1184,7 @@ static int __init acpi_parse_madt_ioapic_entries(void)
 	 * If BIOS did not supply an INT_SRC_OVR for the SCI
 	 * pretend we got one so we can set the SCI flags.
 	 */
-	if (!acpi_sci_override_gsi)
+	if (!acpi_sci_override_gsi && !acpi_gbl_reduced_hardware)
 		acpi_sci_ioapic_setup(acpi_gbl_FADT.sci_interrupt, 0, 0,
 				      acpi_gbl_FADT.sci_interrupt);
 
-- 
2.11.0

