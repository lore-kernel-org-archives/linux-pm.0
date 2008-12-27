From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/2] PCI PM: Split PCI Express port suspend-resume
Date: Sat, 27 Dec 2008 16:28:58 +0100
Message-ID: <200812271628.58748.rjw@sisk.pl>
References: <200812271627.32781.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200812271627.32781.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Suspend-resume of PCI Express ports has recently been moved into
_suspend_late() and _resume_early() callbacks, but some functions
executed from there should not be called with interrupts disabled,
eg. pci_enable_device().  For this reason, split the suspend-resume
of PCI Express ports into parts to be executed with interrupts
disabled and with interrupts enabled.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pcie/portdrv_pci.c |   23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

Index: linux-2.6/drivers/pci/pcie/portdrv_pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pcie/portdrv_pci.c
+++ linux-2.6/drivers/pci/pcie/portdrv_pci.c
@@ -41,7 +41,6 @@ static int pcie_portdrv_restore_config(s
 {
 	int retval;
 
-	pci_restore_state(dev);
 	retval = pci_enable_device(dev);
 	if (retval)
 		return retval;
@@ -50,23 +49,32 @@ static int pcie_portdrv_restore_config(s
 }
 
 #ifdef CONFIG_PM
-static int pcie_portdrv_suspend_late(struct pci_dev *dev, pm_message_t state)
+static int pcie_portdrv_suspend(struct pci_dev *dev, pm_message_t state)
 {
-	int ret = pcie_port_device_suspend(dev, state);
+	return pcie_port_device_suspend(dev, state);
+
+}
 
-	if (!ret)
-		ret = pcie_portdrv_save_config(dev);
-	return ret;
+static int pcie_portdrv_suspend_late(struct pci_dev *dev, pm_message_t state)
+{
+	return pci_save_state(dev);
 }
 
 static int pcie_portdrv_resume_early(struct pci_dev *dev)
 {
+	return pci_restore_state(dev);
+}
+
+static int pcie_portdrv_resume(struct pci_dev *dev)
+{
 	pcie_portdrv_restore_config(dev);
 	return pcie_port_device_resume(dev);
 }
 #else
+#define pcie_portdrv_suspend NULL
 #define pcie_portdrv_suspend_late NULL
 #define pcie_portdrv_resume_early NULL
+#define pcie_portdrv_resume NULL
 #endif
 
 /*
@@ -221,6 +229,7 @@ static pci_ers_result_t pcie_portdrv_slo
 
 	/* If fatal, restore cfg space for possible link reset at upstream */
 	if (dev->error_state == pci_channel_io_frozen) {
+		pci_restore_state(dev);
 		pcie_portdrv_restore_config(dev);
 		pci_enable_pcie_error_reporting(dev);
 	}
@@ -282,8 +291,10 @@ static struct pci_driver pcie_portdriver
 	.probe		= pcie_portdrv_probe,
 	.remove		= pcie_portdrv_remove,
 
+	.suspend	= pcie_portdrv_suspend,
 	.suspend_late	= pcie_portdrv_suspend_late,
 	.resume_early	= pcie_portdrv_resume_early,
+	.resume		= pcie_portdrv_resume,
 
 	.err_handler 	= &pcie_portdrv_err_handler,
 };
