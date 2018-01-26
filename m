From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 4/8] thermal/drivers/Kconfig: Convert the CPU cooling
 device to a choice
Date: Fri, 26 Jan 2018 14:25:58 +0100
Message-ID: <301b5fe7-472e-6291-2880-4202de657de8@linaro.org>
References: <1516721671-16360-1-git-send-email-daniel.lezcano@linaro.org>
 <1516721671-16360-5-git-send-email-daniel.lezcano@linaro.org>
 <20180124163441.7sqq7qny66d6sqrz@oak.lan>
 <02e80d2c-3672-f7e2-dfb2-aed3efc84759@linaro.org>
 <20180125105715.sae3nwvz7u32v4va@oak.lan>
 <b6181a0e-1e64-f343-1f68-ec22e69eac94@linaro.org>
 <20180126121609.qfahclcdamii7a27@oak.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:56204 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752455AbeAZN0C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jan 2018 08:26:02 -0500
Received: by mail-wm0-f67.google.com with SMTP id 143so1254982wma.5
        for <linux-pm@vger.kernel.org>; Fri, 26 Jan 2018 05:26:02 -0800 (PST)
In-Reply-To: <20180126121609.qfahclcdamii7a27@oak.lan>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org, vincent.guittot@linaro.org, amit.kachhap@gmail.com, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>

On 26/01/2018 13:16, Daniel Thompson wrote:
> On Thu, Jan 25, 2018 at 02:36:12PM +0100, Daniel Lezcano wrote:
>> On 25/01/2018 11:57, Daniel Thompson wrote:
>>> On Wed, Jan 24, 2018 at 05:59:09PM +0100, Daniel Lezcano wrote:
>>>> On 24/01/2018 17:34, Daniel Thompson wrote:
>>>> However, we are talking about distros here but the CPU cooling mechanism
>>>> is for mobile and in this case the kernel (usually Android based) comes
>>>> with a specific configuration file and this is where the SoC vendor has
>>>> to choose the right strategy.
>>>
>>> I agree its hard to conceive of a modern Android device that doesn't implement
>>> both the needed features but the performance figures in the covering 
>>> letter come from Hikey (and they look pretty good) and Hikey is 
>>> supported by a good number of regular Linux distros now.
>>>
>>> Using Kconfig to force what should be runtime decisions to happen at 
>>> compile time means that Hikey becomes an example of a platform that
>>> is unable to run at max performance on the distros that have added 
>>> support for it.
>>
>> I disagree. The ARM64's defconfig is not distro ready. We have always to
>> change the default option and fix things in the Kconfig to make the
>> hikey to work (eg. the missing hi655x clock config), without speaking
>> about the hikey960 which is not yet ready for full support.
>>
>> Hence, tweaking the Kconfig to choose the better strategy is not
>> necessarily a problem for this first iteration of code.
> 
> The problem is not about tweaking config for a distro. No distro I know 
> defconfig kernels. Tweaking is normal and expected.
> 
> The problem is that a distro cannot generate a config that performs
> optimally on all devices that it supports because enabling one form of
> CPU cooling prevents other forms from being selected. There is no
> correct value for us to select if we don't know in advance what board
> the kernel image will be loaded on.
> 
> Given the massive work that has gone on (especially in ARM ecosystem) 
> to allow one kernel binary to support many boards at once it surprises 
> me to see new features proposed that cannot be exploited without
> recompiling the kernel from platform to platform.
> 
> 
>> Note I'm not against changing the code to make it runtime selectable but
>> that will need a major rework of the current CPU cooling code especially
>> handling the change while the thermal framework is doing the mitigation
>> (and probably also changes of the thermal framework).
> 
> Perhaps I should have distinguished more between runtime-meaning-boot-time
> and runtime-meaning-full-system-operation. To be clear none of my
> comments are about being able to enable/disable idle injection on a
> fully running system. It is the impact on multi-platform binaries that
> attracted my attention.
> 
> 
>> I prefer to keep simple self-encapsulated feature code and make it
>> evolve to something better instead of sending a blowing patch series
>> taking into account all possible combinations. Choosing the strategy at
>> compile time may be look restrictive but we can live with that without
>> problem and iteratively do the change until the choice becomes the
>> default strategy selection option.
> 
> You won't find me arguing against iterative improvement. However I
> did observe that the idle injection code consists almost exclusively 
> of new lines of code. Thus I don't understand why this new code 
> interferes with cpufreq cooling to the point that the existing cooling
> options must compiled out of the kernel before we can exploit it.
> 
> I can see the combo code does have tentacles in more places but even so
> I have the same question. What prevents the existing cooling strategy
> from being compiled at the same time.
> 
> You appear to be saying that there's not yet enough infrastructure to
> decide which type of cooler to instantiate[1] so its OK to hack around
> the decision by forcing it to be made it at compile time. Even if we
> want to force a decision by some means, is compile time really the best
> point to do that?

For the moment, yes. We are backward compatible, there is no change with
the current feature.

I don't see really the point of being so afraid with this compilation
option, it is not the first time we have compile time code which
migrates to runtime code. The important thing is we don't break the
existing.

Having the runtime selection is the objective after improving the CPU
cooling devices. But this is far from being trivial and will need a
rework of the cooling device / framework (and the changes grouped in a
separate patch series).


> [1] Is that because the DT isn't rich enough for us to figure out 
>     the trade off between using real OPPs and virtual idle-injected
>     ones nor whether cpuidle entry/exit is fast enough for cooling
>     to be effective?

Yes, it is one aspect.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
