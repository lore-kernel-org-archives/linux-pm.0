From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 4/7] PCI PCIe portdrv: Simplify suspend and resume
Date: Wed, 4 Feb 2009 02:00:11 +0100
Message-ID: <200902040200.12488.rjw__35977.4511809976$1233710871$gmane$org@sisk.pl>
References: <200902040154.36018.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902040154.36018.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Simplify suspend and resume of the PCI Express port driver that
doesn't need to save and restore the standard configuration space
of the device any more, since this is now done by the PCI PM core
layer.

This patch is reported to fix the regression tracked as
http://bugzilla.kernel.org/show_bug.cgi?id=12598

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Reported-and-tested-by: Parag Warudkar <parag.lkml@gmail.com>
---
 drivers/pci/pcie/portdrv_pci.c |   16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

Index: linux-2.6/drivers/pci/pcie/portdrv_pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pcie/portdrv_pci.c
+++ linux-2.6/drivers/pci/pcie/portdrv_pci.c
@@ -55,25 +55,13 @@ static int pcie_portdrv_suspend(struct p
 
 }
 
-static int pcie_portdrv_suspend_late(struct pci_dev *dev, pm_message_t state)
-{
-	return pci_save_state(dev);
-}
-
-static int pcie_portdrv_resume_early(struct pci_dev *dev)
-{
-	return pci_restore_state(dev);
-}
-
 static int pcie_portdrv_resume(struct pci_dev *dev)
 {
-	pcie_portdrv_restore_config(dev);
+	pci_set_master(dev);
 	return pcie_port_device_resume(dev);
 }
 #else
 #define pcie_portdrv_suspend NULL
-#define pcie_portdrv_suspend_late NULL
-#define pcie_portdrv_resume_early NULL
 #define pcie_portdrv_resume NULL
 #endif
 
@@ -292,8 +280,6 @@ static struct pci_driver pcie_portdriver
 	.remove		= pcie_portdrv_remove,
 
 	.suspend	= pcie_portdrv_suspend,
-	.suspend_late	= pcie_portdrv_suspend_late,
-	.resume_early	= pcie_portdrv_resume_early,
 	.resume		= pcie_portdrv_resume,
 
 	.err_handler 	= &pcie_portdrv_err_handler,
