From: Greg KH <greg@kroah.com>
Subject: Re: [linux-pm] [PATCH]switching off autosuspend
	through sysfs
Date: Wed, 24 Jan 2007 17:28:13 -0800
Message-ID: <20070125012813.GA17695@kroah.com>
References: <20070124003221.GA3755@suse.de>
	<Pine.LNX.4.44L0.0701241145140.4368-100000@iolanthe.rowland.org>
	<20070125011523.GA4542@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20070125011523.GA4542@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: Greg KH <gregkh@suse.de>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, oneukum@suse.de, Alan Stern <stern@rowland.harvard.edu>, USB development list <linux-usb-devel@lists.sourceforge.net>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 24, 2007 at 05:15:24PM -0800, Greg KH wrote:
> On Wed, Jan 24, 2007 at 11:51:17AM -0500, Alan Stern wrote:
> > On Tue, 23 Jan 2007, Greg KH wrote:
> > 
> > > On Tue, Jan 23, 2007 at 04:22:43PM -0800, David Brownell wrote:
> > > > > > >  static struct attribute *dev_attrs[] = {
> > > > > > > +	/* power management attributes */
> > > > > > > +	&dev_attr_autosuspend.attr,
> > > > > > 
> > > > > > Belongs in /sys/devices/.../power/... then, right?
> > > > >
> > > > > No, I thought we want to drop that power/ directory.
> > > > 
> > > > Dropping that directory hasn't AFAIK ever been discussed.
> > > > If it were to be dropped, where would the per-device wakeup
> > > > flags live?
> > > 
> > > I don't know, it just really annoys me to see that power directory there
> > > with no use for it for a lot of devices :)
> > 
> > Would it help to add a flag somewhere in struct device (or struct
> > dev_pm_info) for indicating that the device is not cognizant of PM?  For
> > instance, all those USB endpoint pseudo-devices we create -- it's a waste
> > of time to try doing power management on them and it generates a bunch of
> > useless and distracting warning messages in the system log.
> 
> Yes.  In fact we should just make it a "has pm" type flag, as the
> majority of devices do not.
> 
> So, what kind of devices do support these files?  I can think of:
> 	PCI
> 	USB
> and that's it right now.  Do platform devices really use those files?

Something as simple as this patch perhaps?

thanks,

greg k-h

---
 drivers/base/power/sysfs.c |    7 +++++--
 drivers/pci/probe.c        |    1 +
 include/linux/device.h     |    1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

--- gregkh-2.6.orig/drivers/base/power/sysfs.c
+++ gregkh-2.6/drivers/base/power/sysfs.c
@@ -156,10 +156,13 @@ static struct attribute_group pm_attr_gr
 
 int dpm_sysfs_add(struct device * dev)
 {
-	return sysfs_create_group(&dev->kobj, &pm_attr_group);
+	if (dev->supports_power)
+		return sysfs_create_group(&dev->kobj, &pm_attr_group);
+	return 0;
 }
 
 void dpm_sysfs_remove(struct device * dev)
 {
-	sysfs_remove_group(&dev->kobj, &pm_attr_group);
+	if (dev->supports_power)
+		sysfs_remove_group(&dev->kobj, &pm_attr_group);
 }
--- gregkh-2.6.orig/drivers/pci/probe.c
+++ gregkh-2.6/drivers/pci/probe.c
@@ -893,6 +893,7 @@ pci_scan_device(struct pci_bus *bus, int
 	dev->sysdata = bus->sysdata;
 	dev->dev.parent = bus->bridge;
 	dev->dev.bus = &pci_bus_type;
+	dev->dev.supports_power = 1;
 	dev->devfn = devfn;
 	dev->hdr_type = hdr_type & 0x7f;
 	dev->multifunction = !!(hdr_type & 0x80);
--- gregkh-2.6.orig/include/linux/device.h
+++ gregkh-2.6/include/linux/device.h
@@ -365,6 +365,7 @@ struct device {
 	char	bus_id[BUS_ID_SIZE];	/* position on parent bus */
 	struct device_type	*type;
 	unsigned		is_registered:1;
+	unsigned		supports_power:1;
 	struct device_attribute uevent_attr;
 	struct device_attribute *devt_attr;
 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
