From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v4 2/3] PM / EM: Expose perf domain struct
Date: Wed, 15 May 2019 12:16:34 +0200
Message-ID: <cf1474cb-7e31-7070-b988-a0c4d3f6f081@linaro.org>
References: <20190515082318.7993-1-quentin.perret@arm.com>
 <20190515082318.7993-3-quentin.perret@arm.com>
 <0ced18eb-e424-fe6b-b11e-165a3c108170@linaro.org>
 <20190515091658.sbpg6qiovhtblqyr@queper01-lin>
 <698400c0-e0a4-4a86-b9df-cdb9bd683c0f@linaro.org>
 <20190515100748.q3t4kt72h2akdpcs@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190515100748.q3t4kt72h2akdpcs@queper01-lin>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org, viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, dietmar.eggemann@arm.com, ionela.voinescu@arm.com, mka@chromium.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 15/05/2019 12:07, Quentin Perret wrote:
> On Wednesday 15 May 2019 at 11:56:30 (+0200), Daniel Lezcano wrote:
>> On 15/05/2019 11:17, Quentin Perret wrote:
>>> Hi Daniel,
>>>
>>> On Wednesday 15 May 2019 at 11:06:18 (+0200), Daniel Lezcano wrote:
>>>> On 15/05/2019 10:23, Quentin Perret wrote:
>>>>> In the current state, the perf_domain struct is fully defined only when
>>>>> CONFIG_ENERGY_MODEL=y. Since we need to write code that compiles both
>>>>> with or without that option in the thermal framework, make sure to
>>>>> actually define the struct regardless of the config option. That allows
>>>>> to avoid using stubbed accessor functions all the time in code paths
>>>>> that use the EM.
>>>>>
>>>>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>>>> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
>>>>
>>>> This patch implies the cpu cooling device can be set without the energy
>>>> model.
>>>>
>>>> Isn't it possible to make a strong dependency for the cpu cooling device
>>>> on the energy model option, add the energy model as default on arm arch
>>>> and drop this patch?
>>>
>>> Right, that should work too.
>>>
>>>> After all, the cpu cooling is using the em framework.
>>>
>>> The reason I did it that way is simply to keep things flexible. If you
>>> don't compile in THERMAL_GOV_POWER_ALLOCATOR, you will never use the EM
>>> for CPU thermal. So I thought it would be good to not mandate compiling
>>> in ENERGY_MODEL in this case -- that should save a bit of space.
>>>
>>> But TBH I don't have a strong opinion on this one, so if everybody
>>> agrees it's fine to just make CPU_THERMAL depend on ENERGY_MODEL, I'm
>>> happy to drop this patch and fix patch 3/3. That would indeed simplify
>>> things a bit.
>>
>> Ok in this case it will be better to drop the 2/3 and add a small series
>> doing for the cpu_cooling.c
>>
>> #ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
>>
>> /* structure freq */
>>
>> /* power2state */
>>
>> /* state2power*/
>>
>> /* getrequestedpower */
>>
>> /* All functions needed for the above */
>>
>> #endif
>>
>> static struct thermal_cooling_device_ops cpufreq_cooling_ops = {
>>         .get_max_state          = cpufreq_get_max_state,
>>         .get_cur_state          = cpufreq_get_cur_state,
>>         .set_cur_state          = cpufreq_set_cur_state,
>> #ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
>>         .get_requested_power    = cpufreq_get_requested_power,
>>         .state2power            = cpufreq_state2power,
>>         .power2state            = cpufreq_power2state,
>> #endif
>> };
>>
>> So you don't have to care about ENERGY_MODEL to be set as
>> THERMAL_GOV_POWER_ALLOCATOR depends on it.
>>
>> I think the result for cpu_cooling.c will be even more cleaner with the
>> em change.
> 
> OK, that works for me. I'll give it a go in v5.

Viresh what do you think ?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
