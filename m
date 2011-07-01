From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] PM / Runtime: Update documentation regarding
	driver removal
Date: Sat, 2 Jul 2011 00:12:29 +0200
Message-ID: <201107020012.29661.rjw__6850.2279966653$1309558359$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1107011711370.1624-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1107011711370.1624-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Commit e1866b33b1e89f077b7132daae3dfd9a594e9a1a (PM / Runtime: Rework
runtime PM handling during driver removal) forgot to update the
documentation in Documentation/power/runtime_pm.txt to match the new
code in drivers/base/dd.c.  Update that documentation to match the
code it describes.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 Documentation/power/runtime_pm.txt |   26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

Index: linux-2.6/Documentation/power/runtime_pm.txt
===================================================================
--- linux-2.6.orig/Documentation/power/runtime_pm.txt
+++ linux-2.6/Documentation/power/runtime_pm.txt
@@ -513,13 +513,29 @@ helper functions described in Section 4.
 should be used.  Of course, for this purpose the device's runtime PM has to be
 enabled earlier by calling pm_runtime_enable().
 
-If the device bus type's or driver's ->probe() or ->remove() callback runs
+If the device bus type's or driver's ->probe() callback runs
 pm_runtime_suspend() or pm_runtime_idle() or their asynchronous counterparts,
 they will fail returning -EAGAIN, because the device's usage counter is
-incremented by the core before executing ->probe() and ->remove().  Still, it
-may be desirable to suspend the device as soon as ->probe() or ->remove() has
-finished, so the PM core uses pm_runtime_put_sync() to invoke the
-subsystem-level idle callback for the device at that time.
+incremented by the driver core before executing ->probe().  Still, it may be
+desirable to suspend the device as soon as ->probe() has finished, so the driver
+core uses pm_runtime_put_sync() to invoke the subsystem-level idle callback for
+the device at that time.
+
+Moreover, the driver core prevents runtime PM callbacks from racing with the bus
+notifier callback in __device_release_driver(), which is necessary, because the
+notifier is used by some subsystems to carry out operations affecting the
+runtime PM functionality.  It does so by calling pm_runtime_get_sync() before
+driver_sysfs_remove() and the BUS_NOTIFY_UNBIND_DRIVER notifications.  This
+resumes the device if it's in the suspended state and prevents it from
+being suspended again while those routines are being executed.
+
+To allow bus types and drivers to put devices into the suspended state by
+calling pm_runtime_suspend() from their ->remove() routines, the driver core
+executes pm_runtime_put_sync() after running the BUS_NOTIFY_UNBIND_DRIVER
+notifications in __device_release_driver().  This requires bus types and
+drivers to make their ->remove() callbacks avoid races with runtime PM directly,
+but also it allows of more flexibility in the handling of devices during the
+removal of their drivers.
 
 The user space can effectively disallow the driver of the device to power manage
 it at run time by changing the value of its /sys/devices/.../power/control
