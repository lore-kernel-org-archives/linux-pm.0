From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: Should 9aafabc7fece be reverted?
Date: Mon, 23 May 2016 11:05:12 -0500
Message-ID: <57432A38.1000407@ti.com>
References: <573C9F45.5090109@ti.com> <201605191806.50809@pali>
 <573DE5A2.7070900@ti.com> <201605191818.20237@pali> <573DEDFF.8060305@ti.com>
 <20160520093432.GC4580@amd> <20160520103505.GW29844@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48634 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098AbcEWQFm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 May 2016 12:05:42 -0400
In-Reply-To: <20160520103505.GW29844@pali>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org

On 05/20/2016 05:35 AM, Pali Roh=C3=A1r wrote:
> On Friday 20 May 2016 11:34:32 Pavel Machek wrote:
>> Hi!
>>
>>>> I think it is insane to starts generating random numbers for IDR..=
=2E Hard=20
>>>> to decide what happen if such situation occur...
>>>>
>>>
>>> That's kind of what I'm looking for though, if the userspace break =
is
>>> caused by software relying on the battery to be named "bq27200-0", =
then
>>> nothing short of hard-coding this exact name will 100% safely fix t=
he
>>> N900 userspace software. And so using IDR and hoping it gives 0 is =
just
>>> a hacky work-around way of just naming the device "bq27200-0".
>>
>> BTW proposals how to fix that userspace would be welcome.
>>
>> We have three "power supplies", but userspace does not know how they
>> are connecting, resulting in strange results. For now, I have
>> hardware-specific layer in userspace.
>>
>> https://gitlab.com/tui/tui/blob/master/ofone/hardware.py
>>
>> Kernel does not really give me other choice.
>=20
> I have in my mind idea of "merged" power supply devices.
>=20
> For Nokia N900 we have:
> * bq27200 monitoring chip
> * bq24150a charging chip
> * isp1707 usb phy chargin chip (wallcharger detection + enable gpio)
> * rx51_battery driver (export ADC values from battery pins: temperatu=
re + design capacity)
>=20
> And each part export own power supply device in /sys/class/power_supp=
ly/
> So there are 4 power supply devices!
>=20
> In ideal world kernel should provide into userspace just two devices:
> * power supply charger device (merged values from isp1707 and bq24150=
a)
> * power supply battery device (merged values from rx51_battery and bq=
27200)
>=20
> Problem is that e.g. design capacity value provide both drivers. But
> bq27xxx just return constant and incorrect value from bq eeprom. Corr=
ect
> design capacity return only rx51_battery (which read it via ADC, thir=
d
> battery pin).
>=20
> That should fix detection and discovery problem. On Nokia N900 there =
is
> just one battery and one charger device.
>=20

Right, so there is no need to append each type of power-supply device
with a number, as there is only one of each type of power-supply, they
can still be uniquely identified. And if ever a product comes out that
has two or more of the same power-supply then they can be identified by
the I2C address they are attached to.

Number them in the name would not even work as it would change dependin=
g
on probe order and not based on which battery is which.

Andrew
