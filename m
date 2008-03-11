From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/3] Driver core: Call device_pm_add() after
	bus_add_device() in device_add()
Date: Wed, 12 Mar 2008 00:59:38 +0100
Message-ID: <200803120059.39902.rjw__6106.17328570715$1205280622$gmane$org@sisk.pl>
References: <200803120055.25885.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803120055.25885.rjw@sisk.pl>
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
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Include dpm_sysfs_add() into device_pm_add(), in analogy with
device_pm_remove(), and modify device_add() to call the latter after
bus_add_device(), to avoid situations in which the PM core may
attempt to suspend a device the registration of which has not been
successful.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/core.c       |   15 +++++----------
 drivers/base/power/main.c |    4 +++-
 2 files changed, 8 insertions(+), 11 deletions(-)

Index: linux-2.6/drivers/base/core.c
===================================================================
--- linux-2.6.orig/drivers/base/core.c
+++ linux-2.6/drivers/base/core.c
@@ -812,17 +812,12 @@ int device_add(struct device *dev)
 	error = device_add_attrs(dev);
 	if (error)
 		goto AttrsError;
-	error = dpm_sysfs_add(dev);
-	if (error)
-		goto PMError;
-	error = device_pm_add(dev);
-	if (error) {
-		dpm_sysfs_remove(dev);
-		goto PMError;
-	}
 	error = bus_add_device(dev);
 	if (error)
 		goto BusError;
+	error = device_pm_add(dev);
+	if (error)
+		goto PMError;
 	kobject_uevent(&dev->kobj, KOBJ_ADD);
 	bus_attach_device(dev);
 	if (parent)
@@ -842,9 +837,9 @@ int device_add(struct device *dev)
  Done:
 	put_device(dev);
 	return error;
- BusError:
-	device_pm_remove(dev);
  PMError:
+	bus_remove_device(dev);
+ BusError:
 	if (dev->bus)
 		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
 					     BUS_NOTIFY_DEL_DEVICE, dev);
Index: linux-2.6/drivers/base/power/main.c
===================================================================
--- linux-2.6.orig/drivers/base/power/main.c
+++ linux-2.6/drivers/base/power/main.c
@@ -81,7 +81,9 @@ int device_pm_add(struct device *dev)
 		WARN_ON(true);
 		error = -EBUSY;
 	} else {
-		list_add_tail(&dev->power.entry, &dpm_active);
+		error = dpm_sysfs_add(dev);
+		if (!error)
+			list_add_tail(&dev->power.entry, &dpm_active);
 	}
 	mutex_unlock(&dpm_list_mtx);
 	return error;
