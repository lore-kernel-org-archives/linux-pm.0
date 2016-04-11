From: Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH 0/7] PM / devfreq: Add NoCP devfreq-event and support
 busfreq on exyno5422-odroidxu3
Date: Mon, 11 Apr 2016 09:31:38 +0530
Message-ID: <CANAwSgRuw9ieoyu5AYFSSAcK3wgjy1-So0TA_y8bVHBa_BF7ig@mail.gmail.com>
References: <1460091646-28701-1-git-send-email-cw00.choi@samsung.com>
 <CANAwSgQuWBRiRhjd-E-WaSdhe2njE262CEG8uVH83jJDGFJVKA@mail.gmail.com>
 <CAGTfZH2gd5zhr4_JioSXTcpf8Fgu6r_Y9gPOJo-mYGTjAJsFyg@mail.gmail.com> <570B08F2.50302@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <570B08F2.50302@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Markus Reichl <m.reichl@fivetechno.de>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, "inki.dae@samsung.com" <inki.dae@samsung.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.>
List-Id: linux-pm@vger.kernel.org

Hi Chanwoo,

On 11 April 2016 at 07:46, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> Hi Anand,
>
> On 2016=EB=85=84 04=EC=9B=94 09=EC=9D=BC 03:24, Chanwoo Choi wrote:
>> Hi Anand,
>>
>> On Sat, Apr 9, 2016 at 3:11 AM, Anand Moon <linux.amoon@gmail.com> w=
rote:
>>> Hi Chanwoo,
>>>
>
> [snip]
>
>>>>
>>>
>>> I am observing following deadlock. Both on Odroid U3 and Odroid XU4=
=2E
>>
>> Thanks for your test. I'll test it again and fix it.
>
> This possible recursive locking is fixed with following diff:
>
> Thanks for your report. I'll fix it on next patchset[1] (v9).
> [1] https://lkml.org/lkml/2016/4/8/14
>
>
> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/gov=
ernor_passive.c
> index 28a9ae32d330..a4b0b02ee797 100644
> --- a/drivers/devfreq/governor_passive.c
> +++ b/drivers/devfreq/governor_passive.c
> @@ -102,7 +102,7 @@ static int update_devfreq_passive(struct devfreq =
*devfreq, unsigned long freq)
>         if (!devfreq->governor)
>                 return -EINVAL;
>
> -       mutex_lock(&devfreq->lock);
> +       mutex_lock_nested(&devfreq->lock, SINGLE_DEPTH_NESTING);
>
>         ret =3D devfreq->governor->get_target_freq(devfreq, &freq);
>         if (ret < 0)
>
> Best Regards,
> Chanwoo Choi
>

Thanks you for these patches on devfreq.
These changes fix the warning.

Tested-by: Anand Moon <linux.amoon@gmail.com>

Tested on Odroid XU4 and Odroid U3.

Best Regards
-Anand Moon
