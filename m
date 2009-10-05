From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI / PCI: Fix NULL pointer dereference in
	acpi_get_pci_dev()
Date: Tue, 6 Oct 2009 01:30:43 +0200
Message-ID: <200910060130.43246.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
Cc: chepioq@gmail.com, Alex Chiang <achiang@hp.com>, Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Danny Feng <dfeng@redhat.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

acpi_get_pci_dev() assumes that every handle it finds in the ACPI CA
name space, between given device handle and the PCI root bridge
handle, corresponds to a PCI-to-PCI bridge with an existing secondary
bus.  For this reason, when it finds a struct pci_dev object
corresponding to one of them, it doesn't check if its 'subordinate'
field is a valid pointer.

However, during resume from a sleep state, as well as at startup, we
may get a dock notification, via dock_acpi_notifier registered by
dock_init(), for a docking station device that is present in the ACPI
tables, but not physically accessible at the moment.  In that
situation, the device appears to be below a PCI bridge whose
'subordinate' field is NULL.  This, in turn, causes
acpi_get_pci_dev() to trigger a NULL pointer dereference.

To fix this issue make acpi_get_pci_dev() check if pdev->subordinate
is not NULL for every device it finds in the path between the root
bridge and the device it's supposed to get to and return NULL if the
"target" device is not really accessible.

Fixes http://bugzilla.kernel.org/show_bug.cgi?id=14129, which is a
regression from 2.6.30.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Reported-by: Danny Feng <dfeng@redhat.com>
Tested-by: chepioq <chepioq@gmail.com>
---
 drivers/acpi/pci_root.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

Index: linux-2.6/drivers/acpi/pci_root.c
===================================================================
--- linux-2.6.orig/drivers/acpi/pci_root.c
+++ linux-2.6/drivers/acpi/pci_root.c
@@ -389,6 +389,18 @@ struct pci_dev *acpi_get_pci_dev(acpi_ha
 
 		pbus = pdev->subordinate;
 		pci_dev_put(pdev);
+
+		/*
+		 * During resume from a sleep state we can get a dock
+		 * notification for a device that is present in ACPI tables,
+		 * but not physically accessible at the moment, so tell the
+		 * caller it's not present in that case.
+		 */
+		if (!pbus) {
+			dev_info(&pdev->dev, "Secondary bus not present\n");
+			pdev = NULL;
+			break;
+		}
 	}
 out:
 	list_for_each_entry_safe(node, tmp, &device_list, node)
