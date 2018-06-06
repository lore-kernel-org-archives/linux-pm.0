From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V5] powercap/drivers/idle_injection: Add an idle injection
 framework
Date: Wed, 6 Jun 2018 15:42:08 +0200
Message-ID: <22f5cf0b-049e-7938-55f6-4b4b154f8389@linaro.org>
References: <1528190208-22915-1-git-send-email-daniel.lezcano@linaro.org>
 <20180606122357.GN12258@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180606122357.GN12258@hirez.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@kernel.org>, Leo Yan <leo.yan@linaro.org>, Kevin Wangtao <kevin.wangtao@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rui Zhang <rui.zhang@intel.com>, Daniel Thompson <daniel.thompson@linaro.org>, "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 06/06/2018 14:23, Peter Zijlstra wrote:
> On Tue, Jun 05, 2018 at 11:16:40AM +0200, Daniel Lezcano wrote:
>> +	atomic_t idle_duration_ms;
>> +	atomic_t run_duration_ms;
> 
>> +	idle_duration_ms = atomic_read(&ii_dev->idle_duration_ms);
> 
>> +	run_duration_ms = atomic_read(&ii_dev->run_duration_ms);
> 
>> +	atomic_set(&ii_dev->run_duration_ms, run_duration_ms);
>> +	atomic_set(&ii_dev->idle_duration_ms, idle_duration_ms);
> 
>> +	*run_duration_ms = atomic_read(&ii_dev->run_duration_ms);
>> +	*idle_duration_ms = atomic_read(&ii_dev->idle_duration_ms);
> 
>> +	if (!atomic_read(&ii_dev->idle_duration_ms))
> 
>> +	if (!atomic_read(&ii_dev->run_duration_ms))
> 
> What is the point of atomic_t here ?!

idle_duration and run_duration can be changed from different places at
the same time. The atomic is here to ensure the read/write are consistent.

Do you think it is pointless ?




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
