From: Alan Stern <stern@rowland.harvard.edu>
Subject: [RFC 3/3] Runtime PM support for named power states
Date: Fri, 30 Sep 2005 16:31:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0509301627170.4470-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============38305968469428464=="
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============38305968469428464==
Content-Type: TEXT/PLAIN; charset=US-ASCII

This patch adds support for named power states to the USB device drivers.  
It's fairly simple and well-contained because USB devices have only two 
states: on and suspended.  Even so, the confusion over which field in 
dev->power.power_state should represent the true state remains.

Alan Stern

P.S.:  I forgot the mention this in the original cover message.  This 
entire series of patches is meant to go on top of 2.6.14-rc2-git6 plus

http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-all-2.6.14-rc2-git6.patch



Index: usb-2.6/drivers/usb/core/usb.c
===================================================================
--- usb-2.6.orig/drivers/usb/core/usb.c
+++ usb-2.6/drivers/usb/core/usb.c
@@ -58,6 +58,8 @@ static int nousb;	/* Disable USB when bu
 
 static DECLARE_RWSEM(usb_all_devices_rwsem);
 
+const char *(usb_states[3]) = { pm_name_ON, pm_name_SUSPEND, NULL };
+
 
 static int generic_probe (struct device *dev)
 {
@@ -739,6 +741,7 @@ usb_alloc_dev(struct usb_device *parent,
 	dev->dev.driver_data = &usb_generic_driver_data;
 	dev->dev.driver = &usb_generic_driver;
 	dev->dev.release = usb_release_dev;
+	dev->dev.power.states = usb_states;
 	dev->state = USB_STATE_ATTACHED;
 
 	INIT_LIST_HEAD(&dev->ep0.urb_list);
Index: usb-2.6/drivers/usb/core/usb.h
===================================================================
--- usb-2.6.orig/drivers/usb/core/usb.h
+++ usb-2.6/drivers/usb/core/usb.h
@@ -29,6 +29,7 @@ extern void usb_major_cleanup(void);
 extern int usb_host_init(void);
 extern void usb_host_cleanup(void);
 
+extern const char *(usb_states[]);
 extern int usb_suspend_device(struct usb_device *dev);
 extern int usb_resume_device(struct usb_device *dev);
 
Index: usb-2.6/drivers/usb/core/message.c
===================================================================
--- usb-2.6.orig/drivers/usb/core/message.c
+++ usb-2.6/drivers/usb/core/message.c
@@ -1393,6 +1393,7 @@ free_interfaces:
 			intf->dev.dma_mask = dev->dev.dma_mask;
 			intf->dev.release = release_interface;
 			device_initialize (&intf->dev);
+			intf->dev.power.states = usb_states;
 			mark_quiesced(intf);
 			sprintf (&intf->dev.bus_id[0], "%d-%s:%d.%d",
 				 dev->bus->busnum, dev->devpath,


--===============38305968469428464==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============38305968469428464==--
