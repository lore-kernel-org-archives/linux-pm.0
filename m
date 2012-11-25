From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] usb: add USB_QUIRK_RESET_RESUME for M-Audio 49
Date: Sun, 25 Nov 2012 13:21:00 -0800
Message-ID: <20121125212100.GE24024@elie.Belkin>
References: <4FA2D481.4070304@droids-corp.org>
 <4FA2DB9D.1040303@droids-corp.org>
 <20120604110608.GG8248@droids-corp.org>
 <20120605232432.GE3619@burratino>
 <4FD06563.7050605@droids-corp.org>
 <20121125094110.GA21387@elie.Belkin>
 <50B2815E.2090105@droids-corp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <50B2815E.2090105@droids-corp.org>
Sender: stable-owner@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-pm@vger.kernel.org, alsa-devel@alsa-project.org, David Banks <amoebae@gmail.com>, Olivier MATZ <zer0@droids-corp.org>, Ralf Lang <lang@b1-systems.de>, Steffen =?utf-8?Q?M=C3=BCller?= <steffen.mueller@radio-frei.de>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Some USB MIDI keyboards fail to operate after a USB autosuspend.  The
device is recognized by ALSA, but no events are received and the
device goes quiet.

	$ amidi -l
	Dir Device    Name
	IO  hw:1,0,0  Oxygen 49 MIDI 1
	$ amidi -p hw:1,0,0 -d
	<... play some notes ...>
	^C
	0 bytes read

A workaround is to disable USB autosuspend for these devices by
putting AUTOSUSPEND_USBID_BLACKLIST="0763:2027" (resp. 0763:019b) in
/etc/laptop-mode/conf.d/usb-autosuspend.conf.  In the spirit of commit
166cb70e97bd ("usb: add USB_QUIRK_RESET_RESUME for M-Audio 88es"),
reset the device on resume so this workaround is not needed any more.

Noticed on a kernel close to 3.2.10.  Tested against 3.6.5.  Debian's
2.6.32.54-based kernel did not seem to be affected, though it's not
clear whether that is due to code or configuration.

Addresses http://bugs.debian.org/664068

Reported-and-tested-by: David Banks <amoebae@gmail.com> # Oxygen 49
Reported-and-tested-by: Olivier MATZ <zer0@droids-corp.org> # KeyRig 49
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Cc: stable@vger.kernel.org
---
Thoughts?

 drivers/usb/core/quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index fdefd9c7f7af..998c6a8290f6 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -105,6 +105,12 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* Midiman M-Audio Keystation 88es */
 	{ USB_DEVICE(0x0763, 0x0192), .driver_info = USB_QUIRK_RESET_RESUME },
 
+	/* Midiman M-Audio KeyRig 49 */
+	{ USB_DEVICE(0x0763, 0x019b), .driver_info = USB_QUIRK_RESET_RESUME },
+
+	/* Midiman M-Audio Oxygen 49 */
+	{ USB_DEVICE(0x0763, 0x2027), .driver_info = USB_QUIRK_RESET_RESUME },
+
 	/* M-Systems Flash Disk Pioneers */
 	{ USB_DEVICE(0x08ec, 0x1000), .driver_info = USB_QUIRK_RESET_RESUME },
 
-- 
1.8.0
