From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH] PM / devfreq: Use freq_table for available_frequencies
Date: Tue, 15 Apr 2014 11:41:28 -0700
Message-ID: <534D7D58.4050201@codeaurora.org>
References: <1368716.232331397543409452.JavaMail.weblogic@epv6ml06>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1368716.232331397543409452.JavaMail.weblogic@epv6ml06>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: =?EUC-KR?B?udqw5rnO?= <kyungmin.park@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 04/14/2014 11:30 PM, =C7=D4=B8=ED=C1=D6 wrote:
>> On 04/14/2014 06:36 PM, =C7=D4=B8=ED=C1=D6 wrote:
>>>> MyungJoo/Kyungmin,
>>>>
>>>> Bump. Can we accept this patch please?
>>>>
>>>> -Saravana
>>>
>>> Nack.
>>>
>>> Please note that freq_table is also an optional value, which may
>>> be null.
>>
>> Ah, I saw that the max_freq would be zero if freq_table was NULL and=
 I
>> assumed that it can't be NULL. But I see that the max_freq limit is =
not
>> applied if it's zero. Thanks for catching it.
>>
>>> Besides, please be aware that your code is under rcu_read_lock().
>>
>> Valid point. I was just trying to keep the diff simple. No one's rea=
lly
>> going to be catting this file often when performance matters.
>>
>>>
>>>
>>> Cheers,
>>> MyungJoo.
>>>
>>> ps. I'll send a related patch (avoid accessing null but not-an-erro=
r
>>> pointer at other sysfs nodes). Thank you for letting me catch such =
bugs anyway.
>>
>> I can go ahead and do this myself if you don't mind.
>=20
> No, we don't need it. It was a false alarm.
> Reading again, I've found that we've already made other sysfs nodes
> check if either freq_table is null or its size is 0.
>=20
> So, we only need to look at this available_frequencies node now.
>=20
> I'll add some notes on the ABI doc for available_frequencies soon.
>=20

Ah, I misunderstood your previous email. I thought you Nack-ed my patch
and decided to send your own patch to replace mine. Ok, I'll fix up min=
e
and send it out.

-Saravana


--=20
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora For=
um,
hosted by The Linux Foundation
