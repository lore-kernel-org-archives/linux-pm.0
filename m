From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] ACPI / boot: Don't shadow error code in acpi_gsi_to_irq()
Date: Tue,  2 Jan 2018 16:08:36 +0200
Message-ID: <20180102140836.21634-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:61258 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751254AbeABOIl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 2 Jan 2018 09:08:41 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

acpi_get_override_irq() followed by acpi_register_gsi() return negative
error code on failure.

Don't shadow them in acpi_gsi_to_irq().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/acpi/boot.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 290b6f5a2d50..cd5745e598fb 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -622,17 +622,17 @@ int acpi_gsi_to_irq(u32 gsi, unsigned int *irqp)
 	}
 
 	rc = acpi_get_override_irq(gsi, &trigger, &polarity);
-	if (rc == 0) {
-		trigger = trigger ? ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
-		polarity = polarity ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
-		irq = acpi_register_gsi(NULL, gsi, trigger, polarity);
-		if (irq >= 0) {
-			*irqp = irq;
-			return 0;
-		}
-	}
+	if (rc)
+		return rc;
 
-	return -1;
+	trigger = trigger ? ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
+	polarity = polarity ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
+	irq = acpi_register_gsi(NULL, gsi, trigger, polarity);
+	if (irq < 0)
+		return irq;
+
+	*irqp = irq;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
 
-- 
2.15.1
