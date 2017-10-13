From: Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2] USB: Force disconnect Huawei 4G modem during suspend
Date: Fri, 13 Oct 2017 09:55:01 +0800
Message-ID: <20171013015501.5889-1-drake@endlessm.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, oneukum-IBi9RG/b67k@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-6IF/jdPJHihWk0Htik3J/w@public.gmane.org, chiu-6IF/jdPJHihWk0Htik3J/w@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org
List-Id: linux-pm@vger.kernel.org

When going into S3 suspend, the Acer TravelMate P648-M and P648-G3
laptops immediately wake up 3-4 seconds later for no obvious reason.

Unbinding the integrated Huawei 4G LTE modem before suspend avoids
the issue, even though we are not using the modem at all (checked
from rescue.target/runlevel1). The problem also occurs when the option
and cdc-ether modem drivers aren't loaded; it reproduces just with the
base usb driver. Under Windows the system can suspend fine.

Seeking a better fix, we've tried a lot of things, including:
 - Check that the device's power/wakeup is disabled
 - Check that remote wakeup is off at the USB level
 - All the quirks in drivers/usb/core/quirks.c e.g. USB_QUIRK_RESET_RESUME,
   USB_QUIRK_RESET, USB_QUIRK_IGNORE_REMOTE_WAKEUP, USB_QUIRK_NO_LPM.

but none of that makes any difference.

There are no errors in the logs showing any suspend/resume-related issues.
When the system wakes up due to the modem, log-wise it appears to be a
normal resume.

Introduce a quirk to disable the port during suspend when the modem is
detected.

The modem from the P648-G3 model is:
T:  Bus=01 Lev=01 Prnt=01 Port=08 Cnt=04 Dev#=  5 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=ff MxPS=64 #Cfgs=  3
P:  Vendor=12d1 ProdID=15c3 Rev= 1.02
S:  Manufacturer=Huawei Technologies Co., Ltd.
S:  Product=HUAWEI Mobile
S:  SerialNumber=0123456789ABCDEF
C:  #Ifs= 5 Cfg#= 1 Atr=a0 MxPwr=  2mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=06 Prot=10 Driver=
E:  Ad=82(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=06 Prot=13 Driver=
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=06 Prot=12 Driver=
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 3 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=06 Prot=16 Driver=
E:  Ad=86(I) Atr=03(Int.) MxPS=  16 Ivl=2ms
I:  If#= 3 Alt= 1 #EPs= 3 Cls=ff(vend.) Sub=06 Prot=16 Driver=
E:  Ad=86(I) Atr=03(Int.) MxPS=  16 Ivl=2ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=06 Prot=1b Driver=
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
C:* #Ifs= 6 Cfg#= 2 Atr=a0 MxPwr=  2mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=06 Prot=00 Driver=cdc_ether
E:  Ad=82(I) Atr=03(Int.) MxPS=  16 Ivl=2ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=06 Prot=00 Driver=cdc_ether
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=06 Prot=10 Driver=option
E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=06 Prot=13 Driver=option
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=06 Prot=12 Driver=option
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=06 Prot=1b Driver=option
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
C:  #Ifs= 2 Cfg#= 3 Atr=a0 MxPwr=  2mA
A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=0e Prot=00
I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=0e Prot=00 Driver=
E:  Ad=82(I) Atr=03(Int.) MxPS=  16 Ivl=2ms
I:  If#= 1 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=02 Driver=
I:  If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Based on an earlier patch by Chris Chiu.

Signed-off-by: Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
---

Notes:
    v2:
    - Handle quirk later in suspend, to avoid interfering with other parts
      of the suspend routine.
    - Don't do the disconnect on runtime suspend, only for S3 suspend

 drivers/usb/core/driver.c  | 10 +++++++++-
 drivers/usb/core/hub.c     | 13 +++++++++++++
 drivers/usb/core/quirks.c  |  6 ++++++
 drivers/usb/core/usb.h     |  1 +
 include/linux/usb/quirks.h |  6 ++++++
 5 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index eb87a259d55c..7c048afc9bfd 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -1461,6 +1461,7 @@ static void choose_wakeup(struct usb_device *udev, pm_message_t msg)
 int usb_suspend(struct device *dev, pm_message_t msg)
 {
 	struct usb_device	*udev = to_usb_device(dev);
+	int r;
 
 	unbind_no_pm_drivers_interfaces(udev);
 
@@ -1469,7 +1470,14 @@ int usb_suspend(struct device *dev, pm_message_t msg)
 	 * so we may still need to unbind and rebind upon resume
 	 */
 	choose_wakeup(udev, msg);
-	return usb_suspend_both(udev, msg);
+	r = usb_suspend_both(udev, msg);
+	if (r)
+		return r;
+
+	if (udev->quirks & USB_QUIRK_DISCONNECT_SUSPEND)
+		r = usb_port_disable(udev);
+
+	return r;
 }
 
 /* The device lock is held by the PM core */
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index b5c733613823..9662eaa9c44d 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -4180,6 +4180,19 @@ static int hub_port_disable(struct usb_hub *hub, int port1, int set_state)
 	return ret;
 }
 
+/*
+ * usb_port_disable - disable a usb device's upstream port
+ * @udev: device to disable
+ * Context: must be able to sleep; device not locked; pm locks held
+ *
+ * Disables a USB device that isn't in active use.
+ */
+int usb_port_disable(struct usb_device *udev)
+{
+	struct usb_hub *hub = usb_hub_to_struct_hub(udev->parent);
+
+	return hub_port_disable(hub, udev->portnum, 1);
+}
 
 /* USB 2.0 spec, 7.1.7.3 / fig 7-29:
  *
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 82806e311202..746d2b19109c 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -203,6 +203,12 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x10d6, 0x2200), .driver_info =
 			USB_QUIRK_STRING_FETCH_255 },
 
+	/* Huawei 4G LTE module */
+	{ USB_DEVICE(0x12d1, 0x15bb), .driver_info =
+			USB_QUIRK_DISCONNECT_SUSPEND },
+	{ USB_DEVICE(0x12d1, 0x15c3), .driver_info =
+			USB_QUIRK_DISCONNECT_SUSPEND },
+
 	/* SKYMEDI USB_DRIVE */
 	{ USB_DEVICE(0x1516, 0x8628), .driver_info = USB_QUIRK_RESET_RESUME },
 
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index dc6949248823..f71890a2db4e 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -73,6 +73,7 @@ extern void usb_hub_cleanup(void);
 extern int usb_major_init(void);
 extern void usb_major_cleanup(void);
 extern int usb_device_supports_lpm(struct usb_device *udev);
+extern int usb_port_disable(struct usb_device *udev);
 
 #ifdef	CONFIG_PM
 
diff --git a/include/linux/usb/quirks.h b/include/linux/usb/quirks.h
index de2a722fe3cf..bdc639cc80b4 100644
--- a/include/linux/usb/quirks.h
+++ b/include/linux/usb/quirks.h
@@ -56,4 +56,10 @@
  */
 #define USB_QUIRK_LINEAR_FRAME_INTR_BINTERVAL	BIT(11)
 
+/*
+ * Device needs to be disconnected before suspend to prevent spurious
+ * wakeup.
+ */
+#define USB_QUIRK_DISCONNECT_SUSPEND		BIT(12)
+
 #endif /* __LINUX_USB_QUIRKS_H */
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
