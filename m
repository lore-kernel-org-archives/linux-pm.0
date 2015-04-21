From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: default value of power/wakeup
Date: Tue, 21 Apr 2015 11:23:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1504211108270.1518-100000@iolanthe.rowland.org>
References: <CAGnHSEnrS9+4Kq_bx5S_gtRMm2pCbn5ETTa-Cegy+XBvN8sX1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:36600 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753512AbbDUPX0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Apr 2015 11:23:26 -0400
In-Reply-To: <CAGnHSEnrS9+4Kq_bx5S_gtRMm2pCbn5ETTa-Cegy+XBvN8sX1g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tom Yan <tom.ty89@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, 21 Apr 2015, Tom Yan wrote:

> On 21 April 2015 at 03:44, Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > The generic driver includes code for enabling wakeup by default,
> 
> Is there a part of code which can shows this? It seems to me that the
> usbhid module is loaded for all USB HID devices, so I doubt a bit:
> 
> [tom@localhost ~]$ journalctl -b -1 | grep hid
> Apr 21 05:00:36 localhost kernel: hidraw: raw HID events driver (C) Jiri Kosina
> Apr 21 05:00:36 localhost kernel: usbcore: registered new interface
> driver usbhid
> Apr 21 05:00:36 localhost kernel: usbhid: USB HID core driver
> Apr 21 05:00:36 localhost kernel: hid-generic 0003:046D:C52E.0001:
> input,hidraw0: USB HID v1.11 Keyboard [Logitech USB Receiver] on
> usb-0000:00:14.0-14/input0
> Apr 21 05:00:36 localhost kernel: hid-generic 0003:046D:C52E.0002:
> input,hiddev0,hidraw1: USB HID v1.11 Mouse [Logitech USB Receiver] on
> usb-0000:00:14.0-14/input1
> 
> [tom@localhost ~]$ journalctl -b -2 | grep hid
> Apr 21 04:59:58 localhost kernel: hidraw: raw HID events driver (C) Jiri Kosina
> Apr 21 04:59:58 localhost kernel: usbcore: registered new interface
> driver usbhid
> Apr 21 04:59:58 localhost kernel: usbhid: USB HID core driver
> Apr 21 04:59:58 localhost kernel: logitech-djreceiver
> 0003:046D:C52B.0003: hiddev0,hidraw0: USB HID v1.11 Device [Logitech
> USB Receiver] on usb-0000:00:14.0-13/input2
> Apr 21 04:59:58 localhost kernel: logitech-hidpp-device
> 0003:046D:4024.0004: input,hidraw1: USB HID v1.11 Keyboard [Logitech
> K400] on usb-0000:00:14.0-13:1
> 
> [tom@localhost ~]$ lsusb -t
> /:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/6p, 5000M
>     |__ Port 1: Dev 2, If 0, Class=Mass Storage, Driver=usb-storage, 5000M
> /:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/14p, 480M
>     |__ Port 13: Dev 2, If 0, Class=Human Interface Device, Driver=usbhid, 12M
>     |__ Port 13: Dev 2, If 1, Class=Human Interface Device, Driver=usbhid, 12M
>     |__ Port 13: Dev 2, If 2, Class=Human Interface Device, Driver=usbhid, 12M
>     |__ Port 14: Dev 3, If 0, Class=Human Interface Device, Driver=usbhid, 12M
>     |__ Port 14: Dev 3, If 1, Class=Human Interface Device, Driver=usbhid, 12M
> /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=ehci-pci/2p, 480M
>     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/8p, 480M
> /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=ehci-pci/2p, 480M
>     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/6p, 480M

You see this because logitech_djreceiver overrides the setting of the 
ll_driver field in struct hid_device.

Briefly, usbhid/hid-core.c initializes the wakeup setting in 
usbhid_start(), which is the .start member of usb_hid_driver, which is 
assigned (in usbhid_probe()) to hid->ll_driver.

But the logi_dj_recv_add_djhid_device() routine in hid-logitech-dj.c 
changes dj_hiddev->ll_driver to &logi_dj_ll_driver, and its .start 
member is logi_dj_ll_start(), which does not initialize the wakeup 
setting.  Since usbhid_start() never gets called, the device doesn't 
get enabled for wakeup.

See the logi_dj_probe() routine for more details about how this works.

Alan Stern

