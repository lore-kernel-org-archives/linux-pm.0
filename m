From: Tom Yan <tom.ty89@gmail.com>
Subject: Re: default value of power/wakeup
Date: Thu, 23 Apr 2015 13:29:56 +0800
Message-ID: <CAGnHSEm8VPZ6fmopyFnedek65tz_mhSEPhWy3jJe031reNRvrQ@mail.gmail.com>
References: <20150422171050.GB2551@kroah.com>
	<Pine.LNX.4.44L0.1504221403380.1630-100000@iolanthe.rowland.org>
	<BN3PR0301MB084933B354441C7D8A37221C81ED0@BN3PR0301MB0849.namprd03.prod.outlook.com>
	<CAGnHSEnPCL3PgA9-L5ECD=7WW3ykYrd-cDUXcT1dd-zE9WwXcw@mail.gmail.com>
	<BN3PR0301MB0849FD2CF54F10347A5B046E81ED0@BN3PR0301MB0849.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:35144 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbbDWF35 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Apr 2015 01:29:57 -0400
In-Reply-To: <BN3PR0301MB0849FD2CF54F10347A5B046E81ED0@BN3PR0301MB0849.namprd03.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Chen <Peter.Chen@freescale.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg KH <greg@kroah.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

https://bugs.freedesktop.org/show_bug.cgi?id=3D90041
Because udev's work would get overrided if there's further
manipulation. So if you want your udev rule to work, you have to make
sure you run a trigger command after the module is loaded or reloaded.
This would happen for all types of devices if their driver make sure
of function like device_set_wakeup_enable.

P.S. Though there could be exceptions if the module is loaded in early
user space. Then the rule will only get overrided if you somehow need
to reload the module.

On 23 April 2015 at 13:22, Peter Chen <Peter.Chen@freescale.com> wrote:
>
>>
>> I'm not saying that the kernel shouldn't initialize the attributes o=
r have a default.
>> But it should only set the default when the attribute is initialized=
 (It doesn't
>> even matter to me whether it's enabled or disabled).
>>
>> It's just there should not be further manipulation from the kernel (=
e.g.
>> device_set_wakeup_enable) afterwards because 1. it's brings inconsis=
tency
>> because the function is adopted per driver 2. it's a user preference=
 and
>> responsibilty 3. third it prevent udev to apply a rule properly (reg=
ression / bug)
>>
>> P.S. Alan for my case, I don't need a patch for logitech-dj, I just =
need to remove
>> device_set_enable_wakeup from hid_core.c, then I can enable or disab=
le the
>> attribute with a udev rule happily for both devices.
>>
>
> You may apply your choice no matter what the default value is, would =
you tell us
> why you can't do that?
>
> Peter
>
>> =E2=96=B6 Show quoted text
>> On 23 April 2015 at 09:21, Peter Chen <Peter.Chen@freescale.com> wro=
te:
>> >
>> >> > >
>> >> > > Oh, okay, I didn't realize that.
>> >> > >
>> >> > > Is there a reasonable way to enable wakeup only when the driv=
er
>> >> > > learns that a keyboard is connected?  Where would the driver =
do this?
>> >> >
>> >> > I don't know if the driver ever "knows" this, as you can pair l=
ots
>> >> > of different devices to this same receiver.  There's a userspac=
e
>> >> > application that lets you manage the device, called "solaar", t=
hat
>> >> > this option could be changed in.
>> >> >
>> >> > But really, putting the device to sleep should work for it no
>> >> > matter if this is a keyboard or a mouse or a joystick, as the
>> >> > wakeup logic is in the receiver, not in the device on the other=
 end of the
>> wireless link.
>> >> >
>> >> > Turning autosuspend works for me for my mouse connected.  It
>> >> > doesn't work for one of my "real" USB keyboards when it's conne=
cted
>> >> > to the machine, which is why I can't enable autosuspend for it,=
 as
>> >> > it drives me crazy.
>> >> >
>> >> > I don't have a keyboard to test the receiver with at the moment=
, to
>> >> > see if autosuspend works for both things connected at the same
>> >> > time, or for just the keyboard.
>> >>
>> >> Tom and I have been talking about enabling wakeup, not autosuspen=
d.
>> >> The question is whether or not the default wakeup setting for the
>> >> receiver should be "enabled".
>> >>
>> >> The kernel's policy is that keyboards should be enabled for wakeu=
p, by
>> default.
>> >> I think that matches most people's expectations.  But when you've=
 got
>> >> a "universal" receiver, what then?
>> >>
>> >> Should it always be enabled by default because a keyboard _might_=
 be
>> >> connected?  Should it be enabled only when a keyboard is detected=
?
>> >> What if multiple devices are connected at the same time?
>> >>
>> >
>> > From my point, the user option should not depend on kernel default=
 value.
>> > If the system you build needs some USB devices as system wakeup
>> > source, the developers need to make sure the wakeups are enabled
>> > before system enters suspend.
>> >
>> > Peter
>> >
>> >> Shucks -- does the receiver even _work_ as a wakeup device?  It
>> >> claims to, but that would require it to remain in wireless contac=
t
>> >> with the remote keyboard even while it's supposed to be in a
>> >> low-power state, which rather seems to defeat the purpose.
>> >>
>> >> Alan Stern
>> >>
>> >> PS: I've got wakeup enabled for the PS/2 keyboard attached to the
>> >> computer I'm using now, but it doesn't work.  I have to press the
>> >> power button to wake the machine up from suspend.  Probably an is=
sue
>> >> in the BIOS or ACPI -- I haven't bothered to try and track it dow=
n.
>> >>
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe linux-u=
sb"
>> >> in the body of a message to majordomo@vger.kernel.org More majord=
omo
>> >> info at http://vger.kernel.org/majordomo-info.html
