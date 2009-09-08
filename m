From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/5] PCI PM: Introduce device flag wakeup_prepared
Date: Tue, 8 Sep 2009 23:14:49 +0200
Message-ID: <200909082314.49251.rjw__37291.1909282722$1252445178$gmane$org@sisk.pl>
References: <200908300041.14541.rjw@sisk.pl> <200909040002.02562.rjw@sisk.pl>
	<200909082311.48366.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200909082311.48366.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Linux PCI <linux-pci@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ykzhao <yakui.zhao@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Introduce a new PCI device flag, wakeup_prepared, to prevent PCI
wake-up preparation code from being executed twice in a row for the
same device and for the same purpose.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci.c   |    8 ++++++++
 include/linux/pci.h |    1 +
 2 files changed, 9 insertions(+)

Index: linux-2.6/drivers/pci/pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci.c
+++ linux-2.6/drivers/pci/pci.c
@@ -1223,6 +1223,10 @@ int pci_enable_wake(struct pci_dev *dev,
 	if (enable && !device_may_wakeup(&dev->dev))
 		return -EINVAL;
 
+	/* Don't do the same thing twice in a row for one device. */
+	if (!!enable == !!dev->wakeup_prepared)
+		return 0;
+
 	/*
 	 * According to "PCI System Architecture" 4th ed. by Tom Shanley & Don
 	 * Anderson we should be doing PME# wake enable followed by ACPI wake
@@ -1239,9 +1243,12 @@ int pci_enable_wake(struct pci_dev *dev,
 		error = platform_pci_sleep_wake(dev, true);
 		if (ret)
 			ret = error;
+		if (!ret)
+			dev->wakeup_prepared = true;
 	} else {
 		platform_pci_sleep_wake(dev, false);
 		pci_pme_active(dev, false);
+		dev->wakeup_prepared = false;
 	}
 
 	return ret;
@@ -1363,6 +1370,7 @@ void pci_pm_init(struct pci_dev *dev)
 	int pm;
 	u16 pmc;
 
+	dev->wakeup_prepared = false;
 	dev->pm_cap = 0;
 
 	/* find PCI PM capability in list */
Index: linux-2.6/include/linux/pci.h
===================================================================
--- linux-2.6.orig/include/linux/pci.h
+++ linux-2.6/include/linux/pci.h
@@ -241,6 +241,7 @@ struct pci_dev {
 	unsigned int	d1_support:1;	/* Low power state D1 is supported */
 	unsigned int	d2_support:1;	/* Low power state D2 is supported */
 	unsigned int	no_d1d2:1;	/* Only allow D0 and D3 */
+	unsigned int	wakeup_prepared:1;
 
 #ifdef CONFIG_PCIEASPM
 	struct pcie_link_state	*link_state;	/* ASPM link state. */
