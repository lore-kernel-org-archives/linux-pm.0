From: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 5/8] dt/bindings: Update binding for PM domain idle
 states
Date: Mon, 10 Oct 2016 18:13:09 +0100
Message-ID: <ffc0b521-329a-d41f-c952-bb9c4877ea87@arm.com>
References: <1475879821-8035-1-git-send-email-lina.iyer@linaro.org>
 <1475879821-8035-6-git-send-email-lina.iyer@linaro.org>
 <4e55d6ad-8de7-72d7-7512-5e4ff2aabc79@arm.com>
 <20161010164342.GC44885@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161010164342.GC44885-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, brendan.jackman-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, Juri.Lelli-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc Titinger <mtitinger+renesas-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org



On 10/10/16 17:43, Lina Iyer wrote:
> On Mon, Oct 10 2016 at 09:45 -0600, Sudeep Holla wrote:
>>
>>
>> On 07/10/16 23:36, Lina Iyer wrote:
>>> Update DT bindings to describe idle states of PM domains.
>>>
>>> This patch is based on the original patch by Marc Titinger.
>>>
>>> Cc: <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
>>> Signed-off-by: Marc Titinger <mtitinger+renesas-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
>>> Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>> Signed-off-by: Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>>> ---
>>> .../devicetree/bindings/power/power_domain.txt     | 38
>>> ++++++++++++++++++++++
>>> 1 file changed, 38 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/power/power_domain.txt
>>> b/Documentation/devicetree/bindings/power/power_domain.txt
>>> index 025b5e7..7f8f27e 100644
>>> --- a/Documentation/devicetree/bindings/power/power_domain.txt
>>> +++ b/Documentation/devicetree/bindings/power/power_domain.txt
>>> @@ -29,6 +29,10 @@ Optional properties:
>>>    specified by this binding. More details about power domain
>>> specifier are
>>>    available in the next section.
>>>
>>> +- domain-idle-states : A phandle of an idle-state that shall be
>>> soaked into a
>>> +                generic domain power state. The idle state
>>> definitions are
>>> +                compatible with arm,idle-state specified in [1].
>>> +
>>
>> Please do add the following details to the binding. IMO, this binding is
>> not complete in terms of specification as there are few open questions:
>>
>> 1. What not define a standard compatible instead of "arm,idle-state" ?
>>   I agree it can be used, but as part of this *generic* binding, IMO
>>   it's better to have something generic and can be used by devices.
>>   Otherwise, this binding becomes CPU specific, that too ARM CPU
>>   specific.
>>
> We had gone down this path of having a separate DT bindings for domains
> that is not arm,idle-state. See RFC patches. But the binding did closely
> match this and it so was suggested that we use arm,idle-state which is
> already defined.
>

Either we say this binding is ARM CPU specific or generic, I can't
understand this mix 'n' match really. You have removed all the CPUIdle
stuff from this series which is good and makes it simpler, but linking
it to only "arm,idle-state" make be feel it's not generic. OK I will
have a look at the RFC as why generic compatible was rejected.

>> 2. Now taking CPU as a special device, how does this co-exist with the
>>   cpu-idle-states ? Better to have some description may be in the ARM
>>   CPU idle binding document(not here of-course)
>>
> The is a binding for a generic PM domain. This has no bearing on the CPU
> or its idle states. Its just that the data is compatible with
> arm,idle-state.
>

I understand that but it's not that simple which I assume you *do*
agree. Hence may need bit of an explanation in the binding(not here
of-course as I mentioned earlier, but in the CPU Idle bindings).
Please consider DT bindings as any other specification. All I am
asking is more description in the binding.

>> 3. I still haven't seen any explanation for not considering complete
>>   hierarchical power domain representation which was raised in earlier
>>   versions. I had provided example for the proposal. I just saw them
>>   already in use in the upstream kernel by Renasas. e.g.:
>>   arch/arm/boot/dts/r8a73a4.dtsi
>>
> Hierarchical power domains have been available for few years in DT. The
> OF features of domains have always supported it. Platforms are free to
> define domains in hierarchy they seem fit for their SoCs. This is a
> feature that is available today and is not being modified in these
> patches. It will be creating confusion if I talk about hierarchical
> domains which are obvious and irrelevant to this series.
>

Agreed and sorry if I created any confusion. But this binding doesn't
clearly state how to build up the hierarchy if the leaf node is not a
power-domain node and I am just trying have those clarifications in the
binding. It would be good if those details are *explicitly* mentioned in
the binding, not this particularly, but in CPU Idle one when you
introduce the user of that.

>>   How does that fit with your proposal, though you have not made one
>>   yet for CPUs in this binding ? In the above file, CPUs have either
>>   own power domain inside the L2 one which is cluster level power
>>   domain.
>>
> Again, this series is not about the CPUs. This is about adding features
> to genpd that may be used in other contexts including cpuidle in the
> future.
>

Yes I understand and hence I was confused as why I don't see an
*generic* compatible but just *arm,idle-states* in the example.

>> One must be able to get answers to these above questions with this
>> binding. Until then it's *incomplete* though it may be correct.
>>
> I have always tried to answer all your questions. If anything remains
> unclarified pls. bring it up.
>

It's not about questions, and definitely you have answered all my
questions, no argument there at all. Now we need to make those useful
discussions part of this binding so that it's *self explanatory* and
one need not refer back these discussions when writing DT for some
different SoC which differs from this. Again that could be part of
your CPUIdle series, I just raised it here as it got mixed sense from
this series. It was hard to be not to associate CPUIdle for reasons
mentioned above.

-- 
Regards,
Sudeep
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
