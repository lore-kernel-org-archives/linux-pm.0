From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: Re: [PATCH 7/8] ACPI / PCI: Do not preserve _OSC control
 bits returned by a query (v2)
Date: Wed, 04 Aug 2010 17:43:59 +0900
Message-ID: <4C59284F.9080808__34878.2871537425$1280911627$gmane$org@jp.fujitsu.com>
References: <201008022351.31406.rjw@sisk.pl> <4C57C182.7060407@jp.fujitsu.com>
	<201008031133.37471.rjw@sisk.pl> <201008032302.33778.rjw@sisk.pl>
	<4C58FE9A.1040607@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C58FE9A.1040607@jp.fujitsu.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, linux-pm@lists.linux-foundation.org, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

(2010/08/04 14:46), Kenji Kaneshige wrote:
> By the way, I think it is getting confusing regarding who query the
> controls. IMO, querying controls to ensure all the requested controls
> are granted to OS should be done in acpi_pci_osc_control_set(), as
> I said above. On the other hand, PCIe port driver need to query
> controls for other reason... Now I think it might be better to change
> acpi_pci_osc_control_set() like below instead of introducing
> acpi_pci_osc_control_query().
> 
> acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *flags)
> {
>     ...
>     query = control_req;
>     status = acpi_pci_query_osc(root, root->osc_support_set, &query);
>     if (ACPI_FAILURE(status))
>         goto out;
>     if ((query & control_req) != control_req) {
>         printk_(KERN_DEBUG
>             "Firmware did not grant requested _OSC control\n");
>         status = AE_SUPPORT;
>         *flags = (query & control_req);
>         goto out;
>     }
>     ...
> }
> 
> And do as follows in pcie_port_acpi_setup()
> 
>     status = acpi_pci_osc_control_set(handle, &flags);
>     if (status == AE_SUPPORT)  {
>         /* 2nd try */
>         status = acpi_pci_osc_control_set(handle, &flags);
>     }
>     if (ACPI_FAILURE(status)) {
>     ...
> 
> What do you think about this?

I think it makes sense, though some minor cares are required.

Does this incremental patch (apply after [8/8]) looks good?
If it is OK, I'll test these 8+1 patches within the next 2days.

Thanks,
H.Seto

=====
Subject: ACPI/PCI: Unify acpi_pci_osc_control_*()

Now AE_SUPPORT of acpi_pci_osc_control_set() tells not only
that query fails with the requested control bits but also that
the result of query is stored into the pointed place.

This allow user to retry acpi_pci_osc_control_set() with the
result of query.

Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
---
 drivers/acpi/pci_root.c          |   54 +++++++++++--------------------------
 drivers/pci/hotplug/acpi_pcihp.c |    2 +-
 drivers/pci/pcie/portdrv_acpi.c  |   23 +++++++---------
 include/linux/acpi.h             |    3 +-
 4 files changed, 28 insertions(+), 54 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 061e6f4..9a288df 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -372,38 +372,6 @@ out:
 }
 EXPORT_SYMBOL_GPL(acpi_get_pci_dev);
 
- /**
- * acpi_pci_osc_control_query - Get the _OSC bits the kernel can control.
- * @handle: ACPI handle of a PCI root bridge (or PCIe Root Complex).
- * @mask: Mask of _OSC bits to query and the place to put the result into.
- **/
-acpi_status acpi_pci_osc_control_query(acpi_handle handle, u32 *mask)
-{
-	struct acpi_pci_root *root;
-	acpi_handle tmp;
-	acpi_status status = AE_OK;
-
-	if (!mask || !(*mask & OSC_PCI_CONTROL_MASKS))
-		return AE_BAD_PARAMETER;
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
-	if ((*mask & root->osc_control_set) == *mask)
-		*mask = root->osc_control_set;
-	else
-		status = acpi_pci_query_osc(root, root->osc_support_set, mask);
-	mutex_unlock(&osc_lock);
-
-	return status;
-}
-
 /**
  * acpi_pci_osc_control_set - commit requested control to Firmware
  * @handle: acpi_handle for the target ACPI object
@@ -411,14 +379,17 @@ acpi_status acpi_pci_osc_control_query(acpi_handle handle, u32 *mask)
  *
  * Attempt to take control from Firmware on requested control bits.
  **/
-acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 flags)
+acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *flags)
 {
 	acpi_status status;
 	u32 control_req, result, capbuf[3];
 	acpi_handle tmp;
 	struct acpi_pci_root *root;
 
-	control_req = (flags & OSC_PCI_CONTROL_MASKS);
+	if (!flags)
+		return AE_BAD_PARAMETER;
+
+	control_req = (*flags & OSC_PCI_CONTROL_MASKS);
 	if (!control_req)
 		return AE_TYPE;
 
@@ -432,8 +403,10 @@ acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 flags)
 
 	mutex_lock(&osc_lock);
 	/* No need to evaluate _OSC if the control was already granted. */
-	if ((root->osc_control_set & control_req) == control_req)
+	if ((root->osc_control_set & control_req) == control_req) {
+		*flags = root->osc_control_set;
 		goto out;
+	}
 
 	/* Need to query controls first before requesting them */
 	result = control_req;
@@ -441,8 +414,10 @@ acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 flags)
 	if (ACPI_FAILURE(status))
 		goto out;
 	if ((result & control_req) != control_req) {
-		printk(KERN_DEBUG
-		       "Firmware did not grant requested _OSC control\n");
+		printk(KERN_DEBUG PREFIX
+		       "Firmware did not grant requested _OSC control: %x/%x\n",
+		       control_req, result);
+		*flags = result;
 		status = AE_SUPPORT;
 		goto out;
 	}
@@ -452,7 +427,10 @@ acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 flags)
 	capbuf[OSC_CONTROL_TYPE] = root->osc_control_set | control_req;
 	status = acpi_pci_run_osc(handle, capbuf, &result);
 	if (ACPI_SUCCESS(status))
-		root->osc_control_set = result;
+		root->osc_control_set = *flags = result;
+	else
+		printk(KERN_WARNING FW_BUG PREFIX
+		       "_OSC did not grant controls that passed query\n");
 out:
 	mutex_unlock(&osc_lock);
 	return status;
diff --git a/drivers/pci/hotplug/acpi_pcihp.c b/drivers/pci/hotplug/acpi_pcihp.c
index 12ea415..675181d 100644
--- a/drivers/pci/hotplug/acpi_pcihp.c
+++ b/drivers/pci/hotplug/acpi_pcihp.c
@@ -358,7 +358,7 @@ int acpi_get_hp_hw_control_from_firmware(struct pci_dev *pdev, u32 flags)
 		acpi_get_name(handle, ACPI_FULL_PATHNAME, &string);
 		dbg("Trying to get hotplug control for %s\n",
 				(char *)string.pointer);
-		status = acpi_pci_osc_control_set(handle, flags);
+		status = acpi_pci_osc_control_set(handle, &flags);
 		if (ACPI_SUCCESS(status))
 			goto got_one;
 		if (status == AE_SUPPORT)
diff --git a/drivers/pci/pcie/portdrv_acpi.c b/drivers/pci/pcie/portdrv_acpi.c
index a07a70e..764d0b3 100644
--- a/drivers/pci/pcie/portdrv_acpi.c
+++ b/drivers/pci/pcie/portdrv_acpi.c
@@ -55,20 +55,17 @@ int pcie_port_acpi_setup(struct pci_dev *port, int *srv_mask)
 			flags |= OSC_PCI_EXPRESS_AER_CONTROL;
 	}
 
-	status = acpi_pci_osc_control_query(handle, &flags);
-	if (ACPI_FAILURE(status)) {
-		dev_dbg(&port->dev, "ACPI _OSC query failed (code %d)\n",
-			status);
-		return -ENODEV;
+retry:
+	status = acpi_pci_osc_control_set(handle, &flags);
+	if (status == AE_SUPPORT) {
+		if (!(flags & OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL)) {
+			dev_dbg(&port->dev, "BIOS refuses to grant control of "
+				"PCIe Capability Structure\n");
+			return -EACCES;
+		}
+		if (flags & ~OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL)
+			goto retry;
 	}
-
-	if (!(flags & OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL)) {
-		dev_dbg(&port->dev, "BIOS refuses to grant control of PCIe "
-			"Capability Structure\n");
-		return -EACCES;
-	}
-
-	status = acpi_pci_osc_control_set(handle, flags);
 	if (ACPI_FAILURE(status)) {
 		dev_dbg(&port->dev, "ACPI _OSC request failed (code %d)\n",
 			status);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index a9afe9c..1b5aac6 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -305,8 +305,7 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
 				OSC_PCI_EXPRESS_AER_CONTROL |		\
 				OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL)
 
-extern acpi_status acpi_pci_osc_control_query(acpi_handle handle, u32 *mask);
-extern acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 flags);
+extern acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *flags);
 extern void acpi_early_init(void);
 
 #else	/* !CONFIG_ACPI */
-- 
1.7.2
