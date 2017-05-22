From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v6 1/4] clk: Add support for runtime PM
Date: Mon, 22 May 2017 14:34:30 +0200
Message-ID: <4049980f-1837-93cc-49e0-e9dee2760cf1@samsung.com>
References: <1490182543-28550-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170322113554eucas1p27471f0de278c55d5dce7fdf120395e09@eucas1p2.samsung.com>
 <1490182543-28550-2-git-send-email-m.szyprowski@samsung.com>
 <149081897388.31513.7062843004022908296@resonance>
 <75509e0f-26cd-52e7-8c71-b004ab6abc81@samsung.com>
 <149089387341.31513.7531874072502656432@resonance>
 <5b4b2f3e-dc4b-0866-c4b8-4c7e4dba2be0@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-reply-to: <5b4b2f3e-dc4b-0866-c4b8-4c7e4dba2be0@samsung.com>
Sender: linux-clk-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Stephen Boyd <sboyd@codeaurora.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi All,

On 2017-04-06 14:46, Marek Szyprowski wrote:
> Hi Michael,
>
> On 2017-03-30 19:11, Michael Turquette wrote:
>> Quoting Marek Szyprowski (2017-03-30 00:24:15)
>>> On 2017-03-29 22:22, Michael Turquette wrote:
>>>> Quoting Marek Szyprowski (2017-03-22 04:35:40)
>>>>> Registers for some clocks might be located in the SOC area, which 
>>>>> are under the
>>>>> power domain. To enable access to those registers respective 
>>>>> domain has to be
>>>>> turned on. Additionally, registers for such clocks will usually 
>>>>> loose its
>>>>> contents when power domain is turned off, so additional saving and 
>>>>> restoring of
>>>>> them might be needed in the clock controller driver.
>>>>>
>>>>> This patch adds basic infrastructure in the clocks core to allow 
>>>>> implementing
>>>>> driver for such clocks under power domains. Clock provider can 
>>>>> supply a
>>>>> struct device pointer, which is the used by clock core for 
>>>>> tracking and managing
>>>>> clock's controller runtime pm state. Each clk_prepare() operation
>>>>> will first call pm_runtime_get_sync() on the supplied device, while
>>>>> clk_unprepare() will do pm_runtime_put_sync() at the end.
>>>>>
>>>>> Additional calls to pm_runtime_get/put functions are required to 
>>>>> ensure that any
>>>>> register access (like calculating/changing clock rates and 
>>>>> unpreparing/disabling
>>>>> unused clocks on boot) will be done with clock controller in 
>>>>> runtime resumend
>>>>> state.
>>>> The above is a bit confusing. Is clk_prepare really special? It 
>>>> seems to
>>>> me that every single clk_ops callback will need this?
>>> clk_prepare/unprepare are special, because they allow sleeping, so they
>>> are natural
>>> candidates for the place for calling runtime PM operations.
>>> clk_enable()/disable()
>>> is called under a spinlock, so runtime pm cannot be called efficiently
>>> there, but
>>> core guarantees that they are called after clk_prepare(), so accessing
>>> hw registers
>>> is safe. The only remaining calls are not guaranteed to be called 
>>> always
>>> after
>>> clk_prepare(), so those additional calls and checks in runtime pm are
>>> needed there.
>> Right, so any call that holds prepare_lock and might touch the hardware
>> needs to first call pm_runtime_get_sync.
>>
>>>> That leads to my second question: why put this in the clk core? Can 
>>>> the
>>>> clk provider driver simply add pm_runtime_{get,put} calls into its
>>>> clk_ops callbacks instead? The clk core does not directly touch 
>>>> hardware
>>>> (e.g. reading registers) so putting the pm runtime calls into the
>>>> provider callbacks should be sufficient.
>>> In theory is should be possible to duplicate all kind of clock build 
>>> blocks
>>> (gates, muxes, dividers, ...) with additional runtime pm calls. This
>>> would however
>>> end in much more code and a bit more complicated locking. Implementing
>>> it in clk
>>> core made the code simpler. It also turned out that runtime pm
>>> integration is
>>> needed for more that a single clock provider: besides Samsung SoCs
>>> (Exynos 5433
>>> and newer, Exynos 4412 ISP, Exynos Audio Subsystem, hacks in Exynos 
>>> 542x
>>> can be
>>> also replaced by runtime PM calls), Ulf mentioned that exactly similar
>>> pattern
>>> is used for some UX500 SoCs (STE). More will probably come once the
>>> feature is
>>> in, because for now such drivers simply forces runtime active state 
>>> as a
>>> workaround or don't instantiate related power domains at all.
>> I agree with the above, but I'm also wondering about the folks that use
>> regmap internally to their own clock provider drivers. I guess they will
>> have the option to either do their own thing or use this framework-level
>> solution.
>>
>> I've started reviewing the code itself and will respond to those mails
>> separately.
>
> Is there a chance to get your comments soon? I would really like to give
> this patchset a try in linux-next for a few days, but for now Sylwester
> waits for you.
>
> Stephen: what is your opinion on this patchset? Would you like to give it
> a try in -next?
>

Mike, Stephen: any comments? We already missed v4.12 merge window...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

