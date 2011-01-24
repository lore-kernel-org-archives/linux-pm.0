From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/8] ACPI: Fix acpi_os_read_memory() and
	acpi_os_write_memory() (v2)
Date: Tue, 25 Jan 2011 00:26:47 +0100
Message-ID: <201101250026.47590.rjw__2741.19297178022$1295912208$gmane$org@sisk.pl>
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

The functions acpi_os_read_memory() and acpi_os_write_memory() do
two wrong things.  First, they shouldn't call rcu_read_unlock()
before the looked up address is actually used for I/O, because in
that case the iomap it belongs to may be removed before the I/O
is done.  Second, if they have to create a new mapping, they should
check the returned virtual address and tell the caller that the
operation failed if it is NULL (in fact, I think they even should not
attempt to map an address that's not present in one of the existing
ACPI iomaps, because that may cause problems to happen when they are
called from nonpreemptible context and their callers ought to know
what they are doing and map the requisite memory regions beforehand).

Make these functions call rcu_read_unlock() when the I/O is complete
(or if it's necessary to map the given address "on the fly") and
return an error code if the requested physical address is not present
in the existing ACPI iomaps and cannot be mapped.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/osl.c |   25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

Index: linux-2.6/drivers/acpi/osl.c
===================================================================
--- linux-2.6.orig/drivers/acpi/osl.c
+++ linux-2.6/drivers/acpi/osl.c
@@ -636,17 +636,21 @@ EXPORT_SYMBOL(acpi_os_write_port);
 acpi_status
 acpi_os_read_memory(acpi_physical_address phys_addr, u32 * value, u32 width)
 {
-	u32 dummy;
 	void __iomem *virt_addr;
-	int size = width / 8, unmap = 0;
+	unsigned int size = width / 8;
+	bool unmap = false;
+	u32 dummy;
 
 	rcu_read_lock();
 	virt_addr = acpi_map_vaddr_lookup(phys_addr, size);
-	rcu_read_unlock();
 	if (!virt_addr) {
+		rcu_read_unlock();
 		virt_addr = acpi_os_ioremap(phys_addr, size);
-		unmap = 1;
+		if (!virt_addr)
+			return AE_BAD_ADDRESS;
+		unmap = true;
 	}
+
 	if (!value)
 		value = &dummy;
 
@@ -666,6 +670,8 @@ acpi_os_read_memory(acpi_physical_addres
 
 	if (unmap)
 		iounmap(virt_addr);
+	else
+		rcu_read_unlock();
 
 	return AE_OK;
 }
@@ -674,14 +680,17 @@ acpi_status
 acpi_os_write_memory(acpi_physical_address phys_addr, u32 value, u32 width)
 {
 	void __iomem *virt_addr;
-	int size = width / 8, unmap = 0;
+	unsigned int size = width / 8;
+	bool unmap = false;
 
 	rcu_read_lock();
 	virt_addr = acpi_map_vaddr_lookup(phys_addr, size);
-	rcu_read_unlock();
 	if (!virt_addr) {
+		rcu_read_unlock();
 		virt_addr = acpi_os_ioremap(phys_addr, size);
-		unmap = 1;
+		if (!virt_addr)
+			return AE_BAD_ADDRESS;
+		unmap = true;
 	}
 
 	switch (width) {
@@ -700,6 +709,8 @@ acpi_os_write_memory(acpi_physical_addre
 
 	if (unmap)
 		iounmap(virt_addr);
+	else
+		rcu_read_unlock();
 
 	return AE_OK;
 }
