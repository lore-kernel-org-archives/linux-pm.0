From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 8/8] ACPI / PM: Use existing ACPI iomaps for NVS
	save/restore (v2)
Date: Tue, 25 Jan 2011 00:32:07 +0100
Message-ID: <201101250032.07423.rjw__46941.8450411924$1295912379$gmane$org@sisk.pl>
References: <201101201226.41021.rjw@sisk.pl> <201101250025.10817.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201101250025.10817.rjw@sisk.pl>
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

Modify the NVS save/restore code to use acpi_os_get_iomem() and
acpi_os_unmap_memory() to acquire and release references to ACPI
iomaps, respectively.  If there's no ACPI iomap corresponding to the
given NVS page, acpi_os_ioremap() is used to map that page and
iounmap() is used to unmap it during resume.  [If the page is not
present in the ACPI iomaps already, it doesn't make sense to add its
mapping to the list of ACPI iomaps, because it's going to be thrown
away during the subsequent resume anyway.]

Testing on my HP nx6325 shows that approx. 90% of the NVS pages
have already been mapped by ACPI before suspend and are present in
the ACPI iomaps on this box, so this change appears to be the right
thing to do in general.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/nvs.c |   22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/acpi/nvs.c
===================================================================
--- linux-2.6.orig/drivers/acpi/nvs.c
+++ linux-2.6/drivers/acpi/nvs.c
@@ -26,6 +26,7 @@ struct nvs_page {
 	unsigned int size;
 	void *kaddr;
 	void *data;
+	bool unmap;
 	struct list_head node;
 };
 
@@ -44,6 +45,9 @@ int suspend_nvs_register(unsigned long s
 {
 	struct nvs_page *entry, *next;
 
+	pr_info("PM: Registering ACPI NVS region at %lx (%ld bytes)\n",
+		start, size);
+
 	while (size > 0) {
 		unsigned int nr_bytes;
 
@@ -81,7 +85,13 @@ void suspend_nvs_free(void)
 			free_page((unsigned long)entry->data);
 			entry->data = NULL;
 			if (entry->kaddr) {
-				iounmap(entry->kaddr);
+				if (entry->unmap) {
+					iounmap(entry->kaddr);
+					entry->unmap = false;
+				} else {
+					acpi_os_unmap_memory(entry->kaddr,
+							     entry->size);
+				}
 				entry->kaddr = NULL;
 			}
 		}
@@ -115,8 +125,14 @@ int suspend_nvs_save(void)
 
 	list_for_each_entry(entry, &nvs_list, node)
 		if (entry->data) {
-			entry->kaddr = acpi_os_ioremap(entry->phys_start,
-						    entry->size);
+			unsigned long phys = entry->phys_start;
+			unsigned int size = entry->size;
+
+			entry->kaddr = acpi_os_get_iomem(phys, size);
+			if (!entry->kaddr) {
+				entry->kaddr = acpi_os_ioremap(phys, size);
+				entry->unmap = !!entry->kaddr;
+			}
 			if (!entry->kaddr) {
 				suspend_nvs_free();
 				return -ENOMEM;
