From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 7/8] PM: Allow USB devices to suspend/resume
	asynchronously
Date: Sun, 24 Jan 2010 00:40:25 +0100
Message-ID: <201001240040.25931.rjw__8824.63045786626$1264290792$gmane$org@sisk.pl>
References: <201001240033.34253.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001240033.34253.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Nigel Cunningham <ncunningham@crca.org.au>, Greg KH <gregkh@suse.de>, Linux SCSI <linux-scsi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, linux-usb@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, James Bottomley <James.Bottomley@suse.de>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Set power.async_suspend for USB devices, endpoints and interfaces,
allowing them to be suspended and resumed asynchronously during
system sleep transitions.

The power.async_suspend flag is also set for devices that don't have
suspend or resume callbacks, because otherwise they would make the
main suspend/resume thread wait for their "asynchronous" children
(during suspend) or parents (during resume), effectively negating the
possible gains from executing these devices' suspend and resume
callbacks asynchronously.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/usb/core/endpoint.c |    1 +
 drivers/usb/core/hcd-pci.c  |    1 +
 drivers/usb/core/hub.c      |    1 +
 drivers/usb/core/message.c  |    1 +
 4 files changed, 4 insertions(+)

Index: linux-2.6/drivers/usb/core/hub.c
===================================================================
--- linux-2.6.orig/drivers/usb/core/hub.c
+++ linux-2.6/drivers/usb/core/hub.c
@@ -1817,6 +1817,7 @@ int usb_new_device(struct usb_device *ud
 	/* Tell the world! */
 	announce_device(udev);
 
+	device_enable_async_suspend(&udev->dev);
 	/* Register the device.  The device driver is responsible
 	 * for configuring the device and invoking the add-device
 	 * notifier chain (used by usbfs and possibly others).
Index: linux-2.6/drivers/usb/core/message.c
===================================================================
--- linux-2.6.orig/drivers/usb/core/message.c
+++ linux-2.6/drivers/usb/core/message.c
@@ -1867,6 +1867,7 @@ free_interfaces:
 			"adding %s (config #%d, interface %d)\n",
 			dev_name(&intf->dev), configuration,
 			intf->cur_altsetting->desc.bInterfaceNumber);
+		device_enable_async_suspend(&intf->dev);
 		ret = device_add(&intf->dev);
 		if (ret != 0) {
 			dev_err(&dev->dev, "device_add(%s) --> %d\n",
Index: linux-2.6/drivers/usb/core/endpoint.c
===================================================================
--- linux-2.6.orig/drivers/usb/core/endpoint.c
+++ linux-2.6/drivers/usb/core/endpoint.c
@@ -186,6 +186,7 @@ int usb_create_ep_devs(struct device *pa
 	ep_dev->dev.parent = parent;
 	ep_dev->dev.release = ep_device_release;
 	dev_set_name(&ep_dev->dev, "ep_%02x", endpoint->desc.bEndpointAddress);
+	device_enable_async_suspend(&ep_dev->dev);
 
 	retval = device_register(&ep_dev->dev);
 	if (retval)
