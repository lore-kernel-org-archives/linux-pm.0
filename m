From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/2] USB / Hub: Do not call
	device_set_wakeup_capable() under spinlock
Date: Sun, 6 Feb 2011 21:07:49 +0100
Message-ID: <201102062107.49909.rjw__10640.2954007082$1297023008$gmane$org@sisk.pl>
References: <201102061519.11360.rjw@sisk.pl> <201102062106.29712.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201102062106.29712.rjw@sisk.pl>
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
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

A subsequent patch will modify device_set_wakeup_capable() in such
a way that it will call functions which may sleep and therefore it
shouldn't be called under spinlocks.  In preparation for that, modify
usb_set_device_state() to avoid calling device_set_wakeup_capable()
under device_state_lock.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/usb/core/hub.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/usb/core/hub.c
===================================================================
--- linux-2.6.orig/drivers/usb/core/hub.c
+++ linux-2.6/drivers/usb/core/hub.c
@@ -1465,6 +1465,7 @@ void usb_set_device_state(struct usb_dev
 		enum usb_device_state new_state)
 {
 	unsigned long flags;
+	int wakeup = -1;
 
 	spin_lock_irqsave(&device_state_lock, flags);
 	if (udev->state == USB_STATE_NOTATTACHED)
@@ -1479,11 +1480,10 @@ void usb_set_device_state(struct usb_dev
 					|| new_state == USB_STATE_SUSPENDED)
 				;	/* No change to wakeup settings */
 			else if (new_state == USB_STATE_CONFIGURED)
-				device_set_wakeup_capable(&udev->dev,
-					(udev->actconfig->desc.bmAttributes
-					 & USB_CONFIG_ATT_WAKEUP));
+				wakeup = udev->actconfig->desc.bmAttributes
+					 & USB_CONFIG_ATT_WAKEUP;
 			else
-				device_set_wakeup_capable(&udev->dev, 0);
+				wakeup = 0;
 		}
 		if (udev->state == USB_STATE_SUSPENDED &&
 			new_state != USB_STATE_SUSPENDED)
@@ -1495,6 +1495,8 @@ void usb_set_device_state(struct usb_dev
 	} else
 		recursively_mark_NOTATTACHED(udev);
 	spin_unlock_irqrestore(&device_state_lock, flags);
+	if (wakeup >= 0)
+		device_set_wakeup_capable(&udev->dev, wakeup);
 }
 EXPORT_SYMBOL_GPL(usb_set_device_state);
 
