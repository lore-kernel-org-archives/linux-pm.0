From: Abhishek <huntbag@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] cpuidle : auto-promotion for cpuidle states
Date: Thu, 4 Apr 2019 16:40:43 +0530
Message-ID: <f535b21a-2441-70c3-e51d-28ec8843de66@linux.vnet.ibm.com>
References: <20190322072942.8038-1-huntbag@linux.vnet.ibm.com>
 <20190322072942.8038-2-huntbag@linux.vnet.ibm.com>
 <CAJZ5v0gY-theHng=bQQpw-33jHGe++iEigEM5j6Ls7vEuewuSQ@mail.gmail.com>
 <cfb0076f-0b56-f12c-a736-469a3d11ab83@linaro.org>
 <50f62972-dfce-52bf-d26b-32e6d2a367e2@linux.vnet.ibm.com>
 <9e542011-df6d-9b84-823b-2af6a6ef9e94@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9e542011-df6d-9b84-823b-2af6a6ef9e94@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Michael Ellerman <mpe@ellerman.id.au>, ego@linux.vnet.ibm.com
List-Id: linux-pm@vger.kernel.org



On 04/04/2019 03:51 PM, Daniel Lezcano wrote:
> Hi Abhishek,
>
> thanks for taking the time to test the different scenario and give us
> the numbers.
>
> On 01/04/2019 07:11, Abhishek wrote:
>>
>> On 03/22/2019 06:56 PM, Daniel Lezcano wrote:
>>> On 22/03/2019 10:45, Rafael J. Wysocki wrote:
>>>> On Fri, Mar 22, 2019 at 8:31 AM Abhishek Goel
>>>> <huntbag@linux.vnet.ibm.com> wrote:
>>>>> Currently, the cpuidle governors (menu /ladder) determine what idle
>>>>> state
>>>>> an idling CPU should enter into based on heuristics that depend on the
>>>>> idle history on that CPU. Given that no predictive heuristic is
>>>>> perfect,
>>>>> there are cases where the governor predicts a shallow idle state,
>>>>> hoping
>>>>> that the CPU will be busy soon. However, if no new workload is
>>>>> scheduled
>>>>> on that CPU in the near future, the CPU will end up in the shallow
>>>>> state.
>>>>>
>>>>> In case of POWER, this is problematic, when the predicted state in the
>>>>> aforementioned scenario is a lite stop state, as such lite states will
>>>>> inhibit SMT folding, thereby depriving the other threads in the core
>>>>> from
>>>>> using the core resources.
> I can understand an idle state can prevent other threads to use the core
> resources. But why a deeper idle state does not prevent this also?
>
>
>>>>> To address this, such lite states need to be autopromoted. The cpuidle-
>>>>> core can queue timer to correspond with the residency value of the next
>>>>> available state. Thus leading to auto-promotion to a deeper idle
>>>>> state as
>>>>> soon as possible.
>>>> Isn't the tick stopping avoidance sufficient for that?
>>> I was about to ask the same :)
>>>
>>>
>>>
>>>
>> Thanks for the review.
>> I performed experiments for three scenarios to collect some data.
>>
>> case 1 :
>> Without this patch and without tick retained, i.e. in a upstream kernel,
>> It would spend more than even a second to get out of stop0_lite.
>>
>> case 2 : With tick retained(as suggested) -
>>
>> Generally, we have a sched tick at 4ms(CONF_HZ = 250). Ideally I expected
>> it to take 8 sched tick to get out of stop0_lite. Experimentally,
>> observation was
>>
>> ===================================
>> min            max            99percentile
>> 4ms            12ms          4ms
>> ===================================
>> *ms = milliseconds
>>
>> It would take atleast one sched tick to get out of stop0_lite.
>>
>> case 2 :  With this patch (not stopping tick, but explicitly queuing a
>> timer)
>>
>> min            max              99.5percentile
>> ===============================
>> 144us       192us              144us
>> ===============================
>> *us = microseconds
>>
>> In this patch, we queue a timer just before entering into a stop0_lite
>> state. The timer fires at (residency of next available state + exit
>> latency of next available state * 2).
> So for the context, we have a similar issue but from the power
> management point of view where a CPU can stay in a shallow state for a
> long period, thus consuming a lot of energy.
>
> The window was reduced by preventing stopping the tick when a shallow
> state is selected. Unfortunately, if the tick is stopped and we
> exit/enter again and we select a shallow state, the situation is the same.
>
> A solution was previously proposed with a timer some years ago, like
> this patch does, and merged but there were complains about bad
> performance impact, so it has been reverted.
>
>> Let's say if next state(stop0) is available which has residency of 20us, it
>> should get out in as low as (20+2*2)*8 [Based on the forumla (residency +
>> 2xlatency)*history length] microseconds = 192us. Ideally we would expect 8
>> iterations, it was observed to get out in 6-7 iterations.
> Can you explain the formula? I don't get the rational. Why using the
> exit latency and why multiply it by 2?
>
> Why the timer is not set to the next state's target residency value ?
>
The idea behind multiplying by 2 is, entry latency + exit latency = 2* 
exit latency, i.e.,
using exit latency = entry latency
So in effect, we are using target residency + 2 * exit latency for 
timeout of timer.
Latency is generally <=10% of residency. I have tried to be conservative 
by including latency
factor in computation for timeout. Thus, this formula will give slightly 
greater value compared
to directly using residency of target state.

--Abhishek
