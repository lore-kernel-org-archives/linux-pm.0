From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V6] powercap/drivers/idle_injection: Add an idle injection
 framework
Date: Tue, 12 Jun 2018 16:37:17 +0200
Message-ID: <cce05d92-d51a-ab4f-83f2-37dcdee0cd6a@linaro.org>
References: <1528804816-32636-1-git-send-email-daniel.lezcano@linaro.org>
 <20180612123036.GJ12180@hirez.programming.kicks-ass.net>
 <16d5649d-863c-10c7-9287-202568e713e6@linaro.org>
 <20180612125247.GO12217@hirez.programming.kicks-ass.net>
 <16770447-afe3-0fd7-19f9-1bd52c4c8ced@linaro.org>
 <20180612140654.GQ12217@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180612140654.GQ12217@hirez.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: viresh.kumar@linaro.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@kernel.org>, Leo Yan <leo.yan@linaro.org>, Kevin Wangtao <kevin.wangtao@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rui Zhang <rui.zhang@intel.com>, Daniel Thompson <daniel.thompson@linaro.org>, Andrea Parri <andrea.parri@amarulasolutions.com>
List-Id: linux-pm@vger.kernel.org

On 12/06/2018 16:06, Peter Zijlstra wrote:
> On Tue, Jun 12, 2018 at 03:02:14PM +0200, Daniel Lezcano wrote:
>> On 12/06/2018 14:52, Peter Zijlstra wrote:
>>> In this case, you can do:
>>
>> That is what we had before but we change the code to set the count
>> before waking up the task, so compute the cpumask_weight of the
>> resulting AND right before this loop.
>>
>>> +       for_each_cpu_and(cpu, &ii_dev->cpumask, cpu_online_mask) {
>>> +               iit = per_cpu_ptr(&idle_injection_thread, cpu);
>>> +               iit->should_run = 1;
>>> +               wake_up_process(iit->tsk);
>>> +       }
> 
> 
> Ah, I see, but since you do:
> 
> 	if (atomic_dec_and_test())
> 	  last_man()
> 
> where that last_man() thing will start a timer, there is no real problem
> with doing atomic_inc() with before wake_up_process().

Viresh was worried about the scenario:

https://lkml.org/lkml/2018/6/5/276


> Yes, it allows doing last_man, too often, but repeated hrtimer_start()
> will DTRT and reprogram the timer.
> 
> Also, last_man() uses @run_duration, but the way I read it, the timer is
> for waking things up again, this means it is in fact the sleep duration,
> no?

No, it is the next idle injection deadline, meanwhile we let the system
continue running.

The sleep duration is managed by another timer in play_idle().

> Furthermore, should you not be using hrtimer_forward(&timer,
> idle_duration + run_duration) instead? AFAICT the current scheme is
> prone to drifting.

(I assume you meant setting the timer in the wakeup task function).

Yes, drifting is not an issue if that happens. This scheme is simpler
and safer than setting the timer ahead before waking up the tasks with
the risk it expires before all the tasks ended their idle cycles.



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
