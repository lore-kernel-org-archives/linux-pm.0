From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 4/4] ACPI / boot: Don't setup SCI on HW reduced platforms
Date: Fri, 15 Dec 2017 23:25:11 +0200
Message-ID: <20171215212511.52155-5-andriy.shevchenko@linux.intel.com>
References: <20171215212511.52155-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:65454 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756435AbdLOVZq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 15 Dec 2017 16:25:46 -0500
In-Reply-To: <20171215212511.52155-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>, linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

As per note in 5.2.9 Fixed ACPI Description Table (FADT) chapter of ACPI
specification OSPM will ignore fields related to the ACPI HW register
interface, one of which is SCI_INT.

Follow the spec and ignore any configuration done for interrupt line
defined by SCI_INT if FADT specifies HW reduced platform.

HW reduced platform would be still able to use SCI in case it provides
an override record in MADT table.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/acpi/boot.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 6302a931fe9b..290b6f5a2d50 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1212,8 +1212,9 @@ static int __init acpi_parse_madt_ioapic_entries(void)
 	/*
 	 * If BIOS did not supply an INT_SRC_OVR for the SCI
 	 * pretend we got one so we can set the SCI flags.
+	 * But ignore setting up SCI on hardware reduced platforms.
 	 */
-	if (acpi_sci_override_gsi == INVALID_ACPI_IRQ)
+	if (acpi_sci_override_gsi == INVALID_ACPI_IRQ && !acpi_gbl_reduced_hardware)
 		acpi_sci_ioapic_setup(acpi_gbl_FADT.sci_interrupt, 0, 0,
 				      acpi_gbl_FADT.sci_interrupt);
 
-- 
2.15.1
