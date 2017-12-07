From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v3 1/6] cpufreq: schedutil: reset sg_cpus's flags at IDLE
 enter
Date: Thu, 7 Dec 2017 16:55:25 +0100
Message-ID: <2ca6459c-8ef5-9593-e8c4-52907d35355a@arm.com>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171130114723.29210-2-patrick.bellasi@arm.com>
 <20171207050135.vvhqttazumjg7n7n@vireshk-mac-ubuntu>
 <20171207124510.GP31247@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171207124510.GP31247@e110439-lin>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

On 12/07/2017 01:45 PM, Patrick Bellasi wrote:
> Hi Viresh,
> 
> On 07-Dec 10:31, Viresh Kumar wrote:
>> On 30-11-17, 11:47, Patrick Bellasi wrote:

[...]

>> We posted some comments on V2 for this particular patch suggesting
>> some improvements. The patch hasn't changed at all and you haven't
>> replied to few of those suggestions as well. Any particular reason for
>> that?
> 
> You right, since the previous posting has been a long time ago, with
> this one I mainly wanted to refresh the discussion. Thanks for
> highlighting hereafter which one was the main discussion points.
> 
> 
>> For example:
>> - I suggested to get rid of the conditional expression in
>>    cpufreq_schedutil.c file that you have added.
> 
> We can probably set flags to SCHED_CPUFREQ_IDLE (instead of resetting
> them), however I think we still need an if condition somewhere.
> 
> Indeed, when SCHED_CPUFREQ_IDLE is asserted we don't want to trigger
> an OPP change (reasons described in the changelog).
> 
> If that's still a goal, then we will need to check this flag and bail
> out from sugov_update_shared straight away. That's why I've added a
> check at the beginning and also defined it as unlikely to have not
> impact on all cases where we call a schedutil update with runnable
> tasks.
> 
> Does this makes sense?

IIRC, there was also this question of doing this not only in the shared 
but also in the single case ...

[...]
