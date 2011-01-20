From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 11/11] ACPI / PM: Make NVS save/restore code use
	slightly less memory
Date: Thu, 20 Jan 2011 12:37:34 +0100
Message-ID: <201101201237.34551.rjw__1885.81049810654$1295524988$gmane$org@sisk.pl>
References: <201101201226.41021.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201101201226.41021.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jeff Chua <jeff.chua.linux@gmail.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Remove the unnecessary field phys_start from struct nvs_page and
rework the code in nvs.c to reflect that change.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/nvs.c |   45 ++++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

Index: linux-2.6/drivers/acpi/nvs.c
===================================================================
--- linux-2.6.orig/drivers/acpi/nvs.c
+++ linux-2.6/drivers/acpi/nvs.c
@@ -22,7 +22,6 @@
  */
 
 struct nvs_page {
-	unsigned long phys_start;
 	unsigned int size;
 	void *kaddr;
 	void *data;
@@ -31,6 +30,8 @@ struct nvs_page {
 };
 
 static LIST_HEAD(nvs_list);
+static unsigned long nvs_start;
+static unsigned int nvs_offset;
 
 /**
  *	suspend_nvs_register - register platform NVS memory region to save
@@ -44,25 +45,28 @@ static LIST_HEAD(nvs_list);
 int suspend_nvs_register(unsigned long start, unsigned long size)
 {
 	struct nvs_page *entry, *next;
+	unsigned int offset;
 
+	nvs_start = round_down(start, PAGE_SIZE);
+	nvs_offset = start - nvs_start;
+	offset = nvs_offset;
 	while (size > 0) {
-		unsigned int nr_bytes;
+		unsigned int nr_bytes = PAGE_SIZE - offset;
 
 		entry = kzalloc(sizeof(struct nvs_page), GFP_KERNEL);
 		if (!entry)
-			goto Error;
+			goto err_out;
 
 		list_add_tail(&entry->node, &nvs_list);
-		entry->phys_start = start;
-		nr_bytes = PAGE_SIZE - (start & ~PAGE_MASK);
 		entry->size = (size < nr_bytes) ? size : nr_bytes;
 
 		start += entry->size;
 		size -= entry->size;
+		offset -= offset;
 	}
 	return 0;
 
- Error:
+ err_out:
 	list_for_each_entry_safe(entry, next, &nvs_list, node) {
 		list_del(&entry->node);
 		kfree(entry);
@@ -117,25 +121,32 @@ int suspend_nvs_alloc(void)
 int suspend_nvs_save(void)
 {
 	struct nvs_page *entry;
+	unsigned long page_addr = nvs_start;
+	unsigned int offset = nvs_offset;
 
 	printk(KERN_INFO "PM: Saving platform NVS memory\n");
 
-	list_for_each_entry(entry, &nvs_list, node)
-		if (entry->data) {
-			unsigned long phys = entry->phys_start;
-			unsigned int size = entry->size;
+	list_for_each_entry(entry, &nvs_list, node) {
+		unsigned long phys = page_addr + offset;
+		unsigned int size = entry->size;
 
-			entry->kaddr = acpi_os_get_iomem(phys, size);
-			if (!entry->kaddr) {
-				entry->kaddr = acpi_os_ioremap(phys, size);
-				entry->unmap = true;
-			}
+		if (!entry->data)
+			return -ENOMEM;
+
+		entry->kaddr = acpi_os_get_iomem(phys, size);
+		if (!entry->kaddr) {
+			entry->kaddr = acpi_os_ioremap(phys, size);
 			if (!entry->kaddr) {
 				suspend_nvs_free();
-				return -ENOMEM;
+				return -EIO;
 			}
-			memcpy(entry->data, entry->kaddr, entry->size);
+			entry->unmap = true;
 		}
+		memcpy(entry->data, entry->kaddr, entry->size);
+
+		page_addr += PAGE_SIZE;
+		offset -= offset;
+	}
 
 	return 0;
 }
