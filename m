From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] [PATCH]switching off autosuspend
	through sysfs
Date: Thu, 25 Jan 2007 03:13:48 -0800
Message-ID: <200701250313.49104.david-b@pacbell.net>
References: <20070124003221.GA3755@suse.de> <20070125011523.GA4542@suse.de>
	<200701241815.22007.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200701241815.22007.david-b@pacbell.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: linux-pm@lists.osdl.org
Cc: oneukum@suse.de, Greg KH <gregkh@suse.de>, USB development list <linux-usb-devel@lists.sourceforge.net>
List-Id: linux-pm@vger.kernel.org

On Wednesday 24 January 2007 6:15 pm, David Brownell wrote:

> > So, what kind of devices do support these files?  I can think of:
> > 	PCI
> 
> Actually, PCI still doesn't because of strangeness in the init
> sequencing on at least PPC ... I can forward the patch that makes
> X86 init the wakeup flag from the PM attributes.

And here it is.  Last refreshed against 2.6.20-rc5; it still works
like a charm on x86.  (As it did since before that PPC patch...)
I have no idea whether this still makes trouble on PPC.

- Dave


=================	CUT HERE
This patch teaches "pci_dev" about the driver model wakeup support:

 - It marks devices as supporting wakeup when the PME# capability is
   listed in its PCI PM capability.

 - pci_enable_wake() refuses to enable wake if that's been disabled
   (e.g. through sysfs).

NOTE that PowerPC does PCI probing a bit differently ... which evidently
causes this to fail on that platform (and maybe others).

One issue is that the driver model "init + add == register" pattern isn't
used inside PCI ...  and the PCI probe change that made PowerPC happier
worsened the problem by making "add" do some "init" too.  Maybe PCI should
match the driver model a lot more closely and grow a "pci_dev_init()".


Index: g26/drivers/pci/probe.c
===================================================================
--- g26.orig/drivers/pci/probe.c	2007-01-20 05:09:21.000000000 -0800
+++ g26/drivers/pci/probe.c	2007-01-20 05:18:42.000000000 -0800
@@ -654,6 +654,7 @@ static void pci_read_irq(struct pci_dev 
 static int pci_setup_device(struct pci_dev * dev)
 {
 	u32 class;
+	u16 pm;
 
 	sprintf(pci_name(dev), "%04x:%02x:%02x.%d", pci_domain_nr(dev->bus),
 		dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
@@ -682,6 +683,19 @@ static int pci_setup_device(struct pci_d
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
@@ -848,6 +862,7 @@ pci_scan_device(struct pci_bus *bus, int
 
 	dev->bus = bus;
 	dev->sysdata = bus->sysdata;
+	device_initialize(&dev->dev);
 	dev->dev.parent = bus->bridge;
 	dev->dev.bus = &pci_bus_type;
 	dev->devfn = devfn;
@@ -871,7 +886,6 @@ pci_scan_device(struct pci_bus *bus, int
 
 void __devinit pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 {
-	device_initialize(&dev->dev);
 	dev->dev.release = pci_release_dev;
 	pci_dev_get(dev);
 
Index: g26/drivers/pci/pci.c
===================================================================
--- g26.orig/drivers/pci/pci.c	2007-01-20 05:18:31.000000000 -0800
+++ g26/drivers/pci/pci.c	2007-01-20 05:18:42.000000000 -0800
@@ -817,6 +817,10 @@ int pci_enable_wake(struct pci_dev *dev,
 	if (!pm) 
 		return enable ? -EIO : 0; 
 
+	/* don't enable unless policy set through driver core allows it */
+	if (!device_may_wakeup(&dev->dev) && enable)
+		return -EROFS;
+
 	/* Check device's ability to generate PME# */
 	pci_read_config_word(dev,pm+PCI_PM_PMC,&value);
 



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
