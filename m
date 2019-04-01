From: Abhishek <huntbag@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] cpuidle : auto-promotion for cpuidle states
Date: Mon, 1 Apr 2019 10:41:35 +0530
Message-ID: <50f62972-dfce-52bf-d26b-32e6d2a367e2@linux.vnet.ibm.com>
References: <20190322072942.8038-1-huntbag@linux.vnet.ibm.com>
 <20190322072942.8038-2-huntbag@linux.vnet.ibm.com>
 <CAJZ5v0gY-theHng=bQQpw-33jHGe++iEigEM5j6Ls7vEuewuSQ@mail.gmail.com>
 <cfb0076f-0b56-f12c-a736-469a3d11ab83@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cfb0076f-0b56-f12c-a736-469a3d11ab83@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Michael Ellerman <mpe@ellerman.id.au>
List-Id: linux-pm@vger.kernel.org



On 03/22/2019 06:56 PM, Daniel Lezcano wrote:
> On 22/03/2019 10:45, Rafael J. Wysocki wrote:
>> On Fri, Mar 22, 2019 at 8:31 AM Abhishek Goel
>> <huntbag@linux.vnet.ibm.com> wrote:
>>> Currently, the cpuidle governors (menu /ladder) determine what idle state
>>> an idling CPU should enter into based on heuristics that depend on the
>>> idle history on that CPU. Given that no predictive heuristic is perfect,
>>> there are cases where the governor predicts a shallow idle state, hoping
>>> that the CPU will be busy soon. However, if no new workload is scheduled
>>> on that CPU in the near future, the CPU will end up in the shallow state.
>>>
>>> In case of POWER, this is problematic, when the predicted state in the
>>> aforementioned scenario is a lite stop state, as such lite states will
>>> inhibit SMT folding, thereby depriving the other threads in the core from
>>> using the core resources.
>>>
>>> To address this, such lite states need to be autopromoted. The cpuidle-
>>> core can queue timer to correspond with the residency value of the next
>>> available state. Thus leading to auto-promotion to a deeper idle state as
>>> soon as possible.
>> Isn't the tick stopping avoidance sufficient for that?
> I was about to ask the same :)
>
>
>
>
Thanks for the review.
I performed experiments for three scenarios to collect some data.

case 1 :
Without this patch and without tick retained, i.e. in a upstream kernel,
It would spend more than even a second to get out of stop0_lite.

case 2 : With tick retained(as suggested) -

Generally, we have a sched tick at 4ms(CONF_HZ = 250). Ideally I expected
it to take 8 sched tick to get out of stop0_lite. Experimentally, 
observation was

===================================
min            max            99percentile
4ms            12ms          4ms
===================================
*ms = milliseconds

It would take atleast one sched tick to get out of stop0_lite.

case 2 :  With this patch (not stopping tick, but explicitly queuing a 
timer)

min            max              99.5percentile
===============================
144us       192us              144us
===============================
*us = microseconds

In this patch, we queue a timer just before entering into a stop0_lite
state. The timer fires at (residency of next available state + exit
latency of next available state * 2).
Let's say if next state(stop0) is available which has residency of 20us, it
should get out in as low as (20+2*2)*8 [Based on the forumla (residency +
2xlatency)*history length] microseconds = 192us. Ideally we would expect 8
iterations, it was observed to get out in 6-7 iterations.
Even if let's say stop2 is next available state(stop0 and stop1 both are
unavailable), it would take (100+2*10)*8 = 960us to get into stop2.

So, We are able to get out of stop0_lite generally in 150us(with this 
patch) as
compared to 4ms(with tick retained). As stated earlier, we do not want 
to get
stuck into stop0_lite as it inhibits SMT folding for other sibling 
threads, depriving
them of core resources. Current patch is using auto-promotion only for 
stop0_lite,
as it gives performance benefit(primary reason) along with lowering down 
power
consumption. We may extend this model for other states in future.

--Abhishek
