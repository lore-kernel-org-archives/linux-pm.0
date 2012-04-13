From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Fri, 13 Apr 2012 17:04:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204131702140.1166-100000@iolanthe.rowland.org>
References: <1334330949.23924.360.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1334330949.23924.360.camel@gandalf.stny.rr.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: jrnieder@gmail.com, Andrey Rahmatullin <wrar@wrar.name>, linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 13 Apr 2012, Steven Rostedt wrote:

> > Second, if you do
> > 
> > 	echo 0 >/sys/bus/usb/devices/usb1/bConfigurationValue
> 
> This never returned. I did the echo, and the command locked up.
> 
> (process 3077)
> 
> cat /proc/3077/wchan 
> usb_disconnect

I found the reason for the deadlock.  The patch below will work around
the problem for now, although it's not a correct fix.  You'll still get
some complaints from lockdep.

Alan Stern



Index: usb-3.4/drivers/usb/core/hub.c
===================================================================
--- usb-3.4.orig/drivers/usb/core/hub.c
+++ usb-3.4/drivers/usb/core/hub.c
@@ -1667,7 +1667,7 @@ void usb_disconnect(struct usb_device **
 {
 	struct usb_device	*udev = *pdev;
 	int			i;
-	struct usb_hcd		*hcd = bus_to_hcd(udev->bus);
+//	struct usb_hcd		*hcd = bus_to_hcd(udev->bus);
 
 	/* mark the device as inactive, so any further urb submissions for
 	 * this device (and any of its children) will fail immediately.
@@ -1690,9 +1690,9 @@ void usb_disconnect(struct usb_device **
 	 * so that the hardware is now fully quiesced.
 	 */
 	dev_dbg (&udev->dev, "unregistering device\n");
-	mutex_lock(hcd->bandwidth_mutex);
+//	mutex_lock(hcd->bandwidth_mutex);
 	usb_disable_device(udev, 0);
-	mutex_unlock(hcd->bandwidth_mutex);
+//	mutex_unlock(hcd->bandwidth_mutex);
 	usb_hcd_synchronize_unlinks(udev);
 
 	usb_remove_ep_devs(&udev->ep0);
