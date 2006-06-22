From: Greg KH <greg@kroah.com>
Subject: [PATCH] get USB suspend to work again on 2.6.17-mm1
Date: Thu, 22 Jun 2006 13:29:52 -0700
Message-ID: <20060622202952.GA14135@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161315AbWFVUdW@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>, Jiri Slaby <jirislaby@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, David Brownell <david-b@pacbell.net>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net, linux-pm@osdl.org, pavel@suse.cz
List-Id: linux-pm@vger.kernel.org

Mattai and Jiri, can you try the patch below to see if it fixes the USB
suspend problem you are seeing with 2.6.17-mm1?

David, we really should not be caring about what the children of a USB
device is doing here, as who knows what type of "device" might hang off
of a struct usb_device.  This patch is just a band-aid around this area,
until Alan's patches fix up everything "properly" :)

thanks,

greg k-h

-----------------------------
Subject: USB: get USB suspend to work again

Yeah, it's a hack, but it is only temporary until Alan's patches
reworking this area make it in.  We really should not care what devices
below us are doing, especially when we do not really know what type of
devices they are.  This patch relies on the fact that the endpoint
devices do not have a driver assigned to us.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/core/usb.c |    2 ++
 1 file changed, 2 insertions(+)

--- gregkh-2.6.orig/drivers/usb/core/usb.c
+++ gregkh-2.6/drivers/usb/core/usb.c
@@ -991,6 +991,8 @@ void usb_buffer_unmap_sg (struct usb_dev
 
 static int verify_suspended(struct device *dev, void *unused)
 {
+	if (dev->driver == NULL)
+		return 0;
 	return (dev->power.power_state.event == PM_EVENT_ON) ? -EBUSY : 0;
 }
 
