From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] PCI: PCIe: PME: Fix pcie_pme_remove()
Date: Thu, 28 Feb 2019 00:56:41 +0100
Message-ID: <1943648.NMEmlssb0J@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Dongdong Liu <liudongdong3@huawei.com>, Lukas Wunner <lukas@wunner.de>, Linux PCI <linux-pci@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is incorrect to call pcie_pme_suspend() from pcie_pme_remove() for
two reasons.

First, pcie_pme_suspend() calls synchronize_irq() that will wait for
the native hotplug interrupt handler as well as for the PME one,
because they share one IRQ (as per the spec).  That may deadlock if
hotplug is signaled while pcie_pme_remove() is running and the latter
calls pci_lock_rescan_remove() before the former.

Second, if pcie_pme_suspend() figures out that wakeup needs to be
enabled for the port, it will return without disabling the interrupt
as expected by pcie_pme_remove() which was overlooked by commit
c7b5a4e6e8fb ("PCI / PM: Fix native PME handling during system
suspend/resume").

To fix that, rework pcie_pme_remove() to disable the PME interrupt,
clear its status and prevent the PME worker function from re-enabling it
before calling free_irq() on it which should be sufficient.

Fixes: c7b5a4e6e8fb ("PCI / PM: Fix native PME handling during system suspend/resume")
Reported-by: Dongdong Liu <liudongdong3@huawei.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pcie/pme.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/pci/pcie/pme.c
===================================================================
--- linux-pm.orig/drivers/pci/pcie/pme.c
+++ linux-pm/drivers/pci/pcie/pme.c
@@ -363,6 +363,16 @@ static bool pcie_pme_check_wakeup(struct
 	return false;
 }
 
+static void pcie_pme_disable_interrupt(struct pci_dev *port,
+				       struct pcie_pme_service_data *data)
+{
+	spin_lock_irq(&data->lock);
+	pcie_pme_interrupt_enable(port, false);
+	pcie_clear_root_pme_status(port);
+	data->noirq = true;
+	spin_unlock_irq(&data->lock);
+}
+
 /**
  * pcie_pme_suspend - Suspend PCIe PME service device.
  * @srv: PCIe service device to suspend.
@@ -387,11 +397,7 @@ static int pcie_pme_suspend(struct pcie_
 			return 0;
 	}
 
-	spin_lock_irq(&data->lock);
-	pcie_pme_interrupt_enable(port, false);
-	pcie_clear_root_pme_status(port);
-	data->noirq = true;
-	spin_unlock_irq(&data->lock);
+	pcie_pme_disable_interrupt(port, data);
 
 	synchronize_irq(srv->irq);
 
@@ -427,9 +433,11 @@ static int pcie_pme_resume(struct pcie_d
  */
 static void pcie_pme_remove(struct pcie_device *srv)
 {
-	pcie_pme_suspend(srv);
+	struct pcie_pme_service_data *data = get_service_data(srv);
+
+	pcie_pme_disable_interrupt(srv->port, data);
 	free_irq(srv->irq, srv);
-	kfree(get_service_data(srv));
+	kfree(data);
 }
 
 static int pcie_pme_runtime_suspend(struct pcie_device *srv)
