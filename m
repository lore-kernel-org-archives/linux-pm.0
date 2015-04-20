From: Tom Yan <tom.ty89-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: default value of power/wakeup
Date: Tue, 21 Apr 2015 02:34:17 +0800
Message-ID: <CAGnHSE=AuGjAKq5TgoFN6iJQHOwAQmOOrBkk9D6GTz5na8wLpw@mail.gmail.com>
References: <CAGnHSE=tvTisq3xd67edEcC+pBOqUmWoUU2nKZXhR5AfRzNO7g@mail.gmail.com>
	<Pine.LNX.4.44L0.1504201339270.1321-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1504201339270.1321-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Thank you very much for your reply.

So I tried to see if there's any difference between the two devices. I
can see that the one didn't get enabled by default has an extra
interface with 0 for the two attributes. But does that matter? Because
if it does, shouldn't the mouse interface prevents the other one to
get enabled by default as well?

Seems to me the keyboard interface is the first interface for both devices:
[tom@localhost ~]$ cat
/sys/devices/pci0000\:00/0000\:00\:14.0/usb3/3-13/3-13\:1.0/bInterfaceSubClass
01
[tom@localhost ~]$ cat
/sys/devices/pci0000\:00/0000\:00\:14.0/usb3/3-13/3-13\:1.0/bInterfaceProtocol
01
[tom@localhost ~]$ cat
/sys/devices/pci0000\:00/0000\:00\:14.0/usb3/3-14/3-14\:1.0/bInterfaceSubClass
01
[tom@localhost ~]$ cat
/sys/devices/pci0000\:00/0000\:00\:14.0/usb3/3-14/3-14\:1.0/bInterfaceProtocol
01

[tom@localhost ~]$ diff <(sudo lsusb -v -s 003:002) <(sudo lsusb -v -s 003:003)
can't get device qualifier: Resource temporarily unavailable
can't get debug descriptor: Resource temporarily unavailable
can't get device qualifier: Resource temporarily unavailable
can't get debug descriptor: Resource temporarily unavailable
2c2
< Bus 003 Device 002: ID 046d:c52b Logitech, Inc. Unifying Receiver
---
> Bus 003 Device 003: ID 046d:c52e Logitech, Inc. MK260 Wireless Combo Receiver
12,13c12,13
<   idProduct          0xc52b Unifying Receiver
<   bcdDevice           12.01
---
>   idProduct          0xc52e MK260 Wireless Combo Receiver
>   bcdDevice           15.00
21,22c21,22
<     wTotalLength           84
<     bNumInterfaces          3
---
>     wTotalLength           59
>     bNumInterfaces          2
24c24
<     iConfiguration          4 RQR12.01_B0019
---
>     iConfiguration          4 RQR15.00_B0048
76c76
<           wDescriptorLength     148
---
>           wDescriptorLength     177
87,117c87
<         wMaxPacketSize     0x0008  1x 8 bytes
<         bInterval               2
<     Interface Descriptor:
<       bLength                 9
<       bDescriptorType         4
<       bInterfaceNumber        2
<       bAlternateSetting       0
<       bNumEndpoints           1
<       bInterfaceClass         3 Human Interface Device
<       bInterfaceSubClass      0
<       bInterfaceProtocol      0
<       iInterface              0
<         HID Device Descriptor:
<           bLength                 9
<           bDescriptorType        33
<           bcdHID               1.11
<           bCountryCode            0 Not supported
<           bNumDescriptors         1
<           bDescriptorType        34 Report
<           wDescriptorLength      98
<          Report Descriptors:
<            ** UNAVAILABLE **
<       Endpoint Descriptor:
<         bLength                 7
<         bDescriptorType         5
<         bEndpointAddress     0x83  EP 3 IN
<         bmAttributes            3
<           Transfer Type            Interrupt
<           Synch Type               None
<           Usage Type               Data
<         wMaxPacketSize     0x0020  1x 32 bytes
---
>         wMaxPacketSize     0x0014  1x 20 bytes

On 21 April 2015 at 01:41, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> wrote:
> On Tue, 21 Apr 2015, Tom Yan wrote:
>
>> I have the following two USB wireless mouse/keyboard receivers:
>>
>> logitech-djreceiver 0003:046D:C52B.0003: hiddev0,hidraw0: USB HID
>> v1.11 Device [Logitech USB Receiver] on usb-0000:00:14.0-13/input2
>> hid-generic 0003:046D:C52E.0005: input,hidraw2: USB HID v1.11 Keyboard
>> [Logitech USB Receiver] on usb-0000:00:14.0-14/input0
>>
>> The default values in their power/wakeup:
>> [tom@localhost ~]$ cat /sys/bus/usb/devices/3-13/power/wakeup
>> disabled
>> [tom@localhost ~]$ cat /sys/bus/usb/devices/3-14/power/wakeup
>> enabled
>>
>> According to https://www.kernel.org/doc/Documentation/usb/power-management.txt:
>>
>> power/wakeup
>>
>>         This file is empty if the device does not support
>>         remote wakeup.  Otherwise the file contains either the
>>         word "enabled" or the word "disabled", ...
>>
>> My question is, which part of the kernel or system determines the
>> default value? When I had a quick look on the source of the two driver
>> modules, I couldn't find any code related. So what caused the
>> difference?
>>
>> P.S. I have no udev rule related to power/wakeup, which is the case I
>> am asking about.
>>
>> [tom@localhost ~]$ cd /etc/udev/rules.d/
>> [tom@localhost rules.d]$ grep wakeup *
>> grep: *: No such file or directory
>> [tom@localhost rules.d]$ cd /lib/udev/rules.d/
>> [tom@localhost rules.d]$ grep wakeup *
>> 42-usb-hid-pm.rules:# advertise remote wakeup support but don't
>> actually implement
>> 42-usb-hid-pm.rules:# remote wakeup is working.
>
> This is from usbhid_start() in drivers/hid/usbhid/hid-core.c:
>
>         /* Some keyboards don't work until their LEDs have been set.
>          * Since BIOSes do set the LEDs, it must be safe for any device
>          * that supports the keyboard boot protocol.
>          * In addition, enable remote wakeup by default for all keyboard
>          * devices supporting the boot protocol.
>          */
>         if (interface->desc.bInterfaceSubClass == USB_INTERFACE_SUBCLASS_BOOT &&
>                         interface->desc.bInterfaceProtocol ==
>                                 USB_INTERFACE_PROTOCOL_KEYBOARD) {
>                 usbhid_set_leds(hid);
>                 device_set_wakeup_enable(&dev->dev, 1);
>         }
>
> Alan Stern
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
