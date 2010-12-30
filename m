From: Stephen Hemminger <shemminger@vyatta.com>
Subject: [PATCH] skge: Do not use legacy PCI power management
Date: Thu, 30 Dec 2010 10:52:29 -0800
Message-ID: <20101230105229.189f3737__30849.413018632$1293735310$gmane$org@nehalam>
References: <201012261944.32517.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012261944.32517.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: netdev@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, David Miller <davem@davemloft.net>
List-Id: linux-pm@vger.kernel.org

The skge driver used the legacy PCI power management, and did its
own PCI callbacks.  Use the same code model as Rafael's changes to
sky2. Let the PCI subsystem take care of all the PCI-specific aspects of
device handling during system power transitions.

Compile tested only (so far).

Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>

--- a/drivers/net/skge.c	2010-12-30 10:19:01.191095951 -0800
+++ b/drivers/net/skge.c	2010-12-30 10:49:30.780295215 -0800
@@ -4044,53 +4044,40 @@ static void __devexit skge_remove(struct
 }
 
 #ifdef CONFIG_PM
-static int skge_suspend(struct pci_dev *pdev, pm_message_t state)
+static int skge_suspend(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct skge_hw *hw  = pci_get_drvdata(pdev);
-	int i, err, wol = 0;
+	int i;
 
 	if (!hw)
 		return 0;
 
-	err = pci_save_state(pdev);
-	if (err)
-		return err;
-
 	for (i = 0; i < hw->ports; i++) {
 		struct net_device *dev = hw->dev[i];
 		struct skge_port *skge = netdev_priv(dev);
 
 		if (netif_running(dev))
 			skge_down(dev);
+
 		if (skge->wol)
 			skge_wol_init(skge);
-
-		wol |= skge->wol;
 	}
 
 	skge_write32(hw, B0_IMSK, 0);
 
-	pci_prepare_to_sleep(pdev);
-
 	return 0;
 }
 
-static int skge_resume(struct pci_dev *pdev)
+static int skge_resume(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct skge_hw *hw  = pci_get_drvdata(pdev);
 	int i, err;
 
 	if (!hw)
 		return 0;
 
-	err = pci_back_from_sleep(pdev);
-	if (err)
-		goto out;
-
-	err = pci_restore_state(pdev);
-	if (err)
-		goto out;
-
 	err = skge_reset(hw);
 	if (err)
 		goto out;
@@ -4111,12 +4098,19 @@ static int skge_resume(struct pci_dev *p
 out:
 	return err;
 }
+
+static SIMPLE_DEV_PM_OPS(skge_pm_ops, skge_suspend, skge_resume);
+#define SKGE_PM_OPS (&skge_pm_ops)
+
+#else
+
+#define SKGE_PM_OPS NULL
 #endif
 
 static void skge_shutdown(struct pci_dev *pdev)
 {
 	struct skge_hw *hw  = pci_get_drvdata(pdev);
-	int i, wol = 0;
+	int i;
 
 	if (!hw)
 		return;
@@ -4127,15 +4121,10 @@ static void skge_shutdown(struct pci_dev
 
 		if (skge->wol)
 			skge_wol_init(skge);
-		wol |= skge->wol;
 	}
 
-	if (pci_enable_wake(pdev, PCI_D3cold, wol))
-		pci_enable_wake(pdev, PCI_D3hot, wol);
-
-	pci_disable_device(pdev);
+	pci_wake_from_d3(pdev, device_may_wakeup(&pdev->dev));
 	pci_set_power_state(pdev, PCI_D3hot);
-
 }
 
 static struct pci_driver skge_driver = {
@@ -4143,11 +4132,8 @@ static struct pci_driver skge_driver = {
 	.id_table =     skge_id_table,
 	.probe =        skge_probe,
 	.remove =       __devexit_p(skge_remove),
-#ifdef CONFIG_PM
-	.suspend = 	skge_suspend,
-	.resume = 	skge_resume,
-#endif
 	.shutdown =	skge_shutdown,
+	.driver.pm =	SKGE_PM_OPS,
 };
 
 static struct dmi_system_id skge_32bit_dma_boards[] = {
