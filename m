From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: Should 9aafabc7fece be reverted?
Date: Fri, 20 May 2016 12:35:05 +0200
Message-ID: <20160520103505.GW29844@pali>
References: <573C9F45.5090109@ti.com>
 <201605191806.50809@pali>
 <573DE5A2.7070900@ti.com>
 <201605191818.20237@pali>
 <573DEDFF.8060305@ti.com>
 <20160520093432.GC4580@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35043 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932424AbcETKfJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 May 2016 06:35:09 -0400
Received: by mail-wm0-f46.google.com with SMTP id w143so23283845wmw.0
        for <linux-pm@vger.kernel.org>; Fri, 20 May 2016 03:35:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160520093432.GC4580@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Andrew F. Davis" <afd@ti.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org

On Friday 20 May 2016 11:34:32 Pavel Machek wrote:
> Hi!
>=20
> > > I think it is insane to starts generating random numbers for IDR.=
=2E. Hard=20
> > > to decide what happen if such situation occur...
> > >=20
> >=20
> > That's kind of what I'm looking for though, if the userspace break =
is
> > caused by software relying on the battery to be named "bq27200-0", =
then
> > nothing short of hard-coding this exact name will 100% safely fix t=
he
> > N900 userspace software. And so using IDR and hoping it gives 0 is =
just
> > a hacky work-around way of just naming the device "bq27200-0".
>=20
> BTW proposals how to fix that userspace would be welcome.
>=20
> We have three "power supplies", but userspace does not know how they
> are connecting, resulting in strange results. For now, I have
> hardware-specific layer in userspace.
>=20
> https://gitlab.com/tui/tui/blob/master/ofone/hardware.py
>=20
> Kernel does not really give me other choice.

I have in my mind idea of "merged" power supply devices.

=46or Nokia N900 we have:
* bq27200 monitoring chip
* bq24150a charging chip
* isp1707 usb phy chargin chip (wallcharger detection + enable gpio)
* rx51_battery driver (export ADC values from battery pins: temperature=
 + design capacity)

And each part export own power supply device in /sys/class/power_supply=
/
So there are 4 power supply devices!

In ideal world kernel should provide into userspace just two devices:
* power supply charger device (merged values from isp1707 and bq24150a)
* power supply battery device (merged values from rx51_battery and bq27=
200)

Problem is that e.g. design capacity value provide both drivers. But
bq27xxx just return constant and incorrect value from bq eeprom. Correc=
t
design capacity return only rx51_battery (which read it via ADC, third
battery pin).

That should fix detection and discovery problem. On Nokia N900 there is
just one battery and one charger device.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
