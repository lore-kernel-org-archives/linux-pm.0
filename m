From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: Should 9aafabc7fece be reverted?
Date: Thu, 19 May 2016 11:11:14 -0500
Message-ID: <573DE5A2.7070900@ti.com>
References: <573C9F45.5090109@ti.com> <201605191751.28412@pali>
 <573DE26E.2040403@ti.com> <201605191806.50809@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39300 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752727AbcESQLu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 19 May 2016 12:11:50 -0400
In-Reply-To: <201605191806.50809@pali>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>

On 05/19/2016 11:06 AM, Pali Roh=C3=A1r wrote:
> On Thursday 19 May 2016 17:57:34 Andrew F. Davis wrote:
>> On 05/19/2016 10:51 AM, Pali Roh=C3=A1r wrote:
>>> On Thursday 19 May 2016 17:48:29 Andrew F. Davis wrote:
>>>> On 05/19/2016 10:44 AM, Pali Roh=C3=A1r wrote:
>>>>> On Thursday 19 May 2016 17:38:14 Andrew F. Davis wrote:
>>>>>> P.S. The code is still a bit strange, I'll probably go grab one
>>>>>> of the N900s from our test farm and make sure my future
>>>>>> cleanups don't break this, but are we sure the *name* of a
>>>>>> driver is an ABI?
>>>>>
>>>>> It is not name of driver, but directory name of sysfs path where
>>>>> device is exported...
>>>>
>>>> Which is named after the drivers name, so the same question
>>>> remains.
>>>>
>>>> :/
>>>
>>> No, it is not driver name, but device name. That is different.
>>
>> My bad, that's what I meant, device names should be dynamic, right?
>> Relying on them being static in software would then be buggy (like
>> relying on eth0 being the right NIC everytime)?
>>
>> I'm not familiar with the N900 software, but IDR can give out
>> different numbers and may not always give the first battery #0 (it
>> does now but is that a guarantee in IDR?) and if not then what is
>> the userspace response to this changing?
>=20
> In case N900 would have more bq27xxx batteries, then yes. But N900 ha=
s=20
> exactly *one* bq27200 battery, so there is no IDR problem.
>=20

Right, but if IDR returns 42 instead of 0 would this then break its
userspace software?

How is this handled for other power-supply drivers when more that one
battery exists, they look to give static device names so I'm assuming
the framework handles giving them new folder names automatically.
