From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCHv2 0/8] devfreq: exynos4: Support dt and use common ppmu
 driver
Date: Mon, 17 Mar 2014 10:58:09 +0900
Message-ID: <532656B1.2010907@samsung.com>
References: <1394698649-20996-1-git-send-email-cw00.choi@samsung.com>
 <5323432E.5060005@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <5323432E.5060005@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tomasz Figa <t.figa@samsung.com>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rafael.j.wysocki@intel.com, nm@ti.com, b.zolnierkie@samsaung.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Tomasz,

On 03/15/2014 02:58 AM, Tomasz Figa wrote:
> Hi Chanwoo,
> 
> On 13.03.2014 09:17, Chanwoo Choi wrote:
>> This patchset support devicetree and use common ppmu driver instead of
>> individual code of exynos4_bus.c to remove duplicate code. Also this patchset
>> get the resources for busfreq from dt data by using DT helper function.
>> - PPMU register address
>> - PPMU clock
>> - Regulator for INT/MIF block
>>
>> This patchset use SET_SYSTEM_SLEEP_PM_OPS macro intead of legacy method.
>> To remove power-leakage in suspend state, before entering suspend state,
>> disable ppmu clocks.
>>
>> Changes from v1:
>> - Add exynos4_bus.txt documentation for devicetree guide
>> - Fix probe failure if CONFIG_PM_OPP is disabled
>> - Fix typo and resource leak(regulator/clock/memory) when happening probe failure
>> - Add additionally comment for PPMU usage instead of previous PPC
>> - Split separate patch to remove ambiguous of patch
>>
>> Chanwoo Choi (8):
>>    devfreq: exynos4: Support devicetree to get device id of Exynos4 SoC
>>    devfreq: exynos4: Use common ppmu driver and get ppmu address from dt data
>>    devfreq: exynos4: Add ppmu's clock control and code clean about regulator control
>>    devfreq: exynos4: Fix bug of resource leak and code clean on probe()
>>    devfreq: exynos4: Use SET_SYSTEM_SLEEP_PM_OPS macro
>>    devfreq: exynos4: Fix power-leakage of clock on suspend state
>>    devfreq: exynos4: Add CONFIG_PM_OPP dependency to fix probe fail
>>    devfreq: exynos4: Add busfreq driver for exynos4210/exynos4x12
>>
>>   .../devicetree/bindings/devfreq/exynos4_bus.txt    |  49 +++
>>   drivers/devfreq/Kconfig                            |   1 +
>>   drivers/devfreq/exynos/Makefile                    |   2 +-
>>   drivers/devfreq/exynos/exynos4_bus.c               | 415 ++++++++++++++-------
>>   4 files changed, 341 insertions(+), 126 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/devfreq/exynos4_bus.txt
>>
> 
> I have reviewed this series and there are several comments that I'd like to ask you to address. Please see my replies to particular patches.

OK, I'll fix it about your comment.

> 
> However, this driver, even after applying your series, is still far from a state that would allow it to be enabled. The most important issue is direct access to CMU registers, based on static mapping, which is not allowed on multiplatform kernels and multiplatform-awareness for drivers is currently a must.
> 
> To allow this driver to be enabled, it needs to be converted to use common clock framework functions to configure all clocks, e.g. clk_set_rate(), clk_set_parent(), etc., without accessing CMU registers directly.
> 
> Of course as long as the driver is effectively unusable, to keep development, we can proceed with refactoring it step-by-step and your series would be basically the first step, after addressing the review comments.
> 

I agree your opinion. When setting frequency of memory bus, this driver access
directly to CMU registers. I know it should be modified by using common clk
framework as your comment.

I'll send patch set about using common clk framework instead of CMU register
based on static mapping after finished the review and apply of this patch set as next step.

Thanks for your review.

Best Regards,
Chanwoo Choi
