From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 2/2] PM: Make system-wide PM and runtime
	PM handle subsystems consistently
Date: Wed, 16 Feb 2011 22:47:49 +0100
Message-ID: <201102162247.49924.rjw__25836.4454065033$1297930423$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1102160955210.2108-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1102160955210.2108-100000@iolanthe.rowland.org>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, February 16, 2011, Alan Stern wrote:
> On Wed, 16 Feb 2011, Rafael J. Wysocki wrote:
> 
> > Unfortunately, it doesn't work on my Acer Ferrari One.  The problem is that
> > hcd_pci_suspend() fails for the EHCI controller, apparently because the root
> > hub is not suspended.  Do root hubs need both class suspend and bus type
> > suspend to work at the same time?
> 
> No, only the bus type suspend method is needed.

Bus type or device type?  It appears to be the latter from reading the code
(although admittedly not too thorough).

> Can you provide the dmesg log using a kernel built with CONFIG_USB_DEBUG?

Well, I know what the problem is.

USB defines usb_device_type pointing to usb_device_pm_ops that provides
system-wide PM callbacks only and usb_bus_type pointing to
usb_bus_pm_ops that provides runtime PM callbacks only.  So it looks like
we should move either the system-wide PM callbacks to usb_bus_pm_ops,
or the runtime PM callbacks to usb_device_pm_ops.

FWIW, the appended patch helps on my test machine, but I'm not sure if it
is the right thing to do.

Apart from this I think the order of checks introduced by the $subject patch
should be:
(1) If dev->class != NULL and dev->class->pm != NULL, use dev->class,
    or otherwise
(2) if dev->type != NULL and dev->type->pm != NULL, use dev->type,
    or otherwise
(3) use dev->bus (if present).
as that would allow classes and device types to override bus type PM
callbacks if they wish to.

Thanks,
Rafael

---
 drivers/usb/core/driver.c |   15 +++------------
 drivers/usb/core/usb.c    |    5 +++++
 drivers/usb/core/usb.h    |   18 ++++++++++++++++++
 3 files changed, 26 insertions(+), 12 deletions(-)

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
 
@@ -90,6 +93,21 @@ static inline int usb_remote_wakeup(stru
 {
 	return 0;
 }
+
+static inline int usb_runtime_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static inline int usb_runtime_resume(struct device *dev)
+{
+	return 0;
+}
+
+static inline int usb_runtime_idle(struct device *dev)
+{
+	return 0;
+}
 
 #endif
 
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
