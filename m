From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: default value of power/wakeup
Date: Mon, 20 Apr 2015 13:41:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1504201339270.1321-100000@iolanthe.rowland.org>
References: <CAGnHSE=tvTisq3xd67edEcC+pBOqUmWoUU2nKZXhR5AfRzNO7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:50652 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751429AbbDTRlm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2015 13:41:42 -0400
In-Reply-To: <CAGnHSE=tvTisq3xd67edEcC+pBOqUmWoUU2nKZXhR5AfRzNO7g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tom Yan <tom.ty89@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, 21 Apr 2015, Tom Yan wrote:

> I have the following two USB wireless mouse/keyboard receivers:
> 
> logitech-djreceiver 0003:046D:C52B.0003: hiddev0,hidraw0: USB HID
> v1.11 Device [Logitech USB Receiver] on usb-0000:00:14.0-13/input2
> hid-generic 0003:046D:C52E.0005: input,hidraw2: USB HID v1.11 Keyboard
> [Logitech USB Receiver] on usb-0000:00:14.0-14/input0
> 
> The default values in their power/wakeup:
> [tom@localhost ~]$ cat /sys/bus/usb/devices/3-13/power/wakeup
> disabled
> [tom@localhost ~]$ cat /sys/bus/usb/devices/3-14/power/wakeup
> enabled
> 
> According to https://www.kernel.org/doc/Documentation/usb/power-management.txt:
> 
> power/wakeup
> 
>         This file is empty if the device does not support
>         remote wakeup.  Otherwise the file contains either the
>         word "enabled" or the word "disabled", ...
> 
> My question is, which part of the kernel or system determines the
> default value? When I had a quick look on the source of the two driver
> modules, I couldn't find any code related. So what caused the
> difference?
> 
> P.S. I have no udev rule related to power/wakeup, which is the case I
> am asking about.
> 
> [tom@localhost ~]$ cd /etc/udev/rules.d/
> [tom@localhost rules.d]$ grep wakeup *
> grep: *: No such file or directory
> [tom@localhost rules.d]$ cd /lib/udev/rules.d/
> [tom@localhost rules.d]$ grep wakeup *
> 42-usb-hid-pm.rules:# advertise remote wakeup support but don't
> actually implement
> 42-usb-hid-pm.rules:# remote wakeup is working.

This is from usbhid_start() in drivers/hid/usbhid/hid-core.c:

	/* Some keyboards don't work until their LEDs have been set.
	 * Since BIOSes do set the LEDs, it must be safe for any device
	 * that supports the keyboard boot protocol.
	 * In addition, enable remote wakeup by default for all keyboard
	 * devices supporting the boot protocol.
	 */
	if (interface->desc.bInterfaceSubClass == USB_INTERFACE_SUBCLASS_BOOT &&
			interface->desc.bInterfaceProtocol ==
				USB_INTERFACE_PROTOCOL_KEYBOARD) {
		usbhid_set_leds(hid);
		device_set_wakeup_enable(&dev->dev, 1);
	}

Alan Stern

