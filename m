From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ath9k: Convert to new PCI PM framework
Date: Sat, 16 Oct 2010 00:36:17 +0200
Message-ID: <201010160036.17653.rjw__37036.7977688604$1287182437$gmane$org@sisk.pl>
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
To: "Luis R. Rodriguez" <lrodriguez@atheros.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, ath9k-devel@venema.h4ckr.net, linux-wireless@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The ath9k driver uses the legacy PCI power management (suspend
and resume) callbacks that apparently cause intermittent problems
to happen (the adapter sometimes doesn't resume correctly on my
Acer Ferrari One).  Make it use the new PCI PM and let the PCI core
code handle the PCI-specific details of power transitions.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/net/wireless/ath/ath9k/pci.c |   40 +++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 18 deletions(-)

Index: linux-2.6/drivers/net/wireless/ath/ath9k/pci.c
===================================================================
--- linux-2.6.orig/drivers/net/wireless/ath/ath9k/pci.c
+++ linux-2.6/drivers/net/wireless/ath/ath9k/pci.c
@@ -247,34 +247,25 @@ static void ath_pci_remove(struct pci_de
 
 #ifdef CONFIG_PM
 
-static int ath_pci_suspend(struct pci_dev *pdev, pm_message_t state)
+static int ath_pci_suspend(struct device *device)
 {
+	struct pci_dev *pdev = to_pci_dev(device);
 	struct ieee80211_hw *hw = pci_get_drvdata(pdev);
 	struct ath_wiphy *aphy = hw->priv;
 	struct ath_softc *sc = aphy->sc;
 
 	ath9k_hw_set_gpio(sc->sc_ah, sc->sc_ah->led_pin, 1);
 
-	pci_save_state(pdev);
-	pci_disable_device(pdev);
-	pci_set_power_state(pdev, PCI_D3hot);
-
 	return 0;
 }
 
-static int ath_pci_resume(struct pci_dev *pdev)
+static int ath_pci_resume(struct device *device)
 {
+	struct pci_dev *pdev = to_pci_dev(device);
 	struct ieee80211_hw *hw = pci_get_drvdata(pdev);
 	struct ath_wiphy *aphy = hw->priv;
 	struct ath_softc *sc = aphy->sc;
 	u32 val;
-	int err;
-
-	pci_restore_state(pdev);
-
-	err = pci_enable_device(pdev);
-	if (err)
-		return err;
 
 	/*
 	 * Suspend/Resume resets the PCI configuration space, so we have to
@@ -293,7 +284,23 @@ static int ath_pci_resume(struct pci_dev
 	return 0;
 }
 
-#endif /* CONFIG_PM */
+static const struct dev_pm_ops ath9k_pm_ops = {
+	.suspend = ath_pci_suspend,
+	.resume = ath_pci_resume,
+	.freeze = ath_pci_suspend,
+	.thaw = ath_pci_resume,
+	.poweroff = ath_pci_suspend,
+	.restore = ath_pci_resume,
+};
+
+#define ATH9K_PM_OPS	(&ath9k_pm_ops)
+
+#else /* !CONFIG_PM */
+
+#define ATH9K_PM_OPS	NULL
+
+#endif /* !CONFIG_PM */
+
 
 MODULE_DEVICE_TABLE(pci, ath_pci_id_table);
 
@@ -302,10 +309,7 @@ static struct pci_driver ath_pci_driver 
 	.id_table   = ath_pci_id_table,
 	.probe      = ath_pci_probe,
 	.remove     = ath_pci_remove,
-#ifdef CONFIG_PM
-	.suspend    = ath_pci_suspend,
-	.resume     = ath_pci_resume,
-#endif /* CONFIG_PM */
+	.driver.pm  = ATH9K_PM_OPS,
 };
 
 int ath_pci_init(void)
