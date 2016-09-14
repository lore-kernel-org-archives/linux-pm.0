From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 1/5] clk: add support for runtime pm
Date: Wed, 14 Sep 2016 12:11:28 +0200
Message-ID: <9c072889-d167-16b4-cc76-fbae2149e6e6@samsung.com>
References: <1472737551-15272-1-git-send-email-m.szyprowski@samsung.com>
 <1472737551-15272-2-git-send-email-m.szyprowski@samsung.com>
 <CGME20160913084956eucas1p2433fb17456cea4620de2729efbbf78c7@eucas1p2.samsung.com>
 <CAPDyKFo7R1f1H1R5Q78L4e_nHfngRYfo8jP_Dfi3uf_OGWvZCg@mail.gmail.com>
 <76bb5b71-dd4e-e1ad-df0b-b84833812502@samsung.com>
 <CAPDyKFqufBW0TmPVBx-noSnCvk26WBk9jP4PjgS5wKVuq6cJmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-reply-to: <CAPDyKFqufBW0TmPVBx-noSnCvk26WBk9jP4PjgS5wKVuq6cJmA@mail.gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-clk <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Ulf,


On 2016-09-13 17:03, Ulf Hansson wrote:
> [...]
>
>>> This needs to be clarified. I agree we need to cover system PM as
>>> well, but let's try be a bit more precise about it.
>>
>> Right, I wasn't precise here. I've developed this code on older (v4.1 and
>> v4.6)
>> kernels, which had a code which disables runtime pm during system sleep
>> transition
>> time. Maybe I need to revisit it and consider your change merged to
>> v4.8-rc1, which
>> keeps runtime pm enabled during system sleep transitions.
> Right, I see.
>
>>>>    static bool clk_core_is_prepared(struct clk_core *core)
>>>>    {
>>>> +       if (clk_pm_runtime_suspended(core))
>>>> +               return false;
>>>> +
>>> This isn't safe, as even if the clock controller is runtime resumed at
>>> this point, that's *not* a guarantee that is stays runtime resumed
>>> while invoking the ->ops->is_prepared().
>>>
>>> Instead you must call a pm_runtime_get_noresume() before you check the
>>> runtime PM status, as that should avoid the device from being runtime
>>> suspended. Then when the ->ops->is_prepared() has been invoked, we
>>> should call pm_runtime_put().
>>>
>>> Although, I am not sure the above change becomes entirely correct as I
>>> think we are mixing the runtime PM status with the clock prepare
>>> status here. In other words, the next time the clock controller
>>> becomes runtime resumed, it may very well restore some register
>>> context which may prepare the clock, unless someone explicitly has
>>> unprepared it.
>>>
>>> Of course, it all depends on how clk_core_is_prepared() is used by the
>>> clock framework.
>>
>> clk_core_is_prepared() is mainly used by disable_unused_tree_*. You are
>> right that it mixes a bit clock prepared state with runtime pm active
>> state of clock controller's, but I assumed here that clock cannot be
>> prepared if runtime pm state of controller is suspended. Other approach
>> here would be to call pm_runtime_get(), check status and then
>> pm_runtime_put(). If you prefer such approach, I will change it.
> Using pm_runtime_get|put() would work for the clk_core_is_prepared()
> case, although perhaps not for the clk_core_is_enabled() case.
>
> The reason is that I guess the clk_core_is_enabled() API may be called
> from atomic context? Thus we would need to enable
> pm_runtime_irq_safe() for the clock provider device, which I *really*
> would like to avoid.

I've checked clk_core_is_enabled() is only used for implementing disabling
of unused clock trees or implementing ->is_enabled() callback, which is used
for the same purpose, so it should be safe to use standard 
pm_runtime_get/put
there.

There should be no other usecases for ->is_enabled() method, as it itself is
not really race prone, as other caller might enable/disable given clock in
meantime.

I will remove clk_pm_runtime_suspended() usage then.

> [...]
>
>>> I believe we are also accessing the clock controller HW from the
>>> late_initcall_sync(clk_disable_unused) function.
>>
>> This was indirectly handled by the runtime pm state check in is_prepared
>> and is_enabled().
> I see.
>
> Although, I was thinking that you explicitly would like to
> disable/unprepare unused clocks in this phase, so then it isn't
> sufficient to rely on the runtime PM status to know whether the clock
> is prepared/enabled.
>
> Perhaps, this is the only case when you actually need a
> pm_runtime_get|put() around the ->is_enabled|prepared()!?

Right.

[...]

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

