From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 3/3] thermal: cpu_cooling: Migrate to using the EM
 framework
Date: Fri, 29 Mar 2019 18:17:58 +0100
Message-ID: <eeaf6156-c591-cc21-d097-b6c5cdb62a5a@linaro.org>
References: <20190328101352.25657-1-quentin.perret@arm.com>
 <20190328101352.25657-4-quentin.perret@arm.com>
 <30926b3d-0074-8c84-a081-d3dbc9258525@linaro.org>
 <20190329091636.gbmh5hzw46ucangr@queper01-ThinkPad-T460s>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190329091636.gbmh5hzw46ucangr@queper01-ThinkPad-T460s>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org, viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, dietmar.eggemann@arm.com, ionela.voinescu@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 29/03/2019 10:16, Quentin Perret wrote:
> Hi Daniel,
> 
> On Thursday 28 Mar 2019 at 21:23:35 (+0100), Daniel Lezcano wrote:
>>>  /**
>>>   * struct time_in_idle - Idle time stats
>>>   * @time: previous reading of the absolute time that this cpu was idle
>>> @@ -82,7 +70,7 @@ struct time_in_idle {
>>>   *	frequency.
>>>   * @max_level: maximum cooling level. One less than total number of valid
>>>   *	cpufreq frequencies.
>>> - * @freq_table: Freq table in descending order of frequencies
>>> + * @em: Reference on the Energy Model of the device
>>>   * @cdev: thermal_cooling_device pointer to keep track of the
>>>   *	registered cooling device.
>>>   * @policy: cpufreq policy.
>>> @@ -98,7 +86,7 @@ struct cpufreq_cooling_device {
>>>  	unsigned int cpufreq_state;
>>>  	unsigned int clipped_freq;
>>>  	unsigned int max_level;
>>> -	struct freq_table *freq_table;	/* In descending order */
>>> +	struct em_perf_domain *em;
>>
>> Why do you need to add this field? it will be accessible via policy->em, no?
> 
> You mean via the CPUFreq policy ? Then no, the EM isn't attached to the
> CPUFreq policy. And we can't attach it directly to the CPUFreq policy
> since in *theory* it is not required to map 1:1 to CPUFreq policies
> (even though that _is_ true for all existing platforms). That's one of
> the things this patch checks in that em_is_sane() function below.
> 
> FWIW, the idea of the design is, the EM framework is 'independent' and
> it's up to the client subsystems (scheduler, IPA) to check if it actually
> works for them. In the case of the scheduler, for example, we can't use
> an EM that's too complex because that would cause too much overhead, so
> we don't start EAS if that's not the case. See:
> 
>   https://elixir.bootlin.com/linux/latest/source/kernel/sched/topology.c#L367
> 
> In the case of IPA, we need to do something similar. We can't use an EM
> that doesn't map 1:1 to CPUFreq policies, so we bail out if that's not
> true, etc, ... This isn't supposed to trigger any time soon, but it's
> good to have a check just to be on the safe side I think.

Ok, makes sense. Thanks for the clarification.



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
