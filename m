From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 4/4] PCI PCIe portdrv: Add kerneldoc comments to
	remining core funtions
Date: Thu, 1 Jan 2009 19:53:32 +0100
Message-ID: <200901011953.32583.rjw__9754.87232576615$1230836273$gmane$org@sisk.pl>
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


Add kerneldoc comments to the reamining functions in
drivers/pci/pcie/portdrv_core.c .

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pcie/portdrv_core.c |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

Index: linux-2.6/drivers/pci/pcie/portdrv_core.c
===================================================================
--- linux-2.6.orig/drivers/pci/pcie/portdrv_core.c
+++ linux-2.6/drivers/pci/pcie/portdrv_core.c
@@ -374,6 +374,14 @@ void pcie_port_device_remove(struct pci_
 		pci_disable_msi(dev);
 }
 
+/**
+ * pcie_port_probe_service - probe driver for given PCI Express port service
+ * @dev: PCI Express port service device to probe against
+ *
+ * If PCI Express port service driver is registered with
+ * pcie_port_service_register(), this function will be called by the driver core
+ * whenever match is found between the driver and a port service device.
+ */
 static int pcie_port_probe_service(struct device *dev)
 {
 	struct pcie_device *pciedev;
@@ -397,6 +405,15 @@ static int pcie_port_probe_service(struc
 	return status;
 }
 
+/**
+ * pcie_port_remove_service - detach driver from given PCI Express port service
+ * @dev: PCI Express port service device to handle
+ *
+ * If PCI Express port service driver is registered with
+ * pcie_port_service_register(), this function will be called by the driver core
+ * when device_unregister() is called for the port service device associated
+ * with the driver.
+ */
 static int pcie_port_remove_service(struct device *dev)
 {
 	struct pcie_device *pciedev;
@@ -416,8 +433,21 @@ static int pcie_port_remove_service(stru
 	return 0;
 }
 
+/**
+ * pcie_port_shutdown_service - shut down given PCI Express port service
+ * @dev: PCI Express port service device to handle
+ *
+ * If PCI Express port service driver is registered with
+ * pcie_port_service_register(), this function will be called by the driver core
+ * when device_shutdown() is called for the port service device associated
+ * with the driver.
+ */
 static void pcie_port_shutdown_service(struct device *dev) {}
 
+/**
+ * pcie_port_service_register - register PCI Express port service driver
+ * @new: PCI Express port service driver to register
+ */
 int pcie_port_service_register(struct pcie_port_service_driver *new)
 {
 	new->driver.name = (char *)new->name;
@@ -429,6 +459,10 @@ int pcie_port_service_register(struct pc
 	return driver_register(&new->driver);
 }
 
+/**
+ * pcie_port_service_unregister - unregister PCI Express port service driver
+ * @drv: PCI Express port service driver to unregister
+ */
 void pcie_port_service_unregister(struct pcie_port_service_driver *drv)
 {
 	driver_unregister(&drv->driver);
