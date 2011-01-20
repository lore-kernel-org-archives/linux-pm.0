From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/11] ACPI: Fix acpi_os_read_memory() and
	acpi_os_write_memory()
Date: Thu, 20 Jan 2011 12:30:09 +0100
Message-ID: <201101201230.10048.rjw__4923.94219986654$1295524172$gmane$org@sisk.pl>
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

The functions acpi_os_read_memory() and acpi_os_write_memory() do
two wrong things.  First, they shouldn't call rcu_read_unlock()
before the looked up address is actually used for I/O, because in
that case the mapping it belongs to may be removed before the I/O
is done.  Second, they shouldn't use the physical address if
there's no mapping for it, because that may lead to problems (at
least for the "write" case it's like sending data to a random
physical address in the hope it's going to work).

Make the rcu_read_unlock() be called by these functions when the I/O
is complete and modify them to dump stack and return error code if
the requested physical address is not present in the ACPI iomaps.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/osl.c |   31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

Index: linux-2.6/drivers/acpi/osl.c
===================================================================
--- linux-2.6.orig/drivers/acpi/osl.c
+++ linux-2.6/drivers/acpi/osl.c
@@ -638,17 +638,17 @@ acpi_os_read_memory(acpi_physical_addres
 {
 	u32 dummy;
 	void __iomem *virt_addr;
-	int size = width / 8, unmap = 0;
+
+	if (!value)
+		value = &dummy;
 
 	rcu_read_lock();
-	virt_addr = acpi_map_vaddr_lookup(phys_addr, size);
-	rcu_read_unlock();
+	virt_addr = acpi_map_vaddr_lookup(phys_addr, width / 8);
 	if (!virt_addr) {
-		virt_addr = acpi_os_ioremap(phys_addr, size);
-		unmap = 1;
+		rcu_read_unlock();
+		WARN(true, "Address not mapped: %llx\n", phys_addr);
+		return AE_BAD_ADDRESS;
 	}
-	if (!value)
-		value = &dummy;
 
 	switch (width) {
 	case 8:
@@ -663,9 +663,7 @@ acpi_os_read_memory(acpi_physical_addres
 	default:
 		BUG();
 	}
-
-	if (unmap)
-		iounmap(virt_addr);
+	rcu_read_unlock();
 
 	return AE_OK;
 }
@@ -674,14 +672,13 @@ acpi_status
 acpi_os_write_memory(acpi_physical_address phys_addr, u32 value, u32 width)
 {
 	void __iomem *virt_addr;
-	int size = width / 8, unmap = 0;
 
 	rcu_read_lock();
-	virt_addr = acpi_map_vaddr_lookup(phys_addr, size);
-	rcu_read_unlock();
+	virt_addr = acpi_map_vaddr_lookup(phys_addr, width / 8);
 	if (!virt_addr) {
-		virt_addr = acpi_os_ioremap(phys_addr, size);
-		unmap = 1;
+		rcu_read_unlock();
+		WARN(true, "Address not mapped: %llx\n", phys_addr);
+		return AE_BAD_ADDRESS;
 	}
 
 	switch (width) {
@@ -697,9 +694,7 @@ acpi_os_write_memory(acpi_physical_addre
 	default:
 		BUG();
 	}
-
-	if (unmap)
-		iounmap(virt_addr);
+	rcu_read_unlock();
 
 	return AE_OK;
 }
