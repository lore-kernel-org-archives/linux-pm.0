From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v4 4/8] ARM: Exynos: use generic cpufreq driver for
 Exynos5420
Date: Fri, 11 Dec 2015 10:13:50 +0900
Message-ID: <566A234E.50603@samsung.com>
References: <1449512300-17230-1-git-send-email-b.zolnierkie@samsung.com>
 <1449512300-17230-5-git-send-email-b.zolnierkie@samsung.com>
 <5666886C.10203@samsung.com> <4086299.WTtvsacqTF@amdc1976>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:15567 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbbLKBOA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Dec 2015 20:14:00 -0500
In-reply-to: <4086299.WTtvsacqTF@amdc1976>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Ben Gamari <ben@smart-cactus.org>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 10.12.2015 23:18, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Tuesday, December 08, 2015 04:36:12 PM Krzysztof Kozlowski wrote:
>> On 08.12.2015 03:18, Bartlomiej Zolnierkiewicz wrote:
>>> From: Thomas Abraham <thomas.ab@samsung.com>
>>>
>>> The new CPU clock type allows the use of cpufreq-dt driver
>>> for Exynos5420.
>>>
>>> Changes by Bartlomiej:
>>> - split Exynos5420 support from the original patch
>>> - disable cpufreq if big.LITTLE switcher support is enabled
>>> - switch to using cpufreq-dt driver
>>>
>>> Cc: Tomasz Figa <tomasz.figa@gmail.com>
>>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>>> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>>> ---
>>>  arch/arm/mach-exynos/exynos.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>
>> I think this is actually now your patch, not Thomas any more. :)
> 
> It seems so, I'll update the patch.
> 
>>> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
>>> index 1c47aee..7a89c9d 100644
>>> --- a/arch/arm/mach-exynos/exynos.c
>>> +++ b/arch/arm/mach-exynos/exynos.c
>>> @@ -230,6 +230,9 @@ static const struct of_device_id exynos_cpufreq_matches[] = {
>>>  	{ .compatible = "samsung,exynos4212", .data = "cpufreq-dt" },
>>>  	{ .compatible = "samsung,exynos4412", .data = "cpufreq-dt" },
>>>  	{ .compatible = "samsung,exynos5250", .data = "cpufreq-dt" },
>>> +#ifndef CONFIG_BL_SWITCHER
>>> +	{ .compatible = "samsung,exynos5420", .data = "cpufreq-dt" },
>>> +#endif
>>
>> Why not on BL_SWITCHER? Shouldn't be enough to disable ARM_DT_BL_CPUFREQ?
> 
> ARM_DT_BL_CPUFREQ is not relevant here (it requires to be explicitly
> enabled by platform code, just like cpufreq-dt) and the dependency on
> !BL_SWITCHER is needed because when BL_SWITCHER is enabled big and
> LITTLE cores are grouped in pairs and presented as "virtual" CPUs to
> the system:
> 
> ...
> [    0.002630] CPU0: update cpu_capacity 448
> [    0.002646] CPU0: thread -1, cpu 0, socket 1, mpidr 80000100
> [    0.002835] Setting up static identity map for 0x40008280 - 0x400082d8
> [    0.003106] ARM CCI driver probed
> [    0.003351] Exynos MCPM support installed
> [    0.045350] CPU1: update cpu_capacity 448
> [    0.045358] CPU1: thread -1, cpu 1, socket 1, mpidr 80000101
> [    0.060326] CPU2: update cpu_capacity 448
> [    0.060334] CPU2: thread -1, cpu 2, socket 1, mpidr 80000102
> [    0.075326] CPU3: update cpu_capacity 448
> [    0.075334] CPU3: thread -1, cpu 3, socket 1, mpidr 80000103
> [    0.090337] CPU4: update cpu_capacity 1535
> [    0.090345] CPU4: thread -1, cpu 0, socket 0, mpidr 80000000
> [    0.105314] CPU5: update cpu_capacity 1535
> [    0.105321] CPU5: thread -1, cpu 1, socket 0, mpidr 80000001
> [    0.120338] CPU6: update cpu_capacity 1535
> [    0.120345] CPU6: thread -1, cpu 2, socket 0, mpidr 80000002
> [    0.135330] CPU7: update cpu_capacity 1535
> [    0.135338] CPU7: thread -1, cpu 3, socket 0, mpidr 80000003
> [    0.135466] Brought up 8 CPUs
> ...
> [    3.027498] big.LITTLE switcher initializing
> [    3.031761] CPU0 paired with CPU7
> [    3.035055] CPU1 paired with CPU6
> [    3.038332] CPU2 paired with CPU5
> [    3.041598] CPU3 paired with CPU4
> [    3.044930] GIC ID for CPU 0 cluster 1 is 4
> [    3.049078] GIC ID for CPU 1 cluster 1 is 5
> [    3.053258] GIC ID for CPU 2 cluster 1 is 6
> [    3.057370] GIC ID for CPU 3 cluster 1 is 7
> [    3.061558] GIC ID for CPU 0 cluster 0 is 0
> [    3.083336] IRQ53 no longer affine to CPU4
> [    3.084336] CPU4: shutdown
> [    3.107059] GIC ID for CPU 1 cluster 0 is 1
> [    3.123303] IRQ54 no longer affine to CPU5
> [    3.124213] CPU5: shutdown
> [    3.146387] GIC ID for CPU 2 cluster 0 is 2
> [    3.158143] cpu cpu0: 1100 MHz, 1250 mV --> 900 MHz, 1100 mV
> [    3.168228] IRQ55 no longer affine to CPU6
> [    3.169135] CPU6: shutdown
> [    3.191485] GIC ID for CPU 3 cluster 0 is 3
> [    3.208264] IRQ56 no longer affine to CPU7
> [    3.209166] CPU7: shutdown
> [    3.236752] big.LITTLE switcher initialized
> ...
> 
> Only arm_big_little_dt driver knows how to handle this setup
> correctly.  cpufreq-dt just treats "virtual" CPUs as a LITTLE
> ones.  Thus when "virtual CPU"'s current core is switched to
> a big one cpufreq-dt is unable to update its voltage.
> 
> [ I tried using BL_SWITCHER_DUMMY_IF functionality to simulate
>   this with:
> 
> 	echo 0,0 > /dev/b.L_switcher
> 
>   but it doesn't seem to work for some reason (from looking at
>   arch/arm/common/bL_switcher_dummy_if.c code it seems that at
>   least "bL_switcher_write" line should get logged but it does
>   not happen). ]

Thank you for explanation, seems good approach.

Best regards,
Krzysztof


