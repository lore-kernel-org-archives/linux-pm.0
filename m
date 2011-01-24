From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 6/8] ACPI: Do not use krefs under a mutex in osl.c
Date: Tue, 25 Jan 2011 00:30:10 +0100
Message-ID: <201101250030.10678.rjw__29879.8420270488$1295912297$gmane$org@sisk.pl>
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

The reference counting of ACPI iomaps is carried out entirely under
acpi_ioremap_lock, so it is sufficient to use simple counters instead
of krefs for this purpose.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/osl.c |   36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

Index: linux-2.6/drivers/acpi/osl.c
===================================================================
--- linux-2.6.orig/drivers/acpi/osl.c
+++ linux-2.6/drivers/acpi/osl.c
@@ -105,7 +105,7 @@ struct acpi_ioremap {
 	void __iomem *virt;
 	acpi_physical_address phys;
 	acpi_size size;
-	struct kref ref;
+	unsigned long refcount;
 };
 
 static LIST_HEAD(acpi_ioremaps);
@@ -319,7 +319,7 @@ acpi_os_map_memory(acpi_physical_address
 	/* Check if there's a suitable mapping already. */
 	map = acpi_map_lookup(phys, size);
 	if (map) {
-		kref_get(&map->ref);
+		map->refcount++;
 		goto out;
 	}
 
@@ -342,7 +342,7 @@ acpi_os_map_memory(acpi_physical_address
 	map->virt = virt;
 	map->phys = pg_off;
 	map->size = pg_sz;
-	kref_init(&map->ref);
+	map->refcount = 1;
 
 	list_add_tail_rcu(&map->list, &acpi_ioremaps);
 
@@ -352,25 +352,24 @@ acpi_os_map_memory(acpi_physical_address
 }
 EXPORT_SYMBOL_GPL(acpi_os_map_memory);
 
-static void acpi_kref_del_iomap(struct kref *ref)
+static void acpi_os_drop_map_ref(struct acpi_ioremap *map)
 {
-	struct acpi_ioremap *map;
-
-	map = container_of(ref, struct acpi_ioremap, ref);
-	list_del_rcu(&map->list);
+	if (!--map->refcount)
+		list_del_rcu(&map->list);
 }
 
-static void acpi_os_remove_map(struct acpi_ioremap *map)
+static void acpi_os_map_cleanup(struct acpi_ioremap *map)
 {
-	synchronize_rcu();
-	iounmap(map->virt);
-	kfree(map);
+	if (!map->refcount) {
+		synchronize_rcu();
+		iounmap(map->virt);
+		kfree(map);
+	}
 }
 
 void __ref acpi_os_unmap_memory(void __iomem *virt, acpi_size size)
 {
 	struct acpi_ioremap *map;
-	int del;
 
 	if (!acpi_gbl_permanent_mmap) {
 		__acpi_unmap_table(virt, size);
@@ -384,11 +383,10 @@ void __ref acpi_os_unmap_memory(void __i
 		WARN(true, PREFIX "%s: bad address %p\n", __func__, virt);
 		return;
 	}
-	del = kref_put(&map->ref, acpi_kref_del_iomap);
+	acpi_os_drop_map_ref(map);
 	mutex_unlock(&acpi_ioremap_lock);
 
-	if (del)
-		acpi_os_remove_map(map);
+	acpi_os_map_cleanup(map);
 }
 EXPORT_SYMBOL_GPL(acpi_os_unmap_memory);
 
@@ -418,7 +416,6 @@ static int acpi_os_map_generic_address(s
 static void acpi_os_unmap_generic_address(struct acpi_generic_address *addr)
 {
 	struct acpi_ioremap *map;
-	int del;
 
 	if (addr->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY)
 		return;
@@ -432,11 +429,10 @@ static void acpi_os_unmap_generic_addres
 		mutex_unlock(&acpi_ioremap_lock);
 		return;
 	}
-	del = kref_put(&map->ref, acpi_kref_del_iomap);
+	acpi_os_drop_map_ref(map);
 	mutex_unlock(&acpi_ioremap_lock);
 
-	if (del)
-		acpi_os_remove_map(map);
+	acpi_os_map_cleanup(map);
 }
 
 #ifdef ACPI_FUTURE_USAGE
