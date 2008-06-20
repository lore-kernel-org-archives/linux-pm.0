From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 8.5/9] PCI PM: Add diagnostic statements to
	PCI device PM initialization
Date: Fri, 20 Jun 2008 18:07:17 +0200
Message-ID: <200806201807.17785.rjw__43062.7561793246$1213978149$gmane$org@sisk.pl>
References: <200806200145.33053.rjw@sisk.pl> <200806200152.45617.rjw@sisk.pl>
	<200806201759.23863.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200806201759.23863.rjw@sisk.pl>
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
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

Also, it seems reasonable to add some diagnostic printk()s to pci_pm_init().

Thanks,
Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>

PCI PM: Add diagnostic statements to PCI device PM initialization

Add two diagnostic printk()s to pci_pm_init() allowing us to check
in the kernel log which PCI devices support generation of PME# and
from what states as well as which PCI devices can generate wake-up
events with the help of the platform.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

Index: linux-next/drivers/pci/pci.c
===================================================================
--- linux-next.orig/drivers/pci/pci.c
+++ linux-next/drivers/pci/pci.c
@@ -1128,14 +1128,24 @@ void pci_pm_init(struct pci_dev *dev)
 		/* Check device's ability to generate PME# */
 		pci_read_config_word(dev, pm + PCI_PM_PMC, &pmc);
 		if (pmc & PCI_PM_CAP_PME_MASK) {
+			printk(KERN_INFO "PCI: Device %s can generate PME# from"
+				"%s%s%s%s%s\n", pci_name(dev),
+				(pmc & PCI_PM_CAP_PME_D0) ? " D0" : "",
+				(pmc & PCI_PM_CAP_PME_D1) ? " D1" : "",
+				(pmc & PCI_PM_CAP_PME_D2) ? " D2" : "",
+				(pmc & PCI_PM_CAP_PME_D3) ? " D3hot" : "",
+				(pmc & PCI_PM_CAP_PME_D3cold) ? " D3cold" : "");
 			can_wakeup = true;
 			/* Disable the PME# generation capability */
 			pci_pme_active(dev, pm, false);
 		}
 	}
 
-	if (platform_pci_can_wakeup(dev))
+	if (platform_pci_can_wakeup(dev)) {
+		printk(KERN_INFO "PCI: Device %s can generate system wake-up "
+			"events through the platform\n", pci_name(dev));
 		can_wakeup = true;
+	}
 
 	device_init_wakeup(&dev->dev, can_wakeup);
 }
