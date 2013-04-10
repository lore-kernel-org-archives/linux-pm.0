From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] PCI / PM: Make pci_pme_active() ignore devices without PME support
Date: Wed, 10 Apr 2013 22:32:51 +0200
Message-ID: <2415503.p0WDU1yixb@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make pci_pme_active() ignore devices without PME support, so that
it doesn't print the "PME enabled" or "PME disabled" debug messages
for devices that don't support PME.

So that pci_pme_active() doesn't have to check pm_cap in addition
to pme_support, make pci_pm_init() clear pme_support upfront to
make sure that it will be 0 for pm_cap equal to 0.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -1575,7 +1575,7 @@ void pci_pme_active(struct pci_dev *dev,
 {
 	u16 pmcsr;
 
-	if (!dev->pm_cap)
+	if (!dev->pme_support)
 		return;
 
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
@@ -1924,6 +1924,7 @@ void pci_pm_init(struct pci_dev *dev)
 	dev->wakeup_prepared = false;
 
 	dev->pm_cap = 0;
+	dev->pme_support = 0;
 
 	/* find PCI PM capability in list */
 	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
@@ -1975,8 +1976,6 @@ void pci_pm_init(struct pci_dev *dev)
 		device_set_wakeup_capable(&dev->dev, true);
 		/* Disable the PME# generation functionality */
 		pci_pme_active(dev, false);
-	} else {
-		dev->pme_support = 0;
 	}
 }
 
