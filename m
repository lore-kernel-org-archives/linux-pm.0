From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V6] powercap/drivers/idle_injection: Add an idle injection
 framework
Date: Tue, 12 Jun 2018 15:02:14 +0200
Message-ID: <16770447-afe3-0fd7-19f9-1bd52c4c8ced@linaro.org>
References: <1528804816-32636-1-git-send-email-daniel.lezcano@linaro.org>
 <20180612123036.GJ12180@hirez.programming.kicks-ass.net>
 <16d5649d-863c-10c7-9287-202568e713e6@linaro.org>
 <20180612125247.GO12217@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180612125247.GO12217@hirez.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: viresh.kumar@linaro.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@kernel.org>, Leo Yan <leo.yan@linaro.org>, Kevin Wangtao <kevin.wangtao@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rui Zhang <rui.zhang@intel.com>, Daniel Thompson <daniel.thompson@linaro.org>, Andrea Parri <andrea.parri@amarulasolutions.com>
List-Id: linux-pm@vger.kernel.org

On 12/06/2018 14:52, Peter Zijlstra wrote:
> On Tue, Jun 12, 2018 at 02:44:29PM +0200, Daniel Lezcano wrote:
>> On 12/06/2018 14:30, Peter Zijlstra wrote:
>>> On Tue, Jun 12, 2018 at 02:00:11PM +0200, Daniel Lezcano wrote:
>>>> +static void __idle_injection_wakeup(struct idle_injection_device *ii_dev)
>>>> +{
>>>> +	struct idle_injection_thread *iit;
>>>> +	struct cpumask tmp;
>>>> +	unsigned int cpu;
>>>> +
>>>> +	cpumask_and(&tmp, ii_dev->cpumask, cpu_online_mask);
>>>
>>> You should not be having a cpumask on the stack. Those things can be
>>> ginormous.
>>
>> Ok, the kernel code uses of cpumask_t on the stack when dealing with
>> cpumask_and. I assume it is also not recommended.
> 
> Yes, that should all get fixed. It's mostly legacy code I suppose. It's
> been at least 10 years I think since we merged the whole
> CPUMASK_OFFSTACK stuff.
> 
>> What would be the best practice ? Allocate a per cpumask at init time as
>> a temporary mask to work with ?
> 
> In this case, you can do:

That is what we had before but we change the code to set the count
before waking up the task, so compute the cpumask_weight of the
resulting AND right before this loop.

> +       for_each_cpu_and(cpu, &ii_dev->cpumask, cpu_online_mask) {
> +               iit = per_cpu_ptr(&idle_injection_thread, cpu);
> +               iit->should_run = 1;
> +               wake_up_process(iit->tsk);
> +       }
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
