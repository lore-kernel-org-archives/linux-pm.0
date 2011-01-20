From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 6/11] ACPI: Avoid walking the list of iomaps in
	osl.c twice in a row
Date: Thu, 20 Jan 2011 12:32:41 +0100
Message-ID: <201101201232.41628.rjw__10635.8318393633$1295524187$gmane$org@sisk.pl>
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

Make acpi_os_unmap_generic_address() use acpi_map_lookup() to find
the desired iomap and drop the reference to it directly (and
eventually remove it if necessary) instead of calling
acpi_os_unmap_memory(), which requires us to walk the list of ACPI
iomaps twice in a row (first, to get the virtual address associated
with the iomap and second, to get the iomap itself).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/osl.c |   33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

Index: linux-2.6/drivers/acpi/osl.c
===================================================================
--- linux-2.6.orig/drivers/acpi/osl.c
+++ linux-2.6/drivers/acpi/osl.c
@@ -358,6 +358,13 @@ static void acpi_kref_del_iomap(struct k
 	list_del_rcu(&map->list);
 }
 
+static void acpi_os_remove_map(struct acpi_ioremap *map)
+{
+	synchronize_rcu();
+	iounmap(map->virt);
+	kfree(map);
+}
+
 void __ref acpi_os_unmap_memory(void __iomem *virt, acpi_size size)
 {
 	struct acpi_ioremap *map;
@@ -372,20 +379,14 @@ void __ref acpi_os_unmap_memory(void __i
 	map = acpi_map_lookup_virt(virt, size);
 	if (!map) {
 		mutex_unlock(&acpi_ioremap_lock);
-		printk(KERN_ERR PREFIX "%s: bad address %p\n", __func__, virt);
-		dump_stack();
+		WARN(true, PREFIX "%s: bad address %p\n", __func__, virt);
 		return;
 	}
-
 	del = kref_put(&map->ref, acpi_kref_del_iomap);
 	mutex_unlock(&acpi_ioremap_lock);
 
-	if (!del)
-		return;
-
-	synchronize_rcu();
-	iounmap(map->virt);
-	kfree(map);
+	if (del)
+		acpi_os_remove_map(map);
 }
 EXPORT_SYMBOL_GPL(acpi_os_unmap_memory);
 
@@ -414,8 +415,8 @@ static int acpi_os_map_generic_address(s
 
 static void acpi_os_unmap_generic_address(struct acpi_generic_address *addr)
 {
-	void __iomem *virt;
-	acpi_size size = addr->bit_width / 8;
+	struct acpi_ioremap *map;
+	int del;
 
 	if (addr->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY)
 		return;
@@ -424,10 +425,16 @@ static void acpi_os_unmap_generic_addres
 		return;
 
 	mutex_lock(&acpi_ioremap_lock);
-	virt = acpi_map_vaddr_lookup(addr->address, size);
+	map = acpi_map_lookup(addr->address, addr->bit_width / 8);
+	if (!map) {
+		mutex_unlock(&acpi_ioremap_lock);
+		return;
+	}
+	del = kref_put(&map->ref, acpi_kref_del_iomap);
 	mutex_unlock(&acpi_ioremap_lock);
 
-	acpi_os_unmap_memory(virt, size);
+	if (del)
+		acpi_os_remove_map(map);
 }
 
 #ifdef ACPI_FUTURE_USAGE
