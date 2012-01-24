From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/10] ACPI, APEI: Add RAM mapping support to ACPI
Date: Mon, 23 Jan 2012 20:30:03 -0500
Message-ID: <ba242d5b1a84bc6611732296517ee40d5a80a4d9.1327368464.git.len.brown@intel.com>
References: <1327368609-28409-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <1327368609-28409-1-git-send-email-lenb@kernel.org>
In-reply-to: <54d5dcc45af7adbb907072d042bbece4c2b4de6e.1327368464.git.len.brown@intel.com>
References: <54d5dcc45af7adbb907072d042bbece4c2b4de6e.1327368464.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Myron Stowe <mstowe@redhat.com>, Myron Stowe <myron.stowe@redhat.com>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Myron Stowe <mstowe@redhat.com>

This patch adds support for RAM to ACPI's mapping capabilities in order
to support APEI error injection (EINJ) actions.

This patch re-factors similar functionality introduced in commit
76da3fb3575, bringing it into osl.c in preparation for removing
./drivers/acpi/atomicio.[ch].

Signed-off-by: Myron Stowe <myron.stowe@redhat.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c |   36 ++++++++++++++++++++++++++++++++++--
 1 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 5498a6d..412a1e0 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -31,6 +31,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
+#include <linux/highmem.h>
 #include <linux/pci.h>
 #include <linux/interrupt.h>
 #include <linux/kmod.h>
@@ -321,6 +322,37 @@ acpi_map_lookup_virt(void __iomem *virt, acpi_size size)
 	return NULL;
 }
 
+#ifndef CONFIG_IA64
+#define should_use_kmap(pfn)   page_is_ram(pfn)
+#else
+/* ioremap will take care of cache attributes */
+#define should_use_kmap(pfn)   0
+#endif
+
+static void __iomem *acpi_map(acpi_physical_address pg_off, unsigned long pg_sz)
+{
+	unsigned long pfn;
+
+	pfn = pg_off >> PAGE_SHIFT;
+	if (should_use_kmap(pfn)) {
+		if (pg_sz > PAGE_SIZE)
+			return NULL;
+		return (void __iomem __force *)kmap(pfn_to_page(pfn));
+	} else
+		return acpi_os_ioremap(pg_off, pg_sz);
+}
+
+static void acpi_unmap(acpi_physical_address pg_off, void __iomem *vaddr)
+{
+	unsigned long pfn;
+
+	pfn = pg_off >> PAGE_SHIFT;
+	if (page_is_ram(pfn))
+		kunmap(pfn_to_page(pfn));
+	else
+		iounmap(vaddr);
+}
+
 void __iomem *__init_refok
 acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
 {
@@ -353,7 +385,7 @@ acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
 
 	pg_off = round_down(phys, PAGE_SIZE);
 	pg_sz = round_up(phys + size, PAGE_SIZE) - pg_off;
-	virt = acpi_os_ioremap(pg_off, pg_sz);
+	virt = acpi_map(pg_off, pg_sz);
 	if (!virt) {
 		mutex_unlock(&acpi_ioremap_lock);
 		kfree(map);
@@ -384,7 +416,7 @@ static void acpi_os_map_cleanup(struct acpi_ioremap *map)
 {
 	if (!map->refcount) {
 		synchronize_rcu();
-		iounmap(map->virt);
+		acpi_unmap(map->phys, map->virt);
 		kfree(map);
 	}
 }
-- 
1.7.9.rc2

