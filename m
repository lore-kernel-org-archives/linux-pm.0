From: Brendan Jackman <brendan.jackman-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 02/15] dt/bindings: Update binding for PM domain idle
 states
Date: Fri, 12 Aug 2016 10:47:44 +0100
Message-ID: <57AD9B40.9040001@arm.com>
References: <1470351902-43103-1-git-send-email-lina.iyer@linaro.org>
 <1470351902-43103-3-git-send-email-lina.iyer@linaro.org>
 <99e35b6c-6698-6d27-f4d7-fa032796869e@arm.com>
 <20160810164034.GA1401@linaro.org>
 <5e59874c-bbb7-270a-199c-da1ff5932554@arm.com>
 <20160811211023.GC1401@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160811211023.GC1401-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Axel Haslam <ahaslam+renesas-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc Titinger <mtitinger+renesas-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi-5wv7dgnIgG8@public.gmane.org>, Juri Lelli <Juri.Lelli-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Lina

On 11/08/16 22:10, Lina Iyer wrote:
> On Wed, Aug 10 2016 at 12:09 -0600, Sudeep Holla wrote:
>>
>>
>> On 10/08/16 17:40, Lina Iyer wrote:
>>> Hi Sudeep,
>>>
>>> On Wed, Aug 10 2016 at 09:15 -0600, Sudeep Holla wrote:
>>>> Hi Lina,
>>>>
>>>> I have few concerns mainly due to the lack of description and not the
>>>> binding per say.
>>
>> [...]
>>
>>> It is pretty clear that CPUs cannot not define the domain idle states.
>>> Domains define their own idle states. Just as you mention above. CPU is
>>> just a single component in its domain. There may be other devices like
>>> PMUs, Coresights etc that also may have a say in the idle state the
>>> domain may be put in, when the devices are idle. As such, adding domain
>>> idle states to the CPU's idle state property is not appropriate.
>>>
>>
>> No I am not saying we need to add domain idle states to the CPU's idle
>> state property. I am saying we need to remove cpu-idle-states or ignore
>> it when PD is present. And get all the idle state information for PD.
>>
>> I am objecting the split we are creating across CPU and higher level
>> power domains. And this binding document is incomplete as it skips all
>> those details. We just need PD handle in CPU and no idle state
>> information there. Create PD hierarchy and have all idle state
>> information at one place.
>>
> Let me think about this a bit and see what I can come up with.
>
>>> Our kernel has runtime PM for devices and then there is CPUidle, both
>>> are diverging without one knowing about the other. We have to start
>>> unifying them inorder to have better holistic power management in the
>>> SoC. To that regard, we have to start imagining CPUs as just another
>>> device, albeit a special device. But for our purposes in determining
>>> domain idle state, it will just be a device attached to the domain.
>>>
>>
>> Absolutely agree on that. No arguments. I am asking to go a step ahead
>> to include even cpu/core level power domains not just cluster/higher
>> level domains.
>>
>>>> We need to have all the idle state information at one place and in this
>>>> case PD seems more appropriate instead of splitting them across.
>>>>
>>> That approach isn't correct. Where will we put the idle states of other
>>> devices that are also part of the domain? We are thinking about a model,
>>> where every device defines its own idle states and we define
>>> relationships between those idle states and their parents' idle states.
>>
>> Yes I understand. You confused me here. Won't that be one-to-one
>> relationship ? If not, how is that dealt in the current bindings ?
>>
>>> Ofcourse, devices don't have idle states today, but that is something we
>>> have been pondering over.
>>>
>>
>> Yes we these binding should be easily extensible, I don't see any issue.
>>
>>>> We can also keep the code clean and not break compatibility. Whenever
>>>> both PD and CPU contains idle-states, PD must take precedence.
>>>>
>>> Why?
>>> The CPU and PD states are orthogonal. While the PD state is dependent on
>>> the CPU state, the latter is not true. Devices determine their own
>>> states. Based on the individual device states, we then determine the
>>> state of the parent and bubble up on the hierarchy.
>>>
>>
>> I may be missing something. Now with your example in the binding, if
>> another device shares the cluster PD, can it have different idle states?
>> If so how does it map ?
>>
>>
>> In general whatever binding we come up must not just address OS
>> coordinated mode. Also I was thinking to have better coverage in the
>> description by having a bit more complex system like:
>>
>> cluster0
>>     CLUSTER_RET(Retention)
>>     CLUSTER_PG(Power Gate)
>>     core0
>>         CORE_RET
>>         CORE_PG
>>     core1
>>         CORE_RET
>>         CORE_PG
>>
>> cluster1
>>     CLUSTER_RET
>>     CLUSTER_PG
>>     core0
>>         CORE_RET
>>         CORE_PG
>>     core1
>>         CORE_RET
>>         CORE_PG
>>
>> Platform Co-ordinate supports the following states and we should be
>> able to determine that from the binding:
>>
>> CORE_RET
>> CORE_PG
>> CORE_RET + CLUSTER_RET
>
> The problem that we have to sove here is knowing that CORE_RET +
> CLUSTER_PG (hypothetically) an invalid combination. Kevin and
> I debated it in the earlier RFC and we dont have a good way to solve
> this generically for all devices.
>

This is interesting. I had been working on the assumption that a parent
power domain cannot enter any idle state until its children were all in
their deepest idle state. I now realise that it's easy to imagine
platforms where this isn't the case.

However, I don't understand how your current bindings solve this issue
and why using domain-power-states for all states (i.e. ignoring
cpu-idle-states and putting CPU idle states in the domain-idle-states of
a per-CPU power domain - I believe this is what Sudeep is suggesting)
makes it any more difficult.

Could you link to this previous discussion you mentioned? I'm having
trouble finding it (R.I.P Gmane).

>> CORE_PG + CLUSTER_RET
>> CORE_PG + CLUSTER_PG
>>
>>
> Thanks,
> Lina
>

Cheers,
Brendan
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
