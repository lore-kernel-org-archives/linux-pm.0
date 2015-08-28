From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: CPUIdle for Exynos5422 Odroid-XU3/XU4 boards.
Date: Fri, 28 Aug 2015 10:35:45 +0200
Message-ID: <55E01D61.8020706@osg.samsung.com>
References: <CANAwSgTWZ1a+j8RTiamsKaALKf+ekLVqtO6RFTLXkG=bJN4BPQ@mail.gmail.com>
 <4468206.R1amSm9GHX@amdc1976> <20150825160932.GD20070@red-moon>
 <1574385.AV2PKdoIbr@amdc1976>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:60687 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750989AbbH1Ifv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 28 Aug 2015 04:35:51 -0400
In-Reply-To: <1574385.AV2PKdoIbr@amdc1976>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Anand Moon <linux.amoon@gmail.com>, Daniel Lezcano <daniel.lezcano@free.fr>, Kukjin Kim <kgene@kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Przemyslaw Marczak <p.marczak@samsung.com>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hello Bartlomiej and Lorenzo,

Thanks a lot for your explanations.

On 08/27/2015 06:58 PM, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Tuesday, August 25, 2015 05:09:32 PM Lorenzo Pieralisi wrote:
>> On Tue, Aug 25, 2015 at 03:35:29PM +0100, Bartlomiej Zolnierkiewicz wrote:
>>>
>>> [ added Lorenzo and linux-pm to Cc: ]
>>>
>>> Hi,
>>>
>>> On Tuesday, August 25, 2015 11:43:38 AM Javier Martinez Canillas wrote:
>>>> [adding Kevin Hilman as cc who was also interested in CPUidle for Exynos]
>>>>
>>>> Hello Krzysztof,
>>>>
>>>> On 08/23/2015 03:26 AM, Krzysztof Kozlowski wrote:
>>>>
>>>> [snip]
>>>>
>>>>> 2015-08-21 16:21 GMT+09:00 Javier Martinez Canillas <javier@osg.samsung.com>:
>>>>>
>>>>> The big.LITTLE cpuidle driver is not a typical Exynos cpuidle driver.
>>>>> It only executes CPU suspend on a cluster which essentially is a power
>>>>> down operation.
>>>>>
>>>>
>>>> You are correct, looking at the the big.LITTLE CPUidle driver I see that
>>>> it only has two C-states: C0 (normal WFI) and C1 (single CPU power-down)
>>>> which as you said, places the CPU into power-down mode by using the MCPM
>>>> infrastructure so it's basically a CPU suspend AFAIU.
>>>>
>>>> So what you are saying is that there are deeper C-states supported by the
>>>> Exynos 542x SoC family but these are not handled by the b.L CPUidle driver.
>>>>  
>>>>> When we talk about cpuidle on Exynos, we have in mind one of sleep
>>>>> modes: AFTR or LPA (sometimes instead of LPA there is LPD or W-AFTR).
>>>>> Actually this is more like a system idle mode, not CPU idle. The power
>>>>> savings are much bigger than disabling only one cluster.
>>>>>
>>>>
>>>> Interesting, I was not aware of AFTR and LPA but I looked in the manual now.
>>>> Thanks a lot for the information.
>>>>
>>>> I see that the Exynos CPUidle driver (drivers/cpuidle/cpuidle-exynos.c) also
>>>> has only two C-states (WFI and C1) but C1 makes the system to enter in AFTR
>>>> (system-level power gating).
>>>>
>>>> This is similar to what the downstream ChromiumOS 3.8 kernel CPUidle driver
>>>> does IIUC [0].
>>>
>>> Yes but upstream does it in a clean way, has support for platforms
>>> requiring secure firmware operations and also implements coupled
>>> AFTR mode on a few platforms.
>>>
>>>>> So the question is still valid - whether someone wants or plans to
>>>>> implement cpuidle for Exynos 542x family. Odroid XU3 is not a priority
>>>>> here because energy consumption is not an issue there. This is not a
>>>>> mobile device.
>>>>>
>>>>
>>>> That's true but it will be interesting for the 5420 and 5800 based
>>>> Chromebooks since optimizing power consumption would be useful there.
>>>
>>> I would be happy to help with reviewing patches etc. but personally
>>> I don't have any plans for doing this work.  I may look into adding
>>> support for newer ARM64 SoCs (Exynos5433) if I find some extra time
>>> (quite unlikely currently).
>>>
>>>> I thought that big.LITTLE platforms were encouraged to use the generic b.L
>>>> CPUidle driver just like DT platforms should use the generic CPUFreq DT
>>>> driver but I guess I misunderstood.
>>>>
>>>> So the b.L CPUidle driver is only to have minimum CPUidle support but a SoC
>>>> specific driver is needed to fine tune and get most out of the platform?
>>>>
>>>> Or should the b.L CPUidle driver be extended to add per platform C-states?
>>>
>>> This is a good question. Daniel/Lorenzo?
>>
>> To move the b.L driver to multiple C-states we should first convert it to
>> the generic CPUidle driver (by defining an MCPM enable-method):
>>
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/cpuidle/cpuidle-arm.c?id=refs/tags/v4.2-rc8
>>
>> Then we have to figure out how to determine how many CPUidle drivers we
>> have to create (since idle states are different on different CPUs), since
>> using the MIDR does not really scale.
>>
>> For certain I won't support coupled C-states in the DT idle states code,
>> and every platform requiring them is considered buggy and not worth
>> merging in the mainline kernel from now onwards, HW should be fixed,
>> eventually, I am not willing to see code like
>> drivers/cpuidle/cpuidle-exynos.c in the mainline kernel anymore,
>> I am sorry.
> 
> For Exynos chipsets coupled C-states are not strictly required for
> having cpuidle support but make it more useful.  On Exynos chipsets
> secondary CPUs must be disabled to allow system to go into deeper
> idle modes and this is assured by using coupled C-states.  Original
> Android drivers don't use coupled C-states and depend on the rest
> of the system to offline secondary CPUs when not needed.
> 
> I would of course prefer not to have handle this in software and
> be automatically handled by hardware/firmware but that doesn't mean
> that we should be declining mainline support for "ugly" hardware
> (this has never been "the Linux way" of doing things).
>
> Coming back to the platforms in question (ARM32 big.LITTLE based
> Odroid XU3 boards etc.) they have been shipped long time ago and
> the best we can do nowadays is to support them as well as possible.
>

I agree.
 
> If somebody wants to implement a separate Exynos542x/Exynos5800
> big.LITTLE cpuidle driver for them I see no problem with it and I'm
> willing to help in maintaining it.
>

Ok, I'll see if I can take a look what is needed to implement a Exynos542x CPUidle
driver. I'm quite busy with other stuff right now but I should be less busy in a
couple of weeks.

Maybe is a little bit out of topic but since Anand also asked about CPUFreq support,
are you planning on re-posting your "cpufreq: add generic cpufreq driver support
for Exynos5250/5800 platforms" [0] series?
 
>> I think it is time to draw a line with CPUidle on ARM, take stock, clean
>> it up and find a way forward, current situation is a potpourri of solutions
>> that all differ in a slightly incompatible way.
>>
>> Support on ARM64 SoC must be PSCI based and for that there is already
>> support in the mainline kernel (through the PSCI back-end and the DT
>> idle states bindings).
> 
> I hope that on ARM64 PSCI will be used.  However I have no access to
> chipset designers / original firmware authors so I can't tell for
> sure.
> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 

[0]: https://lkml.org/lkml/2015/4/21/520

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
