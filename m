From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH 00/11] thermal: add new flag irq-mode for trip point
Date: Wed, 17 Oct 2018 10:24:00 +0200
Message-ID: <20181017082402eucas1p1088cde8bb32592e96decd0075ecc055a~eV8jZImjv1752717527eucas1p1K@eucas1p1.samsung.com>
References: <CGME20181016145637eucas1p2dfa78042b9fd4fd27af7cc8537b7f485@eucas1p2.samsung.com>
        <20181016145637eucas1p2dfa78042b9fd4fd27af7cc8537b7f485~eHqCoEO-42133821338eucas1p2F@eucas1p2.samsung.com>
        <CAJKOXPei6b7TnOnG7DUMNm+xEUsMxqcMOfbG10cJbrNROXLN2w@mail.gmail.com>
        <20181017074244eucas1p2487ff3bccf50d6f4fd7a99cd7d8d2bb4~eVYe84jXW0904509045eucas1p2q@eucas1p2.samsung.com>
        <CAJKOXPd4=hvowfkEJbfX_BXf_PEjxuKxn7dxy7cb=G59a8+GOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJKOXPd4=hvowfkEJbfX_BXf_PEjxuKxn7dxy7cb=G59a8+GOw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, corbet@lwn.net, =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org



On 10/17/2018 09:52 AM, Krzysztof Kozlowski wrote:
> On Wed, 17 Oct 2018 at 09:42, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>> Hi Krzysztof,
>>
>> On 10/17/2018 09:03 AM, Krzysztof Kozłowski wrote:
>>> On Tue, 16 Oct 2018 at 16:56, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>>>
>>>> Hi all,
>>>>
>>>> This patch set adds new flag and mechanism in thermal trip point in DT.
>>>> The current situation with 'passive' (passive cooling - DVFS)
>>>> trip point is that it enables polling mode in thermal framework.
>>>
>>> For DT platform, I checked it some months ago... and that time I was
>>> pretty sure - passive mode does not enable polling (unless you tell it
>>> explicitly with "polling-delay-passive"). Maybe something changed...
>>> but quick look at the code tell me that not. Passive does not indicate
>>> polling mode.
>>>
>>> Why do you think that passive enables polling?
>> Please check dt file which implements 2 more trip points that HW
>> supports:
>> arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
>>
>> In that file we have this trick with 'active' present.
>> Yes, you are right, 'polling-delay-passive' enables it in
>> the thermal code (for whole thermal zone).
>> Unfortunately, if you change the bellow 'active' to 'passive'
>> in that file, they will start polling, which is not what we want.
> 
> Yes but this looks different than what you explained at the beginning.
> You said that passive enables polling mode... which is not true. You
> can have active with or without polling. You can have passive with or
> without polling. But the real problem you described now is that given
> polling/IRQ mode applies to entire thermal zone, not to a specific
> trip point.
> 
> I agree with this problem but you need to clearly mark it in cover
> letter and description of other commits because really from existing
> explanation I understood something completely different. You simply
> want to configure IRQ or polling per trip-point, not per thermal zone.
Thank you for your feedback, I will rewrite the cover letter and
descriptions.
I will add that the thermal zone polling settings are for all it's trip
points, which has some implications. Therefore, trying to work around,
might cause confusion due to misalignment with trip point documentation
and old assumptions.

Regards,
Lukasz

> 
> Best regards,
> Krzysztof
> 
