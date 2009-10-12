From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI / PCI: Fix NULL pointer dereference in
	acpi_get_pci_dev() (rev. 2)
Date: Tue, 13 Oct 2009 01:01:57 +0200
Message-ID: <200910130101.57595.rjw@sisk.pl>
References: <200910060130.43246.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200910060130.43246.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: chepioq@gmail.com, Alex Chiang <achiang@hp.com>, Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Danny Feng <dfeng@redhat.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

acpi_get_pci_dev() may be called for a non-PCI device, in which case
it should return NULL.  However, it assumes that every handle it
finds in the ACPI CA name space, between given device handle and the
PCI root bridge handle, corresponds to a PCI-to-PCI bridge with an
existing secondary bus.  For this reason, when it finds a struct
pci_dev object corresponding to one of them, it doesn't check if
its 'subordinate' field is a valid pointer.  This obviously leads to
a NULL pointer dereference if acpi_get_pci_dev() is called for a
non-PCI device with a PCI parent which is not a bridge.

To fix this issue make acpi_get_pci_dev() check if pdev->subordinate
is not NULL for every device it finds on the path between the root
bridge and the device it's supposed to get to and return NULL if the
"target" device cannot be found.

Fixes http://bugzilla.kernel.org/show_bug.cgi?id=14129, which is a
regression from 2.6.30.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---

Jesse, Len,

This is a replacement for the original $subject patch (now in the Len's tree
as commit 5988eaded02e3cca2702f46efc255143468255bd).

The code was correct, but the comment and the changelog were not.  Please
use the one below instead.

Thanks,
Rafael

---
 drivers/acpi/pci_root.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

Index: linux-2.6/drivers/acpi/pci_root.c
===================================================================
--- linux-2.6.orig/drivers/acpi/pci_root.c
+++ linux-2.6/drivers/acpi/pci_root.c
@@ -389,6 +389,17 @@ struct pci_dev *acpi_get_pci_dev(acpi_ha
 
 		pbus = pdev->subordinate;
 		pci_dev_put(pdev);
+
+		/*
+		 * This function may be called for a non-PCI device that has a
+		 * PCI parent (eg. a disk under a PCI SATA controller).  In that
+		 * case pdev->subordinate will be NULL for the parent.
+		 */
+		if (!pbus) {
+			dev_dbg(&pdev->dev, "Not a PCI-to-PCI bridge\n");
+			pdev = NULL;
+			break;
+		}
 	}
 out:
 	list_for_each_entry_safe(node, tmp, &device_list, node)
