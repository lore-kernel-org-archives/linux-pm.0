From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: Should 9aafabc7fece be reverted?
Date: Mon, 23 May 2016 11:29:33 -0500
Message-ID: <57432FED.1080704@ti.com>
References: <573C9F45.5090109@ti.com> <20160520092927.GB4580@amd>
 <57432805.6000108@ti.com> <201605231810.42102@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([198.47.19.12]:60591 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753046AbcEWQaE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 23 May 2016 12:30:04 -0400
In-Reply-To: <201605231810.42102@pali>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org

On 05/23/2016 11:10 AM, Pali Roh=C3=A1r wrote:
> On Monday 23 May 2016 17:55:49 Andrew F. Davis wrote:
>> On 05/20/2016 04:29 AM, Pavel Machek wrote:
>>> Hi!
>>>
>>>>>>>>> No, it is not driver name, but device name. That is
>>>>>>>>> different.
>>>>>>>>
>>>>>>>> My bad, that's what I meant, device names should be dynamic,
>>>>>>>> right? Relying on them being static in software would then be
>>>>>>>> buggy (like relying on eth0 being the right NIC everytime)?
>>>>>>>>
>>>>>>>> I'm not familiar with the N900 software, but IDR can give out
>>>>>>>> different numbers and may not always give the first battery #0
>>>>>>>> (it does now but is that a guarantee in IDR?) and if not then
>>>>>>>> what is the userspace response to this changing?
>>>>>>>
>>>>>>> In case N900 would have more bq27xxx batteries, then yes. But
>>>>>>> N900 has exactly *one* bq27200 battery, so there is no IDR
>>>>>>> problem.
>>>>>>
>>>>>> Right, but if IDR returns 42 instead of 0 would this then break
>>>>>> its userspace software?
>>>>>
>>>>> I think it is insane to starts generating random numbers for
>>>>> IDR... Hard to decide what happen if such situation occur...
>>>>
>>>> That's kind of what I'm looking for though, if the userspace break
>>>> is caused by software relying on the battery to be named
>>>> "bq27200-0", then nothing short of hard-coding this exact name
>>>> will 100% safely fix the N900 userspace software. And so using
>>>> IDR and hoping it gives 0 is just a hacky work-around way of just
>>>> naming the device "bq27200-0".
>>>
>>> N900 userspace is not intended to be portable. (And actually
>>> current kernel support does not allow writing portable userspace
>>> for a phone. It presents _3_ power supplies to userspace. How is
>>> userspace expected to deal with that?)
>>>
>>> And if you ever name the single battery bq27200-42 or bq27200-1337,
>>> you'll have a flock of angry penguins at your doorstep.
>>
>> haha, wouldn't want that.
>>
>> That's what I'm trying to prevent here. Right now n900 userspace
>> looks for "bq27200-0" and *only* that, but the 0 does not
>> necessarily mean it is the first battery, it doesn't mean anything,
>> we could have it mean the first bq27x battery if we keep a count,
>> right now we though we depend on IDR behavior, which does not make
>> any order guarantee.
>>
>> Really we are abusing IDR, which is meant to return a unique ID that
>> we can use to fetch an associated pointer, but we don't do that, we
>> are just using it as a number generator, and that number needs to be
>> zero.
>>
>> Looking at the code you posted it looks like "n900-battery" was
>> renamed to "rx51-battery", I think this would be the correct fix
>> here for the bq27x batteries, there is only one of each so just
>> dropping the "-0" and looking for "bq27200" should fix all this.
>>
>> Or we could always call the battery "bq27200-0" and not use IDR to
>> generate the number zero for us :)
>>
>> Thanks,
>> Andrew
>=20
> I think that IDR is used here to allow more bq27xxx batteries to be=20
> registered into power_supply subsystem. You cannot have two batteries=
=20
> with same name, as all are exported by sysfs...
>=20

Then this is a problem with the framework as I see very few power-suppl=
y
driver doing this unique naming thing. I can add framework support if
the need ever arises.

> Basically, if you store name into driver, device tree or IDR... I do =
not=20
> care, what I want is to have working code and working battery chargin=
g.
>=20

I would like this as well, hopefully these fixes can make things more
robust and prevent future breakages.

Andrew
