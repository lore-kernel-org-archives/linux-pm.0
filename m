From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] USB: Move runtime PM callbacks to
	usb_device_pm_ops
Date: Thu, 17 Feb 2011 00:58:56 +0100
Message-ID: <201102170058.56503.rjw__49768.7007919469$1297936803$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

USB defines usb_device_type pointing to usb_device_pm_ops that
provides system-wide PM callbacks only and usb_bus_type pointing to
usb_bus_pm_ops that provides runtime PM callbacks only.  However,
the USB runtime PM callbacks may be defined in usb_device_pm_ops
which makes it possible to drop usb_bus_pm_ops and will allow us
to consolidate the handling of subsystems by the PM core code.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---

Hi Greg,

Would you mind if I merged the following patch?  It is requisite for
https://patchwork.kernel.org/patch/552411/ which I think is the right thing
to do and people seem to generally agree with me.

Alan has seen it and says it is fine.

Thanks,
Rafael

---
 drivers/usb/core/driver.c |   15 +++------------
 drivers/usb/core/usb.c    |    5 +++++
 drivers/usb/core/usb.h    |    3 +++
 3 files changed, 11 insertions(+), 12 deletions(-)

Index: linux-2.6/drivers/usb/core/driver.c
===================================================================
--- linux-2.6.orig/drivers/usb/core/driver.c
+++ linux-2.6/drivers/usb/core/driver.c
@@ -1646,7 +1646,7 @@ static int autosuspend_check(struct usb_
 	return 0;
 }
 
-static int usb_runtime_suspend(struct device *dev)
+int usb_runtime_suspend(struct device *dev)
 {
 	struct usb_device	*udev = to_usb_device(dev);
 	int			status;
@@ -1662,7 +1662,7 @@ static int usb_runtime_suspend(struct de
 	return status;
 }
 
-static int usb_runtime_resume(struct device *dev)
+int usb_runtime_resume(struct device *dev)
 {
 	struct usb_device	*udev = to_usb_device(dev);
 	int			status;
@@ -1674,7 +1674,7 @@ static int usb_runtime_resume(struct dev
 	return status;
 }
 
-static int usb_runtime_idle(struct device *dev)
+int usb_runtime_idle(struct device *dev)
 {
 	struct usb_device	*udev = to_usb_device(dev);
 
@@ -1686,19 +1686,10 @@ static int usb_runtime_idle(struct devic
 	return 0;
 }
 
-static const struct dev_pm_ops usb_bus_pm_ops = {
-	.runtime_suspend =	usb_runtime_suspend,
-	.runtime_resume =	usb_runtime_resume,
-	.runtime_idle =		usb_runtime_idle,
-};
-
 #endif /* CONFIG_USB_SUSPEND */
 
 struct bus_type usb_bus_type = {
 	.name =		"usb",
 	.match =	usb_device_match,
 	.uevent =	usb_uevent,
-#ifdef CONFIG_USB_SUSPEND
-	.pm =		&usb_bus_pm_ops,
-#endif
 };
Index: linux-2.6/drivers/usb/core/usb.h
===================================================================
--- linux-2.6.orig/drivers/usb/core/usb.h
+++ linux-2.6/drivers/usb/core/usb.h
@@ -77,6 +77,9 @@ static inline int usb_port_resume(struct
 extern void usb_autosuspend_device(struct usb_device *udev);
 extern int usb_autoresume_device(struct usb_device *udev);
 extern int usb_remote_wakeup(struct usb_device *dev);
+extern int usb_runtime_suspend(struct device *dev);
+extern int usb_runtime_resume(struct device *dev);
+extern int usb_runtime_idle(struct device *dev);
 
 #else
 
Index: linux-2.6/drivers/usb/core/usb.c
===================================================================
--- linux-2.6.orig/drivers/usb/core/usb.c
+++ linux-2.6/drivers/usb/core/usb.c
@@ -315,6 +315,11 @@ static const struct dev_pm_ops usb_devic
 	.thaw =		usb_dev_thaw,
 	.poweroff =	usb_dev_poweroff,
 	.restore =	usb_dev_restore,
+#ifdef CONFIG_USB_SUSPEND
+	.runtime_suspend =	usb_runtime_suspend,
+	.runtime_resume =	usb_runtime_resume,
+	.runtime_idle =		usb_runtime_idle,
+#endif
 };
 
 #endif	/* CONFIG_PM */
