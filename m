From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/8] ACPI: Do not export functions that are only
	used in osl.c
Date: Tue, 25 Jan 2011 00:27:37 +0100
Message-ID: <201101250027.37509.rjw__5870.48232923752$1295912054$gmane$org@sisk.pl>
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

The functions acpi_os_map_generic_address() and
acpi_os_unmap_generic_address() are only used in drivers/acpi/osl.c,
so make them static and remove the extern definitions of them from
include/linux/acpi_io.h.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/osl.c      |    6 ++----
 include/linux/acpi_io.h |    3 ---
 2 files changed, 2 insertions(+), 7 deletions(-)

Index: linux-2.6/drivers/acpi/osl.c
===================================================================
--- linux-2.6.orig/drivers/acpi/osl.c
+++ linux-2.6/drivers/acpi/osl.c
@@ -397,7 +397,7 @@ void __init early_acpi_os_unmap_memory(v
 		__acpi_unmap_table(virt, size);
 }
 
-int acpi_os_map_generic_address(struct acpi_generic_address *addr)
+static int acpi_os_map_generic_address(struct acpi_generic_address *addr)
 {
 	void __iomem *virt;
 
@@ -413,9 +413,8 @@ int acpi_os_map_generic_address(struct a
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(acpi_os_map_generic_address);
 
-void acpi_os_unmap_generic_address(struct acpi_generic_address *addr)
+static void acpi_os_unmap_generic_address(struct acpi_generic_address *addr)
 {
 	void __iomem *virt;
 	unsigned long flags;
@@ -433,7 +432,6 @@ void acpi_os_unmap_generic_address(struc
 
 	acpi_os_unmap_memory(virt, size);
 }
-EXPORT_SYMBOL_GPL(acpi_os_unmap_generic_address);
 
 #ifdef ACPI_FUTURE_USAGE
 acpi_status
Index: linux-2.6/include/linux/acpi_io.h
===================================================================
--- linux-2.6.orig/include/linux/acpi_io.h
+++ linux-2.6/include/linux/acpi_io.h
@@ -10,7 +10,4 @@ static inline void __iomem *acpi_os_iore
        return ioremap_cache(phys, size);
 }
 
-int acpi_os_map_generic_address(struct acpi_generic_address *addr);
-void acpi_os_unmap_generic_address(struct acpi_generic_address *addr);
-
 #endif
