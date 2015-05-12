From: Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [PATCH v7 2/5] PM / Domains: core changes for multiple states
Date: Tue, 12 May 2015 13:58:18 +0200
Message-ID: <CAKXjFTND6q5B+T4VZtC2BHy=dp7BerqwwyDvYmmwT7tkKKtyAw@mail.gmail.com>
References: <1430391335-7588-1-git-send-email-ahaslam@baylibre.com>
	<1430391335-7588-3-git-send-email-ahaslam@baylibre.com>
	<20150507155359.GA15980@linaro.org>
	<7ha8xehjug.fsf@deeprootsystems.com>
	<20150508223135.GA16124@linaro.org>
	<CAKXjFTN2vxjtURFX+TXaPXy7BD_dL82NE6miomcs7x2AOBp_JQ@mail.gmail.com>
	<20150511165047.GD16124@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:34206 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932309AbbELL6T (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2015 07:58:19 -0400
Received: by oiko83 with SMTP id o83so3608195oik.1
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2015 04:58:18 -0700 (PDT)
In-Reply-To: <20150511165047.GD16124@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Benoit Cousson <bcousson@baylibre.com>, Linux PM list <linux-pm@vger.kernel.org>, Axel Haslam <ahaslam+renesas@baylibre.com>, =?UTF-8?Q?Bartosz_Go=C5=82aszewski?= <bgolaszewski@baylibre.com>

Hi Lina

On Mon, May 11, 2015 at 6:50 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
> On Mon, May 11 2015 at 09:53 -0600, Axel Haslam wrote:
>>
>> Hi Lina,
>>
>> + Bartosz who was interested in the patches too.
>>
>> On Sat, May 9, 2015 at 12:31 AM, Lina Iyer <lina.iyer@linaro.org> wrote:
>>>
>>> On Fri, May 08 2015 at 14:53 -0600, Kevin Hilman wrote:
>>>>
>>>>
>>>> Lina Iyer <lina.iyer@linaro.org> writes:
>>>>
>>>>> On Thu, Apr 30 2015 at 04:57 -0600, ahaslam@baylibre.com wrote:
>>>>>>
>>>>>>
>>>>>> From: Axel Haslam <ahaslam+renesas@baylibre.com>
>>>>>>
>>>>>> Add the core changes to be able to declare multiple states.
>>>>>> When trying to set a power domain to off, genpd will be able
>>>>>> to choose from an array of states declared by the platform.
>>>>>>
>>>>>> The power on and off latencies are now tied to a state.
>>>>>>
>>>>>> States should be declared in ascending order from shallowest
>>>>>> to deepest, deepest meaning the state which takes longer to
>>>>>> enter and exit.
>>>>>>
>>>>>> the power_off and power_on function can use the 'state_idx'
>>>>>> field of the generic_pm_domain structure, to distinguish between
>>>>>> the different states and act accordingly.
>>>>>>
>>>>>> - if the genpd is initially off, the user should set the state_idx
>>>>>>   field when registering the genpd.
>>>>>>
>>>>>> - if no states are passed to pm_genpd_init, a single OFF
>>>>>>   state with no latency is assumed.
>>>>>>
>>>>>> Example:
>>>>>>
>>>>>> static int pd1_power_on(struct generic_pm_domain *domain)
>>>>>> {
>>>>>>         /* domain->state_idx = state the domain is coming from */
>>>>>> }
>>>>>>
>>>>>> static int pd1_power_off(struct generic_pm_domain *domain)
>>>>>> {
>>>>>>         /* domain->state_idx = desired powered off state */
>>>>>> }
>>>>>>
>>>>>> const struct genpd_power_state pd_states[] = {
>>>>>>         {
>>>>>>                 .name = "RET",
>>>>>>                 .power_on_latency_ns = ON_LATENCY_FAST,
>>>>>>                 .power_off_latency_ns = OFF_LATENCY_FAST,
>>>>>>         },
>>>>>>         {
>>>>>>                 .name = "DEEP_RET",
>>>>>>                 .power_on_latency_ns = ON_LATENCY_MED,
>>>>>>                 .power_off_latency_ns = OFF_LATENCY_MED,
>>>>>>         },
>>>>>>         {
>>>>>>                 .name = "OFF",
>>>>>>                 .power_on_latency_ns = ON_LATENCY_SLOW,
>>>>>>                 .power_off_latency_ns = OFF_LATENCY_SLOW,
>>>>>>         }
>>>>>> };
>>>>>>
>>>>>
>>>>> I am trying to use your patches in fashioning a genpd for the cpu
>>>>> domain.
>>>>>
>>>>> The cpus are part of a power domain that can be powered off when the
>>>>> cpus are powered off as part of the cpuidle. One of the biggest power
>>>>> savings comes from powering off the domain completely. However,
>>>>> powering
>>>>> off the domain involves flushing of caches (possibly) and turning off
>>>>> some regulators and peripheral hardware. The power benefit is only
>>>>> realized when the domain remains powered off for a certain period of
>>>>> time, otherwise the overhead of powering on/off would add up to the
>>>>> ineffeciency in the system.
>>>>>
>>>>> So a governor that determines the idle state of the domain has two
>>>>> things that needs to match, the time available to power off the domain
>>>>> (which we can get from timer wheel) and the other residency as dictated
>>>>> by the platform.
>>>>>
>>>>> I was wondering if we could match the idle state definition of the
>>>>> domain with that of the cpu, which has a precedence in the kernel. The
>>>>> idle state of the cpu [1] is a superset of the idle state definition
>>>>> you
>>>>> have above.  That way a shim layer could pick up domain idle states
>>>>> from
>>>>> DT and pass the states to pm_genpd_init(). The use of these values
>>>>> could
>>>>> depend on the genpd governor.
>>>>
>>>>
>>>>
>>>> IMO, we need to keep the domain latency descriptions separate from the
>>>> the devices within those domains, which could be CPUs or any other form
>>>> of device.
>>>
>>>
>>>
>>> Sure, the devices could be any. All I am saying is the format of idle
>>> state definitions could be the same (same as cpu). There is a good
>>> value in specifying the residency of an idle state in addition to the
>>> the enter and exit latency.
>>>
>>>> It should be the job of the governor then to look at the domain latency
>>>> along with latencies of the other devices in the domain to make its
>>>> decision.
>>>
>>>
>>>
>>> Agreed and thats how it should be. In all probablility, a cpu-domain
>>> governor would need a residency value of the domain idle state to best
>>> determine the idle state of the domain.
>>>
>>> If we have not stored the residency in struct genpd_power_state, then
>>> the governor would not have a good way to make that decision.
>>>
>>> I am not ready yet with my patches, but feel free to browse through my
>>> working tree at [1] to see how I plan to use this patchset.
>>
>>
>>
>> I took a quick look at the tree you mentioned and i have a couple of
>> doubts about
>> the concepts. i will list what i understood so maybe you can comment
>> if im wrong:
>
>
> Hi Axel,
>
> Thanks for looking at my series.
>
>>
>> - genpd  cpu-domain governor is not meant to replace the cpuidle governor.
>> right?
>>
> That is correct. I am not replacing the cpuidle governor. What I am
> working on is independent of the cpuidle governor.
>
>> - the idea is to tie the cpuidle states to the cpu-domain states. there
>> would be a c-state for doing a cluster off, with the off/on latencies
>> and min residency
>> values that would represent the cost of turning the cluster off.
>
>
> Not necessarily. The map is not to individual C-States of the cpu, but
> only to the power down state of the cpu (the ones which send out CPU_PM
> notifications), at this time. The residencies of the individual cpu
> c-states are for the cpu only. A similar but independent one could exist
> for the cpu-domain is the proposal here.


Thanks for the clarification, i think most of my confusion is that
i had imagined doing a cluster off as simply a more expensive c-state.

>>
>>
>> - the cpuidle governor (menu governor)has some extra logic to decide the
>> idle
>> state aside from the exit latencies and target residency (eg, buckets,
>> performance multiplier).
>> Even if the next wakeup, latencies and target residencies justify going to
>> a
>> deep c-state, the governor can decide to demote that state based on the
>> recent history. im not sure were the line is between the governor taking a
>> c state decision and genpd taking another one, I feel the cpu-domain
>> governor will not always respect the same state decision as that the
>> cpuidle
>> governor may have taken, and i guess there should not be two places
>> were the decision
>> is taken. (but again,maybe i got  the idea wrong)o
>
>
> Absolutely. The cpus will obey the idle state suggested by the menu or
> any other governor. Once a state is chosen, the cpu is expected to enter
> the state or bail out if there was a pending interrupt.
>
> CPU-Domain decisions will be based on the cpuidle governor decisions.
> For states that CPU_PM notifications are not sent out, we can be sure
> that the cpu is not powered off and so the domain would not be powered
> off as well. Hence the tie up of the pm_runtime_put_sync() with CPU_PM
> notifications.
>
> But take the case where the menu governor decides for each cpu, that it
> can power down the cpu. If there is enough time where all cpus are
> powered off in the domain, then the domain can safely be powered down,
> until the first of the cpus in that domain wakes up. The time between
> the last cpu down and the first cpu up is generally a good opportunity
> for power saving. Power savings could come from turning off peripheral
> hardware, flushing cashes, switching regulators to supply a low load
> mode. There is usually a cost benefit table associated with the sleep
> time available for the domain vs turning off these components and that
> cost benefict analysis in my case is the residency - the sleep time that
> the domain needs to sleep in order to reap the benefits of the overhead
> in powering off and on the domain while the cpus are sleeping. Its
> fairly common for the mobile cpus to sleep tens of milliseconds between
> active operations and it is beneficial to flush caches and power the
> domain in many such cases.
>
>>
>> - the cpu_pm_enter call in cpuidle, which will notify of the intention to
>> suspend, happens before the actual suspend. when the genpd gets the
>> notifications
>> you will call pm_runtime_put_sync(dev) for the cpu which will potentially
>> turn off the cluster using the genpd-off callback (regulators..etc...),
>> but the cpu is not yet be suspended right?
>>
>
> Also correct. Most architectures (ARM especially)that allow powering off
> the cpu domain, usually would do it through a peripheral power-controller
> that is capable of being triggered when the last cpu in the domain is
> powered off. In QCOM SoCs that I am most familiar with, ARM WFI signal
> (which means that the processor is clock gated, therefore not running)
> from a processor is used to trigger an external power controller for the
> cpu. This ensures that there is no race with the cpu actually running
> when the power-controller is powering down the cpu on its behalf. The
> same WFI signal is also sent to the domain power-controller that can
> be configured to power down the caches and turn off regulators etc. On
> the way up, the interrupt to the core is trapped to wake up the domain
> first (if powered off), before the cpu is resumed.
>
> The CPU_PM notifications do get sent before the cpu is actually powered
> off, but is sent at a point, when the decision has been made to power
> off the cpu. So the domain decision can be made decisively knowing what
> state the cpus are going to be in.
>
> In all likelihood, there might be a pending interrupt for the cpu, when
> this domain decision happens, in which case, both the cpu and the domain
> would bail out of their idle states.
>
>> -maybe it was discussed before, But i think that if the cpuidle governor
>> would save the time a cpu entered in a particular state, we could add
>> a .validate callback
>> in the menu governor that would take the a cpumask of the cpus in the
>> cluster
>> and would compare the time each cpu entered a c-state against the
>> predicted
>> time to get how much "remaining time" is "probably" left. That way we
>> could
>> know if a cluster off i worth it or not, and it would use the inteligence
>> allready available in the cpuidle governor.
>
>
> Fair point. And that could be ideal. The governor algorithm need not
> exist with GenPD and could be handled by the menu governor. I can work on
> that, but since it is external to menu governor decision, I had
> chosen to put as a genpd governor. This can be discussed more.

 maybe it can be usefull to start a separate thread about this discussion.
i can post a RFC to start the thread..

Regards
Axel



>
> Thanks,
> Lina
>
>>> [1].
>>>
>>> https://git.linaro.org/people/lina.iyer/linux-next.git/shortlog/refs/heads/genpd-8916-3
