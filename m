From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: default value of power/wakeup
Date: Tue, 21 Apr 2015 11:51:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1504211126530.1518-100000@iolanthe.rowland.org>
References: <CAGnHSEmFjAAAkfFTfgtM1yWXsSZBWraoc1mzQRR7v02FubpeWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:36621 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932882AbbDUPvI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Apr 2015 11:51:08 -0400
In-Reply-To: <CAGnHSEmFjAAAkfFTfgtM1yWXsSZBWraoc1mzQRR7v02FubpeWA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tom Yan <tom.ty89@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, 21 Apr 2015, Tom Yan wrote:

> By blacklisting the hid-generic, I think I can confirm hid-generic is
> the module that matters. Though I'm curious how it use the code from
> usbhid/hid-core.c because I couldn't find a clue in the short
> hid-generic.c.

In fact, hid-generic.c contains no executable code at all!  What 
matters is that it is a driver and it can bind to a device.  Take a 
look at the hid_device_probe() routine in hid-core.c, and bear in mind 
that hid_hw_start() is an inline routine which calls 
hdev->ll_driver->start().

> Anyway I don't know much about coding so it's not really my concern.
> But I think the fact hid-generic sets a default (no matter if it's
> "enabled" or "disabled") brings a problem. The reason is, the wakeup
> attribute is not "initialized" or "created" by hid-generic, so udev
> can apply a rule related to the attribute before hid-generic get
> loaded (which seems to be what it is doing, see
> https://bugs.freedesktop.org/show_bug.cgi?id=90041). If the module
> gets loaded or reloaded afterwards, the value would be set to the
> hard-coded default anyway.

This is a similar problem affecting all devices.  The wakeup attribute
in sysfs (along with all the other power-related sysfs attributes) gets
created before the device is probed.  Consequently, any changes made by
drivers in their probe routines don't show up in the initial sysfs 
files.

> Perhaps it is possible to change the behaviour by rewriting some bits
> of udev, but I don't see the point of doing so. IMHO these hard-coded
> default should be avoid from all drivers until it is really necessary,
> and when it is needed, it's best to have the default set right at the
> point when the attribute is initialized if possible.

Setting the default when the attribute gets initialized is not possible
in this case.  The wakeup attribute belongs to the USB device, but the
fact that the device can act as a keyboard is hidden away in one of the
interfaces (and the interfaces are registered _after_ the device).  
Things would be a little better if the wakeup attribute were a property
of the interface, but it isn't.

Anyway, you're suggesting that drivers should never override sysfs
attribute values.  But there doesn't seem to be any other way to
implement the kernel's policy that wakeup should be enabled by default
for all keyboard devices.  After all, only the driver knows whether or
not the device it manages is a keyboard.

Alan Stern

