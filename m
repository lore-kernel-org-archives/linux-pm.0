From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] Wireless / ath5k: Simplify suspend and resume
	callbacks
Date: Mon, 5 Oct 2009 00:52:09 +0200
Message-ID: <200910050052.09085.rjw@sisk.pl>
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
To: ath5k-devel@venema.h4ckr.net
Cc: Bob Copeland <me@bobcopeland.com>, pm list <linux-pm@lists.linux-foundation.org>, linux-wireless@vger.kernel.org, "John W. Linville" <linville@tuxdriver.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Simplify the suspend and resume callbacks of ath5k by converting the
driver to struct dev_pm_ops and allowing the PCI PM core to do the
PCI-specific suspend/resume handling.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/net/wireless/ath/ath5k/base.c |   35 ++++++++++------------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

Index: linux-2.6/drivers/net/wireless/ath/ath5k/base.c
===================================================================
--- linux-2.6.orig/drivers/net/wireless/ath/ath5k/base.c
+++ linux-2.6/drivers/net/wireless/ath/ath5k/base.c
@@ -195,12 +195,13 @@ static int __devinit	ath5k_pci_probe(str
 				const struct pci_device_id *id);
 static void __devexit	ath5k_pci_remove(struct pci_dev *pdev);
 #ifdef CONFIG_PM
-static int		ath5k_pci_suspend(struct pci_dev *pdev,
-					pm_message_t state);
-static int		ath5k_pci_resume(struct pci_dev *pdev);
+static int		ath5k_pci_suspend(struct device *dev);
+static int		ath5k_pci_resume(struct device *dev);
+
+SIMPLE_DEV_PM_OPS(ath5k_pm_ops, ath5k_pci_suspend, ath5k_pci_resume);
+#define ATH5K_PM_OPS	(&ath5k_pm_ops)
 #else
-#define ath5k_pci_suspend NULL
-#define ath5k_pci_resume NULL
+#define ATH5K_PM_OPS	NULL
 #endif /* CONFIG_PM */
 
 static struct pci_driver ath5k_pci_driver = {
@@ -208,8 +209,7 @@ static struct pci_driver ath5k_pci_drive
 	.id_table	= ath5k_pci_id_table,
 	.probe		= ath5k_pci_probe,
 	.remove		= __devexit_p(ath5k_pci_remove),
-	.suspend	= ath5k_pci_suspend,
-	.resume		= ath5k_pci_resume,
+	.driver.pm	= ATH5K_PM_OPS,
 };
 
 
@@ -669,33 +669,20 @@ ath5k_pci_remove(struct pci_dev *pdev)
 }
 
 #ifdef CONFIG_PM
-static int
-ath5k_pci_suspend(struct pci_dev *pdev, pm_message_t state)
+static int ath5k_pci_suspend(struct device *dev)
 {
-	struct ieee80211_hw *hw = pci_get_drvdata(pdev);
+	struct ieee80211_hw *hw = pci_get_drvdata(to_pci_dev(dev));
 	struct ath5k_softc *sc = hw->priv;
 
 	ath5k_led_off(sc);
-
-	pci_save_state(pdev);
-	pci_disable_device(pdev);
-	pci_set_power_state(pdev, PCI_D3hot);
-
 	return 0;
 }
 
-static int
-ath5k_pci_resume(struct pci_dev *pdev)
+static int ath5k_pci_resume(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct ieee80211_hw *hw = pci_get_drvdata(pdev);
 	struct ath5k_softc *sc = hw->priv;
-	int err;
-
-	pci_restore_state(pdev);
-
-	err = pci_enable_device(pdev);
-	if (err)
-		return err;
 
 	/*
 	 * Suspend/Resume resets the PCI configuration space, so we have to
