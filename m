From: Frans Pop <elendil@planet.nl>
Subject: [PATCH] usb: avoid PM error messages during resume if a
	device was disconnected
Date: Mon, 23 Mar 2009 22:11:49 +0100
Message-ID: <200903232211.51154.elendil__8878.40520958907$1237843042$gmane$org@planet.nl>
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
To: linux-usb@vger.kernel.org
Cc: linux-pm@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

I've walked through the code and AFAICT just returning 0 does not make any
difference for the PM core code.

In a first version of this patch I had the following included just before
the 'return 0':
	pr_info("usb %s: failed to resume: no longer connected\n",
						dev_name(&udev->dev));

Problem with that was that the message got printed twice for each device,
once for .resume and once for .complete. Given that the disconnects are
reported shortly after anyway, I decided the simpler patch might do just
as well.

Cheers,
FJP

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index d0a21a5..97ea69b 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -1727,6 +1727,10 @@ int usb_external_resume_device(struct usb_device *udev, pm_message_t msg)
 	status = usb_resume_both(udev, msg);
 	udev->last_busy = jiffies;
 	usb_pm_unlock(udev);
+
+	if (status == -ENODEV)
+		return 0;
+
 	if (status == 0)
 		do_unbind_rebind(udev, DO_REBIND);
 
