From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/3] arm64: defconfig: Enable CONFIG_ENERGY_MODEL
Date: Thu, 28 Mar 2019 20:51:12 +0100
Message-ID: <1f99acdf-3f9a-5419-b1b5-1bcb9b36dbb6@linaro.org>
References: <20190328101352.25657-1-quentin.perret@arm.com>
 <20190328101352.25657-2-quentin.perret@arm.com>
 <20190328102206.doqj5fykqlld7jkd@queper01-lin>
 <f5c699d6-f8f8-ab53-2835-329ae2bd8202@linaro.org>
 <20190328174233.jthsdzxrzmzpjnqd@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190328174233.jthsdzxrzmzpjnqd@queper01-lin>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: edubezval@gmail.com, javi.merino@kernel.org, viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, dietmar.eggemann@arm.com, ionela.voinescu@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

On 28/03/2019 18:42, Quentin Perret wrote:
> Hi Daniel,
> 
> On Thursday 28 Mar 2019 at 18:27:49 (+0100), Daniel Lezcano wrote:
>> On 28/03/2019 11:22, Quentin Perret wrote:
>>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>>>> index 2d9c39033c1a..3c09bdaaefd3 100644
>>>> --- a/arch/arm64/configs/defconfig
>>>> +++ b/arch/arm64/configs/defconfig
>>>> @@ -97,6 +97,7 @@ CONFIG_XEN=y
>>>>  CONFIG_COMPAT=y
>>>>  CONFIG_HIBERNATION=y
>>>>  CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
>>>> +CONFIG_ENERGY_MODEL=n
>>>
>>> Hmm, sorry I turned this to '=n' for testing and forgot to update the
>>> patch. This obviously should be '=y' ...
>>
>> I did a test without the ENERGY_MODEL config option set, dhrystone and
>> the power_allocator policy on the hikey. The board did not mitigate well
>> and ended up rebooting.
> 
> OK ... And is the same thing happening if you just run mainline w/o the
> dynamic-power-coefficient binding set for example ? The result _should_
> be the same. 

Right, it is the same.

> If not, then perhaps I missed something. I'll try to
> reproduce on my end. Just to be sure, when you say hikey, you mean
> hikey960 ? Or 620 ? In any case, thanks for testing :-)

hikey620

>> May be the cpu cooling Kconfig option should add
>> a SELECT or a DEPENDS on ENERGY_MODEL ?
> 
> Right, I've been wondering the same thing. I'm not a big fan of 'select'
> because enabling ENERGY_MODEL automatically for the thermal stuff will
> also happen to enable other things (EAS) without the user knowing. So
> I'd rather keep the ENERGY_MODEL option explicit.
> 
> But perhaps having THERMAL_GOV_POWER_ALLOCATOR 'depend on ENERGY_MODEL'
> could work. It's just that there is no _strong_ dependency, the IPA code
> isn't supposed to crash even if there is no EM ...

Given if the ENERGY_MODEL is not set there is a regression we should add
the dependency IMO.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
