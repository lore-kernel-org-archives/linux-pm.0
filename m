From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Runtime PM for PCI-based USB host controllers
Date: Tue, 1 Jun 2010 13:25:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006011157400.2949-100000__19986.4965551116$1275413342$gmane$org@iolanthe.rowland.org>
References: <20100601150645.GA10095@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100601150645.GA10095@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-pci@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 1 Jun 2010, Matthew Garrett wrote:

> On Tue, Jun 01, 2010 at 10:59:17AM -0400, Alan Stern wrote:
> 
> > Can we rely on the forbid/allow mechanism?  If userspace never allows 
> > runtime suspend for devices like the video controller then there's no 
> > problem.  Conversely, if a PCI device really doesn't have a driver and 
> > isn't used for anything, then by default it should go into a lower 
> > power state if userspace allows this.
> 
> I think that's safe, yes. Other fringe concerns include things like 
> smbus controllers - we typically won't allow a driver to bind to them 
> because they're used by ACPI, so putting the in D3 is also an error. So 
> I think Rafael's right in that we should default to forbid unless a 
> driver knows that it's safe, and let userspace override us.

Therefore the default state for unbound PCI devices should be
runtime-PM-enabled.  Devices will be put in a low-power state if
userspace allows.  Also, the PCI core should make sure that devices are
active when drivers' probe and release methods are called.

If a driver doesn't want to use runtime PM then not doing anything at 
all should leave the device with a positive usage count.  If it does 
want to use runtime PM then a pm_runtime_put_sync() during probe and 
pm_runtime_get_sync() during release will take care of everything.

Something like the patch below, awkward though it is.  Does this look 
reasonable?

Alan Stern



Index: usb-2.6/drivers/pci/bus.c
===================================================================
--- usb-2.6.orig/drivers/pci/bus.c
+++ usb-2.6/drivers/pci/bus.c
@@ -15,6 +15,7 @@
 #include <linux/proc_fs.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/pm_runtime.h>
 
 #include "pci.h"
 
@@ -134,6 +135,9 @@ pci_bus_alloc_resource(struct pci_bus *b
 int pci_bus_add_device(struct pci_dev *dev)
 {
 	int retval;
+
+	pm_runtime_set_active(&dev->dev);
+	pm_runtime_enable(&dev->dev);
 	retval = device_add(&dev->dev);
 	if (retval)
 		return retval;
Index: usb-2.6/drivers/pci/pci-driver.c
===================================================================
--- usb-2.6.orig/drivers/pci/pci-driver.c
+++ usb-2.6/drivers/pci/pci-driver.c
@@ -289,8 +289,23 @@ struct drv_dev_and_id {
 static long local_pci_probe(void *_ddi)
 {
 	struct drv_dev_and_id *ddi = _ddi;
-
-	return ddi->drv->probe(ddi->dev, ddi->id);
+	struct device *dev = &ddi->dev->dev;
+	struct device_driver *driver = dev->driver;
+	int rc;
+
+	dev->driver = NULL;
+	rc = pm_runtime_get_sync(dev);
+	dev->driver = driver;
+	if (rc < 0)
+		return rc;
+
+	rc = ddi->drv->probe(ddi->dev, ddi->id);
+	if (rc) {
+		dev->driver = NULL;
+		pm_runtime_put_sync(dev);
+		dev->driver = driver;
+	}
+	return rc;
 }
 
 static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
@@ -365,15 +380,24 @@ static int pci_device_probe(struct devic
 
 static int pci_device_remove(struct device * dev)
 {
+	struct device_driver *driver = dev->driver;
 	struct pci_dev * pci_dev = to_pci_dev(dev);
 	struct pci_driver * drv = pci_dev->driver;
 
 	if (drv) {
-		if (drv->remove)
+		if (drv->remove) {
+			pm_runtime_get_sync(dev);
 			drv->remove(pci_dev);
+			pm_runtime_put_noidle(dev);
+		}
 		pci_dev->driver = NULL;
 	}
 
+	/* Undo the pm_runtime_get_sync() in local_pci_probe() */
+	dev->driver = NULL;
+	pm_runtime_put_sync(dev);
+	dev->driver = driver;
+
 	/*
 	 * If the device is still on, set the power state as "unknown",
 	 * since it might change by the next time we load the driver.
