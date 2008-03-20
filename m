From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.25-rc6 7/7] PCI set up
	device.power.can_wakeup flags
Date: Thu, 20 Mar 2008 14:25:54 -0700
Message-ID: <200803201425.54587.david-b__42994.2319904969$1206049364$gmane$org@pacbell.net>
References: <200803201408.33466.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803201408.33466.david-b@pacbell.net>
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
To: linux-pm@lists.linux-foundation.org
Cc: linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch teaches "pci_dev" about the driver model wakeup support, by
marking devices as supporting wakeup when the PME# capability is listed
in a PCI PM capability.  Right now, few PCI drivers support wakeup events:
only USB hosts, and various network drivers.

A previous version of this patch broke on PowerPC platforms after they
changed how they do early PCI initialization (following the first version
of this patch).  Potentially the real fix involves switching PCI init on
all platforms so they all adopt the driver model "init() then add()" model,
calling device_initialize() early and pci_setup_device() before device_add().

Also, note that ACPI has its own notions of what devices are wakeup-capable.
Assuming that the PCI PM# capability is queried before calling device_add()
to initialize driver model wakeup flags, ACPI overrides those settings for
devices with entries in ACPI tables in its platform_notify().

That's how ACPI kicks in legacy PCI PM (e.g. Intel's UHCI controllers
don't use PME#), declares that _it_ will handle SMBUSALERT# thank you, and
handles various other board quirks.

The fact that ACPI flags some bridges as wakeup-capable is puzzling though.
I'm guessing it relates to whether PME# (or WAKE# on PCIE, etc) is actually
wired up for use by add-on cards, and this marks an area where ACPI doesn't
yet work correctly (it doesn't handle such wakeups).


NOT YET READY FOR PRIME TIME ... expected to still break PowerPC.
---
 drivers/pci/probe.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

--- g26.orig/drivers/pci/probe.c	2008-02-24 00:18:23.000000000 -0800
+++ g26/drivers/pci/probe.c	2008-02-24 01:02:30.000000000 -0800
@@ -678,6 +678,7 @@ static void pci_read_irq(struct pci_dev 
 static int pci_setup_device(struct pci_dev * dev)
 {
 	u32 class;
+	u16 pm;
 
 	sprintf(pci_name(dev), "%04x:%02x:%02x.%d", pci_domain_nr(dev->bus),
 		dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
@@ -707,6 +708,19 @@ static int pci_setup_device(struct pci_d
 		pci_read_config_word(dev, PCI_SUBSYSTEM_VENDOR_ID, &dev->subsystem_vendor);
 		pci_read_config_word(dev, PCI_SUBSYSTEM_ID, &dev->subsystem_device);
 
+		/* PCI PM capable devices may be able to issue PME# (wakeup) */
+		pm = pci_find_capability(dev, PCI_CAP_ID_PM);
+		if (pm) {
+			pci_read_config_word(dev, pm + PCI_PM_PMC, &pm);
+			if (pm & PCI_PM_CAP_PME_MASK)
+				device_init_wakeup(&dev->dev, 1);
+
+			/* REVISIT: if (pm & PCI_PM_CAP_PME_D3cold) then
+			 * pci pm spec 1.2, section 3.2.4 says we should
+			 * init PCI_PM_CTRL_PME_{STATUS,ENABLE} ...
+			 */
+		}
+
 		/*
 		 *	Do the ugly legacy mode stuff here rather than broken chip
 		 *	quirk code. Legacy mode ATA controllers have fixed
@@ -903,6 +917,7 @@ pci_scan_device(struct pci_bus *bus, int
 
 	dev->bus = bus;
 	dev->sysdata = bus->sysdata;
+	device_initialize(&dev->dev);
 	dev->dev.parent = bus->bridge;
 	dev->dev.bus = &pci_bus_type;
 	dev->devfn = devfn;
@@ -927,7 +942,6 @@ pci_scan_device(struct pci_bus *bus, int
 
 void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 {
-	device_initialize(&dev->dev);
 	dev->dev.release = pci_release_dev;
 	pci_dev_get(dev);
 
