From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 4/9] PM: Allow PCI devices to suspend/resume
	asynchronously
Date: Thu, 10 Sep 2009 01:36:56 +0200
Message-ID: <200909100136.56111.rjw__26791.3873460659$1252539983$gmane$org@sisk.pl>
References: <200909100127.11252.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200909100127.11252.rjw@sisk.pl>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Set async_suspend for all PCI devices and PCIe port services, so that
they can be suspended and resumed asynchronously with other devices
they don't depend on in a known way (i.e. devices which are not their
parents or children and to which they are not connected via struct
pm_link objects).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci.c               |    1 +
 drivers/pci/pcie/portdrv_core.c |    1 +
 2 files changed, 2 insertions(+)

Index: linux-2.6/drivers/pci/pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci.c
+++ linux-2.6/drivers/pci/pci.c
@@ -1373,6 +1373,7 @@ void pci_pm_init(struct pci_dev *dev)
 	int pm;
 	u16 pmc;
 
+	device_enable_async_suspend(&dev->dev, true);
 	dev->wakeup_prepared = false;
 	dev->pm_cap = 0;
 
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
