From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 0/7] PM / devfreq: Add NoCP devfreq-event and support
 busfreq on exyno5422-odroidxu3
Date: Mon, 11 Apr 2016 13:03:59 +0900
Message-ID: <570B222F.4030503@samsung.com>
References: <1460091646-28701-1-git-send-email-cw00.choi@samsung.com>
 <CANAwSgQuWBRiRhjd-E-WaSdhe2njE262CEG8uVH83jJDGFJVKA@mail.gmail.com>
 <CAGTfZH2gd5zhr4_JioSXTcpf8Fgu6r_Y9gPOJo-mYGTjAJsFyg@mail.gmail.com>
 <570B08F2.50302@samsung.com>
 <CANAwSgRuw9ieoyu5AYFSSAcK3wgjy1-So0TA_y8bVHBa_BF7ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CANAwSgRuw9ieoyu5AYFSSAcK3wgjy1-So0TA_y8bVHBa_BF7ig@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anand Moon <linux.amoon@gmail.com>
Cc: "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, =?UTF-8?B?S3J6eXN6dG9mIEtvesWCb3dza2k=?= <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Markus Reichl <m.reichl@fivetechno.de>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, "inki.dae@samsung.com" <inki.dae@samsung.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@li>
List-Id: linux-pm@vger.kernel.org

Hi Anand,

On 2016=EB=85=84 04=EC=9B=94 11=EC=9D=BC 13:01, Anand Moon wrote:
> Hi Chanwoo,
>=20
> On 11 April 2016 at 07:46, Chanwoo Choi <cw00.choi@samsung.com> wrote=
:
>> Hi Anand,
>>
>> On 2016=EB=85=84 04=EC=9B=94 09=EC=9D=BC 03:24, Chanwoo Choi wrote:
>>> Hi Anand,
>>>
>>> On Sat, Apr 9, 2016 at 3:11 AM, Anand Moon <linux.amoon@gmail.com> =
wrote:
>>>> Hi Chanwoo,
>>>>
>>
>> [snip]
>>
>>>>>
>>>>
>>>> I am observing following deadlock. Both on Odroid U3 and Odroid XU=
4.
>>>
>>> Thanks for your test. I'll test it again and fix it.
>>
>> This possible recursive locking is fixed with following diff:
>>
>> Thanks for your report. I'll fix it on next patchset[1] (v9).
>> [1] https://lkml.org/lkml/2016/4/8/14
>>
>>
>> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/go=
vernor_passive.c
>> index 28a9ae32d330..a4b0b02ee797 100644
>> --- a/drivers/devfreq/governor_passive.c
>> +++ b/drivers/devfreq/governor_passive.c
>> @@ -102,7 +102,7 @@ static int update_devfreq_passive(struct devfreq=
 *devfreq, unsigned long freq)
>>         if (!devfreq->governor)
>>                 return -EINVAL;
>>
>> -       mutex_lock(&devfreq->lock);
>> +       mutex_lock_nested(&devfreq->lock, SINGLE_DEPTH_NESTING);
>>
>>         ret =3D devfreq->governor->get_target_freq(devfreq, &freq);
>>         if (ret < 0)
>>
>> Best Regards,
>> Chanwoo Choi
>>
>=20
> Thanks you for these patches on devfreq.
> These changes fix the warning.
>=20
> Tested-by: Anand Moon <linux.amoon@gmail.com>
>=20
> Tested on Odroid XU4 and Odroid U3.

Thanks for your test and report.

Best Regards,
Chanwoo Choi
