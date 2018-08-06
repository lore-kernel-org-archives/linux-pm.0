From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v5 09/14] sched: Add over-utilization/tipping point
 indicator
Date: Mon, 6 Aug 2018 14:29:26 +0200
Message-ID: <1cac0d16-9f50-ed30-2460-340b077faa57@arm.com>
References: <20180802153035.vjtmqwdwujvt7ojs@queper01-lin>
 <CAKfTPtCGGqykN027kxK+chvKvCpNu4bYYdvfZJ+3_7YzT3Utfg@mail.gmail.com>
 <20180802160009.uhwwj3tqrqmv7q5a@queper01-lin>
 <CAKfTPtB_tWgOPCB3q2Q2rESKczTPGBDUojcXDY7uP8YTQddBMg@mail.gmail.com>
 <20180802161027.v2ctgscuc4uxbb7u@queper01-lin>
 <CAKfTPtDtaF9Qs4NWkKWUSr8Ryi-ScYNmPyacocPQUPxT00XAYg@mail.gmail.com>
 <20180802165924.7ywgoxj2jwftxycz@queper01-lin>
 <CAKfTPtDsG4FJy5xBO8+6pJzehEM668=SZ4yQ-szVTduofN3QZg@mail.gmail.com>
 <20180803081850.hj7bp5ognuywapmd@queper01-lin>
 <CAKfTPtDkJY=JYicZk8sM9_mJ-iq+Jwse0oVRbW=wpxXKKnEoeQ@mail.gmail.com>
 <20180803155547.sxlhxpmhwcoappit@queper01-lin>
 <CAKfTPtBT-p-Z0EneirfOTwUw=5jEeDGa+4_EE4ogi2Ht7GU9Bg@mail.gmail.com>
 <68689fcb-3cb8-4685-58ef-0bec84be2047@arm.com>
 <CAKfTPtADSDJJaPr17zD8ZNtS7CQGBwfU6JDGRwssLN20zyW7Nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKfTPtADSDJJaPr17zD8ZNtS7CQGBwfU6JDGRwssLN20zyW7Nw@mail.gmail.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Quentin Perret <quentin.perret@arm.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, Thara Gopinath <thara.gopinath@linaro.org>, viresh kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joel@joelfernandes.org>, "Cc: Steve Muckle" <smuckle@google.com>, adharmap@quicinc.com, "Kannan, Saravana" <skannan@quicinc.com>, pkondeti@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On 08/06/2018 12:33 PM, Vincent Guittot wrote:
> On Mon, 6 Aug 2018 at 12:08, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 08/06/2018 10:40 AM, Vincent Guittot wrote:
>>> On Fri, 3 Aug 2018 at 17:55, Quentin Perret <quentin.perret@arm.com> wrote:
>>>>
>>>> On Friday 03 Aug 2018 at 15:49:24 (+0200), Vincent Guittot wrote:
>>>>> On Fri, 3 Aug 2018 at 10:18, Quentin Perret <quentin.perret@arm.com> wrote:
>>>>>>
>>>>>> On Friday 03 Aug 2018 at 09:48:47 (+0200), Vincent Guittot wrote:
>>>>>>> On Thu, 2 Aug 2018 at 18:59, Quentin Perret <quentin.perret@arm.com> wrote:
>>
>> [...]
>>
>>>> I think we're discussing two different things right now:
>>>>       1. Should forkees go in find_energy_efficient_cpu() ?
>>>>       2. Should forkees have 0 of initial util_avg when EAS is enabled ?
>>>
>>> It's the same topic: How EAS should consider a newly created task ?
>>>
>>> For now, we let the "performance" mode selects a CPU. This CPU will
>>> most probably be worst CPU from a EAS pov because it's the idlest CPU
>>> in the idlest group which is the opposite of what EAS tries to do
>>>
>>> The current behavior is :
>>> For every new task, the cpu selection is done assuming it's a heavy
>>> task with the max possible load_avg,  and it looks for the idlest cpu.
>>> This means that if the system is lightly loaded, scheduler will select
>>> most probably a idle big core.
>>
>> AFAICS, task load doesn't seem to be used for find_idlest_cpu() (
>> find_idlest_group() and find_idlest_group_cpu()). So the forkee
>> (SD_BALANCE_FORK) is placed independently of his task load.
> 
> hmm ... so what is used if load or runnable load are not used ?
> find_idlest_group() uses load and runnable load but skip spare
> capacity in case of fork

Yes, runnable load and load are used, but from the cpus, not from the task.

[...]
