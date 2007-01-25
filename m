From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [PATCH]switching off autosuspend
 through sysfs
Date: Thu, 25 Jan 2007 11:03:21 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0701251058580.3958-100000@iolanthe.rowland.org>
References: <20070125012813.GA17695@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20070125012813.GA17695@kroah.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: Greg KH <greg@kroah.com>
Cc: oneukum@suse.de, Greg KH <gregkh@suse.de>, Linux-pm mailing list <linux-pm@lists.osdl.org>, USB development list <linux-usb-devel@lists.sourceforge.net>
List-Id: linux-pm@vger.kernel.org

On Wed, 24 Jan 2007, Greg KH wrote:

> > > Would it help to add a flag somewhere in struct device (or struct
> > > dev_pm_info) for indicating that the device is not cognizant of PM?  For
> > > instance, all those USB endpoint pseudo-devices we create -- it's a waste
> > > of time to try doing power management on them and it generates a bunch of
> > > useless and distracting warning messages in the system log.
> > 
> > Yes.  In fact we should just make it a "has pm" type flag, as the
> > majority of devices do not.
> > 
> > So, what kind of devices do support these files?  I can think of:
> > 	PCI
> > 	USB
> > and that's it right now.  Do platform devices really use those files?
> 
> Something as simple as this patch perhaps?

I had something bigger in mind.  More like the patch below (completely 
untested).  Plus of course code to turn off the new flag for the 
appropriate devices.

Alan Stern


Index: usb-2.6/drivers/base/power/sysfs.c
===================================================================
--- usb-2.6.orig/drivers/base/power/sysfs.c
+++ usb-2.6/drivers/base/power/sysfs.c
@@ -152,10 +152,13 @@ static struct attribute_group pm_attr_gr
 
 int dpm_sysfs_add(struct device * dev)
 {
-	return sysfs_create_group(&dev->kobj, &pm_attr_group);
+	if (dev->supports_pm)
+		return sysfs_create_group(&dev->kobj, &pm_attr_group);
+	return 0;
 }
 
 void dpm_sysfs_remove(struct device * dev)
 {
-	sysfs_remove_group(&dev->kobj, &pm_attr_group);
+	if (dev->supports_pm)
+		sysfs_remove_group(&dev->kobj, &pm_attr_group);
 }
Index: usb-2.6/drivers/pci/probe.c
===================================================================
--- usb-2.6.orig/drivers/pci/probe.c
+++ usb-2.6/drivers/pci/probe.c
@@ -893,6 +893,7 @@ pci_scan_device(struct pci_bus *bus, int
 	dev->sysdata = bus->sysdata;
 	dev->dev.parent = bus->bridge;
 	dev->dev.bus = &pci_bus_type;
+	dev->dev.supports_pm = 1;
 	dev->devfn = devfn;
 	dev->hdr_type = hdr_type & 0x7f;
 	dev->multifunction = !!(hdr_type & 0x80);
Index: usb-2.6/include/linux/device.h
===================================================================
--- usb-2.6.orig/include/linux/device.h
+++ usb-2.6/include/linux/device.h
@@ -367,6 +367,7 @@ struct device {
 	char	bus_id[BUS_ID_SIZE];	/* position on parent bus */
 	struct device_type	*type;
 	unsigned		is_registered:1;
+	unsigned		supports_pm:1;
 	struct device_attribute uevent_attr;
 	struct device_attribute *devt_attr;
 
Index: usb-2.6/drivers/base/power/resume.c
===================================================================
--- usb-2.6.orig/drivers/base/power/resume.c
+++ usb-2.6/drivers/base/power/resume.c
@@ -24,6 +24,9 @@ int resume_device(struct device * dev)
 {
 	int error = 0;
 
+	if (!dev->supports_pm)
+		return error;
+
 	TRACE_DEVICE(dev);
 	TRACE_RESUME(0);
 	down(&dev->sem);
@@ -52,6 +55,9 @@ static int resume_device_early(struct de
 {
 	int error = 0;
 
+	if (!dev->supports_pm)
+		return error;
+
 	TRACE_DEVICE(dev);
 	TRACE_RESUME(0);
 	if (dev->bus && dev->bus->resume_early) {
Index: usb-2.6/drivers/base/power/suspend.c
===================================================================
--- usb-2.6.orig/drivers/base/power/suspend.c
+++ usb-2.6/drivers/base/power/suspend.c
@@ -50,6 +50,9 @@ int suspend_device(struct device * dev, 
 {
 	int error = 0;
 
+	if (!dev->supports_pm)
+		return error;
+
 	down(&dev->sem);
 	if (dev->power.power_state.event) {
 		dev_dbg(dev, "PM: suspend %d-->%d\n",
@@ -103,7 +106,8 @@ static int suspend_device_late(struct de
 {
 	int error = 0;
 
-	if (dev->bus && dev->bus->suspend_late && !dev->power.power_state.event) {
+	if (dev->supports_pm && dev->bus && dev->bus->suspend_late &&
+			!dev->power.power_state.event) {
 		dev_dbg(dev, "LATE %s%s\n",
 			suspend_verb(state.event),
 			((state.event == PM_EVENT_SUSPEND)


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
