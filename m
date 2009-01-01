From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/4] PCI PCIe portdrv: Add kerneldoc comments to
	some core functions
Date: Thu, 1 Jan 2009 19:48:55 +0100
Message-ID: <200901011948.55555.rjw__12685.4184236892$1230836303$gmane$org@sisk.pl>
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


Add kerneldoc comments to some functions in
drivers/pci/pcie/portdrv_core.c, since the code in there is not
easy to follow without any additional description.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pcie/portdrv_core.c |   77 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 70 insertions(+), 7 deletions(-)

Index: linux-2.6/drivers/pci/pcie/portdrv_core.c
===================================================================
--- linux-2.6.orig/drivers/pci/pcie/portdrv_core.c
+++ linux-2.6/drivers/pci/pcie/portdrv_core.c
@@ -94,12 +94,12 @@ static int pcie_port_resume_service(stru
 	return 0;
 }
 
-/*
- * release_pcie_device
- *	
- *	Being invoked automatically when device is being removed 
- *	in response to device_unregister(dev) call.
- *	Release all resources being claimed.
+/**
+ * release_pcie_device - free PCI Express port service device structure
+ * @dev: Port service device to release
+ *
+ * Invoked automatically when device is being removed in response to
+ * device_unregister(dev).  Release all resources being claimed.
  */
 static void release_pcie_device(struct device *dev)
 {
@@ -128,7 +128,16 @@ static int is_msi_quirked(struct pci_dev
 	}
 	return quirk;
 }
-	
+
+/**
+ * assign_interrupt_mode - choose interrupt mode for PCI Express port services
+ *                         (INTx, MSI-X, MSI) and set up vectors
+ * @dev: PCI Express port to handle
+ * @vectors: Array of interrupt vectors to populate
+ * @mask: Bitmask of port capabilities returned by get_port_device_capability()
+ *
+ * Return value: Interrupt mode associated with the port
+ */
 static int assign_interrupt_mode(struct pci_dev *dev, int *vectors, int mask)
 {
 	int i, pos, nvec, status = -EINVAL;
@@ -177,6 +186,16 @@ static int assign_interrupt_mode(struct 
 	return interrupt_mode;
 }
 
+/**
+ * get_port_device_capability - discover capabilities of a PCI Express port
+ * @dev: PCI Express port to examine
+ *
+ * The capabilities are read from the port's PCI Express configuration registers
+ * as described in PCI Express Base Specification 1.0a sections 7.8.2, 7.8.9 and
+ * 7.9 - 7.11.
+ *
+ * Return value: Bitmask of discovered port capabilities
+ */
 static int get_port_device_capability(struct pci_dev *dev)
 {
 	int services = 0, pos;
@@ -204,6 +223,15 @@ static int get_port_device_capability(st
 	return services;
 }
 
+/**
+ * pcie_device_init - initialize PCI Express port service device
+ * @dev: Port service device to initialize
+ * @parent: PCI Express port to associate the service device with
+ * @port_type: Type of the port
+ * @service_type: Type of service to associate with the service device
+ * @irq: Interrupt vector to associate with the service device
+ * @irq_mode: Interrupt mode of the service (INTx, MSI-X, MSI)
+ */
 static void pcie_device_init(struct pci_dev *parent, struct pcie_device *dev, 
 	int port_type, int service_type, int irq, int irq_mode)
 {
@@ -229,6 +257,14 @@ static void pcie_device_init(struct pci_
 	device->parent = &parent->dev;
 }
 
+/**
+ * alloc_pcie_device - allocate PCI Express port service device structure
+ * @parent: PCI Express port to associate the service device with
+ * @port_type: Type of the port
+ * @service_type: Type of service to associate with the service device
+ * @irq: Interrupt vector to associate with the service device
+ * @irq_mode: Interrupt mode of the service (INTx, MSI-X, MSI)
+ */
 static struct pcie_device* alloc_pcie_device(struct pci_dev *parent,
 	int port_type, int service_type, int irq, int irq_mode)
 {
@@ -243,6 +279,10 @@ static struct pcie_device* alloc_pcie_de
 	return device;
 }
 
+/**
+ * pcie_port_device_probe - check if device is a PCI Express port
+ * @dev: Device to check
+ */
 int pcie_port_device_probe(struct pci_dev *dev)
 {
 	int pos, type;
@@ -260,6 +300,13 @@ int pcie_port_device_probe(struct pci_de
 	return -ENODEV;
 }
 
+/**
+ * pcie_port_device_register - register PCI Express port
+ * @dev: PCI Express port to register
+ *
+ * Allocate the port extension structure and register services associated with
+ * the port.
+ */
 int pcie_port_device_register(struct pci_dev *dev)
 {
 	struct pcie_port_device_ext *p_ext;
@@ -323,6 +370,11 @@ static int suspend_iter(struct device *d
 	return 0;
 }
 
+/**
+ * pcie_port_device_suspend - suspend port services associated with a PCIe port
+ * @dev: PCI Express port to handle
+ * @state: Representation of system power management transition in progress
+ */
 int pcie_port_device_suspend(struct pci_dev *dev, pm_message_t state)
 {
 	return device_for_each_child(&dev->dev, &state, suspend_iter);
@@ -341,6 +393,10 @@ static int resume_iter(struct device *de
 	return 0;
 }
 
+/**
+ * pcie_port_device_suspend - resume port services associated with a PCIe port
+ * @dev: PCI Express port to handle
+ */
 int pcie_port_device_resume(struct pci_dev *dev)
 {
 	return device_for_each_child(&dev->dev, NULL, resume_iter);
@@ -363,6 +419,13 @@ static int remove_iter(struct device *de
 	return 0;
 }
 
+/**
+ * pcie_port_device_remove - unregister PCI Express port service devices
+ * @dev: PCI Express port the service devices to unregister are associated with
+ *
+ * Remove PCI Express port service devices associated with given port and
+ * disable MSI-X or MSI for the port.
+ */
 void pcie_port_device_remove(struct pci_dev *dev)
 {
 	struct device *device;
