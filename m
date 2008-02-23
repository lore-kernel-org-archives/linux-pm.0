From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.25-rc2-git] crosslink ACPI and "real" device
	nodes
Date: Fri, 22 Feb 2008 21:54:24 -0800
Message-ID: <200802222154.25204.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: linux-acpi@vger.kernel.org
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Add cross-links between ACPI device and "real" devices in sysfs,
exposing otherwise-hidden interrelationships between the various
device nodes for ACPI stuff.  As a representative example, one
hardware device is exposed as two logical devices (PNP and ACPI):

  .../pnp0/00:06/
  .../LNXSYSTM:00/device:00/PNP0A03:00/device:15/PNP0B00:00/

The PNP device gets a "firmware_node" link pointing to the ACPI device,
and is what a Linux device driver binds to.  The ACPI device has instead
a "physical_node" link pointing back to the PNP device.  Other firmware
frameworks, like OpenFirmware, could do the same thing to couple their
firmware tables to the rest of the system.

(Based on a patch from Zhang Rui.  This version is modified to not
depend on the patch makig ACPI initialize driver model wakeup flags.)

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Cc: Zhang Rui <rui.zhang@intel.com> 
---
Another extract from the "teach ACPI how to use driver model wakeup
flags" patch series.  The linkage helps sort out confusion about which
devices are wakeup-capable, among other things, and can help when
interpreting /proc/acpi/wakeup contents.

 drivers/acpi/glue.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

--- g26.orig/drivers/acpi/glue.c	2008-02-22 20:39:19.000000000 -0800
+++ g26/drivers/acpi/glue.c	2008-02-22 20:46:40.000000000 -0800
@@ -142,6 +142,7 @@ EXPORT_SYMBOL(acpi_get_physical_device);
 
 static int acpi_bind_one(struct device *dev, acpi_handle handle)
 {
+	struct acpi_device *acpi_dev;
 	acpi_status status;
 
 	if (dev->archdata.acpi_handle) {
@@ -157,6 +158,16 @@ static int acpi_bind_one(struct device *
 	}
 	dev->archdata.acpi_handle = handle;
 
+	status = acpi_bus_get_device(handle, &acpi_dev);
+	if (!ACPI_FAILURE(status)) {
+		int ret;
+
+		ret = sysfs_create_link(&dev->kobj, &acpi_dev->dev.kobj,
+				"firmware_node");
+		ret = sysfs_create_link(&acpi_dev->dev.kobj, &dev->kobj,
+				"physical_node");
+	}
+
 	return 0;
 }
 
@@ -165,8 +176,17 @@ static int acpi_unbind_one(struct device
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
