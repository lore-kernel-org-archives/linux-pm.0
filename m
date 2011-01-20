From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 10/11] ACPI / PM: Use existing ACPI iomaps for
	NVS save/restore
Date: Thu, 20 Jan 2011 12:36:36 +0100
Message-ID: <201101201236.37192.rjw__25874.6983985931$1295524900$gmane$org@sisk.pl>
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
the ACPI iomaps, so this change appears to be the right thing to do
in general.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/nvs.c |   19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

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
 
@@ -81,7 +82,13 @@ void suspend_nvs_free(void)
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
@@ -115,8 +122,14 @@ int suspend_nvs_save(void)
 
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
+				entry->unmap = true;
+			}
 			if (!entry->kaddr) {
 				suspend_nvs_free();
 				return -ENOMEM;
