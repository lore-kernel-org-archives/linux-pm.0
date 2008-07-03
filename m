From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH 4/4] x86_32: mark ACPI NVS memory region
Date: Thu, 03 Jul 2008 10:24:39 +0800
Message-ID: <1215051879.5628.36.camel@rzhang-dt.sh.intel.com>
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


x86_32: Mark ACPI NVS memory region.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 arch/x86/kernel/e820_32.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

Index: linux-2.6/arch/x86/kernel/e820_32.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/e820_32.c	2008-07-01 09:32:27.000000000 +0800
+++ linux-2.6/arch/x86/kernel/e820_32.c	2008-07-03 09:00:37.000000000 +0800
@@ -10,6 +10,8 @@
 #include <linux/pfn.h>
 #include <linux/uaccess.h>
 #include <linux/suspend.h>
+#include <linux/efi.h>
+#include <linux/acpi.h>
 
 #include <asm/pgtable.h>
 #include <asm/page.h>
@@ -253,6 +255,30 @@
 			break;
 	}
 }
+
+/* Mark ACPI NVS region so that OS can save/restore it during hibernation */
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
+		acpi_mark_nvs_region(start, end - 1);
+	}
+	return 0;
+}
+core_initcall(e820_mark_nvs_memory);
 #endif
 
 void __init add_memory_region(unsigned long long start,
