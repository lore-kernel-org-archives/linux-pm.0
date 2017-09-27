From: Daniel Drake <drake@endlessm.com>
Subject: Huawei integrated modem causes instant resume from suspend on Acer P648-G3
Date: Wed, 27 Sep 2017 14:14:46 +0800
Message-ID: <20170927061446.15512-1-drake@endlessm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:49551 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbdI0GO4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2017 02:14:56 -0400
Received: by mail-pg0-f46.google.com with SMTP id m30so7218957pgn.6
        for <linux-pm@vger.kernel.org>; Tue, 26 Sep 2017 23:14:56 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-pm@vger.kernel.org
Cc: linux@endlessm.com

Hi,

The Acer TravelMate P648-G3 laptop includes this integrated Huawei 4G modem
on the USB bus:

T:  Bus=01 Lev=01 Prnt=01 Port=08 Cnt=04 Dev#=  5 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=ff MxPS=64 #Cfgs=  3
P:  Vendor=12d1 ProdID=15c3 Rev= 1.02
S:  Manufacturer=Huawei Technologies Co., Ltd.
S:  Product=HUAWEI Mobile
S:  SerialNumber=0123456789ABCDEF
C:  #Ifs= 5 Cfg#= 1 Atr=a0 MxPwr=  2mA

Under Linux, this system has an issue where it will automatically resume
3-4 seconds after going into suspend. After some experimentation we realised
that it is related to this 4G modem.

The problem can be worked around with:

  echo 1-9 > /sys/bus/usb/drivers/usb/unbind

or the attached hacky patch which does something similar. Now the system
goes into suspend and stays asleep.

The problem happens even though we are not using the modem at all (checked
from rescue.target/runlevel1). Under Windows the system can suspend fine.

Seeking a better fix, we've tried a lot of things, including:
 - Unbind usb serial interface(ttyUSB0-3) and cdc-eth interface (instead of
the whole port)
 - Check that the device's power/wakeup is disabled
 - All the quirks in drivers/usb/core/quirks.c e.g. USB_QUIRK_RESET_RESUME,
   USB_QUIRK_RESET, USB_QUIRK_IGNORE_REMOTE_WAKEUP, USB_QUIRK_NO_LPM.
 - Check usb_port_suspend() to see if the do_remote_wakeup path is followed
   (it's not)

but none of that makes any difference.

There are no errors in the logs showing any suspend/resume-related issues.
When the system wakes up due to the modem, log-wise it appears to be a
normal resume.

Does anyone have any suggestions for how we can investigate further, or how
we should workaround this issue in upstreamable form?

Thanks
Daniel

---
 drivers/usb/core/hub.c     | 4 ++++
 drivers/usb/core/quirks.c  | 4 ++++
 include/linux/usb/quirks.h | 5 +++++
 3 files changed, 13 insertions(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 822f8c50e423..ac9ceacdc76c 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -3160,6 +3160,10 @@ int usb_port_suspend(struct usb_device *udev, pm_message_t msg)
 			goto err_ltm;
 	}
 
+	if (udev->quirks & USB_QUIRK_DISCONNECT_SUSPEND) {
+		usb_clear_port_feature(hub->hdev, port1, USB_PORT_FEAT_ENABLE);
+	}
+
 	/* see 7.1.7.6 */
 	if (hub_is_superspeed(hub->hdev))
 		status = hub_set_port_link_state(hub, port1, USB_SS_PORT_LS_U3);
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 82806e311202..9325be88bb02 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -203,6 +203,10 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x10d6, 0x2200), .driver_info =
 			USB_QUIRK_STRING_FETCH_255 },
 
+	/* Huawei 4G LTE module */
+	{ USB_DEVICE(0x12d1, 0x15c3), .driver_info = USB_QUIRK_DISCONNECT_SUSPEND},
+	{ USB_DEVICE(0x12d1, 0x15bb), .driver_info = USB_QUIRK_DISCONNECT_SUSPEND},
+
 	/* SKYMEDI USB_DRIVE */
 	{ USB_DEVICE(0x1516, 0x8628), .driver_info = USB_QUIRK_RESET_RESUME },
 
diff --git a/include/linux/usb/quirks.h b/include/linux/usb/quirks.h
index de2a722fe3cf..45ad360dfa21 100644
--- a/include/linux/usb/quirks.h
+++ b/include/linux/usb/quirks.h
@@ -56,4 +56,9 @@
  */
 #define USB_QUIRK_LINEAR_FRAME_INTR_BINTERVAL	BIT(11)
 
+/* device need to be disconnect before suspend to prevent from unexpected
+ * wakeup.
+ */
+#define USB_QUIRK_DISCONNECT_SUSPEND		BIT(12)
+
 #endif /* __LINUX_USB_QUIRKS_H */
-- 
2.11.0
