From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: USB suspend issue with 2.6.38-rc2 -- still there in
	RC4-g795abaf
Date: Mon, 14 Feb 2011 15:55:38 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1102141541120.1716-100000__36861.1133461401$1297725098$gmane$org@iolanthe.rowland.org>
References: <m31v3abf1k.fsf@x201s.gr8dns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <m31v3abf1k.fsf@x201s.gr8dns.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dirk Hohndel <hohndel@infradead.org>
Cc: Linux PM List <linux-pm@lists.linux-foundation.org>, Linux USB List <linux-usb@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 14 Feb 2011, Dirk Hohndel wrote:

> > It might help to see the dmesg output rather than the system log file.  
> > Include everything going back to the boot.
> 
> Here's the latest, with the latest kernel from Linus: 2.6.38-rc4-00178-g795abaf
> which includes the commit that you mentioned bf3d7d40e42a85ca73a34e1385ff34f092a384eb
> 
> I did a successfull suspend / resume while the system was in the docking
> station - that's around seconds 42-44 in the dmesg output.
> 
> Next I undock and do another suspend attempt - starts around second
> 57. This one failed again, but now we have much more information from
> the dmesg output - attached all the way from reboot.
> 
> > > 1-1 appears to be my built-in root hub.
> > 
> > No, the root hub is usb1.  1-1 is the device plugged into port 1 of the
> > root hub.  If you have a debugfs filesystem mounted, you can see the
> > device list in /sys/kernel/debug/usb/devices.
> 
> I'm attaching that as well :-)
> 
> Let me know what else I should send / try.

Okay, this is great.  The log shows you have a Broadcom Bluetooth
device that got disconnected right at the same time each suspend
started.  Did you unplug it by hand or were the disconnects triggered
by the hardware somehow?

At any rate, the close timing between the disconnect and the suspend
caused a new race to show up, one I haven't come across before.  Even
though the Bluetooth device's USB port was disabled, the device was not
yet unregistered.  The hub driver saw the device structure was still
present and refused to suspend, thinking there was an unsuspended child
device attached.

I can't recall having seen this particular failure path (an attempt to 
suspend a hub while one of its attached devices is still active) in 
years, if ever.  Hence the easiest way to solve the problem is to 
remove the check.  Hopefully the patch below will fix your problem.

Alan Stern

P.S.: Contrary to Linus's earlier suggestion, it's not a good idea to
remove _all_ checks for failures during suspend.  The same code is used
for both system sleep and runtime PM, and we definitely _do_ want to
catch failures during runtime suspend.



Index: usb-2.6/drivers/usb/core/hub.c
===================================================================
--- usb-2.6.orig/drivers/usb/core/hub.c
+++ usb-2.6/drivers/usb/core/hub.c
@@ -2457,21 +2457,6 @@ int usb_port_resume(struct usb_device *u
 static int hub_suspend(struct usb_interface *intf, pm_message_t msg)
 {
 	struct usb_hub		*hub = usb_get_intfdata (intf);
-	struct usb_device	*hdev = hub->hdev;
-	unsigned		port1;
-
-	/* fail if children aren't already suspended */
-	for (port1 = 1; port1 <= hdev->maxchild; port1++) {
-		struct usb_device	*udev;
-
-		udev = hdev->children [port1-1];
-		if (udev && udev->can_submit) {
-			if (!(msg.event & PM_EVENT_AUTO))
-				dev_dbg(&intf->dev, "port %d nyet suspended\n",
-						port1);
-			return -EBUSY;
-		}
-	}
 
 	dev_dbg(&intf->dev, "%s\n", __func__);
 
