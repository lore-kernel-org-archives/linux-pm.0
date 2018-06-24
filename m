From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V9] powercap/drivers/idle_injection: Add an idle injection
 framework
Date: Mon, 25 Jun 2018 00:40:15 +0200
Message-ID: <fc2ef4e9-7ec8-c644-9495-e33f000531b2@linaro.org>
References: <1529414627-5638-1-git-send-email-daniel.lezcano@linaro.org>
 <20180620043415.57yvgzlye4l7wdqy@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180620043415.57yvgzlye4l7wdqy@vireshk-i7>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@kernel.org>, Leo Yan <leo.yan@linaro.org>, Kevin Wangtao <kevin.wangtao@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rui Zhang <rui.zhang@intel.com>, Daniel Thompson <daniel.thompson@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


Hi Rafael,

do you think this patch is acceptable for merging ?



On 20/06/2018 06:34, Viresh Kumar wrote:
> On 19-06-18, 15:23, Daniel Lezcano wrote:
>> Initially, the cpu_cooling device for ARM was changed by adding a new
>> policy inserting idle cycles. The intel_powerclamp driver does a
>> similar action.
>>
>> Instead of implementing idle injections privately in the cpu_cooling
>> device, move the idle injection code in a dedicated framework and give
>> the opportunity to other frameworks to make use of it.
>>
>> The framework relies on the smpboot kthreads which handles via its
>> main loop the common code for hotplugging and [un]parking.
>>
>> This code was previously tested with the cpu cooling device and went
>> through several iterations. It results now in split code and API
>> exported in the header file. It was tested with the cpu cooling device
>> with success.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Cc: Eduardo Valentin <edubezval@gmail.com>
>> Cc: Javi Merino <javi.merino@kernel.org>
>> Cc: Leo Yan <leo.yan@linaro.org>
>> Cc: Kevin Wangtao <kevin.wangtao@linaro.org>
>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> Cc: Rui Zhang <rui.zhang@intel.com>
>> Cc: Daniel Thompson <daniel.thompson@linaro.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
>> ---
>>
>> V9:
>>    - Unconditionnally reset the should_run flag for all kthreads
>>      belonging to the cpumask and remove the park() callback (Viresh Kumar)
>>    - Fix up the typos in the comments (Viresh Kumar)
> 
> Looks great now. Can't think of any more races :)
> 
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
