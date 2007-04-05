From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.21-rc5-git 3/3] PCI inits driver model flags
Date: Thu, 5 Apr 2007 12:49:18 -0700
Message-ID: <200704051249.18470.david-b__39736.4564858892$1175803734$gmane$org@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch teaches "pci_dev" about the driver model wakeup support, by
marking devices as supporting wakeup when the PME# capability is listed
in a PCI PM capability.  Right now, few PCI drivers support wakeup events:
only USB hosts, and various network drivers.

A previous version of this patch broke on PowerPC platforms because they
changed how they do early PCI initialization some time ago (after the first
version of this patch).  Potentially the fix involves switching PCI init on
all platforms so they all adopt the driver model "init() then add()" model,
calling device_initialize() early and pci_setup_device() before device_add(=
).

Also, note that ACPI has its own notions of what devices are wakeup-capable.
Assuming that the PCI PM# capability is queried before calling device_add()
to initialize driver model wakeup flags, ACPI overrides those settings for
devices with entries in ACPI tables in its platform_notify().

That's how ACPI kicks in legacy PCI PM (e.g. many/most Intel UHCI controlle=
rs
don't use PME#), declares that _it_ will handle SMBUSALERT# thank you, and
handles various other board quirks.  The fact that ACPI flags some bridges =
as
wakeup-capable is puzzling though; I'm guessing it relates to whether PME#
(or WAKE# on PCIE#, etc) is actually wired up to add-on cards.


NOT YET READY FOR PRIME TIME ... expected to still break PowerPC.
---
 g26/drivers/pci/probe.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletion(-)

--- g26.orig/drivers/pci/probe.c	2007-04-04 12:26:06.000000000 -0700
+++ g26/drivers/pci/probe.c	2007-04-05 06:04:41.000000000 -0700
@@ -724,6 +724,7 @@ static void change_legacy_io_resource(st
 static int pci_setup_device(struct pci_dev * dev)
 {
 	u32 class;
+	u16 pm;
 =

 	sprintf(pci_name(dev), "%04x:%02x:%02x.%d", pci_domain_nr(dev->bus),
 		dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
@@ -752,6 +753,19 @@ static int pci_setup_device(struct pci_d
 		pci_read_config_word(dev, PCI_SUBSYSTEM_VENDOR_ID, &dev->subsystem_vendo=
r);
 		pci_read_config_word(dev, PCI_SUBSYSTEM_ID, &dev->subsystem_device);
 =

+		/* PCI PM capable devices may be able to issue PME# (wakeup) */
+		pm =3D pci_find_capability(dev, PCI_CAP_ID_PM);
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
@@ -910,6 +924,7 @@ pci_scan_device(struct pci_bus *bus, int
 =

 	dev->bus =3D bus;
 	dev->sysdata =3D bus->sysdata;
+	device_initialize(&dev->dev);
 	dev->dev.parent =3D bus->bridge;
 	dev->dev.bus =3D &pci_bus_type;
 	dev->devfn =3D devfn;
@@ -933,7 +948,6 @@ pci_scan_device(struct pci_bus *bus, int
 =

 void __devinit pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 {
-	device_initialize(&dev->dev);
 	dev->dev.release =3D pci_release_dev;
 	pci_dev_get(dev);
 =
