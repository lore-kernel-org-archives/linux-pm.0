From: Tom Yan <tom.ty89-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: default value of power/wakeup
Date: Tue, 21 Apr 2015 18:19:50 +0800
Message-ID: <CAGnHSEmFjAAAkfFTfgtM1yWXsSZBWraoc1mzQRR7v02FubpeWA@mail.gmail.com>
References: <CAGnHSE=pYr+0pDqS3x=G6qQGLtkP+8yx9OZH_0h=pctrfB85JQ@mail.gmail.com>
	<Pine.LNX.4.44L0.1504201527570.1321-100000@iolanthe.rowland.org>
	<CAGnHSEnrS9+4Kq_bx5S_gtRMm2pCbn5ETTa-Cegy+XBvN8sX1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGnHSEnrS9+4Kq_bx5S_gtRMm2pCbn5ETTa-Cegy+XBvN8sX1g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

By blacklisting the hid-generic, I think I can confirm hid-generic is
the module that matters. Though I'm curious how it use the code from
usbhid/hid-core.c because I couldn't find a clue in the short
hid-generic.c.

Anyway I don't know much about coding so it's not really my concern.
But I think the fact hid-generic sets a default (no matter if it's
"enabled" or "disabled") brings a problem. The reason is, the wakeup
attribute is not "initialized" or "created" by hid-generic, so udev
can apply a rule related to the attribute before hid-generic get
loaded (which seems to be what it is doing, see
https://bugs.freedesktop.org/show_bug.cgi?id=90041). If the module
gets loaded or reloaded afterwards, the value would be set to the
hard-coded default anyway.

Perhaps it is possible to change the behaviour by rewriting some bits
of udev, but I don't see the point of doing so. IMHO these hard-coded
default should be avoid from all drivers until it is really necessary,
and when it is needed, it's best to have the default set right at the
point when the attribute is initialized if possible.

On 21 April 2015 at 05:20, Tom Yan <tom.ty89-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On 21 April 2015 at 03:44, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> wrote:
>
>> The generic driver includes code for enabling wakeup by default,
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
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
