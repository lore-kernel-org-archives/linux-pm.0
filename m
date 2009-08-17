From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 5/7] PM: Asynchronous suspend and resume of
	PCI devices
Date: Mon, 17 Aug 2009 02:20:18 +0200
Message-ID: <200908170220.18874.rjw__49556.6798410893$1250469126$gmane$org@sisk.pl>
References: <200908122218.13975.rjw@sisk.pl> <200908170215.21173.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908170215.21173.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm <linux-pm@lists.linux-foundation.org>
Cc: Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Set async_suspend for all PCI devices and PCIe port services.

---
 drivers/input/serio/i8042.c     |    2 ++
 drivers/pci/pci.c               |    2 ++
 drivers/pci/pcie/portdrv_core.c |    1 +
 3 files changed, 5 insertions(+)

Index: linux-2.6/drivers/pci/pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci.c
+++ linux-2.6/drivers/pci/pci.c
@@ -1409,6 +1409,8 @@ void pci_pm_init(struct pci_dev *dev)
 	} else {
 		dev->pme_support = 0;
 	}
+
+	device_enable_async_suspend(&dev->dev, true);
 }
 
 /**
Index: linux-2.6/drivers/pci/pcie/portdrv_core.c
===================================================================
--- linux-2.6.orig/drivers/pci/pcie/portdrv_core.c
+++ linux-2.6/drivers/pci/pcie/portdrv_core.c
@@ -280,6 +280,7 @@ static void pcie_device_init(struct pci_
 	dev_set_name(device, "%s:pcie%02x",
 		 pci_name(parent), get_descriptor_id(port_type, service_type));
 	device->parent = &parent->dev;
+	device_enable_async_suspend(device, true);
 }
 
 /**
