From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 06/12] pinctrl: samsung: Add missing initconst annotation
Date: Tue, 17 Jan 2017 16:13:49 +0900
Message-ID: <CA+Ln22Eg5x6y1E_28-S2Ogw8id6_JyNMydAzY2jtv0tXdfQJ5g@mail.gmail.com>
References: <1484549107-5957-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170116064526eucas1p1e3064fad71a3ab8de34d306dec531b14@eucas1p1.samsung.com>
 <1484549107-5957-7-git-send-email-m.szyprowski@samsung.com>
 <20170116191400.ehm3ivkmz4csynvq@kozik-lap> <CA+Ln22EsV1mKzM5WZ4gwD+C2Yy22aMwy7YNgi7P=2Jy03XXaSg@mail.gmail.com>
 <CAJKOXPc0u061nany6SYWRN5W=iKWWSJpZ_W5g68AM9_+oR=B7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAJKOXPc0u061nany6SYWRN5W=iKWWSJpZ_W5g68AM9_+oR=B7Q@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

2017-01-17 15:34 GMT+09:00 Krzysztof Kozlowski <krzk@kernel.org>:
> On Tue, Jan 17, 2017 at 6:44 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>> 2017-01-17 4:14 GMT+09:00 Krzysztof Kozlowski <krzk@kernel.org>:
>>> On Mon, Jan 16, 2017 at 07:45:01AM +0100, Marek Szyprowski wrote:
>>>> Exynos5433 support has been added in parallel to adding initconst
>>>> annotation to most of the init data structures, so add those
>>>> annotations also to Exynos5433 structures.
>>>>
>>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>>> ---
>>>>  drivers/pinctrl/samsung/pinctrl-exynos.c | 22 +++++++++++-----------
>>>>  1 file changed, 11 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
>>>> index bf753a596209..70b94ad10cc1 100644
>>>> --- a/drivers/pinctrl/samsung/pinctrl-exynos.c
>>>> +++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
>>>> @@ -1266,7 +1266,7 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
>>>>  };
>>>>
>>>>  /* pin banks of exynos5433 pin-controller - ALIVE */
>>>> -static const struct samsung_pin_bank_data exynos5433_pin_banks0[] = {
>>>> +static const struct samsung_pin_bank_data exynos5433_pin_banks0[] __initconst = {
>>>>       EXYNOS5433_PIN_BANK_EINTW(8, 0x000, "gpa0", 0x00),
>>>>       EXYNOS5433_PIN_BANK_EINTW(8, 0x020, "gpa1", 0x04),
>>>>       EXYNOS5433_PIN_BANK_EINTW(8, 0x040, "gpa2", 0x08),
>>>> @@ -1279,28 +1279,28 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
>>>>  };
>>>
>>> Your change is aligned with existing code... but after I started to look
>>> into it I think this should not be initconst.
>>>
>>> The pin_banks (initconst) are referenced in pin_ctrl (initconst) which
>>> is referenced in samsung_pinctrl_dt_match (NOT initconst). The dt_match
>>> then is used in samsung_pinctrl_driver (for obvious reasons not
>>> initconst).
>>>
>>> We suppress the bind so this looks safe - this data should not be ever used
>>> after init - but it is not correct strictly speaking.
>>>
>>> Let's imagine some weird future platform which will use DT overlays with
>>> pinctrl. I think the overlays could affect the tree after the init
>>> stage.
>>
>> I think it's not very realistic to have a Samsung on-SoC pin
>> controller in an overlay. AFAIR we already assume in several places
>> that this driver fully initializes in init stage, so we can save some
>> memory by discarding this data
>
> Two things here. Either we write proper code or we write code for
> "believe it will work". There is a problem with second approach -
> after some time, the driver will be developed further it your
> assumptions might change... then stuff might get broken because no one
> expected that driver data is discarded. Code working only with some
> assumptions is a more difficult to maintain than code which is
> correct.

We write code that is proper for the assumptions we made during the
design, i.e. design decisions. Otherwise you would end up with the
driver bloated everywhere with handing things that don't make any
sense, which would be definitely _not_ easier to maintain. Of course
we can have some trivial code to enforce the assumptions, as I
mentioned before.

This is a driver for an on-chip low level device that is very, very
unlikely to be hotpluggable and almost any other driver for remaining
on-chip devices depend on it. It doesn't mean that we can't change the
design decision later, if in future it becomes feasible to load
low-level SoC drivers from modules then we can make the driver support
so.

>
> In the same time if you believe your code is "correct" then just mark
> samsung_pinctrl_dt_match initconst... Marking only few parts in the
> chain is broken.

I haven't said that samsung_pinctrl_dt_match should be kept
non-initconst. It's indeed a good idea to make it initconst as well.

>
> Second thing. How much memory you are saving? 5 kB in total? 10 kB? Is
> it worth the risk?

10 kB in one driver. Multiply by the number of similar low level
drivers for all SoCs supported by ARM v7 multiplatform build and you
can get quite a significant number of memory saved...

>
>> Still, I guess we could add some measure to make sure nothing attempts
>> to probe this driver after the data is discarded.
>
> That could work... but last time I asked for checking the return value
> of match_data then you (I think) and Bartlomiej responded "no sense".
> So please be consistent.

That's because this is already enforced by the design of the driver model...

> Anyway it is not possible to NULL-ify the
> match_data after first probe because samsung_pinctrl_dt_match is
> const. This means you would have to add some crazy logic to check for
> late (from overlays) or second probe and discard it... just because we
> wanted to save some memory and marked initconst something referenced
> from non-initconst section.

...and similarly the assumptions we are talking about in case of this
problem could be enforced the same way. There is already
platform_driver_probe() that is supposed to be used for such on-SoC
non-hotpluggable devices and which triggers a one-time probe.
Unfortunately it is a bit broken currently, because it can't handle
deferred probes.

Anyway, I'm not even insisting that we should keep this initconst
annotation. Just wanted to point out that there are valid reasons for
it to be useful and correct (in terms of the design decisions taken
when writing the driver).

Best regards,
Tomasz
