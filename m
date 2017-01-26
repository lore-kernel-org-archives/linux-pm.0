From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 11/13] pinctrl: samsung: Move retention control from
 mach-exynos to the pinctrl driver
Date: Thu, 26 Jan 2017 16:30:19 +0200
Message-ID: <CAJKOXPfrUKtfP0B5mDY7SYM6Of4gGe0F4C95hvYZotTNn4a32Q@mail.gmail.com>
References: <CGME20170119134909eucas1p11a7638a4b9bf69b00458189ba9c1bb90@eucas1p1.samsung.com>
 <1484833733-16082-1-git-send-email-m.szyprowski@samsung.com>
 <1484833733-16082-12-git-send-email-m.szyprowski@samsung.com>
 <CACRpkdYc7u6Q4CW7a2ECsDkfUkiDJq_zk--RvKwz2i-XW0xHLQ@mail.gmail.com>
 <2d9ad2d4-c2f8-ef6b-2504-1337db0da178@samsung.com> <CACRpkdapMKpsGVbbvJvXBtYGJCANYUOqMox=083+Lf6LkApmTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdapMKpsGVbbvJvXBtYGJCANYUOqMox=083+Lf6LkApmTw@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, "arm@kernel.org" <arm@kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 26, 2017 at 11:46 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Thu, Jan 26, 2017 at 10:13 AM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> On 2017-01-26 10:10, Linus Walleij wrote:
>>> On Thu, Jan 19, 2017 at 2:48 PM, Marek Szyprowski
>>> <m.szyprowski@samsung.com> wrote:
>>>>
>>>> This patch moves pad retention control from PMU driver to Exynos pin
>>>> controller driver. This helps to avoid possible ordering and logical
>>>> dependencies between machine, PMU and pin control code. Till now it
>>>> worked fine only because sys_ops for PMU and pin controller were called
>>>> in registration order.
>>>> This is also a preparation for adding new features to Exynos pin
>>>> controller driver, like runtime power management and suspending
>>>> individual pin controllers, which might be a part of some power domain.
>>>>
>>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>>> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
>>>> Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
>>>> ---
>>>>   arch/arm/mach-exynos/suspend.c           |  64 --------------
>>>>   drivers/pinctrl/samsung/pinctrl-exynos.c | 145
>>>> +++++++++++++++++++++++++++++++
>>>
>>> This makes all kind of sense, but I would ideally like an ACK
>>> from the ARM SoC maintainer(s): Arnd, Olof, are you OK with
>>> this?
>>
>>
>> Isn't enough to have Krzysztof's (Exynos SoC maintainer) 'reviewed-by' tag?
>> I assume that 'reviewed-by' also includes 'acked-by'.
>
> If the SoC maintainers are too stressed to answer in reasonable time
> or I just get randomly bored of waiting yes, I usually apply it anyway.
>
> Just want to give them a heads-up essentially.

My Reviewed-by is also acked-by, so please go ahead and take this
patch through pinctrl tree.

Best regards,
Krzysztof
