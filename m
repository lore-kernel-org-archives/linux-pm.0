From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 9/10] ACPI / PCI: Reorder checks in
	acpi_pci_osc_control_set()
Date: Fri, 6 Aug 2010 03:13:38 +0200
Message-ID: <201008060313.38590.rjw__35635.375037282$1281058922$gmane$org@sisk.pl>
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

Make acpi_pci_osc_control_set() attempt to find the handle of the
_OSC object under the given PCI root bridge object after verifying
that its second argument is correct and that there is a struct
acpi_pci_root object for the given root bridge handle.  This is
more logical than the old code and it matches the code ordering
in acpi_pci_osc_control_query().

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Reviewed-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
---
 drivers/acpi/pci_root.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/acpi/pci_root.c
===================================================================
--- linux-2.6.orig/drivers/acpi/pci_root.c
+++ linux-2.6/drivers/acpi/pci_root.c
@@ -428,10 +428,6 @@ acpi_status acpi_pci_osc_control_set(acp
 	acpi_handle tmp;
 	struct acpi_pci_root *root;
 
-	status = acpi_get_handle(handle, "_OSC", &tmp);
-	if (ACPI_FAILURE(status))
-		return status;
-
 	control_req = (flags & OSC_PCI_CONTROL_MASKS);
 	if (!control_req)
 		return AE_TYPE;
@@ -440,6 +436,10 @@ acpi_status acpi_pci_osc_control_set(acp
 	if (!root)
 		return AE_NOT_EXIST;
 
+	status = acpi_get_handle(handle, "_OSC", &tmp);
+	if (ACPI_FAILURE(status))
+		return status;
+
 	mutex_lock(&osc_lock);
 	/* No need to evaluate _OSC if the control was already granted. */
 	if ((root->osc_control_set & control_req) == control_req)
