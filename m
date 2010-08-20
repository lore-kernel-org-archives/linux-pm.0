From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 5/10] ACPI / PCI: Do not preserve _OSC control
	bits returned by a query (v4)
Date: Sat, 21 Aug 2010 01:54:41 +0200
Message-ID: <201008210154.41507.rjw__26899.3784011856$1282349511$gmane$org@sisk.pl>
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

There is the assumption in acpi_pci_osc_control_set() that it is
always sufficient to compare the mask of _OSC control bits to be
requested with the result of an _OSC query where all of the known
control bits have been checked.  However, in general, that need not
be the case.  For example, if an _OSC feature A depends on an _OSC
feature B and control of A, B plus another _OSC feature C is
requested simultaneously, the BIOS may return A, B, C, while it would
only return C if A and C were requested without B.

That may result in passing a wrong mask of _OSC control bits to an
_OSC control request, in which case the BIOS may only grant control
of a subset of the requested features.  Moreover, acpi_pci_run_osc()
will return error code if that happens and the caller of
acpi_pci_osc_control_set() will not know that it's been granted
control of some _OSC features.  Consequently, the system will
generally not work as expected.

For this reason, make acpi_pci_osc_control_set() always check if
control of the requested _OSC features will be granted before making
the final control request.  As a result, the osc_control_qry and
osc_queried members of struct acpi_pci_root are not necessary any
more, so drop them and remove the remaining code referring to them.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/pci_root.c |   20 +++++++-------------
 include/acpi/acpi_bus.h |    3 ---
 2 files changed, 7 insertions(+), 16 deletions(-)

Index: linux-2.6/drivers/acpi/pci_root.c
===================================================================
--- linux-2.6.orig/drivers/acpi/pci_root.c
+++ linux-2.6/drivers/acpi/pci_root.c
@@ -249,12 +249,8 @@ static acpi_status acpi_pci_query_osc(st
 	status = acpi_pci_run_osc(root->device->handle, capbuf, &result);
 	if (ACPI_SUCCESS(status)) {
 		root->osc_support_set = support;
-		if (control) {
+		if (control)
 			*control = result;
-		} else {
-			root->osc_control_qry = result;
-			root->osc_queried = 1;
-		}
 	}
 	return status;
 }
@@ -409,14 +405,12 @@ acpi_status acpi_pci_osc_control_set(acp
 		goto out;
 
 	/* Need to query controls first before requesting them */
-	if (!root->osc_queried) {
-		status = acpi_pci_query_osc(root, root->osc_support_set, NULL);
-		if (ACPI_FAILURE(status))
-			goto out;
-	}
-	if ((root->osc_control_qry & control_req) != control_req) {
-		printk(KERN_DEBUG
-		       "Firmware did not grant requested _OSC control\n");
+	flags = control_req;
+	status = acpi_pci_query_osc(root, root->osc_support_set, &flags);
+	if (ACPI_FAILURE(status))
+		goto out;
+
+	if (flags != control_req) {
 		status = AE_SUPPORT;
 		goto out;
 	}
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
