From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH] Warn about attempts to register/unregister
 devices during system suspend
Date: Mon, 31 Dec 2007 13:40:20 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0712311335360.10555-100000__15805.8927314871$1199126519$gmane$org@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

This patch (as1030) prints warning messages in the system log when
drivers try to register or unregister devices during a system sleep
transition.  These actions are now illegal and will either fail or
block (likely leading to deadlock).

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

This patch applies on top of
gregkh-driver-pm-acquire-device-locks-prior-to-suspending.patch.  The
new locking arrangement can cause deadlocks or other errors if drivers
try to do the wrong thing.  With this patch we should easily be able to
tell where the problems are.

Alan Stern


Index: usb-2.6/drivers/base/core.c
===================================================================
--- usb-2.6.orig/drivers/base/core.c
+++ usb-2.6/drivers/base/core.c
@@ -789,8 +789,11 @@ int device_add(struct device *dev)
 	int error;
 
 	error = pm_sleep_lock();
-	if (error)
+	if (error) {
+		dev_warn(dev, "Illegal %s during suspend\n", __FUNCTION__);
+		dump_stack();
 		return error;
+	}
 
 	dev = get_device(dev);
 	if (!dev || !strlen(dev->bus_id)) {
@@ -953,6 +956,13 @@ void device_del(struct device * dev)
 	struct device * parent = dev->parent;
 	struct class_interface *class_intf;
 
+	if (pm_sleep_lock()) {
+		dev_warn(dev, "Illegal %s during suspend\n", __FUNCTION__);
+		dump_stack();
+	} else {
+		pm_sleep_unlock();
+	}
+
 	if (parent)
 		klist_del(&dev->knode_parent);
 	if (MAJOR(dev->devt))
