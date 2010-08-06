From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 10/10] ACPI / PCI: Merge
	acpi_pci_osc_control_{query|set}()
Date: Fri, 6 Aug 2010 03:15:40 +0200
Message-ID: <201008060315.40437.rjw__43250.2938820564$1281058650$gmane$org@sisk.pl>
References: <201008060303.51224.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201008060303.51224.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, linux-pm@lists.linux-foundation.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The both of the existing callers of acpi_pci_osc_control_query()
and acpi_pci_osc_control_set() have the same structure, such that
acpi_pci_osc_control_query() is called first for certain mask of
control bits, then the mask returned by it is tested against a given
subset of the queried control bits and if that test is successful,
acpi_pci_osc_control_set() is run for the mask of control bits
returned by acpi_pci_osc_control_query().  Thus it is possible to
move the initial query as well as the subsequent test to
acpi_pci_osc_control_set() and simplify its callers.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/pci_root.c          |   75 ++++++++++++++-------------------------
 drivers/pci/hotplug/acpi_pcihp.c |    9 ++--
 drivers/pci/pcie/portdrv_acpi.c  |   16 +-------
 include/linux/acpi.h             |    4 +-
 4 files changed, 36 insertions(+), 68 deletions(-)

Index: linux-2.6/drivers/acpi/pci_root.c
===================================================================
--- linux-2.6.orig/drivers/acpi/pci_root.c
+++ linux-2.6/drivers/acpi/pci_root.c
@@ -372,21 +372,35 @@ out:
 }
 EXPORT_SYMBOL_GPL(acpi_get_pci_dev);
 
- /**
- * acpi_pci_osc_control_query - Get the _OSC bits the kernel can control.
+/**
+ * acpi_pci_osc_control_set - Request control of PCI root _OSC features.
  * @handle: ACPI handle of a PCI root bridge (or PCIe Root Complex).
- * @mask: Mask of _OSC bits to query and the place to put the result into.
+ * @mask: Mask of _OSC bits to request control of, place to store control mask.
+ * @req: Mask of _OSC bits the control of is essential to the caller.
+ *
+ * Run _OSC query for @mask and if that is successful, compare the returned
+ * mask of control bits with @req.  If all of the @req bits are set in the
+ * returned mask, run _OSC request for it.
+ *
+ * The variable at the @mask address may be modified regardless of whether or
+ * not the function returns success.  On success it will contain the mask of
+ * _OSC bits the BIOS has granted control of, but its contents are meaningless
+ * on failure.
  **/
-acpi_status acpi_pci_osc_control_query(acpi_handle handle, u32 *mask)
+acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 req)
 {
 	struct acpi_pci_root *root;
+	acpi_status status;
+	u32 ctrl, flags, capbuf[3];
 	acpi_handle tmp;
-	acpi_status status = AE_OK;
-	u32 ctrl = *mask;
 
-	if (!(ctrl & OSC_PCI_CONTROL_MASKS))
+	if (!mask)
 		return AE_BAD_PARAMETER;
 
+	ctrl = *mask & OSC_PCI_CONTROL_MASKS;
+	if ((ctrl & req) != req)
+		return AE_TYPE;
+
 	root = acpi_pci_find_root(handle);
 	if (!root)
 		return AE_NOT_EXIST;
@@ -404,53 +418,20 @@ acpi_status acpi_pci_osc_control_query(a
 	for (ctrl = 0; *mask != ctrl; ctrl = *mask) {
 		status = acpi_pci_query_osc(root, root->osc_support_set, mask);
 		if (ACPI_FAILURE(status))
-			break;
+			goto out;
 	}
 
- out:
-	mutex_unlock(&osc_lock);
-
-	return status;
-}
-EXPORT_SYMBOL(acpi_pci_osc_control_query);
-
-/**
- * acpi_pci_osc_control_set - commit requested control to Firmware
- * @handle: acpi_handle for the target ACPI object
- * @flags: driver's requested control bits
- *
- * Attempt to take control from Firmware on requested control bits.
- **/
-acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 flags)
-{
-	acpi_status status;
-	u32 control_req, result, capbuf[3];
-	acpi_handle tmp;
-	struct acpi_pci_root *root;
-
-	control_req = (flags & OSC_PCI_CONTROL_MASKS);
-	if (!control_req)
-		return AE_TYPE;
-
-	root = acpi_pci_find_root(handle);
-	if (!root)
-		return AE_NOT_EXIST;
-
-	status = acpi_get_handle(handle, "_OSC", &tmp);
-	if (ACPI_FAILURE(status))
-		return status;
-
-	mutex_lock(&osc_lock);
-	/* No need to evaluate _OSC if the control was already granted. */
-	if ((root->osc_control_set & control_req) == control_req)
+	if ((ctrl & req) != req) {
+		status = AE_SUPPORT;
 		goto out;
+	}
 
 	capbuf[OSC_QUERY_TYPE] = 0;
 	capbuf[OSC_SUPPORT_TYPE] = root->osc_support_set;
-	capbuf[OSC_CONTROL_TYPE] = root->osc_control_set | control_req;
-	status = acpi_pci_run_osc(handle, capbuf, &result);
+	capbuf[OSC_CONTROL_TYPE] = ctrl;
+	status = acpi_pci_run_osc(handle, capbuf, mask);
 	if (ACPI_SUCCESS(status))
-		root->osc_control_set = result;
+		root->osc_control_set = *mask;
 out:
 	mutex_unlock(&osc_lock);
 	return status;
Index: linux-2.6/include/linux/acpi.h
===================================================================
--- linux-2.6.orig/include/linux/acpi.h
+++ linux-2.6/include/linux/acpi.h
@@ -305,8 +305,8 @@ acpi_status acpi_run_osc(acpi_handle han
 				OSC_PCI_EXPRESS_AER_CONTROL |		\
 				OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL)
 
-extern acpi_status acpi_pci_osc_control_query(acpi_handle handle, u32 *mask);
-extern acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 flags);
+extern acpi_status acpi_pci_osc_control_set(acpi_handle handle,
+					     u32 *mask, u32 req);
 extern void acpi_early_init(void);
 
 #else	/* !CONFIG_ACPI */
Index: linux-2.6/drivers/pci/pcie/portdrv_acpi.c
===================================================================
--- linux-2.6.orig/drivers/pci/pcie/portdrv_acpi.c
+++ linux-2.6/drivers/pci/pcie/portdrv_acpi.c
@@ -55,20 +55,8 @@ int pcie_port_acpi_setup(struct pci_dev 
 			flags |= OSC_PCI_EXPRESS_AER_CONTROL;
 	}
 
-	status = acpi_pci_osc_control_query(handle, &flags);
-	if (ACPI_FAILURE(status)) {
-		dev_dbg(&port->dev, "ACPI _OSC query failed (code %d)\n",
-			status);
-		return -ENODEV;
-	}
-
-	if (!(flags & OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL)) {
-		dev_dbg(&port->dev, "BIOS refuses to grant control of PCIe "
-			"Capability Structure\n");
-		return -EACCES;
-	}
-
-	status = acpi_pci_osc_control_set(handle, flags);
+	status = acpi_pci_osc_control_set(handle, &flags,
+					OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL);
 	if (ACPI_FAILURE(status)) {
 		dev_dbg(&port->dev, "ACPI _OSC request failed (code %d)\n",
 			status);
Index: linux-2.6/drivers/pci/hotplug/acpi_pcihp.c
===================================================================
--- linux-2.6.orig/drivers/pci/hotplug/acpi_pcihp.c
+++ linux-2.6/drivers/pci/hotplug/acpi_pcihp.c
@@ -358,13 +358,12 @@ int acpi_get_hp_hw_control_from_firmware
 		acpi_get_name(handle, ACPI_FULL_PATHNAME, &string);
 		dbg("Trying to get hotplug control for %s\n",
 				(char *)string.pointer);
-		status = acpi_pci_osc_control_query(handle, &flags);
-		if (ACPI_FAILURE(status)
-		    || !(flags & OSC_SHPC_NATIVE_HP_CONTROL))
-			goto no_control;
-		status = acpi_pci_osc_control_set(handle, flags);
+		status = acpi_pci_osc_control_set(handle, &flags,
+						OSC_SHPC_NATIVE_HP_CONTROL);
 		if (ACPI_SUCCESS(status))
 			goto got_one;
+		if (status == AE_SUPPORT)
+			goto no_control;
 		kfree(string.pointer);
 		string = (struct acpi_buffer){ ACPI_ALLOCATE_BUFFER, NULL };
 	}
