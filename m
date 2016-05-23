From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: Should 9aafabc7fece be reverted?
Date: Mon, 23 May 2016 10:55:49 -0500
Message-ID: <57432805.6000108@ti.com>
References: <573C9F45.5090109@ti.com> <201605191806.50809@pali>
 <573DE5A2.7070900@ti.com> <201605191818.20237@pali> <573DEDFF.8060305@ti.com>
 <20160520092927.GB4580@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([198.47.19.11]:33853 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752021AbcEWP4Y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 23 May 2016 11:56:24 -0400
In-Reply-To: <20160520092927.GB4580@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org

On 05/20/2016 04:29 AM, Pavel Machek wrote:
> Hi!
> 
>>>>>>> No, it is not driver name, but device name. That is different.
>>>>>>
>>>>>> My bad, that's what I meant, device names should be dynamic,
>>>>>> right? Relying on them being static in software would then be
>>>>>> buggy (like relying on eth0 being the right NIC everytime)?
>>>>>>
>>>>>> I'm not familiar with the N900 software, but IDR can give out
>>>>>> different numbers and may not always give the first battery #0 (it
>>>>>> does now but is that a guarantee in IDR?) and if not then what is
>>>>>> the userspace response to this changing?
>>>>>
>>>>> In case N900 would have more bq27xxx batteries, then yes. But N900
>>>>> has exactly *one* bq27200 battery, so there is no IDR problem.
>>>>
>>>> Right, but if IDR returns 42 instead of 0 would this then break its
>>>> userspace software?
>>>
>>> I think it is insane to starts generating random numbers for IDR... Hard 
>>> to decide what happen if such situation occur...
>>>
>>
>> That's kind of what I'm looking for though, if the userspace break is
>> caused by software relying on the battery to be named "bq27200-0", then
>> nothing short of hard-coding this exact name will 100% safely fix the
>> N900 userspace software. And so using IDR and hoping it gives 0 is just
>> a hacky work-around way of just naming the device "bq27200-0".
> 
> N900 userspace is not intended to be portable. (And actually current
> kernel support does not allow writing portable userspace for a
> phone. It presents _3_ power supplies to userspace. How is userspace
> expected to deal with that?) 
> 
> And if you ever name the single battery bq27200-42 or bq27200-1337,
> you'll have a flock of angry penguins at your doorstep.
> 

haha, wouldn't want that.

That's what I'm trying to prevent here. Right now n900 userspace looks
for "bq27200-0" and *only* that, but the 0 does not necessarily mean it
is the first battery, it doesn't mean anything, we could have it mean
the first bq27x battery if we keep a count, right now we though we
depend on IDR behavior, which does not make any order guarantee.

Really we are abusing IDR, which is meant to return a unique ID that we
can use to fetch an associated pointer, but we don't do that, we are
just using it as a number generator, and that number needs to be zero.

Looking at the code you posted it looks like "n900-battery" was renamed
to "rx51-battery", I think this would be the correct fix here for the
bq27x batteries, there is only one of each so just dropping the "-0" and
looking for "bq27200" should fix all this.

Or we could always call the battery "bq27200-0" and not use IDR to
generate the number zero for us :)

Thanks,
Andrew

> Best regards,
> 									Pavel
> 
