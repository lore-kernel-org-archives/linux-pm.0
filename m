From: Ionela Voinescu <ionela.voinescu@arm.com>
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
Date: Wed, 10 Oct 2018 17:15:01 +0100
Message-ID: <ad3492f2-f5a9-97ea-8068-d4df2d9288ce@arm.com>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <20181010061751.GA37224@gmail.com>
 <20181010082933.4ful4dzk7rkijcwu@queper01-lin>
 <CAKfTPtA1sgf77xLUPr74iEEb+W8PGCMCkgu+Kw8xM_Jxx7_hjQ@mail.gmail.com>
 <20181010095459.orw2gse75klpwosx@queper01-lin>
 <CAKfTPtA+FWrMnerQhrNQhvmvVSK_S86da=8shpdET-807zZgVg@mail.gmail.com>
 <20181010103623.ttjexasymdpi66lu@queper01-lin>
 <CAKfTPtBM24F99OhtjWU-cx4DdFFpvUMMDYuqZH_vaJg9HEpPTw@mail.gmail.com>
 <20181010130549.hzpkaskvlgifbdrp@queper01-lin>
 <CAKfTPtA=GYaiKcJ9N5zEnzxJTKBATG41c0xDjhbA21G-Cv6LvA@mail.gmail.com>
 <20181010134755.jrigtogbxwaz2izb@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010134755.jrigtogbxwaz2izb@queper01-lin>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thara Gopinath <thara.gopinath@linaro.org>, linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Zhang Rui <rui.zhang@intel.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Amit Kachhap <amit.kachhap@gmail.com>, viresh kumar <viresh.kumar@linaro.org>, Javi Merino <javi.merino@kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi guys,

On 10/10/18 14:47, Quentin Perret wrote:
> On Wednesday 10 Oct 2018 at 15:27:57 (+0200), Vincent Guittot wrote:
>> On Wed, 10 Oct 2018 at 15:05, Quentin Perret <quentin.perret@arm.com> wrote:
>>>
>>> On Wednesday 10 Oct 2018 at 14:04:40 (+0200), Vincent Guittot wrote:
>>>> This patchset doesn't touch cpu_capacity_orig and doesn't need to  as
>>>> it assume that the max capacity is unchanged but some capacity is
>>>> momentary stolen by thermal.
>>>>  If you want to reflect immediately all thermal capping change, you
>>>> have to update this field and all related fields and struct around
>>>
>>> I don't follow you here. I never said I wanted to change
>>> cpu_capacity_orig. I don't think we should do that actually. Changing
>>> capacity_of (which is updated during LB IIRC) is just fine. The question
>>> is about what you want to do there: reflect an averaged value or the
>>> instantaneous one.
>>
>> Sorry I though your were speaking about updating this cpu_capacity_orig.
> 
> N/p, communication via email can easily become confusing :-)
> 
>> With using instantaneous max  value in capacity_of(), we are back to
>> the problem raised by Thara that  the value will most probably not
>> reflect the current capping value when it is used in LB, because LB
>> period can quite long on busy CPU (default max value is 32*sd_weight
>> ms)
> 
> But averaging the capping value over time doesn't make LB happen more
> often ... That will help you account for capping that happened in the
> past, but it's not obvious this is actually a good thing. Probably not
> all the time anyway.
> 
> Say a CPU was capped at 50% of it's capacity, then the cap is removed.
> At that point it'll take 100ms+ for the thermal signal to decay and let
> the scheduler know about the newly available capacity. That can probably
> be a performance hit in some use cases ... And the other way around, it
> can also take forever for the scheduler to notice that a CPU has a
> reduced capacity before reacting to it.
> 
> If you want to filter out very short transient capping events to avoid
> over-reacting in the scheduler (is this actually happening ?), then
> maybe the average should be done on the cooling device side or something
> like that ?
> 

I think there isn't just the issue of the *occasional* overreaction of a
thermal governor due to noise in the temperature sensors or some spike
in environmental temperature that determines a delayed reaction in the
scheduler due to when capacity is updated.

I'm seeing a bigger issue for *sustained* high temperatures that are not
treated effectively by governors. Depending on the platform, heat can
be dissipated over longer or shorter periods of time. This can determine
a seesaw effect on the maximum frequency: it determines the temperature
is over a threshold and it starts capping, but heat is not dissipated
quickly enough for that to reflect in the value of the temperature sensor,
so it continues to cap; when the temperature gets to normal, capping
is lifted, which in turn results access to higher OPPs and a return to
high temperatures, etc.

What will happen is that, *depending on platform* and the moment when
capacity is updated, you can see either a CPU with a capacity of 1024, or
let's say 800, or (on hikey960 :)) around 500, and back and forth
between them.

Because of these I tend to think that a regulated (averaged) value of
thermal pressure is better than an instantaneous one. Thermal mitigation
measures are there for the well-being and safety of a device, not for
optimizations so it can and should be allowed to overreact, or have a
delayed reaction. But ping-pong-ing tasks back and forth between CPUs
due to changes in CPU capacity is harmful for performance. What would be
awesome to achieve with this is (close to) optimal use of restricted
capacities of CPUs, and I tend to believe instantaneous and most probably
out of date capacity values would not lead to this.

But this is almost a gut feeling and of course it should be validated on
devices with different thermal characteristics. Given the high variation
between devices with regards to this I'd be reluctant to tie it to the
PELT half life.

Regards,
Ionela.

> Thanks,
> Quentin
> 
