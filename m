From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 6/8] PM: Allow PCI devices to suspend/resume
	asynchronously
Date: Sun, 24 Jan 2010 00:39:40 +0100
Message-ID: <201001240039.40419.rjw__19612.1434601539$1264291088$gmane$org@sisk.pl>
References: <201001240033.34253.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001240033.34253.rjw@sisk.pl>
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
Cc: Nigel Cunningham <ncunningham@crca.org.au>, Greg KH <gregkh@suse.de>, Linux SCSI <linux-scsi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, linux-usb@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, James Bottomley <James.Bottomley@suse.de>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Set power.async_suspend for all PCI devices and PCIe port services,
so that they can be suspended and resumed in parallel with other
devices they don't depend on in a known way (i.e. devices which are
not their parents or children).

This only affects the "regular" suspend and resume stages, which
means in particular that the restoration of the PCI devices' standard
configuration registers during resume will still be carried out
synchronously (at the "early" resume stage).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci.c               |    1 +
 drivers/pci/pcie/portdrv_core.c |    1 +
 drivers/pci/probe.c             |    1 +
 3 files changed, 3 insertions(+)

Index: linux-2.6/drivers/pci/pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci.c
+++ linux-2.6/drivers/pci/pci.c
@@ -1541,6 +1541,7 @@ void pci_pm_init(struct pci_dev *dev)
 	int pm;
 	u16 pmc;
 
+	device_enable_async_suspend(&dev->dev);
 	dev->wakeup_prepared = false;
 	dev->pm_cap = 0;
 
Index: linux-2.6/drivers/pci/pcie/portdrv_core.c
===================================================================
--- linux-2.6.orig/drivers/pci/pcie/portdrv_core.c
+++ linux-2.6/drivers/pci/pcie/portdrv_core.c
@@ -285,6 +285,7 @@ static int pcie_device_init(struct pci_d
 		     pci_name(pdev),
 		     get_descriptor_id(pdev->pcie_type, service));
 	device->parent = &pdev->dev;
+	device_enable_async_suspend(device);
 
 	retval = device_register(device);
 	if (retval)
Index: linux-2.6/drivers/pci/probe.c
===================================================================
--- linux-2.6.orig/drivers/pci/probe.c
+++ linux-2.6/drivers/pci/probe.c
@@ -1200,6 +1200,7 @@ struct pci_bus * pci_create_bus(struct d
 	if (error)
 		goto dev_reg_err;
 	b->bridge = get_device(dev);
+	device_enable_async_suspend(b->bridge);
 
 	if (!parent)
 		set_dev_node(b->bridge, pcibus_to_node(b));
