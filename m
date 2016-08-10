From: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 02/15] dt/bindings: Update binding for PM domain idle
 states
Date: Wed, 10 Aug 2016 19:09:21 +0100
Message-ID: <5e59874c-bbb7-270a-199c-da1ff5932554@arm.com>
References: <1470351902-43103-1-git-send-email-lina.iyer@linaro.org>
 <1470351902-43103-3-git-send-email-lina.iyer@linaro.org>
 <99e35b6c-6698-6d27-f4d7-fa032796869e@arm.com>
 <20160810164034.GA1401@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160810164034.GA1401-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Axel Haslam <ahaslam+renesas-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc Titinger <mtitinger+renesas-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi-5wv7dgnIgG8@public.gmane.org>, Brendan Jackman <Brendan.Jackman-5wv7dgnIgG8@public.gmane.org>, Juri Lelli <Juri.Lelli-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org



On 10/08/16 17:40, Lina Iyer wrote:
> Hi Sudeep,
>
> On Wed, Aug 10 2016 at 09:15 -0600, Sudeep Holla wrote:
>> Hi Lina,
>>
>> I have few concerns mainly due to the lack of description and not the
>> binding per say.

[...]

>>> +- domain-idle-states : A phandle of an idle-state that shall be
>>> soaked into a
>>> +                generic domain power state. The idle state
>>> definitions are
>>> +                compatible with arm,idle-state specified in [1].
>>> +
>>
>> So I assume these can be used for the genpd states. Either we rename
>> it domain-power-states or make it clear that these domain-idle-states
>> can also represent the power-states for normal devices.
>>
> These are the domains' idle states. These states are only used when the
> domain goes into idle, not when the domain is active. These are not
> power states that the domain can operate on either. Hence the idle-state
> moniker.

I am not sure if we can tell that the device is running in all it's
power states. E.g. in ACPI IIUC, only D0 state represent running state,
while D{1,2,3} are power states which consume less power than D0/running
state. I think genpd is designed on those lines.

So I was thinking if these idle-states can also if use from non-CPU
devices w.r.t binding, it will serve as D-state equivalent in ACPI

> Also, the bindings to describe the state are the same as arm,idle-state.
> It made sense to call these domain idle states instead of
> domain-power-states.
>

I am fine with that, but we have idle states compatible to distinguish 
it from normal device idle/power states.

>>> Example:
>>>
>>>     power: power-controller@12340000 {
>>> @@ -59,6 +63,57 @@ The nodes above define two power controllers:
>>> 'parent' and 'child'.
>>> Domains created by the 'child' power controller are subdomains of '0'
>>> power
>>> domain provided by the 'parent' power controller.
>>>
>>> +Example 3: ARM v7 style CPU PM domains (Linux domain controller)
>>> +
>>> +    cpus {
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +
>>> +        CPU0: cpu@0 {
>>> +            device_type = "cpu";
>>> +            compatible = "arm,cortex-a7", "arm,armv7";
>>> +            reg = <0x0>;
>>> +            power-domains = <&a7_pd>;
>>
>> This example doesn't consider how do we deal with the presence off
>> cpu-idle-states property in CPU nodes.
>>
> I can amend the example. But to answer your underlying question, they
> will exist as separate properties.
>

Which is asking for trouble IMO. One should take precedence over other
if both are present. Ideally new DTs can just have PD, we will continue
to support cpu-idle-states for old DT.

>> IMO we need move even the cpu/core level idle states into its own power
>> domain. It also helps to solve other usecases like PMU, debug/coresight
>> devices attached to the core power domain(in most of the cases) while
>> they may be in separate PD like PMUs on OMAP. That will help OS whether
>> to save/restore the states on idle-entry.
>>
> This idea was brought up by Kevin earlier in the discussions, but we
> shelved it for a later date.
>

Any particular reasons ? I will try to dig up. I would do in one shot
especially with respect to bindings. Implementation wise, it's fine we
can take up in stages. I don't see any issue adding it in first go. This
binding is good, you just make it hierarchical and add more description.

>> In [PATCH v3 15/15] ARM64: dts: Define CPU power domain for MSM8916, the
>> idle-states are split across the cpu cpu-idle-states and pd
>> domain-idle-states property. That looks like a really mess to me.
>>
> It is pretty clear that CPUs cannot not define the domain idle states.
> Domains define their own idle states. Just as you mention above. CPU is
> just a single component in its domain. There may be other devices like
> PMUs, Coresights etc that also may have a say in the idle state the
> domain may be put in, when the devices are idle. As such, adding domain
> idle states to the CPU's idle state property is not appropriate.
>

No I am not saying we need to add domain idle states to the CPU's idle
state property. I am saying we need to remove cpu-idle-states or ignore
it when PD is present. And get all the idle state information for PD.

I am objecting the split we are creating across CPU and higher level
power domains. And this binding document is incomplete as it skips all
those details. We just need PD handle in CPU and no idle state
information there. Create PD hierarchy and have all idle state
information at one place.

> Our kernel has runtime PM for devices and then there is CPUidle, both
> are diverging without one knowing about the other. We have to start
> unifying them inorder to have better holistic power management in the
> SoC. To that regard, we have to start imagining CPUs as just another
> device, albeit a special device. But for our purposes in determining
> domain idle state, it will just be a device attached to the domain.
>

Absolutely agree on that. No arguments. I am asking to go a step ahead
to include even cpu/core level power domains not just cluster/higher
level domains.

>> We need to have all the idle state information at one place and in this
>> case PD seems more appropriate instead of splitting them across.
>>
> That approach isn't correct. Where will we put the idle states of other
> devices that are also part of the domain? We are thinking about a model,
> where every device defines its own idle states and we define
> relationships between those idle states and their parents' idle states.

Yes I understand. You confused me here. Won't that be one-to-one 
relationship ? If not, how is that dealt in the current bindings ?

> Ofcourse, devices don't have idle states today, but that is something we
> have been pondering over.
>

Yes we these binding should be easily extensible, I don't see any issue.

>> We can also keep the code clean and not break compatibility. Whenever
>> both PD and CPU contains idle-states, PD must take precedence.
>>
> Why?
> The CPU and PD states are orthogonal. While the PD state is dependent on
> the CPU state, the latter is not true. Devices determine their own
> states. Based on the individual device states, we then determine the
> state of the parent and bubble up on the hierarchy.
>

I may be missing something. Now with your example in the binding, if
another device shares the cluster PD, can it have different idle states?
If so how does it map ?


In general whatever binding we come up must not just address OS 
coordinated mode. Also I was thinking to have better coverage in the 
description by having a bit more complex system like:

cluster0
	CLUSTER_RET(Retention)
	CLUSTER_PG(Power Gate)
	core0
		CORE_RET
		CORE_PG
	core1
		CORE_RET
		CORE_PG

cluster1
	CLUSTER_RET
	CLUSTER_PG
	core0
		CORE_RET
		CORE_PG
	core1
		CORE_RET
		CORE_PG

Platform Co-ordinate supports the following states and we should be able 
to determine that from the binding:

CORE_RET
CORE_PG
CORE_RET + CLUSTER_RET
CORE_PG + CLUSTER_RET
CORE_PG + CLUSTER_PG


-- 
Regards,
Sudeep
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
