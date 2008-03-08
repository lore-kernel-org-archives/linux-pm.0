From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.25-rc2-git] crosslink ACPI and "real"
	device nodes
Date: Sat, 8 Mar 2008 11:47:13 -0800
Message-ID: <200803081147.14023.david-b__43217.3615009107$1205005846$gmane$org@pacbell.net>
References: <200802222154.25204.david-b@pacbell.net>
	<20080226131058.GA8234@khazad-dum.debian.net>
	<200802261819.31755.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200802261819.31755.david-b@pacbell.net>
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
To: linux-acpi@vger.kernel.org
Cc: linux-pm@lists.linux-foundation.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>
List-Id: linux-pm@vger.kernel.org

On Tuesday 26 February 2008, David Brownell wrote:
> On Tuesday 26 February 2008, Henrique de Moraes Holschuh wrote:
> > On Mon, 25 Feb 2008, David Brownell wrote:
> > > int __must_check sysfs_create_link(struct kobject *kobj, struct kobject *target,
> > >                                    const char *name);
> > > 
> > > Perhaps you disabled those warnings.  (And FWIW, I don't see any
> > > reasonable way to handle such faults, so ignoring them is thus
> > > the right "solution".)
> > 
> > You issue a printk warning the user, and try to continue.
> 
> That's not "handling" in any useful sense though.  There's no
> question about "try" to continue, by the way ... from inside
> the kernel this information is completely non-essential.

Here's a version with pr_debug() to report those case.
Against git-current.

======== CUT HERE
From: David Brownell <dbrownell@users.sourceforge.net>

Add cross-links between ACPI device and "real" devices in sysfs,
exposing otherwise-hidden interrelationships between the various
device nodes which ACPI creates.  As a representative example one
hardware device is exposed as two logical devices (PNP and ACPI):

  .../pnp0/00:06/
  .../LNXSYSTM:00/device:00/PNP0A03:00/device:15/PNP0B00:00/

The PNP device gets a "firmware_node" link pointing to the ACPI device.
The ACPI device has a "physical_node" link pointing to the PNP device.

Linux drivers currently bind only to the "physical" device nodes.

Other device trees provided by firmware tables could be exported
using the same scheme; these names aren't ACPI-specific.

(Based on a patch from Zhang Rui.  This version is modified to not
depend on the patch teaching ACPI about driver model wakeup flags.)

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Cc: Zhang Rui <rui.zhang@intel.com> 
---
Change from previous version:  if creating the link fails, a
pr_debug level message is emitted.

 drivers/acpi/glue.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

--- g26.orig/drivers/acpi/glue.c	2008-03-08 11:11:18.000000000 -0800
+++ g26/drivers/acpi/glue.c	2008-03-08 11:29:07.000000000 -0800
@@ -142,6 +142,7 @@ EXPORT_SYMBOL(acpi_get_physical_device);
 
 static int acpi_bind_one(struct device *dev, acpi_handle handle)
 {
+	struct acpi_device *acpi_dev;
 	acpi_status status;
 
 	if (dev->archdata.acpi_handle) {
@@ -157,6 +158,23 @@ static int acpi_bind_one(struct device *
 	}
 	dev->archdata.acpi_handle = handle;
 
+	status = acpi_bus_get_device(handle, &acpi_dev);
+	if (!ACPI_FAILURE(status)) {
+		int ret;
+
+		ret = sysfs_create_link(&dev->kobj, &acpi_dev->dev.kobj,
+				"firmware_node");
+		if (ret != 0)
+			pr_debug(PREFIX "Can't create %s link for %s\n",
+				"firmware_node", dev->bus_id);
+
+		ret = sysfs_create_link(&acpi_dev->dev.kobj, &dev->kobj,
+				"physical_node");
+		if (ret != 0)
+			pr_debug(PREFIX "Can't create %s link for %s\n",
+				"physical_node", acpi_dev->dev.bus_id);
+	}
+
 	return 0;
 }
 
@@ -165,8 +183,17 @@ static int acpi_unbind_one(struct device
 	if (!dev->archdata.acpi_handle)
 		return 0;
 	if (dev == acpi_get_physical_device(dev->archdata.acpi_handle)) {
+		struct acpi_device *acpi_dev;
+
 		/* acpi_get_physical_device increase refcnt by one */
 		put_device(dev);
+
+		if (!acpi_bus_get_device(dev->archdata.acpi_handle,
+					&acpi_dev)) {
+			sysfs_remove_link(&dev->kobj, "firmware_node");
+			sysfs_remove_link(&acpi_dev->dev.kobj, "physical_node");
+		}
+
 		acpi_detach_data(dev->archdata.acpi_handle,
 				 acpi_glue_data_handler);
 		dev->archdata.acpi_handle = NULL;
