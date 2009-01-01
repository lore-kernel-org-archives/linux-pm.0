From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/4] PCI PCIe portdrv: Rearrange code so that
	related things are together
Date: Thu, 1 Jan 2009 19:52:12 +0100
Message-ID: <200901011952.12363.rjw__38137.6362442554$1230836325$gmane$org@sisk.pl>
References: <200901011947.19872.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200901011947.19872.rjw@sisk.pl>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


Rearrange code in drivers/pci/pcie/portdrv_bus.c and
drivers/pci/pcie/portdrv_core.c so that related functions and data
structures are closer together.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pcie/portdrv_bus.c  |   10 ++++
 drivers/pci/pcie/portdrv_core.c |   90 +++++++++++++++++-----------------------
 2 files changed, 50 insertions(+), 50 deletions(-)

Index: linux-2.6/drivers/pci/pcie/portdrv_bus.c
===================================================================
--- linux-2.6.orig/drivers/pci/pcie/portdrv_bus.c
+++ linux-2.6/drivers/pci/pcie/portdrv_bus.c
@@ -44,3 +44,13 @@ static int pcie_port_bus_match(struct de
 
 	return 1;
 }
+
+int pcie_port_bus_register(void)
+{
+	return bus_register(&pcie_port_bus_type);
+}
+
+void pcie_port_bus_unregister(void)
+{
+	bus_unregister(&pcie_port_bus_type);
+}
Index: linux-2.6/drivers/pci/pcie/portdrv_core.c
===================================================================
--- linux-2.6.orig/drivers/pci/pcie/portdrv_core.c
+++ linux-2.6/drivers/pci/pcie/portdrv_core.c
@@ -19,50 +19,6 @@
 
 extern int pcie_mch_quirk;	/* MSI-quirk Indicator */
 
-static int pcie_port_probe_service(struct device *dev)
-{
-	struct pcie_device *pciedev;
-	struct pcie_port_service_driver *driver;
-	int status;
-
-	if (!dev || !dev->driver)
-		return -ENODEV;
-
- 	driver = to_service_driver(dev->driver);
-	if (!driver || !driver->probe)
-		return -ENODEV;
-
-	pciedev = to_pcie_device(dev);
-	status = driver->probe(pciedev, driver->id_table);
-	if (!status) {
-		dev_printk(KERN_DEBUG, dev, "service driver %s loaded\n",
-			driver->name);
-		get_device(dev);
-	}
-	return status;
-}
-
-static int pcie_port_remove_service(struct device *dev)
-{
-	struct pcie_device *pciedev;
-	struct pcie_port_service_driver *driver;
-
-	if (!dev || !dev->driver)
-		return 0;
-
-	pciedev = to_pcie_device(dev);
- 	driver = to_service_driver(dev->driver);
-	if (driver && driver->remove) { 
-		dev_printk(KERN_DEBUG, dev, "unloading service driver %s\n",
-			driver->name);
-		driver->remove(pciedev);
-		put_device(dev);
-	}
-	return 0;
-}
-
-static void pcie_port_shutdown_service(struct device *dev) {}
-
 /**
  * release_pcie_device - free PCI Express port service device structure
  * @dev: Port service device to release
@@ -418,16 +374,50 @@ void pcie_port_device_remove(struct pci_
 		pci_disable_msi(dev);
 }
 
-int pcie_port_bus_register(void)
+static int pcie_port_probe_service(struct device *dev)
 {
-	return bus_register(&pcie_port_bus_type);
+	struct pcie_device *pciedev;
+	struct pcie_port_service_driver *driver;
+	int status;
+
+	if (!dev || !dev->driver)
+		return -ENODEV;
+
+	driver = to_service_driver(dev->driver);
+	if (!driver || !driver->probe)
+		return -ENODEV;
+
+	pciedev = to_pcie_device(dev);
+	status = driver->probe(pciedev, driver->id_table);
+	if (!status) {
+		dev_printk(KERN_DEBUG, dev, "service driver %s loaded\n",
+			driver->name);
+		get_device(dev);
+	}
+	return status;
 }
 
-void pcie_port_bus_unregister(void)
+static int pcie_port_remove_service(struct device *dev)
 {
-	bus_unregister(&pcie_port_bus_type);
+	struct pcie_device *pciedev;
+	struct pcie_port_service_driver *driver;
+
+	if (!dev || !dev->driver)
+		return 0;
+
+	pciedev = to_pcie_device(dev);
+	driver = to_service_driver(dev->driver);
+	if (driver && driver->remove) {
+		dev_printk(KERN_DEBUG, dev, "unloading service driver %s\n",
+			driver->name);
+		driver->remove(pciedev);
+		put_device(dev);
+	}
+	return 0;
 }
 
+static void pcie_port_shutdown_service(struct device *dev) {}
+
 int pcie_port_service_register(struct pcie_port_service_driver *new)
 {
 	new->driver.name = (char *)new->name;
@@ -439,9 +429,9 @@ int pcie_port_service_register(struct pc
 	return driver_register(&new->driver);
 }
 
-void pcie_port_service_unregister(struct pcie_port_service_driver *new)
+void pcie_port_service_unregister(struct pcie_port_service_driver *drv)
 {
-	driver_unregister(&new->driver);
+	driver_unregister(&drv->driver);
 }
 
 EXPORT_SYMBOL(pcie_port_service_register);
