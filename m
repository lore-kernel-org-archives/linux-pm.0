From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/5] clk: add support for runtime pm
Date: Tue, 13 Sep 2016 09:24:44 +0200
Message-ID: <CAPDyKFrSYkke8LsQ68oxdarxg1mMeiEEwqYKVTqDLAEApEEHYA@mail.gmail.com>
References: <1472737551-15272-1-git-send-email-m.szyprowski@samsung.com>
 <1472737551-15272-2-git-send-email-m.szyprowski@samsung.com> <20160908001943.GC13062@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20160908001943.GC13062@codeaurora.org>
Sender: linux-clk-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linux-clk <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Michael Turquette <mturquette@baylibre.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 8 September 2016 at 02:19, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 09/01, Marek Szyprowski wrote:
>> Registers for some clocks might be located in the SOC area, which are under the
>> power domain. To enable access to those registers respective domain has to be
>> turned on. Additionally, registers for such clocks will usually loose its
>> contents when power domain is turned off, so additional saving and restoring of
>> them might be needed in the clock controller driver.
>>
>> This patch adds basic infrastructure in the clocks core to allow implementing
>> driver for such clocks under power domains. Clock provider can supply a
>> struct device pointer, which is the used by clock core for tracking and managing
>> clock's controller runtime pm state. Each clk_prepare() operation
>> will first call pm_runtime_get_sync() on the supplied device, while
>> clk_unprepare() will do pm_runtime_put() at the end.
>>
>> Additional calls to pm_runtime_get/put functions are required to ensure that any
>> register access (like calculating/chaning clock rates) will be done with clock
>> controller in active runtime state.
>>
>> Special handling of the case when runtime pm is disabled for clock controller's
>> device is needed to let this feature work properly also during system sleep
>> suspend/resume operations (runtime pm is first disabled before entering sleep
>> state's, but controller is usually still operational until its suspend pm
>> callback is called).
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>
> My "knee jerk" concern is that we're going to take a runtime PM
> lock underneath the prepare lock. That seems like a situation
> where we could hit a lock inversion if the runtime PM callbacks
> themselves acquire the prepare lock by calling clk APIs? But this
> concern is false right? We release the runtime PM lock before
> calling the PM callback, so we shouldn't hit any deadlock and
> lockdep won't complain?

You assumption is correct!

Before the runtime PM core invokes a runtime PM callback it will
unlock the -">dev->power.lock" spinlock. When the callback returns it
will re-lock the spinlock.

Kind regards
Uffe
