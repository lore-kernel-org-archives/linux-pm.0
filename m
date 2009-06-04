From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] USB: Avoid PM error messages during resume if a
	device was disconnected
Date: Thu, 4 Jun 2009 22:30:48 +0200
Message-ID: <200906042230.49825.rjw__30047.003288246$1244147634$gmane$org@sisk.pl>
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
To: Greg KH <gregkh@suse.de>
Cc: Frans Pop <elendil@planet.nl>, linux-usb@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Frans Pop <elendil@planet.nl>

Currently if a laptop is suspended e.g. while docked and then resumed after
undocking it, the following errors get generated because the USB hub in the
docking station and the devices connected to it are no longer available:
pm_op(): usb_dev_resume+0x0/0x10 returns -19
PM: Device 1-2 failed to resume: error -19
pm_op(): usb_dev_resume+0x0/0x10 returns -19
PM: Device 1-2.2 failed to resume: error -19
pm_op(): usb_dev_resume+0x0/0x10 returns -19
PM: Device 1-2.3 failed to resume: error -19

As the removal of USB devices while a system is suspended is a relatively
common use case and in most cases not an error, just return success on
-ENODEV. The user gets informed anyway as the USB subsystem generates
regular disconnect messages for the devices shortly afterwards:
usb 1-2: USB disconnect, address 3
usb 1-2.2: USB disconnect, address 4
usblp0: removed
usb 1-2.3: USB disconnect, address 5

Signed-off-by: Frans Pop <elendil@planet.nl>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
Hi Greg,

I can take this patch to the suspend tree, but if you think it should go
through USB, please consider including it into the 2.6.31 push.

Best,
Rafael
---
 drivers/usb/core/driver.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/usb/core/driver.c
===================================================================
--- linux-2.6.orig/drivers/usb/core/driver.c
+++ linux-2.6/drivers/usb/core/driver.c
@@ -1762,6 +1762,7 @@ int usb_suspend(struct device *dev, pm_m
 int usb_resume(struct device *dev, pm_message_t msg)
 {
 	struct usb_device	*udev;
+	int			status;
 
 	udev = to_usb_device(dev);
 
@@ -1771,7 +1772,14 @@ int usb_resume(struct device *dev, pm_me
 	 */
 	if (udev->skip_sys_resume)
 		return 0;
-	return usb_external_resume_device(udev, msg);
+	status = usb_external_resume_device(udev, msg);
+
+	/* Avoid PM error messages for devices disconnected while suspended
+	 * as we'll display regular disconnect messages just a bit later.
+	 */
+	if (status == -ENODEV)
+		return 0;
+	return status;
 }
 
 #endif /* CONFIG_PM */
