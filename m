From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 6/10] ACPI / PCI: Negotiate _OSC control bits
	before requesting them
Date: Sat, 21 Aug 2010 01:55:31 +0200
Message-ID: <201008210155.31915.rjw__41445.6861828969$1282349516$gmane$org@sisk.pl>
References: <201008060303.51224.rjw@sisk.pl> <201008210149.39576.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201008210149.39576.rjw@sisk.pl>
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
Cc: linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, linux-pm@lists.linux-foundation.org, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

It is possible that the BIOS will not grant control of all _OSC
features requested via acpi_pci_osc_control_set(), so it is
recommended to negotiate the final set of _OSC features with the
query flag set before calling _OSC to request control of these
features.

To implement it, rework acpi_pci_osc_control_set() so that the caller
can specify the mask of _OSC control bits to negotiate and the mask
of _OSC control bits that are absolutely necessary to it.  Then,
acpi_pci_osc_control_set() will run _OSC queries in a loop until
the mask of _OSC control bits returned by the BIOS is equal to the
mask passed to it.  Also, before running the _OSC request
acpi_pci_osc_control_set() will check if the caller's required
control bits are present in the final mask.

Using this mechanism we will be able to avoid situations in which the
BIOS doesn't grant control of certain _OSC features, because they
depend on some other _OSC features that have not been requested.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/pci_root.c              |   56 +++++++++++++++++++++--------------
 drivers/pci/hotplug/acpi_pcihp.c     |    2 -
 drivers/pci/pcie/aer/aerdrv_acpi.c   |    6 +--
 drivers/pci/pcie/pme/pcie_pme_acpi.c |    8 +++--
 include/linux/acpi.h                 |    4 +-
 5 files changed, 46 insertions(+), 30 deletions(-)

Index: linux-2.6/drivers/acpi/pci_root.c
===================================================================
--- linux-2.6.orig/drivers/acpi/pci_root.c
+++ linux-2.6/drivers/acpi/pci_root.c
@@ -374,21 +374,32 @@ out:
 EXPORT_SYMBOL_GPL(acpi_get_pci_dev);
 
 /**
- * acpi_pci_osc_control_set - commit requested control to Firmware
- * @handle: acpi_handle for the target ACPI object
- * @flags: driver's requested control bits
+ * acpi_pci_osc_control_set - Request control of PCI root _OSC features.
+ * @handle: ACPI handle of a PCI root bridge (or PCIe Root Complex).
+ * @mask: Mask of _OSC bits to request control of, place to store control mask.
+ * @req: Mask of _OSC bits the control of is essential to the caller.
  *
- * Attempt to take control from Firmware on requested control bits.
+ * Run _OSC query for @mask and if that is successful, compare the returned
+ * mask of control bits with @req.  If all of the @req bits are set in the
+ * returned mask, run _OSC request for it.
+ *
+ * The variable at the @mask address may be modified regardless of whether or
+ * not the function returns success.  On success it will contain the mask of
+ * _OSC bits the BIOS has granted control of, but its contents are meaningless
+ * on failure.
  **/
-acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 flags)
+acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 req)
 {
+	struct acpi_pci_root *root;
 	acpi_status status;
-	u32 control_req, result, capbuf[3];
+	u32 ctrl, capbuf[3];
 	acpi_handle tmp;
-	struct acpi_pci_root *root;
 
-	control_req = (flags & OSC_PCI_CONTROL_MASKS);
-	if (!control_req)
+	if (!mask)
+		return AE_BAD_PARAMETER;
+
+	ctrl = *mask & OSC_PCI_CONTROL_MASKS;
+	if ((ctrl & req) != req)
 		return AE_TYPE;
 
 	root = acpi_pci_find_root(handle);
@@ -400,27 +411,30 @@ acpi_status acpi_pci_osc_control_set(acp
 		return status;
 
 	mutex_lock(&osc_lock);
+
+	*mask |= root->osc_control_set;
 	/* No need to evaluate _OSC if the control was already granted. */
-	if ((root->osc_control_set & control_req) == control_req)
+	if ((root->osc_control_set & ctrl) == ctrl)
 		goto out;
 
-	/* Need to query controls first before requesting them */
-	flags = control_req;
-	status = acpi_pci_query_osc(root, root->osc_support_set, &flags);
-	if (ACPI_FAILURE(status))
-		goto out;
+	/* Need to check the available controls bits before requesting them. */
+	for (ctrl = 0; *mask != ctrl; ctrl = *mask) {
+		status = acpi_pci_query_osc(root, root->osc_support_set, mask);
+		if (ACPI_FAILURE(status))
+			goto out;
+	}
 
-	if (flags != control_req) {
+	if ((ctrl & req) != req) {
 		status = AE_SUPPORT;
 		goto out;
 	}
 
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
@@ -551,8 +565,8 @@ static int __devinit acpi_pci_root_add(s
 	if (flags != base_flags)
 		acpi_pci_osc_support(root, flags);
 
-	status = acpi_pci_osc_control_set(root->device->handle,
-					  OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL);
+	flags = OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL;
+	status = acpi_pci_osc_control_set(root->device->handle, &flags, flags);
 
 	if (ACPI_FAILURE(status)) {
 		printk(KERN_INFO "Unable to assume PCIe control: Disabling ASPM\n");
Index: linux-2.6/include/linux/acpi.h
===================================================================
--- linux-2.6.orig/include/linux/acpi.h
+++ linux-2.6/include/linux/acpi.h
@@ -304,8 +304,8 @@ acpi_status acpi_run_osc(acpi_handle han
 				OSC_PCI_EXPRESS_PME_CONTROL |		\
 				OSC_PCI_EXPRESS_AER_CONTROL |		\
 				OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL)
-
-extern acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 flags);
+extern acpi_status acpi_pci_osc_control_set(acpi_handle handle,
+					     u32 *mask, u32 req);
 extern void acpi_early_init(void);
 
 #else	/* !CONFIG_ACPI */
Index: linux-2.6/drivers/pci/pcie/aer/aerdrv_acpi.c
===================================================================
--- linux-2.6.orig/drivers/pci/pcie/aer/aerdrv_acpi.c
+++ linux-2.6/drivers/pci/pcie/aer/aerdrv_acpi.c
@@ -39,9 +39,9 @@ int aer_osc_setup(struct pcie_device *pc
 
 	handle = acpi_find_root_bridge_handle(pdev);
 	if (handle) {
-		status = acpi_pci_osc_control_set(handle,
-					OSC_PCI_EXPRESS_AER_CONTROL |
-					OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL);
+		u32 flags = OSC_PCI_EXPRESS_AER_CONTROL |
+				OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL;
+		status = acpi_pci_osc_control_set(handle, &flags, flags);
 	}
 
 	if (ACPI_FAILURE(status)) {
Index: linux-2.6/drivers/pci/pcie/pme/pcie_pme_acpi.c
===================================================================
--- linux-2.6.orig/drivers/pci/pcie/pme/pcie_pme_acpi.c
+++ linux-2.6/drivers/pci/pcie/pme/pcie_pme_acpi.c
@@ -28,6 +28,7 @@ int pcie_pme_acpi_setup(struct pcie_devi
 	acpi_status status = AE_NOT_FOUND;
 	struct pci_dev *port = srv->port;
 	acpi_handle handle;
+	u32 flags;
 	int error = 0;
 
 	if (acpi_pci_disabled)
@@ -39,9 +40,10 @@ int pcie_pme_acpi_setup(struct pcie_devi
 	if (!handle)
 		return -EINVAL;
 
-	status = acpi_pci_osc_control_set(handle,
-			OSC_PCI_EXPRESS_PME_CONTROL |
-			OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL);
+	flags = OSC_PCI_EXPRESS_PME_CONTROL |
+		OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL;
+
+	status = acpi_pci_osc_control_set(handle, &flags, flags);
 	if (ACPI_FAILURE(status)) {
 		dev_info(&port->dev,
 			"Failed to receive control of PCIe PME service: %s\n",
Index: linux-2.6/drivers/pci/hotplug/acpi_pcihp.c
===================================================================
--- linux-2.6.orig/drivers/pci/hotplug/acpi_pcihp.c
+++ linux-2.6/drivers/pci/hotplug/acpi_pcihp.c
@@ -360,7 +360,7 @@ int acpi_get_hp_hw_control_from_firmware
 		acpi_get_name(handle, ACPI_FULL_PATHNAME, &string);
 		dbg("Trying to get hotplug control for %s\n",
 				(char *)string.pointer);
-		status = acpi_pci_osc_control_set(handle, flags);
+		status = acpi_pci_osc_control_set(handle, &flags, flags);
 		if (ACPI_SUCCESS(status))
 			goto got_one;
 		if (status == AE_SUPPORT)
