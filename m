From: Thara Gopinath <thara.gopinath@linaro.org>
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
Date: Wed, 10 Oct 2018 13:08:22 -0400
Message-ID: <5BBE3206.2010407@linaro.org>
References: <20181010082933.4ful4dzk7rkijcwu@queper01-lin>
 <CAKfTPtA1sgf77xLUPr74iEEb+W8PGCMCkgu+Kw8xM_Jxx7_hjQ@mail.gmail.com>
 <20181010095459.orw2gse75klpwosx@queper01-lin>
 <CAKfTPtA+FWrMnerQhrNQhvmvVSK_S86da=8shpdET-807zZgVg@mail.gmail.com>
 <20181010103623.ttjexasymdpi66lu@queper01-lin>
 <CAKfTPtBM24F99OhtjWU-cx4DdFFpvUMMDYuqZH_vaJg9HEpPTw@mail.gmail.com>
 <20181010122348.GL9130@localhost.localdomain>
 <CAKfTPtCVryjWWT_M1zEZfJUjGkt2JPUiBK6vt0YiJTK4qVoqbA@mail.gmail.com>
 <20181010125033.GP9130@localhost.localdomain>
 <CAKfTPtAL5b0ZAOY_85ajskOX+thLf3j3M-xJ+Pt_NrM+N8udPw@mail.gmail.com>
 <20181010133443.GR9130@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010133443.GR9130@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@gmail.com>, Vincent Guittot <vincent.guittot@linaro.org>
Cc: Quentin Perret <quentin.perret@arm.com>, Ingo Molnar <mingo@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Zhang Rui <rui.zhang@intel.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Amit Kachhap <amit.kachhap@gmail.com>, viresh kumar <viresh.kumar@linaro.org>, Javi Merino <javi.merino@kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, Ionela Voinescu <ionela.voinescu@arm.com>
List-Id: linux-pm@vger.kernel.org

On 10/10/2018 09:34 AM, Juri Lelli wrote:
> On 10/10/18 15:08, Vincent Guittot wrote:
>> On Wed, 10 Oct 2018 at 14:50, Juri Lelli <juri.lelli@gmail.com> wrote:
>>>
>>> On 10/10/18 14:34, Vincent Guittot wrote:
>>>> Hi  Juri,
>>>>
>>>> On Wed, 10 Oct 2018 at 14:23, Juri Lelli <juri.lelli@gmail.com> wrote:
>>>>>
>>>>> On 10/10/18 14:04, Vincent Guittot wrote:
>>>>>
>>>>> [...]
>>>>>
>>>>>> The problem was the same with RT, the cfs utilization was lower than
>>>>>> reality because RT steals soem cycle to CFS
>>>>>> So schedutil was selecting a lower frequency when cfs was running
>>>>>> whereas the CPU was fully used.
>>>>>> The same can happen with thermal:
>>>>>> cap the max freq because of thermal
>>>>>> the utilization with decrease.
>>>>>> remove the cap
>>>>>> the utilization is still low and you will select a low OPP because you
>>>>>> don't take into account cycle stolen by thermal like with RT
>>>>>
>>>>> What if we scale frequency component considering the capped temporary
>>>>> max?
>>>>
>>>> Do you mean using a kind of scale_thermal_capacity in accumulate_sum
>>>> when computing utilization ?
>>>
>>> Yeah, something like that I guess. So that we account for temporary
>>> "fake" 1024..
>>
>> But the utilization will not be invariant anymore across the system
> 
> Mmm, I guess I might be wrong, but I was thinking we should be able to
> deal with this similarly to what we do with cpus with different max
> capacities. So, another factor?  Because then, how do we handle other
> ways in which max freq can be restricted (e.g. from userspace as Javi
> was also mentioning)?

IMHO, user-space restrictions should be handled separately. It should
probably reflect as an update of capacity_orig and rebuilding of
scheduler structures as such a restriction is meant to stay for a long
duration.

Regards
Thara
> 


-- 
Regards
Thara
