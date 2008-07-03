From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH 3/4] x86_64: mark ACPI NVS memory region
Date: Thu, 03 Jul 2008 10:24:36 +0800
Message-ID: <1215051876.5628.35.camel@rzhang-dt.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


x86_64: Mark ACPI NVS memory region.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 arch/x86/kernel/e820_64.c |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

Index: linux-2.6/arch/x86/kernel/e820_64.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/e820_64.c	2008-06-19 15:09:52.000000000 +0800
+++ linux-2.6/arch/x86/kernel/e820_64.c	2008-06-19 15:11:45.000000000 +0800
@@ -19,6 +19,8 @@
 #include <linux/mm.h>
 #include <linux/suspend.h>
 #include <linux/pfn.h>
+#include <linux/efi.h>
+#include <linux/acpi.h>
 
 #include <asm/pgtable.h>
 #include <asm/page.h>
@@ -377,6 +379,33 @@
 	}
 }
 
+#ifdef CONFIG_HIBERNATION
+/* Mark ACPI NVS region, so that OS can save/restore it during hibernation */
+static int __init e820_mark_nvs_memory(void)
+{
+	int i;
+
+	if (efi_enabled)
+		return 0;
+
+	for (i = 0; i < e820.nr_map; i++) {
+		struct e820entry *ei = &e820.map[i];
+		unsigned long start, end;
+
+		if (ei->type != E820_NVS)
+			continue;
+		start = round_up(ei->addr, PAGE_SIZE) >> PAGE_SHIFT;
+		end = round_down(ei->addr + ei->size, PAGE_SIZE) >> PAGE_SHIFT;
+		if (start >= end)
+			continue;
+
+		acpi_mark_nvs_region(start, end - 1);
+	}
+	return 0;
+}
+core_initcall(e820_mark_nvs_memory);
+#endif
+
 /*
  * Finds an active region in the address range from start_pfn to end_pfn and
  * returns its range in ei_startpfn and ei_endpfn for the e820 entry.
