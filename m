From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 4/10] ACPI / PCI: Make acpi_pci_query_osc()
	return control bits
Date: Sat, 21 Aug 2010 01:53:27 +0200
Message-ID: <201008210153.28207.rjw__37212.5984322794$1282349197$gmane$org@sisk.pl>
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

Make acpi_pci_query_osc() use an additional pointer argument to
return the mask of control bits obtained from the BIOS to the
caller.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/pci_root.c |   77 +++++++++++++++++++++++++++++++++++++++++-------
 include/linux/acpi.h    |    1 
 2 files changed, 67 insertions(+), 11 deletions(-)

Index: linux-2.6/drivers/acpi/pci_root.c
===================================================================
--- linux-2.6.orig/drivers/acpi/pci_root.c
+++ linux-2.6/drivers/acpi/pci_root.c
@@ -226,22 +226,35 @@ static acpi_status acpi_pci_run_osc(acpi
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
-		root->osc_control_qry = result;
-		root->osc_queried = 1;
+		root->osc_support_set = support;
+		if (control) {
+			*control = result;
+		} else {
+			root->osc_control_qry = result;
+			root->osc_queried = 1;
+		}
 	}
 	return status;
 }
@@ -255,7 +268,7 @@ static acpi_status acpi_pci_osc_support(
 	if (ACPI_FAILURE(status))
 		return status;
 	mutex_lock(&osc_lock);
-	status = acpi_pci_query_osc(root, flags);
+	status = acpi_pci_query_osc(root, flags, NULL);
 	mutex_unlock(&osc_lock);
 	return status;
 }
@@ -397,7 +452,7 @@ acpi_status acpi_pci_osc_control_set(acp
 
 	/* Need to query controls first before requesting them */
 	if (!root->osc_queried) {
-		status = acpi_pci_query_osc(root, root->osc_support_set);
+		status = acpi_pci_query_osc(root, root->osc_support_set, NULL);
 		if (ACPI_FAILURE(status))
 			goto out;
 	}
