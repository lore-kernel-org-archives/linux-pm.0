From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 4/4] sky2: Adapt sky2 to use reworked PCI PM
Date: Sat, 19 Jul 2008 14:42:51 +0200
Message-ID: <200807191442.52759.rjw__14792.8298255012$1216471485$gmane$org@sisk.pl>
References: <200807191436.40726.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200807191436.40726.rjw@sisk.pl>
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
To: LKML <linux-kernel@vger.kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Hemminger <shemminger@vyatta.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Adapt the sky2 driver to use the reworked PCI PM.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/net/sky2.c |   42 +++++++++++++++---------------------------
 1 file changed, 15 insertions(+), 27 deletions(-)

Index: linux-2.6/drivers/net/sky2.c
===================================================================
--- linux-2.6.orig/drivers/net/sky2.c
+++ linux-2.6/drivers/net/sky2.c
@@ -2988,7 +2988,8 @@ static int sky2_set_wol(struct net_devic
 	struct sky2_port *sky2 = netdev_priv(dev);
 	struct sky2_hw *hw = sky2->hw;
 
-	if (wol->wolopts & ~sky2_wol_supported(sky2->hw))
+	if ((wol->wolopts & ~sky2_wol_supported(sky2->hw))
+	    || !device_can_wakeup(&hw->pdev->dev))
 		return -EOPNOTSUPP;
 
 	sky2->wol = wol->wolopts;
@@ -2999,8 +3000,8 @@ static int sky2_set_wol(struct net_devic
 		sky2_write32(hw, B0_CTST, sky2->wol
 			     ? Y2_HW_WOL_ON : Y2_HW_WOL_OFF);
 
-	if (!netif_running(dev))
-		sky2_wol_init(sky2);
+	device_set_wakeup_enable(&hw->pdev->dev, sky2->wol);
+
 	return 0;
 }
 
@@ -4120,18 +4121,6 @@ static int __devinit sky2_test_msi(struc
 	return err;
 }
 
-static int __devinit pci_wake_enabled(struct pci_dev *dev)
-{
-	int pm  = pci_find_capability(dev, PCI_CAP_ID_PM);
-	u16 value;
-
-	if (!pm)
-		return 0;
-	if (pci_read_config_word(dev, pm + PCI_PM_CTRL, &value))
-		return 0;
-	return value & PCI_PM_CTRL_PME_ENABLE;
-}
-
 static int __devinit sky2_probe(struct pci_dev *pdev,
 				const struct pci_device_id *ent)
 {
@@ -4170,7 +4159,7 @@ static int __devinit sky2_probe(struct p
 		}
 	}
 
-	wol_default = pci_wake_enabled(pdev) ? WAKE_MAGIC : 0;
+	wol_default = device_may_wakeup(&pdev->dev) ? WAKE_MAGIC : 0;
 
 	err = -ENOMEM;
 	hw = kzalloc(sizeof(*hw), GFP_KERNEL);
@@ -4335,7 +4324,8 @@ static void __devexit sky2_remove(struct
 static int sky2_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct sky2_hw *hw = pci_get_drvdata(pdev);
-	int i, wol = 0;
+	int i;
+	bool wol = false;
 
 	if (!hw)
 		return 0;
@@ -4351,10 +4341,10 @@ static int sky2_suspend(struct pci_dev *
 		if (netif_running(dev))
 			sky2_down(dev);
 
-		if (sky2->wol)
+		if (sky2->wol) {
+			wol = true;
 			sky2_wol_init(sky2);
-
-		wol |= sky2->wol;
+		}
 	}
 
 	sky2_write32(hw, B0_IMSK, 0);
@@ -4362,8 +4352,8 @@ static int sky2_suspend(struct pci_dev *
 	sky2_power_aux(hw);
 
 	pci_save_state(pdev);
-	pci_enable_wake(pdev, pci_choose_state(pdev, state), wol);
-	pci_set_power_state(pdev, pci_choose_state(pdev, state));
+
+	pci_prepare_to_sleep(pdev);
 
 	return 0;
 }
@@ -4376,7 +4366,7 @@ static int sky2_resume(struct pci_dev *p
 	if (!hw)
 		return 0;
 
-	err = pci_set_power_state(pdev, PCI_D0);
+	err = pci_back_from_sleep(pdev);
 	if (err)
 		goto out;
 
@@ -4384,8 +4374,6 @@ static int sky2_resume(struct pci_dev *p
 	if (err)
 		goto out;
 
-	pci_enable_wake(pdev, PCI_D0, 0);
-
 	/* Re-enable all clocks */
 	if (hw->chip_id == CHIP_ID_YUKON_EX ||
 	    hw->chip_id == CHIP_ID_YUKON_EC_U ||
@@ -4444,8 +4432,8 @@ static void sky2_shutdown(struct pci_dev
 	if (wol)
 		sky2_power_aux(hw);
 
-	pci_enable_wake(pdev, PCI_D3hot, wol);
-	pci_enable_wake(pdev, PCI_D3cold, wol);
+	if (pci_enable_wake(pdev, PCI_D3cold, wol))
+		pci_enable_wake(pdev, PCI_D3hot, wol);
 
 	pci_disable_device(pdev);
 	pci_set_power_state(pdev, PCI_D3hot);
