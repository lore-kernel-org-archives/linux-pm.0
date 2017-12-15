From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 1/4] ACPI / boot: Swap variables in condition in acpi_register_gsi_ioapic()
Date: Fri, 15 Dec 2017 23:25:08 +0200
Message-ID: <20171215212511.52155-2-andriy.shevchenko@linux.intel.com>
References: <20171215212511.52155-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171215212511.52155-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>, linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

For better readability compare input to something considered settled
down. Additionally move it to one line (while it's slightly longer
80 characters it makes readability better).

No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/acpi/boot.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 3b33662c072a..bd556b0a48f3 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -679,8 +679,7 @@ static int acpi_register_gsi_ioapic(struct device *dev, u32 gsi,
 	mutex_lock(&acpi_ioapic_lock);
 	irq = mp_map_gsi_to_irq(gsi, IOAPIC_MAP_ALLOC, &info);
 	/* Don't set up the ACPI SCI because it's already set up */
-	if (irq >= 0 && enable_update_mptable &&
-	    acpi_gbl_FADT.sci_interrupt != gsi)
+	if (irq >= 0 && enable_update_mptable && gsi != acpi_gbl_FADT.sci_interrupt)
 		mp_config_acpi_gsi(dev, gsi, trigger, polarity);
 	mutex_unlock(&acpi_ioapic_lock);
 #endif
-- 
2.15.1
