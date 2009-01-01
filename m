From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/4] PCI PCIe portdrv: Fix suspend and resume of
	PCI Express port services
Date: Thu, 1 Jan 2009 19:51:15 +0100
Message-ID: <200901011951.15391.rjw__46512.0675544769$1230836294$gmane$org@sisk.pl>
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


There is a problem with the suspend and resume of PCI Express port
service devices that the ->suspend() and ->resume() routines of each
service device are called twice in each suspend-resume cycle, which
is obviously wrong.

The scenario is that first, the PCI Express port driver calls
suspend and resume routines of each port service driver from its
pcie_portdrv_suspend() and pcie_portdrv_resume() callbacks,
respectively (which is correct), and second, the pcie_port_bus_type
driver calls them from its ->suspend() and ->resume() callbacks
(which is not correct, because it doesn't happen at the right time).

The solution is to remove the ->suspend() and ->resume() callbacks
from pcie_port_bus_type and the associated functions.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pcie/portdrv_bus.c  |   34 ----------------------------------
 drivers/pci/pcie/portdrv_core.c |   33 ---------------------------------
 2 files changed, 67 deletions(-)

Index: linux-2.6/drivers/pci/pcie/portdrv_bus.c
===================================================================
--- linux-2.6.orig/drivers/pci/pcie/portdrv_bus.c
+++ linux-2.6/drivers/pci/pcie/portdrv_bus.c
@@ -16,14 +16,10 @@
 #include "portdrv.h"
 
 static int pcie_port_bus_match(struct device *dev, struct device_driver *drv);
-static int pcie_port_bus_suspend(struct device *dev, pm_message_t state);
-static int pcie_port_bus_resume(struct device *dev);
 
 struct bus_type pcie_port_bus_type = {
 	.name 		= "pci_express",
 	.match 		= pcie_port_bus_match,
-	.suspend	= pcie_port_bus_suspend,
-	.resume		= pcie_port_bus_resume, 
 };
 EXPORT_SYMBOL_GPL(pcie_port_bus_type);
 
@@ -48,33 +44,3 @@ static int pcie_port_bus_match(struct de
 
 	return 1;
 }
-
-static int pcie_port_bus_suspend(struct device *dev, pm_message_t state)
-{
-	struct pcie_device *pciedev;
-	struct pcie_port_service_driver *driver;
-
-	if (!dev || !dev->driver)
-		return 0;
-
-	pciedev = to_pcie_device(dev);
- 	driver = to_service_driver(dev->driver);
-	if (driver && driver->suspend)
-		driver->suspend(pciedev, state);
-	return 0;
-}
-
-static int pcie_port_bus_resume(struct device *dev)
-{
-	struct pcie_device *pciedev;
-	struct pcie_port_service_driver *driver;
-
-	if (!dev || !dev->driver)
-		return 0;
-
-	pciedev = to_pcie_device(dev);
- 	driver = to_service_driver(dev->driver);
-	if (driver && driver->resume)
-		driver->resume(pciedev);
-	return 0;
-}
Index: linux-2.6/drivers/pci/pcie/portdrv_core.c
===================================================================
--- linux-2.6.orig/drivers/pci/pcie/portdrv_core.c
+++ linux-2.6/drivers/pci/pcie/portdrv_core.c
@@ -63,37 +63,6 @@ static int pcie_port_remove_service(stru
 
 static void pcie_port_shutdown_service(struct device *dev) {}
 
-static int pcie_port_suspend_service(struct device *dev, pm_message_t state)
-{
-	struct pcie_device *pciedev;
-	struct pcie_port_service_driver *driver;
-
-	if (!dev || !dev->driver)
-		return 0;
-
-	pciedev = to_pcie_device(dev);
- 	driver = to_service_driver(dev->driver);
-	if (driver && driver->suspend)
-		driver->suspend(pciedev, state);
-	return 0;
-}
-
-static int pcie_port_resume_service(struct device *dev)
-{
-	struct pcie_device *pciedev;
-	struct pcie_port_service_driver *driver;
-
-	if (!dev || !dev->driver)
-		return 0;
-
-	pciedev = to_pcie_device(dev);
- 	driver = to_service_driver(dev->driver);
-
-	if (driver && driver->resume)
-		driver->resume(pciedev);
-	return 0;
-}
-
 /**
  * release_pcie_device - free PCI Express port service device structure
  * @dev: Port service device to release
@@ -466,8 +435,6 @@ int pcie_port_service_register(struct pc
 	new->driver.probe = pcie_port_probe_service;
 	new->driver.remove = pcie_port_remove_service;
 	new->driver.shutdown = pcie_port_shutdown_service;
-	new->driver.suspend = pcie_port_suspend_service;
-	new->driver.resume = pcie_port_resume_service;
 
 	return driver_register(&new->driver);
 }
