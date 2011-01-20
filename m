From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 5/11] ACPI: Change acpi_ioremap_lock into a mutex
Date: Thu, 20 Jan 2011 12:31:41 +0100
Message-ID: <201101201231.41625.rjw__9258.64552050388$1295524192$gmane$org@sisk.pl>
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

There's no reason why acpi_ioremap_lock has to be a spinlock,
because all of the functions it is used in may sleep anyway and
there's no reason why it should be locked with interrupts off.
Use a mutex instead (that's going to allow us to put some more
operations under the lock later).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/osl.c |   21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

Index: linux-2.6/drivers/acpi/osl.c
===================================================================
--- linux-2.6.orig/drivers/acpi/osl.c
+++ linux-2.6/drivers/acpi/osl.c
@@ -109,7 +109,7 @@ struct acpi_ioremap {
 };
 
 static LIST_HEAD(acpi_ioremaps);
-static DEFINE_SPINLOCK(acpi_ioremap_lock);
+static DEFINE_MUTEX(acpi_ioremap_lock);
 
 static void __init acpi_osi_setup_late(void);
 
@@ -303,7 +303,6 @@ void __iomem *__init_refok
 acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
 {
 	struct acpi_ioremap *map, *tmp_map;
-	unsigned long flags;
 	void __iomem *virt;
 	acpi_physical_address pg_off;
 	acpi_size pg_sz;
@@ -334,18 +333,18 @@ acpi_os_map_memory(acpi_physical_address
 	map->size = pg_sz;
 	kref_init(&map->ref);
 
-	spin_lock_irqsave(&acpi_ioremap_lock, flags);
+	mutex_lock(&acpi_ioremap_lock);
 	/* Check if page has already been mapped. */
 	tmp_map = acpi_map_lookup(phys, size);
 	if (tmp_map) {
 		kref_get(&tmp_map->ref);
-		spin_unlock_irqrestore(&acpi_ioremap_lock, flags);
+		mutex_unlock(&acpi_ioremap_lock);
 		iounmap(map->virt);
 		kfree(map);
 		return tmp_map->virt + (phys - tmp_map->phys);
 	}
 	list_add_tail_rcu(&map->list, &acpi_ioremaps);
-	spin_unlock_irqrestore(&acpi_ioremap_lock, flags);
+	mutex_unlock(&acpi_ioremap_lock);
 
 	return map->virt + (phys - map->phys);
 }
@@ -362,7 +361,6 @@ static void acpi_kref_del_iomap(struct k
 void __ref acpi_os_unmap_memory(void __iomem *virt, acpi_size size)
 {
 	struct acpi_ioremap *map;
-	unsigned long flags;
 	int del;
 
 	if (!acpi_gbl_permanent_mmap) {
@@ -370,17 +368,17 @@ void __ref acpi_os_unmap_memory(void __i
 		return;
 	}
 
-	spin_lock_irqsave(&acpi_ioremap_lock, flags);
+	mutex_lock(&acpi_ioremap_lock);
 	map = acpi_map_lookup_virt(virt, size);
 	if (!map) {
-		spin_unlock_irqrestore(&acpi_ioremap_lock, flags);
+		mutex_unlock(&acpi_ioremap_lock);
 		printk(KERN_ERR PREFIX "%s: bad address %p\n", __func__, virt);
 		dump_stack();
 		return;
 	}
 
 	del = kref_put(&map->ref, acpi_kref_del_iomap);
-	spin_unlock_irqrestore(&acpi_ioremap_lock, flags);
+	mutex_unlock(&acpi_ioremap_lock);
 
 	if (!del)
 		return;
@@ -417,7 +415,6 @@ static int acpi_os_map_generic_address(s
 static void acpi_os_unmap_generic_address(struct acpi_generic_address *addr)
 {
 	void __iomem *virt;
-	unsigned long flags;
 	acpi_size size = addr->bit_width / 8;
 
 	if (addr->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY)
@@ -426,9 +423,9 @@ static void acpi_os_unmap_generic_addres
 	if (!addr->address || !addr->bit_width)
 		return;
 
-	spin_lock_irqsave(&acpi_ioremap_lock, flags);
+	mutex_lock(&acpi_ioremap_lock);
 	virt = acpi_map_vaddr_lookup(addr->address, size);
-	spin_unlock_irqrestore(&acpi_ioremap_lock, flags);
+	mutex_unlock(&acpi_ioremap_lock);
 
 	acpi_os_unmap_memory(virt, size);
 }
