From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/3] PCI PM: Power up devices before restoring
	their state
Date: Thu, 22 Jan 2009 23:38:31 +0100
Message-ID: <200901222338.32195.rjw__3591.63751495561$1232664231$gmane$org@sisk.pl>
References: <200901222335.07341.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200901222335.07341.rjw@sisk.pl>
Content-Disposition: inline
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Matthew Wilcox <matthew@wil.cx>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Devices that have MSI-X enabled before suspend to RAM or hibernation
and that are in a low power state during resume will not be handled
correctly by pci_restore_standard_config().  Namely, it first calls
pci_restore_state() which calls pci_restore_msi_state(), which in turn
executes __pci_restore_msix_state() that accesses the device's memory
space to restore the contents of the MSI-X table.  However, if the
device is in a low power state at this point, it's memory space is
not accessible.

The easiest way to fix this potential problem is to make
pci_restore_standard_config() call pci_restore_state() after
it has put the device into the full power state, D0.  Fortunately,
all of this is done with interrupts off, so the change of ordering
should not cause any trouble.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/pci/pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci.c
+++ linux-2.6/drivers/pci/pci.c
@@ -1393,12 +1393,11 @@ int pci_restore_standard_config(struct p
 	pci_power_t prev_state;
 	int error;
 
-	pci_restore_state(dev);
 	pci_update_current_state(dev, PCI_D0);
 
 	prev_state = dev->current_state;
 	if (prev_state == PCI_D0)
-		return 0;
+		goto Restore;
 
 	error = pci_raw_set_power_state(dev, PCI_D0, false);
 	if (error)
@@ -1421,7 +1420,8 @@ int pci_restore_standard_config(struct p
 
 	dev->current_state = PCI_D0;
 
-	return 0;
+ Restore:
+	return pci_restore_state(dev);
 }
 
 /**
