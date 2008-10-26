From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/4] x86 hibernate: Mark ACPI NVS memory region
	at startup
Date: Sun, 26 Oct 2008 20:54:24 +0100
Message-ID: <200810262054.24929.rjw__25408.235731493$1225051433$gmane$org@sisk.pl>
References: <200810262048.23468.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200810262048.23468.rjw@sisk.pl>
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
To: Len Brown <lenb@kernel.org>
Cc: Nigel Cunningham <ncunningham@crca.org.au>, Ingo Molnar <mingo@elte.hu>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: x86 hibernate: Mark ACPI NVS memory region at startup

Introduce new initcall for marking the ACPI NVS memory at startup, so
that it can be saved/restore during hibernation/resume.

Based on a patch by Zhang Rui.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Zhang Rui <rui.zhang@intel.com>
---
 arch/x86/kernel/e820.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index ce97bf3..e1e63a8 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -20,6 +20,7 @@
 #include <linux/pfn.h>
 #include <linux/suspend.h>
 #include <linux/firmware-map.h>
+#include <linux/efi.h>
 
 #include <asm/pgtable.h>
 #include <asm/page.h>
@@ -665,6 +666,30 @@ void __init e820_mark_nosave_regions(unsigned long limit_pfn)
 }
 #endif
 
+#ifdef CONFIG_HIBERNATION
+/**
+ * Mark ACPI NVS memory region, so that we can save/restore it during
+ * hibernation and the subsequent resume.
+ */
+static int __init e820_mark_nvs_memory(void)
+{
+	int i;
+
+	if (efi_enabled)
+		return 0;
+
+	for (i = 0; i < e820.nr_map; i++) {
+		struct e820entry *ei = &e820.map[i];
+
+		if (ei->type == E820_NVS)
+			hibernate_nvs_register(ei->addr, ei->size);
+	}
+
+	return 0;
+}
+core_initcall(e820_mark_nvs_memory);
+#endif
+
 /*
  * Early reserved memory areas.
  */
-- 
1.5.6
