From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 4/8] thermal/drivers/Kconfig: Convert the CPU cooling
 device to a choice
Date: Thu, 25 Jan 2018 14:36:12 +0100
Message-ID: <b6181a0e-1e64-f343-1f68-ec22e69eac94@linaro.org>
References: <1516721671-16360-1-git-send-email-daniel.lezcano@linaro.org>
 <1516721671-16360-5-git-send-email-daniel.lezcano@linaro.org>
 <20180124163441.7sqq7qny66d6sqrz@oak.lan>
 <02e80d2c-3672-f7e2-dfb2-aed3efc84759@linaro.org>
 <20180125105715.sae3nwvz7u32v4va@oak.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180125105715.sae3nwvz7u32v4va@oak.lan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org, vincent.guittot@linaro.org, amit.kachhap@gmail.com, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 25/01/2018 11:57, Daniel Thompson wrote:
> On Wed, Jan 24, 2018 at 05:59:09PM +0100, Daniel Lezcano wrote:
>> On 24/01/2018 17:34, Daniel Thompson wrote:
>>> On Tue, Jan 23, 2018 at 04:34:27PM +0100, Daniel Lezcano wrote:
>>>> The next changes will add new way to cool down a CPU. In order to
>>>> sanitize and make the overall cpu cooling code consistent and robust
>>>> we must prevent the cpu cooling devices to co-exists with the same
>>>> purpose at the same time in the kernel.
>>>>
>>>> Make the CPU cooling device a choice in the Kconfig, so only one CPU
>>>> cooling strategy can be chosen.
>>>
>>> I puzzled by the role of Kconfig here.
>>>
>>> IIUC a distro kernel will always be forced to select the combo strategy 
>>> otherwise it will never be able to cool systems that don't have cpufreq
>>> (I hope the combo strategy treats such system as a special case with
>>> only one OPP).
>>
>> Actually it does not make sense to select the combo if there is no
>> cpufreq support. The cpuidle cooling device must be used instead.
> 
> Well, I said before what I hoped. This is what I feared! ;-)
> 
> 
>>> This raises the question what the other options (cpufreq-only
>>> idle-injection-only) are for? Are they just for petrol heads who want to
>>> save a few bytes of code or is idle-injection undesirable for some
>>> users.
>>
>> The combo cooling device must be used on a system with a proper support
>> for cpuidle and cpufreq and with the power numbers specified in the DT.
>>
>> By proper support of cpuidle, I mean a cluster power down idle state,
>> fast enough. This idle state allows to drop the dynamic power *and* the
>> static leakage (the latter to prevent a thermal runaway).
>>
>> If the system does not have power numbers, no (or bad) cpuidle, the
>> combo cooling device must not be used. If there is no cpufreq support,
>> the cpuidle cooling must be used and if there is no proper support for
>> both, the CPU cooling can't be used. In this case, you have to put a fan
>> on your board or reduce the frequency where the system stays in its
>> thermal envelope.
> 
> How can we know (in the general case) what is going to be in the DT at
> compile time?
> 
> 
>>> If the later, how can a distro kernel mitigate the undesired effects
>>> whilst still selecting the combo strategy.
>>
>> I'm not sure to understand the question. Distros always use the make
>> allmodconfig, so that chooses the cpufreq CPU cooling device which was
>> the case before without this change.
> 
> So there's no regression. That's nice but doesn't that mean distros
> cannot exploit the new features.
> 
> 
>> However, we are talking about distros here but the CPU cooling mechanism
>> is for mobile and in this case the kernel (usually Android based) comes
>> with a specific configuration file and this is where the SoC vendor has
>> to choose the right strategy.
> 
> I agree its hard to conceive of a modern Android device that doesn't implement
> both the needed features but the performance figures in the covering 
> letter come from Hikey (and they look pretty good) and Hikey is 
> supported by a good number of regular Linux distros now.
> 
> Using Kconfig to force what should be runtime decisions to happen at 
> compile time means that Hikey becomes an example of a platform that
> is unable to run at max performance on the distros that have added 
> support for it.

I disagree. The ARM64's defconfig is not distro ready. We have always to
change the default option and fix things in the Kconfig to make the
hikey to work (eg. the missing hi655x clock config), without speaking
about the hikey960 which is not yet ready for full support.

Hence, tweaking the Kconfig to choose the better strategy is not
necessarily a problem for this first iteration of code.

Note I'm not against changing the code to make it runtime selectable but
that will need a major rework of the current CPU cooling code especially
handling the change while the thermal framework is doing the mitigation
(and probably also changes of the thermal framework).

I prefer to keep simple self-encapsulated feature code and make it
evolve to something better instead of sending a blowing patch series
taking into account all possible combinations. Choosing the strategy at
compile time may be look restrictive but we can live with that without
problem and iteratively do the change until the choice becomes the
default strategy selection option.






 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
