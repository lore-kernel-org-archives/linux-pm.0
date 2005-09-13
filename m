From: David Brownell <david-b@pacbell.net>
Subject: [patch 3/3] pci device wakeup flags
Date: Mon, 12 Sep 2005 19:48:14 -0700
Message-ID: <200509121948.14849.david-b@pacbell.net>
References: <200509121923.58993.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_u3jJDvDPXE1eiJA"
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200509121923.58993.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--Boundary-00=_u3jJDvDPXE1eiJA
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

And here's the PCI support, as driven by PCI PM capabilities.  On systems
using ACPI, most of these will be reported through ACPI.  (But there will
often also be PS/2 mouse and keyboard devices ...)

Two minor notes here.  One, the PCI spec says we should init some PM
stuff that we don't; that'll matter for wakeup from D3cold (but not now).
Two, some oddness in the PCI device init sequence.  Evidently some PPC
patches are on the way, but nothing in the current tree will care about
reverting that part of a recent patch.

- Dave

--Boundary-00=_u3jJDvDPXE1eiJA
Content-Type: text/x-diff;
  charset="us-ascii";
  name="pm-wake-pci.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pm-wake-pci.patch"

This patch teaches "pci_dev" about the new driver model wakeup support:

 - It marks devices as supporting wakeup when "can issue PME#" is
   listed in its PCI PM capability.

 - pci_enable_wake() refuses to enable wake if that's been disabled
   (e.g. through sysfs).

NOTE that a recent patch changed PCI probing, and this reverts part
of that change ... so that driver model initialization is again done
before the PCI setup.

(One issue is that the driver model "init + add == register" pattern isn't
being used inside PCI ...  and that probe change worsened the problem by
making "add" do some "init" too.  Maybe PCI should match the driver model
more closely, and just grow a new "pci_dev_init" function.)

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- g26.orig/drivers/pci/probe.c	2005-09-11 18:24:11.000000000 -0700
+++ g26/drivers/pci/probe.c	2005-09-12 11:38:01.000000000 -0700
@@ -571,6 +571,7 @@ static void pci_read_irq(struct pci_dev 
 static int pci_setup_device(struct pci_dev * dev)
 {
 	u32 class;
+	u16 pm;
 
 	sprintf(pci_name(dev), "%04x:%02x:%02x.%d", pci_domain_nr(dev->bus),
 		dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
@@ -598,6 +599,19 @@ static int pci_setup_device(struct pci_d
 		pci_read_bases(dev, 6, PCI_ROM_ADDRESS);
 		pci_read_config_word(dev, PCI_SUBSYSTEM_VENDOR_ID, &dev->subsystem_vendor);
 		pci_read_config_word(dev, PCI_SUBSYSTEM_ID, &dev->subsystem_device);
+
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
 		break;
 
 	case PCI_HEADER_TYPE_BRIDGE:		    /* bridge header */
@@ -737,6 +751,7 @@ pci_scan_device(struct pci_bus *bus, int
 	memset(dev, 0, sizeof(struct pci_dev));
 	dev->bus = bus;
 	dev->sysdata = bus->sysdata;
+	device_initialize(&dev->dev);
 	dev->dev.parent = bus->bridge;
 	dev->dev.bus = &pci_bus_type;
 	dev->devfn = devfn;
@@ -759,7 +774,6 @@ pci_scan_device(struct pci_bus *bus, int
 
 void __devinit pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 {
-	device_initialize(&dev->dev);
 	dev->dev.release = pci_release_dev;
 	pci_dev_get(dev);
 
--- g26.orig/drivers/pci/pci.c	2005-09-11 18:24:11.000000000 -0700
+++ g26/drivers/pci/pci.c	2005-09-11 18:25:12.000000000 -0700
@@ -531,6 +531,10 @@ int pci_enable_wake(struct pci_dev *dev,
 	if (!pm) 
 		return enable ? -EIO : 0; 
 
+	/* don't enable unless policy set through driver core allows it */
+	if (!device_may_wakeup(&dev->dev) && enable)
+		return -EROFS;
+
 	/* Check device's ability to generate PME# */
 	pci_read_config_word(dev,pm+PCI_PM_PMC,&value);
 

--Boundary-00=_u3jJDvDPXE1eiJA
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--Boundary-00=_u3jJDvDPXE1eiJA--
