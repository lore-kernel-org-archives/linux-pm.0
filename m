From: Frans Pop <elendil@planet.nl>
Subject: [PATCH v2] usb: avoid PM error messages during resume if
	a device was disconnected
Date: Wed, 3 Jun 2009 00:26:07 +0200
Message-ID: <200906030026.08399.elendil__23868.0990798914$1243981641$gmane$org@planet.nl>
References: <Pine.LNX.4.44L0.0906021745380.3960-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0906021745380.3960-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, linux-usb@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

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
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
---

On Tuesday 02 June 2009, Alan Stern wrote:
> If we change -ENODEV to 0, the change should be made in usb_resume()
> rather than usb_external_resume_device().

Like so?
Agreed that it's cleaner and tested that it works just as well :-)

Cheers,
FJP

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index d0a21a5..0aaf26e 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -1762,6 +1762,7 @@ int usb_suspend(struct device *dev, pm_message_t msg)
 int usb_resume(struct device *dev, pm_message_t msg)
 {
 	struct usb_device	*udev;
+	int			status;
 
 	udev = to_usb_device(dev);
 
@@ -1771,7 +1772,14 @@ int usb_resume(struct device *dev, pm_message_t msg)
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
