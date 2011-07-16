From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCHv3] ARM: EXYNOS4: Support for generic I/O
 power domains on EXYNOS4210
Date: Sat, 16 Jul 2011 12:58:25 +0900
Message-ID: <4E210C61.6060006__2008.71719648621$1310788734$gmane$org@samsung.com>
References: <4E165C64.8090808@samsung.com>
	<000e01cc3d2f$eca5d530$c5f17f90$%kim@samsung.com>
	<4E16A171.7040509@samsung.com>
	<035201cc4367$2b165c80$81431580$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <035201cc4367$2b165c80$81431580$%kim@samsung.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: 'Sylwester Nawrocki' <snjw23@gmail.com>, 'linux-samsung-soc' <linux-samsung-soc@vger.kernel.org>, 'linux-kernel' <linux-kernel@vger.kernel.org>, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'MyungJoo Ham' <myungjoo.ham@samsung.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Kukjin Kim wrote:
> Chanwoo Choi wrote:
>> Kukjin Kim wrote:
> 
> (snip)
> 
>>>> @@ -183,6 +183,7 @@ config MACH_NURI
>>>>  	select EXYNOS4_SETUP_SDHCI
>>>>  	select EXYNOS4_SETUP_USB_PHY
>>>>  	select SAMSUNG_DEV_PWM
>>>> +	select PM_GENERIC_DOMAINS if PM
>>> Do you _really_ think this should be under MACH_NURI?
>>>
>> This patch apply the generic power-domain to NURI board.
> 
> I mean, the PM_GENERIC_DOMAINS feature depends on CPU not board even though this is for only NURI board.
> 
OK, I will move it from CONFIG_MACH_NURI to CONFIG_CPU_EXYNOS4210 in arch/arm/mach-exynos4/Kconfig.

> (snip)
> 
>>>> diff --git a/arch/arm/mach-exynos4/include/mach/pm-exynos4210.h
>>>> b/arch/arm/mach-exynos4/include/mach/pm-exynos4210.h
>>>> new file mode 100644
>>>> index 0000000..ab09034
>>>> --- /dev/null
>>>> +++ b/arch/arm/mach-exynos4/include/mach/pm-exynos4210.h
>>>> @@ -0,0 +1,53 @@
>>>> +/* linux/arch/arm/mach-exynos4/include/mach/pm-exynos4.h
>>> According to your file name, should be linux/arch/arm/mach-
>> exynos4/include/mach/pm-exynos4210.h ?
>>
> I said just typo...
> 
> +/* linux/arch/arm/mach-exynos4/include/mach/pm-exynos4210.h
> 
>> This patch support only power-domain of EXYNOS4210, so I named "pm-
>> exynos4210.h"
>> If EXYNOS4 series board will be released, I will modify include file name
>> from "pm-exynos4210.h" to "pm-exynos4.h" to support all EXYNOS4 series.
> 
> No need it, it's different.

My mistake. I will fix it.
> 
> (snip)
> 
>>> Would be better if you could add some common function for pd_power_up and
>> _down...
>>
>> What do you mean about common function?
>>
> I thought, pd_power_up and _down can be implemented in one function.
> 

OK, If you want to combine two function(pd_power_up and pd_power_down),
I will modify it.

> (snip)
> 
>>> I wonder why we need to add this for handling power domain not update current
>> pd.
>>
> See arch/arm/mach-exynos4/dev-pd.c
> 
> I mean, we _really_ need to keep duplication files for handling power domain?...

Now, you're right. 
But, If Generic Power-domain Framework will be applied to the mainline,
I think it necessary that we should apply Generic Power-domain Framework to all of 
the board using EXYNOS4210(arch/arm/mach-exynos4) and delete old power-domain
(arch/arm/mach-exynos4/dev-pd.c) to remove duplication file.

Thanks & Regards,
Chanwoo Choi
