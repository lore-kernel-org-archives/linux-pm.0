From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 7/8] ACPI / PCI: Do not preserve _OSC control
	bits returned by a query (v2)
Date: Mon, 2 Aug 2010 23:59:32 +0200
Message-ID: <201008022359.33177.rjw__46971.2414815605$1280787979$gmane$org@sisk.pl>
References: <201008022351.31406.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201008022351.31406.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, linux-pci@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

All of the remaining callers of acpi_pci_osc_control_set() either
use acpi_pci_root_osc_query() right before it, like
pcie_port_acpi_setup(), or ask for control of one feature only,
like acpi_get_hp_hw_control_from_firmware().  Thus there is no
reason to preserve the _OSC control bits returned by an _OSC query
and the osc_control_qry and osc_queried fields of struct
acpi_pci_root are not necessary any more.  Remove them and modify the
code that uses them accordingly.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Reviewed-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
---
 drivers/acpi/pci_root.c |   15 ---------------
 include/acpi/acpi_bus.h |    3 ---
 2 files changed, 18 deletions(-)

Index: linux-2.6/drivers/acpi/pci_root.c
===================================================================
--- linux-2.6.orig/drivers/acpi/pci_root.c
+++ linux-2.6/drivers/acpi/pci_root.c
@@ -248,10 +248,8 @@ static acpi_status acpi_pci_query_osc(st
 	status = acpi_pci_run_osc(root->device->handle, capbuf, &result);
 	if (ACPI_SUCCESS(status)) {
 		root->osc_support_set = support;
-		root->osc_control_qry = result;
 		if (control)
 			*control = result;
-		root->osc_queried = 1;
 	}
 	return status;
 }
@@ -434,19 +432,6 @@ acpi_status acpi_pci_osc_control_set(acp
 	if ((root->osc_control_set & control_req) == control_req)
 		goto out;
 
-	/* Need to query controls first before requesting them */
-	if (!root->osc_queried) {
-		status = acpi_pci_query_osc(root, root->osc_support_set, NULL);
-		if (ACPI_FAILURE(status))
-			goto out;
-	}
-	if ((root->osc_control_qry & control_req) != control_req) {
-		printk(KERN_DEBUG
-		       "Firmware did not grant requested _OSC control\n");
-		status = AE_SUPPORT;
-		goto out;
-	}
-
 	capbuf[OSC_QUERY_TYPE] = 0;
 	capbuf[OSC_SUPPORT_TYPE] = root->osc_support_set;
 	capbuf[OSC_CONTROL_TYPE] = root->osc_control_set | control_req;
Index: linux-2.6/include/acpi/acpi_bus.h
===================================================================
--- linux-2.6.orig/include/acpi/acpi_bus.h
+++ linux-2.6/include/acpi/acpi_bus.h
@@ -377,9 +377,6 @@ struct acpi_pci_root {
 
 	u32 osc_support_set;	/* _OSC state of support bits */
 	u32 osc_control_set;	/* _OSC state of control bits */
-	u32 osc_control_qry;	/* the latest _OSC query result */
-
-	u32 osc_queried:1;	/* has _OSC control been queried? */
 };
 
 /* helper */
