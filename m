From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCHv2 0/8] devfreq: exynos4: Support dt and use common ppmu
 driver
Date: Mon, 17 Mar 2014 10:56:28 +0900
Message-ID: <5326564C.5050407@samsung.com>
References: <1394698649-20996-1-git-send-email-cw00.choi@samsung.com>
 <2117336.08cyWySR1X@amdc1032> <532273FB.6040303@samsung.com>
 <2149456.oUDFM14jk3@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-reply-to: <2149456.oUDFM14jk3@amdc1032>
Sender: linux-doc-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rafael.j.wysocki@intel.com, nm@ti.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,
On 03/14/2014 07:47 PM, Bartlomiej Zolnierkiewicz wrote:
> On Friday, March 14, 2014 12:14:03 PM Chanwoo Choi wrote:
>> Hi,
>>
>> On 03/14/2014 01:43 AM, Bartlomiej Zolnierkiewicz wrote:
>>>
>>> Hi,
>>>
>>> On Thursday, March 13, 2014 05:17:21 PM Chanwoo Choi wrote:
>>>> This patchset support devicetree and use common ppmu driver instead of
>>>> individual code of exynos4_bus.c to remove duplicate code. Also this patchset
>>>> get the resources for busfreq from dt data by using DT helper function.
>>>> - PPMU register address
>>>> - PPMU clock
>>>> - Regulator for INT/MIF block
>>>>
>>>> This patchset use SET_SYSTEM_SLEEP_PM_OPS macro intead of legacy method.
>>>> To remove power-leakage in suspend state, before entering suspend state,
>>>> disable ppmu clocks.
>>>>
>>>> Changes from v1:
>>>> - Add exynos4_bus.txt documentation for devicetree guide
>>>> - Fix probe failure if CONFIG_PM_OPP is disabled
>>>> - Fix typo and resource leak(regulator/clock/memory) when happening probe failure
>>>> - Add additionally comment for PPMU usage instead of previous PPC
>>>> - Split separate patch to remove ambiguous of patch
>>>>
>>>> Chanwoo Choi (8):
>>>>   devfreq: exynos4: Support devicetree to get device id of Exynos4 SoC
>>>>   devfreq: exynos4: Use common ppmu driver and get ppmu address from dt data
>>>>   devfreq: exynos4: Add ppmu's clock control and code clean about regulator control
>>>>   devfreq: exynos4: Fix bug of resource leak and code clean on probe()
>>>>   devfreq: exynos4: Use SET_SYSTEM_SLEEP_PM_OPS macro
>>>>   devfreq: exynos4: Fix power-leakage of clock on suspend state
>>>>   devfreq: exynos4: Add CONFIG_PM_OPP dependency to fix probe fail
>>>>   devfreq: exynos4: Add busfreq driver for exynos4210/exynos4x12
>>>>
>>>>  .../devicetree/bindings/devfreq/exynos4_bus.txt    |  49 +++
>>>>  drivers/devfreq/Kconfig                            |   1 +
>>>>  drivers/devfreq/exynos/Makefile                    |   2 +-
>>>>  drivers/devfreq/exynos/exynos4_bus.c               | 415 ++++++++++++++-------
>>>>  4 files changed, 341 insertions(+), 126 deletions(-)
>>>>  create mode 100644 Documentation/devicetree/bindings/devfreq/exynos4_bus.txt
>>>
>>> Thanks for updating this patchset.  There are still some minor issues
>>> left though:
>>>
>>> - patch #4 should be at beginning of the patch series
>>>
>>> - moving of devfreq_unregister_opp_notifier(dev, data->devfreq) from
>>>   exynos4_bus_exit() to exynos4_busfreq_remove() should be in patch #4
>>>   (which should really be at the beggining of patch series) not #3
>>>
>>> - handling of iounmap(data->ppmu[i].hw_base) should be added to
>>>   exynos4_bus_exit() in patch #2 not #3
>>>
>>> - patch #8 summary and description should mention fact that it adds DT
>>>   binding documentation (not the driver itself) and the patch itself
>>>   can be slighlty polished
>>
>> OK, I'll re-order the sequence of patchset and modify minior issues about your comment.
>> Also, I'll modify the patch description for patch8.
>>
>>>
>>> One important note about this patchset not mentioned in the cover
>>> letter is that it is improving currently unused driver (because of
>>> DT-only mach-exynos conversion the only user was removed in June 2013
>>> and from the reading the code I suspect that even that user hadn't
>>> worked previously).  As such this patch series should not cause any
>>> regressions.
>>
>> I don't understand correct your meaning.I explained DT support on upper
>> patchset description by using DT helper function and I added PPMU descritpion.
>> Also, Each patch include detailed description of patch content.
> 
> Everything is okay, I just noted that since there are no users of this
> driver currently (the only user was NURI and it was removed by DT
> conversion of mach-exynos) it should be okay to merge the patch series
> quickly once reviewed and acked by the respective maintainers.
> 
>> What is more needed?
> 
> Users of the driver? ;)
> 
> Your patchset adds DT support and fixes to the driver but it doesn't
> add actual users of the driver to arch/arm/boot/dts/ files.

Ah, I didn't understand 'users'  meanings.

Now, clk-exynos4.c driver in mainline don't provide the clocks for PPMU IP. So, I can't add dt node of exynos4_busfreq to exynos4210.dtsi/exynos4x12.dtsi/exynos4210-trats.dts/exynos4412-trats2.dts.

First of all, I will add the ppmu clocks to clk-exynos4.c driver and then modify dts file for exynos4_busfreq as your comment. That which add the ppmu clocks is apart from this patch set.

Thanks for your comment.

Best Regards,
Chanwoo Choi

