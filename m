From: Zhang Rui <rui.zhang@intel.com>
Subject: [linux-next] [PATCH V2 3/4] ACPI: mark ACPI NVS memory
	region
Date: Fri, 11 Jul 2008 13:29:12 +0800
Message-ID: <1215754152.1617.60.camel__8699.20830377868$1215754876$gmane$org@rzhang-dt>
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
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>
Cc: Pavel Machek <pavel@suse.cz>, Andi Kleen <andi@firstfloor.org>, Ingo Molnar <mingo@elte.hu>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>
List-Id: linux-pm@vger.kernel.org


Mark ACPI NVS memory region during startup.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 arch/x86/kernel/e820.c |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

Index: linux-next/arch/x86/kernel/e820.c
===================================================================
--- linux-next.orig/arch/x86/kernel/e820.c	2008-07-11 11:44:54.000000000 +0800
+++ linux-next/arch/x86/kernel/e820.c	2008-07-11 11:52:22.000000000 +0800
@@ -19,6 +19,8 @@
 #include <linux/mm.h>
 #include <linux/pfn.h>
 #include <linux/suspend.h>
+#include <linux/efi.h>
+#include <linux/acpi.h>
 
 #include <asm/pgtable.h>
 #include <asm/page.h>
@@ -623,6 +625,33 @@
 }
 #endif
 
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
+		start = PFN_UP(ei->addr);
+		end = PFN_DOWN(ei->addr + ei->size);
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
  * Early reserved memory areas.
  */
