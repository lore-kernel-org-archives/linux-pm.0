From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/10] PCI / PCIe: Introduce commad line switch
	for disabling port services
Date: Sat, 21 Aug 2010 01:51:44 +0200
Message-ID: <201008210151.44353.rjw__43053.3664919951$1282349439$gmane$org@sisk.pl>
References: <201008060303.51224.rjw@sisk.pl> <201008210149.39576.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201008210149.39576.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, linux-pm@lists.linux-foundation.org, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Introduce kernel command line switch pcie_ports= allowing one to
disable all of the native PCIe port services, so that PCIe ports
are treated like PCI-to-PCI bridges.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 Documentation/kernel-parameters.txt |    4 ++++
 drivers/pci/pcie/portdrv.h          |    2 ++
 drivers/pci/pcie/portdrv_core.c     |    3 +++
 drivers/pci/pcie/portdrv_pci.c      |   15 +++++++++++++++
 4 files changed, 24 insertions(+)

Index: linux-2.6/drivers/pci/pcie/portdrv_pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pcie/portdrv_pci.c
+++ linux-2.6/drivers/pci/pcie/portdrv_pci.c
@@ -29,6 +29,18 @@ MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
+/* If this switch is set, PCIe port native services should not be enabled. */
+bool pcie_ports_disabled;
+
+static int __init pcie_port_setup(char *str)
+{
+	if (!strncmp(str, "compat", 6))
+		pcie_ports_disabled = true;
+
+	return 1;
+}
+__setup("pcie_ports=", pcie_port_setup);
+
 /* global data */
 
 static int pcie_portdrv_restore_config(struct pci_dev *dev)
@@ -301,6 +313,9 @@ static int __init pcie_portdrv_init(void
 {
 	int retval;
 
+	if (pcie_ports_disabled)
+		return -EACCES;
+
 	dmi_check_system(pcie_portdrv_dmi_table);
 
 	retval = pcie_port_bus_register();
Index: linux-2.6/Documentation/kernel-parameters.txt
===================================================================
--- linux-2.6.orig/Documentation/kernel-parameters.txt
+++ linux-2.6/Documentation/kernel-parameters.txt
@@ -1974,6 +1974,10 @@ and is between 256 and 4096 characters. 
 		force	Enable ASPM even on devices that claim not to support it.
 			WARNING: Forcing ASPM on may cause system lockups.
 
+	pcie_ports=	[PCIE] PCIe ports handling:
+		compat	Treat PCIe ports as PCI-to-PCI bridges, disable the PCIe
+			ports driver.
+
 	pcie_pme=	[PCIE,PM] Native PCIe PME signaling options:
 			Format: {auto|force}[,nomsi]
 		auto	Use native PCIe PME signaling if the BIOS allows the
Index: linux-2.6/drivers/pci/pcie/portdrv.h
===================================================================
--- linux-2.6.orig/drivers/pci/pcie/portdrv.h
+++ linux-2.6/drivers/pci/pcie/portdrv.h
@@ -20,6 +20,8 @@
 
 #define get_descriptor_id(type, service) (((type - 4) << 4) | service)
 
+extern bool pcie_ports_disabled;
+
 extern struct bus_type pcie_port_bus_type;
 extern int pcie_port_device_register(struct pci_dev *dev);
 #ifdef CONFIG_PM
Index: linux-2.6/drivers/pci/pcie/portdrv_core.c
===================================================================
--- linux-2.6.orig/drivers/pci/pcie/portdrv_core.c
+++ linux-2.6/drivers/pci/pcie/portdrv_core.c
@@ -494,6 +494,9 @@ static void pcie_port_shutdown_service(s
  */
 int pcie_port_service_register(struct pcie_port_service_driver *new)
 {
+	if (pcie_ports_disabled)
+		return -ENODEV;
+
 	new->driver.name = (char *)new->name;
 	new->driver.bus = &pcie_port_bus_type;
 	new->driver.probe = pcie_port_probe_service;
