From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] cpufreq: arm_big_little: set lowest frequcency for cluster
 when no cpus in it
Date: Thu, 26 Jun 2014 19:57:53 +0100
Message-ID: <53AC6D31.7010709@arm.com>
References: <1403795313-6903-1-git-send-email-thomas.ab@samsung.com>	<CAKohpomv=0y30q09fuuRDOGQ_XtuKnerC830vFExNok9mAcyfw@mail.gmail.com>	<53AC42CE.2050304@arm.com> <CAJuA9agJb4xx--ujc3=efeFNFLiw4o87nOig8u-X+kY0wj99dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:35732 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878AbaFZS50 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Jun 2014 14:57:26 -0400
In-Reply-To: <CAJuA9agJb4xx--ujc3=efeFNFLiw4o87nOig8u-X+kY0wj99dA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Abraham <ta.omasab@gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>



On 26/06/14 19:25, Thomas Abraham wrote:
> On Thu, Jun 26, 2014 at 9:27 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>>
>> On 26/06/14 16:38, Viresh Kumar wrote:
>>>
>>> On 26 June 2014 20:38, Thomas Abraham <thomas.ab@samsung.com> wrote:
>>>>
>>>> From: Thomas Abraham <thomas.ab@samsung.com>
>>>>
>>>> If there are no active cpus in a cluster, the clock frequency of the
>>>> cluster
>>>> can be lowered to the lowest possible frequency for that cluster. This
>>>> can
>>>> help reduce the output clock speed of the PLL clocking the cluster and
>>>> save power.
>>>>
>>>> The get_table_min() function is also moved with this change to avoid
>>>> forward
>>>> declaration. The function get_table_max() is also moved along with
>>>> get_table_min() so that these two functions are adjacent the code.
>>>
>>>
>>> Makes sense as my poor mind also thought this over an year and
>>> half back.
>>>
>>>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>>>> ---
>>>>    drivers/cpufreq/arm_big_little.c |   51
>>>> +++++++++++++++++++++-----------------
>>>>    1 file changed, 28 insertions(+), 23 deletions(-)
>>>>
>>>> diff --git a/drivers/cpufreq/arm_big_little.c
>>>> b/drivers/cpufreq/arm_big_little.c
>>>> index 1f4d4e3..4b1431f 100644
>>>> --- a/drivers/cpufreq/arm_big_little.c
>>>> +++ b/drivers/cpufreq/arm_big_little.c
>>>> @@ -75,6 +75,28 @@ static inline int cpu_to_cluster(int cpu)
>>>>                   MAX_CLUSTERS : raw_cpu_to_cluster(cpu);
>>>>    }
>>>>
>>>> +/* get the minimum frequency in the cpufreq_frequency_table */
>>>> +static inline u32 get_table_min(struct cpufreq_frequency_table *table)
>>>> +{
>>>> +       struct cpufreq_frequency_table *pos;
>>>> +       uint32_t min_freq = ~0;
>>>> +       cpufreq_for_each_entry(pos, table)
>>>> +               if (pos->frequency < min_freq)
>>>> +                       min_freq = pos->frequency;
>>>> +       return min_freq;
>>>> +}
>>>> +
>>>> +/* get the maximum frequency in the cpufreq_frequency_table */
>>>> +static inline u32 get_table_max(struct cpufreq_frequency_table *table)
>>>> +{
>>>> +       struct cpufreq_frequency_table *pos;
>>>> +       uint32_t max_freq = 0;
>>>> +       cpufreq_for_each_entry(pos, table)
>>>> +               if (pos->frequency > max_freq)
>>>> +                       max_freq = pos->frequency;
>>>> +       return max_freq;
>>>> +}
>>>> +
>>>>    static unsigned int find_cluster_maxfreq(int cluster)
>>>>    {
>>>>           int j;
>>>> @@ -170,9 +192,14 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32
>>>> new_cluster, u32 rate)
>>>>
>>>>                   mutex_lock(&cluster_lock[old_cluster]);
>>>>
>>>> -               /* Set freq of old cluster if there are cpus left on it
>>>> */
>>>> +               /*
>>>> +                * Set freq of old cluster. If there are no cpus left on
>>>> it,
>>>> +                * set the lowest possible frequency for that cluster.
>>>> +                */
>>>>                   new_rate = find_cluster_maxfreq(old_cluster);
>>>>                   new_rate = ACTUAL_FREQ(old_cluster, new_rate);
>>>> +               if (!new_rate)
>>>> +                       new_rate =
>>>> get_table_min(freq_table[old_cluster]);
>>>
>>>
>>> Have you hit this code? How did you test it?
>>>
>>> In case you have hit this code, you must be using IKS as in MP it
>>> doesn't make sense.
>
> Yes, I have hit this code with IKS.
>
>>>
>>> Two things:
>>> - First in case this patch gets in, you can check !new_rate just after
>>>     find_cluster_maxfreq() as it will be zero there as well..
>
> Ok.
>
>>>
>>> - The counter argument given to me from Sudeep at that time was,
>>>     "it is just a waste of time". Because if we aren't using the cluster
>>>     anymore, it will be switched off very soon and there is no point
>>>     wasting time changing freq to lowest..
>>>
>>
>> I was just writing the same thing again, you saved my time :)
>> Since in IKS the cluster will be powered down if no CPU is active, I see no
>> point in doing this. bL_switch_request would initiate cluster powerdown and
>
> The CPU clock domain can contain additional components than just the
> mutli-core cluster. Those continue to be alive and clocked even when
> the cluster is power gated. This results in additional power
> consumption, though may not be high enough, but can be reduced by
> lowering the clock speed.
>

I am not really sure if that's the case. Consider a single cluster system,
how would you handle that ? Do you set the clock to lowest every time you
enter deepest C-state.

Alternatively in a multi-cluster platform if I hotplug out all the cpus in one
cluster, do you mean we still have to explicitly set the frequency to lowest
before the last cpu goes down. This needs to be handled implicitly IMO, but
they may be some restrictions on some platforms which I am not aware of.

It would be good to know why exactly you need that.

>> trying to reset the clk to lowest might unnecessarily wake it up(though
>> the exact behaviour depends on the firmware/code managing it)
>
> Any particular example of a platform that has this problem, just to
> understand what could cause such a behavior and if is mostly a
> software or a hardware induced problem.
>

No I don't know any particular platform.

