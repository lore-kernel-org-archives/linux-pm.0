From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V2 6/7] thermal/drivers/cpu_cooling: Introduce the cpu
 idle cooling driver
Date: Wed, 4 Apr 2018 10:50:02 +0200
Message-ID: <78504a65-d21a-eea0-d8af-6e12d5747b87@linaro.org>
References: <1519226968-19821-1-git-send-email-daniel.lezcano@linaro.org>
 <1519226968-19821-7-git-send-email-daniel.lezcano@linaro.org>
 <20180223073432.GF26947@vireshk-i7>
 <faaf027c-e01c-6801-9a0c-ab7e0ba669a1@linaro.org>
 <20180226043021.GK26947@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180226043021.GK26947@vireshk-i7>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org, vincent.guittot@linaro.org, amit.kachhap@gmail.com, linux-kernel@vger.kernel.org, javi.merino@kernel.org, rui.zhang@intel.com, daniel.thompson@linaro.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 26/02/2018 05:30, Viresh Kumar wrote:

[ ... ]

>>>> +
>>>> +	for_each_possible_cpu(cpu) {
>>>> +		cpumask = topology_core_cpumask(cpu);
>>>> +
>>>> +		cct = per_cpu_ptr(&cpuidle_cooling_tsk, cpu);
>>>> +
>>>> +		/*
>>>> +		 * This condition makes the first cpu belonging to the
>>>> +		 * cluster to create a cooling device and allocates
>>>> +		 * the structure. Others CPUs belonging to the same
>>>> +		 * cluster will just increment the refcount on the
>>>> +		 * cooling device structure and initialize it.
>>>> +		 */
>>>> +		if (cpu == cpumask_first(cpumask)) {
>>>
>>> Your function still have few assumptions of cpu numbering and it will
>>> break in few cases. What if the CPUs on a big Little system (4x4) are
>>> present in this order: B L L L L B B B  ??
>>>
>>> This configuration can happen if CPUs in DT are marked as: 0-3 LITTLE,
>>> 4-7 big and a big CPU is used by the boot loader to bring up Linux.
>>
>> Ok, how can I sort it out ?
> 
> I would do something like this:
> 
>         cpumask_copy(possible, cpu_possible_mask);
>         
>         while (!cpumask_empty(possible)) {
>                 first = cpumask_first(possible);
>                 cpumask = topology_core_cpumask(first);
>                 cpumask_andnot(possible, possible, cpumask);
>         
>                 allocate_cooling_dev(first); //This is most of this function in your patch.
>         
>                 while (!cpumask_empty(cpumask)) {
>                         temp = cpumask_first(possible);
>                         //rest init "temp"
>                         cpumask_clear_cpu(temp, cpumask);
>                 }
>         
>                 //Everything done, register cooling device for cpumask.
>         }


Mmh, that sounds very complex. May be it is simpler to count the number
of cluster and initialize the idle_cdev for each cluster and then go for
this loop with the cluster cpumask.




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
