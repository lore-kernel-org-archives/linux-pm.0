From: Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
Subject: [PATCH] USB: Force disconnect Huawei 4G modem during suspend
Date: Wed, 11 Oct 2017 14:47:53 +0800
Message-ID: <20171011064753.11471-1-drake@endlessm.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, oneukum-IBi9RG/b67k@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-6IF/jdPJHihWk0Htik3J/w@public.gmane.org, chiu-6IF/jdPJHihWk0Htik3J/w@public.gmane.org
List-Id: linux-pm@vger.kernel.org

From: Chris Chiu <chiu-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>

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

Signed-off-by: Chris Chiu <chiu-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
Signed-off-by: Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
---
 drivers/usb/core/hub.c     | 3 +++
 drivers/usb/core/quirks.c  | 6 ++++++
 include/linux/usb/quirks.h | 6 ++++++
 3 files changed, 15 insertions(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index b5c733613823..0eb3d8191a26 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -3160,6 +3160,9 @@ int usb_port_suspend(struct usb_device *udev, pm_message_t msg)
 			goto err_ltm;
 	}
 
+	if (udev->quirks & USB_QUIRK_DISCONNECT_SUSPEND)
+		usb_clear_port_feature(hub->hdev, port1, USB_PORT_FEAT_ENABLE);
+
 	/* see 7.1.7.6 */
 	if (hub_is_superspeed(hub->hdev))
 		status = hub_set_port_link_state(hub, port1, USB_SS_PORT_LS_U3);
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
