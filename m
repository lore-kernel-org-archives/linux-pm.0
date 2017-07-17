From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/5] ACPI / boot: Correct address space of __acpi_map_table()
Date: Mon, 17 Jul 2017 13:24:01 +0300
Message-ID: <20170717102404.27191-3-andriy.shevchenko@linux.intel.com>
References: <20170717102404.27191-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170717102404.27191-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

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
 arch/arm64/kernel/acpi.c    | 4 ++--
 arch/ia64/kernel/acpi.c     | 4 ++--
 arch/x86/kernel/acpi/boot.c | 4 ++--
 include/linux/acpi.h        | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index e25c11e727fe..b3162715ed78 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -95,7 +95,7 @@ static int __init dt_scan_depth1_nodes(unsigned long node,
  * __acpi_map_table() will be called before page_init(), so early_ioremap()
  * or early_memremap() should be called here to for ACPI table mapping.
  */
-char *__init __acpi_map_table(unsigned long phys, unsigned long size)
+void __init __iomem *__acpi_map_table(unsigned long phys, unsigned long size)
 {
 	if (!size)
 		return NULL;
@@ -103,7 +103,7 @@ char *__init __acpi_map_table(unsigned long phys, unsigned long size)
 	return early_memremap(phys, size);
 }
 
-void __init __acpi_unmap_table(char *map, unsigned long size)
+void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
 {
 	if (!map || !size)
 		return;
diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
index 7508c306aa9e..b9388cc283bc 100644
--- a/arch/ia64/kernel/acpi.c
+++ b/arch/ia64/kernel/acpi.c
@@ -159,12 +159,12 @@ int acpi_request_vector(u32 int_type)
 	return vector;
 }
 
-char *__init __acpi_map_table(unsigned long phys_addr, unsigned long size)
+void __init __iomem *__acpi_map_table(unsigned long phys, unsigned long size)
 {
 	return __va(phys_addr);
 }
 
-void __init __acpi_unmap_table(char *map, unsigned long size)
+void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
 {
 }
 
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 09ddb3cd627a..6d5b1346268a 100644
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
index c749eef1daa1..3848b56fcd83 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -228,8 +228,8 @@ struct acpi_subtable_proc {
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
