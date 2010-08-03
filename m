From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/8] ACPI / PCI: Introduce
	acpi_pci_osc_control_query()
Date: Tue, 3 Aug 2010 22:58:40 +0200
Message-ID: <201008032258.40838.rjw__38729.831603314$1280869369$gmane$org@sisk.pl>
References: <201008022351.31406.rjw@sisk.pl> <4C57A346.6020003@jp.fujitsu.com>
	<201008031127.12117.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201008031127.12117.rjw@sisk.pl>
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
Cc: linux-pci@vger.kernel.org, linux-pm@lists.linux-foundation.org, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, August 03, 2010, Rafael J. Wysocki wrote:
> On Tuesday, August 03, 2010, Kenji Kaneshige wrote:
> > (2010/08/03 6:53), Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki<rjw@sisk.pl>
> > 
> > <snip.>
> > 
> > > +	mutex_lock(&osc_lock);
> > > +	status = acpi_pci_query_osc(root, root->osc_support_set, ctrl_mask);
> > > +	mutex_unlock(&osc_lock);
> > > +
> > 
> > One more comment here.
> > 
> > I think we can skip acpi_pci_query_osc() if all of queried controls are
> > already granted to OS. Please see below
> > 
> > 	mutex_lock(&osc_lock);
> > 	if ((root->osc_control_set & *ctrl_mask) == *ctrl_mask) {
> > 		*ctrl_mask = root->osc_control_set;
> > 		goto out;
> > 	}
> > 	status = acpi_pci_query_osc(root, root->osc_support_set, ctrl_mask);
> > 	mutex_unlock(&osc_lock);
> > out:
> 
> Well I guess you mean:
> 
>  	mutex_lock(&osc_lock);
>  	if ((root->osc_control_set & *ctrl_mask) != *ctrl_mask) 
>  		status = acpi_pci_query_osc(root, root->osc_support_set, ctrl_mask);
>  	mutex_unlock(&osc_lock);
> 
> Otherwise we would return with the mutex held. :-)

Updated patch is appended, please tell me what you think.

Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: ACPI / PCI: Introduce acpi_pci_osc_control_query() (v2)

Introduce a function allowing the caller to obtain a mask of _OSC
control bits the BIOS will allow the kernel to control for a given
PCI root bridge.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/pci_root.c |   61 ++++++++++++++++++++++++++++++++++++++++--------
 include/linux/acpi.h    |    1 
 2 files changed, 53 insertions(+), 9 deletions(-)

Index: linux-2.6/drivers/acpi/pci_root.c
===================================================================
--- linux-2.6.orig/drivers/acpi/pci_root.c
+++ linux-2.6/drivers/acpi/pci_root.c
@@ -225,21 +225,32 @@ static acpi_status acpi_pci_run_osc(acpi
 	return status;
 }
 
-static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root, u32 flags)
+static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root,
+					u32 support,
+					u32 *control)
 {
 	acpi_status status;
-	u32 support_set, result, capbuf[3];
+	u32 result, capbuf[3];
+
+	support &= OSC_PCI_SUPPORT_MASKS;
+	support |= root->osc_support_set;
 
-	/* do _OSC query for all possible controls */
-	support_set = root->osc_support_set | (flags & OSC_PCI_SUPPORT_MASKS);
 	capbuf[OSC_QUERY_TYPE] = OSC_QUERY_ENABLE;
-	capbuf[OSC_SUPPORT_TYPE] = support_set;
-	capbuf[OSC_CONTROL_TYPE] = OSC_PCI_CONTROL_MASKS;
+	capbuf[OSC_SUPPORT_TYPE] = support;
+	if (control) {
+		*control &= OSC_PCI_CONTROL_MASKS;
+		capbuf[OSC_CONTROL_TYPE] = *control | root->osc_control_set;
+	} else {
+		/* Run _OSC query for all possible controls. */
+		capbuf[OSC_CONTROL_TYPE] = OSC_PCI_CONTROL_MASKS;
+	}
 
 	status = acpi_pci_run_osc(root->device->handle, capbuf, &result);
 	if (ACPI_SUCCESS(status)) {
-		root->osc_support_set = support_set;
+		root->osc_support_set = support;
 		root->osc_control_qry = result;
+		if (control)
+			*control = result;
 		root->osc_queried = 1;
 	}
 	return status;
@@ -254,7 +265,7 @@ static acpi_status acpi_pci_osc_support(
 	if (ACPI_FAILURE(status))
 		return status;
 	mutex_lock(&osc_lock);
-	status = acpi_pci_query_osc(root, flags);
+	status = acpi_pci_query_osc(root, flags, NULL);
 	mutex_unlock(&osc_lock);
 	return status;
 }
@@ -363,6 +374,38 @@ out:
 }
 EXPORT_SYMBOL_GPL(acpi_get_pci_dev);
 
+ /**
+ * acpi_pci_osc_control_query - Get the _OSC bits the kernel can control.
+ * @handle: ACPI handle of a PCI root bridge (or PCIe Root Complex).
+ * @mask: Mask of _OSC bits to query and the place to put the result into.
+ **/
+acpi_status acpi_pci_osc_control_query(acpi_handle handle, u32 *mask)
+{
+	struct acpi_pci_root *root;
+	acpi_handle tmp;
+	acpi_status status = AE_OK;
+
+	if (!mask || !(*mask & OSC_PCI_CONTROL_MASKS))
+		return AE_BAD_PARAMETER;
+
+	root = acpi_pci_find_root(handle);
+	if (!root)
+		return AE_NOT_EXIST;
+
+	status = acpi_get_handle(handle, "_OSC", &tmp);
+	if (ACPI_FAILURE(status))
+		return status;
+
+	mutex_lock(&osc_lock);
+	if ((*mask & root->osc_control_set) == *mask)
+		*mask = root->osc_control_set;
+	else
+		status = acpi_pci_query_osc(root, root->osc_support_set, mask);
+	mutex_unlock(&osc_lock);
+
+	return status;
+}
+
 /**
  * acpi_pci_osc_control_set - commit requested control to Firmware
  * @handle: acpi_handle for the target ACPI object
@@ -396,7 +439,7 @@ acpi_status acpi_pci_osc_control_set(acp
 
 	/* Need to query controls first before requesting them */
 	if (!root->osc_queried) {
-		status = acpi_pci_query_osc(root, root->osc_support_set);
+		status = acpi_pci_query_osc(root, root->osc_support_set, NULL);
 		if (ACPI_FAILURE(status))
 			goto out;
 	}
Index: linux-2.6/include/linux/acpi.h
===================================================================
--- linux-2.6.orig/include/linux/acpi.h
+++ linux-2.6/include/linux/acpi.h
@@ -305,6 +305,7 @@ acpi_status acpi_run_osc(acpi_handle han
 				OSC_PCI_EXPRESS_AER_CONTROL |		\
 				OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL)
 
+extern acpi_status acpi_pci_osc_control_query(acpi_handle handle, u32 *mask);
 extern acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 flags);
 extern void acpi_early_init(void);
 
