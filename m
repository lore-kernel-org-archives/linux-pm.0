From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 8/10] PCI PM: Register power state of devices
	during initialization
Date: Wed, 7 Jan 2009 13:10:35 +0100
Message-ID: <200901071310.36119.rjw__19252.1612196744$1231330632$gmane$org@sisk.pl>
References: <200901071301.00139.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200901071301.00139.rjw@sisk.pl>
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
Cc: Greg KH <greg@kroah.com>, pm list <linux-pm@lists.linux-foundation.org>, Linux PCI <linux-pci@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Use the observation that the power state of a PCI device can be
loaded into its pci_dev structure as soon as pci_pm_init() is run for
it and make that happen.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@suse.cz>
---
 drivers/pci/pci.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/pci/pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci.c
+++ linux-2.6/drivers/pci/pci.c
@@ -1260,14 +1260,15 @@ void pci_pm_init(struct pci_dev *dev)
 	/* find PCI PM capability in list */
 	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
 	if (!pm)
-		return;
+		goto Exit;
+
 	/* Check device's ability to generate PME# */
 	pci_read_config_word(dev, pm + PCI_PM_PMC, &pmc);
 
 	if ((pmc & PCI_PM_CAP_VER_MASK) > 3) {
 		dev_err(&dev->dev, "unsupported PM cap regs version (%u)\n",
 			pmc & PCI_PM_CAP_VER_MASK);
-		return;
+		goto Exit;
 	}
 
 	dev->pm_cap = pm;
@@ -1306,6 +1307,9 @@ void pci_pm_init(struct pci_dev *dev)
 	} else {
 		dev->pme_support = 0;
 	}
+
+ Exit:
+	pci_update_current_state(dev, PCI_D0);
 }
 
 /**
