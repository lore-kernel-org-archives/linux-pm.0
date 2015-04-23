From: Tom Yan <tom.ty89@gmail.com>
Subject: Re: default value of power/wakeup
Date: Thu, 23 Apr 2015 13:16:36 +0800
Message-ID: <CAGnHSEnPCL3PgA9-L5ECD=7WW3ykYrd-cDUXcT1dd-zE9WwXcw@mail.gmail.com>
References: <20150422171050.GB2551@kroah.com>
	<Pine.LNX.4.44L0.1504221403380.1630-100000@iolanthe.rowland.org>
	<BN3PR0301MB084933B354441C7D8A37221C81ED0@BN3PR0301MB0849.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:34330 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744AbbDWFQh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Apr 2015 01:16:37 -0400
In-Reply-To: <BN3PR0301MB084933B354441C7D8A37221C81ED0@BN3PR0301MB0849.namprd03.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Chen <Peter.Chen@freescale.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg KH <greg@kroah.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

I'm not saying that the kernel shouldn't initialize the attributes or
have a default. But it should only set the default when the attribute
is initialized (It doesn't even matter to me whether it's enabled or
disabled).

It's just there should not be further manipulation from the kernel
(e.g. device_set_wakeup_enable) afterwards because
1. it's brings inconsistency because the function is adopted per driver
2. it's a user preference and responsibilty
3. third it prevent udev to apply a rule properly (regression / bug)

P.S. Alan for my case, I don't need a patch for logitech-dj, I just
need to remove device_set_enable_wakeup from hid_core.c, then I can
enable or disable the attribute with a udev rule happily for both
devices.

=E2=96=B6 Show quoted text
On 23 April 2015 at 09:21, Peter Chen <Peter.Chen@freescale.com> wrote:
>
>> > >
>> > > Oh, okay, I didn't realize that.
>> > >
>> > > Is there a reasonable way to enable wakeup only when the driver
>> > > learns that a keyboard is connected?  Where would the driver do =
this?
>> >
>> > I don't know if the driver ever "knows" this, as you can pair lots=
 of
>> > different devices to this same receiver.  There's a userspace
>> > application that lets you manage the device, called "solaar", that
>> > this option could be changed in.
>> >
>> > But really, putting the device to sleep should work for it no matt=
er
>> > if this is a keyboard or a mouse or a joystick, as the wakeup logi=
c is
>> > in the receiver, not in the device on the other end of the wireles=
s link.
>> >
>> > Turning autosuspend works for me for my mouse connected.  It doesn=
't
>> > work for one of my "real" USB keyboards when it's connected to the
>> > machine, which is why I can't enable autosuspend for it, as it dri=
ves
>> > me crazy.
>> >
>> > I don't have a keyboard to test the receiver with at the moment, t=
o
>> > see if autosuspend works for both things connected at the same tim=
e,
>> > or for just the keyboard.
>>
>> Tom and I have been talking about enabling wakeup, not autosuspend.
>> The question is whether or not the default wakeup setting for the re=
ceiver
>> should be "enabled".
>>
>> The kernel's policy is that keyboards should be enabled for wakeup, =
by default.
>> I think that matches most people's expectations.  But when you've go=
t a
>> "universal" receiver, what then?
>>
>> Should it always be enabled by default because a keyboard _might_ be
>> connected?  Should it be enabled only when a keyboard is detected?
>> What if multiple devices are connected at the same time?
>>
>
> From my point, the user option should not depend on kernel default va=
lue.
> If the system you build needs some USB devices as system wakeup sourc=
e,
> the developers need to make sure the wakeups are enabled before syste=
m
> enters suspend.
>
> Peter
>
>> Shucks -- does the receiver even _work_ as a wakeup device?  It clai=
ms to, but
>> that would require it to remain in wireless contact with the remote =
keyboard
>> even while it's supposed to be in a low-power state, which rather se=
ems to
>> defeat the purpose.
>>
>> Alan Stern
>>
>> PS: I've got wakeup enabled for the PS/2 keyboard attached to the co=
mputer
>> I'm using now, but it doesn't work.  I have to press the power butto=
n to wake
>> the machine up from suspend.  Probably an issue in the BIOS or ACPI =
-- I
>> haven't bothered to try and track it down.
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-usb"=
 in the body
>> of a message to majordomo@vger.kernel.org More majordomo info at
>> http://vger.kernel.org/majordomo-info.html
