From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] ACPI / boot: Correct address space of __acpi_map_table()
Date: Sat,  8 Jul 2017 18:50:29 +0300
Message-ID: <20170708155030.12587-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:54216 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752769AbdGHPuf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 8 Jul 2017 11:50:35 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Sparse complains about wrong address space used in __acpi_map_table()
and in __acpi_unmap_table().

arch/x86/kernel/acpi/boot.c:127:29: warning: incorrect type in return expression (different address spaces)
arch/x86/kernel/acpi/boot.c:127:29:    expected char *
arch/x86/kernel/acpi/boot.c:127:29:    got void [noderef] <asn:2>*
arch/x86/kernel/acpi/boot.c:135:23: warning: incorrect type in argument 1 (different address spaces)
arch/x86/kernel/acpi/boot.c:135:23:    expected void [noderef] <asn:2>*addr
arch/x86/kernel/acpi/boot.c:135:23:    got char *map

Correct address space to be in align of type of returned and passed
parameter.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/acpi/boot.c | 4 ++--
 include/linux/acpi.h        | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 6d534af94761..ac9bb564f004 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -118,7 +118,7 @@ static u32 isa_irq_to_gsi[NR_IRQS_LEGACY] __read_mostly = {
  * This is just a simple wrapper around early_ioremap(),
  * with sanity checks for phys == 0 and size == 0.
  */
-char *__init __acpi_map_table(unsigned long phys, unsigned long size)
+void __init __iomem *__acpi_map_table(unsigned long phys, unsigned long size)
 {
 
 	if (!phys || !size)
@@ -127,7 +127,7 @@ char *__init __acpi_map_table(unsigned long phys, unsigned long size)
 	return early_ioremap(phys, size);
 }
 
-void __init __acpi_unmap_table(char *map, unsigned long size)
+void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
 {
 	if (!map || !size)
 		return;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 99f96df83dd8..17cb57a533bb 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -224,8 +224,8 @@ struct acpi_subtable_proc {
 	int count;
 };
 
-char * __acpi_map_table (unsigned long phys_addr, unsigned long size);
-void __acpi_unmap_table(char *map, unsigned long size);
+void __iomem *__acpi_map_table(unsigned long phys_addr, unsigned long size);
+void __acpi_unmap_table(void __iomem *map, unsigned long size);
 int early_acpi_boot_init(void);
 int acpi_boot_init (void);
 void acpi_boot_table_init (void);
-- 
2.11.0
