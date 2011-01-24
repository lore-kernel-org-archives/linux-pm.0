From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 7/8] ACPI: Introduce acpi_os_get_iomem()
Date: Tue, 25 Jan 2011 00:30:52 +0100
Message-ID: <201101250030.53131.rjw__20411.5620967515$1295912337$gmane$org@sisk.pl>
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

Introduce function acpi_os_get_iomem() that may be used by its callers
to get a reference to an ACPI iomap.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/osl.c      |   16 ++++++++++++++++
 include/linux/acpi_io.h |    2 ++
 2 files changed, 18 insertions(+)

Index: linux-2.6/drivers/acpi/osl.c
===================================================================
--- linux-2.6.orig/drivers/acpi/osl.c
+++ linux-2.6/drivers/acpi/osl.c
@@ -285,6 +285,22 @@ acpi_map_vaddr_lookup(acpi_physical_addr
 	return NULL;
 }
 
+void __iomem *acpi_os_get_iomem(acpi_physical_address phys, unsigned int size)
+{
+	struct acpi_ioremap *map;
+	void __iomem *virt = NULL;
+
+	mutex_lock(&acpi_ioremap_lock);
+	map = acpi_map_lookup(phys, size);
+	if (map) {
+		virt = map->virt + (phys - map->phys);
+		map->refcount++;
+	}
+	mutex_unlock(&acpi_ioremap_lock);
+	return virt;
+}
+EXPORT_SYMBOL_GPL(acpi_os_get_iomem);
+
 /* Must be called with 'acpi_ioremap_lock' or RCU read lock held. */
 static struct acpi_ioremap *
 acpi_map_lookup_virt(void __iomem *virt, acpi_size size)
Index: linux-2.6/include/linux/acpi_io.h
===================================================================
--- linux-2.6.orig/include/linux/acpi_io.h
+++ linux-2.6/include/linux/acpi_io.h
@@ -10,4 +10,6 @@ static inline void __iomem *acpi_os_iore
        return ioremap_cache(phys, size);
 }
 
+void __iomem *acpi_os_get_iomem(acpi_physical_address phys, unsigned int size);
+
 #endif
