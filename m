From: David Brownell <david-b@pacbell.net>
Subject: [patch 2/3] usb device wakeup flags
Date: Mon, 12 Sep 2005 19:39:39 -0700
Message-ID: <200509121939.39358.david-b@pacbell.net>
References: <200509121923.58993.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_rvjJD5T6x0sbnxr"
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200509121923.58993.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--Boundary-00=_rvjJD5T6x0sbnxr
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here's a patch showing how USB can detect wakeup-capable devices,
such as hubs, keyboards, mice, and Ethernet adapters ... and use
the policy setting to enable remote wakeup only when appropriate.

There's another USB patch on the way, switching the HCDs over to
use the new driver model bits rather than the USB-only bits that
do the same thing.  I'm holding back on that till more of the
HCD level PM updates get made.

- Dave


--Boundary-00=_rvjJD5T6x0sbnxr
Content-Type: text/x-diff;
  charset="us-ascii";
  name="pm-wake-usb.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pm-wake-usb.patch"

This patch teaches "usb_device" about the new driver model wakeup support:

 - It updates device wakeup capabilities when entering a configuration
   with the WAKEUP attribute;

 - During suspend processing it consults the policy bit to see
   whether it should enable wakeup for that device.  (This resolves
   a FIXME to not assume the answer is always "yes"; some devices
   lie about supporting remote wakeup.)

Support for root hubs and the HCDs is separate (and more complex).

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- g26.orig/drivers/usb/core/hub.c	2005-09-11 18:24:17.000000000 -0700
+++ g26/drivers/usb/core/hub.c	2005-09-12 11:43:16.000000000 -0700
@@ -1020,9 +1020,15 @@ void usb_set_device_state(struct usb_dev
 	spin_lock_irqsave(&device_state_lock, flags);
 	if (udev->state == USB_STATE_NOTATTACHED)
 		;	/* do nothing */
-	else if (new_state != USB_STATE_NOTATTACHED)
+	else if (new_state != USB_STATE_NOTATTACHED) {
 		udev->state = new_state;
-	else
+		if (new_state == USB_STATE_CONFIGURED)
+			device_init_wakeup(&udev->dev,
+				(udev->actconfig->desc.bmAttributes
+				 & USB_CONFIG_ATT_WAKEUP));
+		else if (new_state != USB_STATE_SUSPENDED)
+			device_init_wakeup(&udev->dev, 0);
+	} else
 		recursively_mark_NOTATTACHED(udev);
 	spin_unlock_irqrestore(&device_state_lock, flags);
 }
@@ -1546,11 +1552,7 @@ static int hub_port_suspend(struct usb_h
 	 * NOTE:  OTG devices may issue remote wakeup (or SRP) even when
 	 * we don't explicitly enable it here.
 	 */
-	if (udev->actconfig
-			// && FIXME (remote wakeup enabled on this bus)
-			// ... currently assuming it's always appropriate
-			&& (udev->actconfig->desc.bmAttributes
-				& USB_CONFIG_ATT_WAKEUP) != 0) {
+	if (device_may_wakeup(&udev->dev)) {
 		status = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
 				USB_REQ_SET_FEATURE, USB_RECIP_DEVICE,
 				USB_DEVICE_REMOTE_WAKEUP, 0,

--Boundary-00=_rvjJD5T6x0sbnxr
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--Boundary-00=_rvjJD5T6x0sbnxr--
