From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] i386: Do not restore reserved memory after
	hibernation
Date: Fri, 1 Jun 2007 21:58:32 +0200
Message-ID: <200706012158.32832.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm <linux-pm@lists.osdl.org>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, Andi Kleen <ak@suse.de>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Hi,

This patch is designed to fix http://bugzilla.kernel.org/show_bug.cgi?id=7995

Unfortunately, the reporter is unresponsive, so it hasn't been explicitly
confirmed to fix the issue, but it's based on some previous patches that
worked and definitely does what it's meant to do. :-)

Greetings,
Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>

On some systems the ACPI NVS area is located in the first 1 MB of RAM and
it is overwritten by the i386 code during the restore after hibernation.
This confuses the ACPI platform firmware that doesn't update the AC adapter
status appropriately as a result
(http://bugzilla.kernel.org/show_bug.cgi?id=7995).

The solution is to register the reserved memory in the first 1 MB as 'nosave',
so that swsusp doesn't touch it during the restore.  Also, this has been done
on x86_64 for a long time now, so the patch makes the i386 restore behaviour
equivalent to the one of x86_64.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/i386/kernel/e820.c  |   30 ++++++++++++++++++++++++++++++
 arch/i386/kernel/setup.c |    1 +
 include/asm-i386/e820.h  |    1 +
 3 files changed, 32 insertions(+)

Index: linux-2.6.22-rc3/arch/i386/kernel/e820.c
===================================================================
--- linux-2.6.22-rc3.orig/arch/i386/kernel/e820.c
+++ linux-2.6.22-rc3/arch/i386/kernel/e820.c
@@ -10,6 +10,7 @@
 #include <linux/efi.h>
 #include <linux/pfn.h>
 #include <linux/uaccess.h>
+#include <linux/suspend.h>
 
 #include <asm/pgtable.h>
 #include <asm/page.h>
@@ -320,6 +321,35 @@ static int __init request_standard_resou
 
 subsys_initcall(request_standard_resources);
 
+/**
+ * e820_mark_nosave_regions - Find the ranges of physical addresses that do not
+ * correspond to e820 RAM areas and mark the corresponding pages as nosave for
+ * hibernation.
+ *
+ * This function requires the e820 map to be sorted and without any
+ * overlapping entries and assumes the first e820 area to be RAM.
+ */
+void __init e820_mark_nosave_regions(void)
+{
+	int i;
+	unsigned long pfn;
+
+	pfn = PFN_DOWN(e820.map[0].addr + e820.map[0].size);
+	for (i = 1; i < e820.nr_map; i++) {
+		struct e820entry *ei = &e820.map[i];
+
+		if (pfn < PFN_UP(ei->addr))
+			register_nosave_region(pfn, PFN_UP(ei->addr));
+
+		pfn = PFN_DOWN(ei->addr + ei->size);
+		if (ei->type != E820_RAM)
+			register_nosave_region(PFN_UP(ei->addr), pfn);
+
+		if (pfn >= max_low_pfn)
+			break;
+	}
+}
+
 void __init add_memory_region(unsigned long long start,
 			      unsigned long long size, int type)
 {
Index: linux-2.6.22-rc3/arch/i386/kernel/setup.c
===================================================================
--- linux-2.6.22-rc3.orig/arch/i386/kernel/setup.c
+++ linux-2.6.22-rc3/arch/i386/kernel/setup.c
@@ -648,6 +648,7 @@ void __init setup_arch(char **cmdline_p)
 #endif
 
 	e820_register_memory();
+	e820_mark_nosave_regions();
 
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
Index: linux-2.6.22-rc3/include/asm-i386/e820.h
===================================================================
--- linux-2.6.22-rc3.orig/include/asm-i386/e820.h
+++ linux-2.6.22-rc3/include/asm-i386/e820.h
@@ -44,6 +44,7 @@ extern void register_bootmem_low_pages(u
 extern void e820_register_memory(void);
 extern void limit_regions(unsigned long long size);
 extern void print_memory_map(char *who);
+extern void e820_mark_nosave_regions(void);
 
 #endif/*!__ASSEMBLY__*/
 
