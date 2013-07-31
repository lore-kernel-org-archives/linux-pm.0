From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC PATCH 1/2] PM / OPP: add support to specify phandle of another
 node for OPP
Date: Wed, 31 Jul 2013 09:46:34 -0500
Message-ID: <51F9234A.6010501@ti.com>
References: <1375207217-4433-1-git-send-email-Sudeep.KarkadaNagesha@arm.com> <1375207217-4433-2-git-send-email-Sudeep.KarkadaNagesha@arm.com> <51F80750.8030701@wwwdotorg.org> <51F826A0.2000109@ti.com> <51F8F17B.1020304@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51F8F17B.1020304@arm.com>
Sender: cpufreq-owner@vger.kernel.org
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

On 07/31/2013 06:14 AM, Sudeep KarkadaNagesha wrote:
> On 30/07/13 21:48, Nishanth Menon wrote:
>> On 07/30/2013 01:34 PM, Stephen Warren wrote:
>>> On 07/30/2013 12:00 PM, Sudeep KarkadaNagesha wrote:
>>>> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>>>>
>>>> If more than one similar devices share the same OPPs, currently we
>>>> need to replicate the OPP entries in all the nodes.
>>>>
>>>> Few drivers like cpufreq depend on physical cpu0 node to specify the
>>>> OPPs and only that node is referred irrespective of the logical cpu
>>>> accessing it. Alternatively to support cpuhotplug path, few drivers
>>>> parse all the cpu nodes for OPPs. Instead we can specify the phandle
>>>> of the node with which the current node shares the operating points.
>>>>
>>>> This patch adds support to specify the phandle in the operating points
>>>> of any device node, where the node specified by the phandle holds the
>>>> actual OPPs.
>>>
>>>> diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp.txt
>>>
>>>> +Optional properties:
>>>> +- operating-points-phandle: phandle to the device node with which this
>>>
>>> That's a funny name. Bikeshedding a bit, how about shared-operating-points?
>>>
>>> I haven't thought at all about whether this change conceptually makes sense.
>>>
>>
>> They may not really be shared- we could have phandle list even. one
>> might have optional OPP sets for a chip family that one may  - I was
>> about to suggest something similar to pinctrl
>>
> I am not sure if I follow you here, if each chip family has its unique
> set of OPPs, why do we need to represent all of them together ?
> IIUC you are thinking about having these in include dts file, used by
> multiple chip/board dts.
>
>> operating-points-names = "default", "performance", "cheapboard-config" ;)
>> operating-points-0 = <&...>
>> operating-points-1 = <&...>
>> operating-points-2 = <&...>
>>
> This looks more like a PM policy.

Let me try to explain since SoCs such as OMAP/AM family dont make life 
trivial :)..

An legacy example[1][2]

SoC DM explains that the chip is capable of X opps:
opp1, 2 - for all devices
opp1,2, 3 - if efuse bit X@y is set
opp1,2,3,4 - if efuse bit X@y is set AND Board design meets SoC vendors 
requirements (including additional features A, B is enabled).

So, the same chip family has a hardware feature - not just as a pm 
policy of selecting among a set of OPPs which opp to work on, but the 
actual set of OPPs are actually options in themselves that is selected 
based on board's SoC selection.

this you could in theory, compare to selecting an pinctrl configuration 
option based on certain hardware selection criteria.

>

>> + wanted also to consider how we might have a single definition to scale
>> across to what Mike is attempting to do with a generic clock framework
>> support for DVFS.
>>
> I don't quite follow what you are trying to say.
>
> In fact, following Mike's consolidation I had a thought that OPP must be
> part of clock node as multiple devices in the same clock domain refer to
> the same clock node.

just that the configuration and option we select *must* think beyond 
just CPU with a generic clock framework triggered dvfs - the strategy 
must work for devfreq/other frameworks as well.

>
>> for compatibility sake, if operating-points is defined, we continue to
>> expect old style definition, else we have options to pick from.
>>
> Yes we can do that, but we need to agree on where these OPPs need to
> present in DTS.

I see Grant is in alignment, and I personally like the idea as well - as 
long as we dont break backward compatibility.

>
>> This should setup stage for many of the work we have been trying to
>> figure out on AM/OMAP and few other processors which has to depend on
>> few sets of OPPs which may not be supported on various platforms.
>>
> I still don't get the point why you would publish some OPP in the DT
> when the hardware which it describes doesn't support it.
>
> This may be already discussed when DT support was added to OPP library,
> IMO if for some reason the firmware/boot entity disables some of the
> OPPs, then it can append OPPs in DT with the state(enabled/disabled).
> But this needs extension of current binding.

you could also have reduced OPP set which needs to be invoked, appending 
wont really work if cpufreq table is built as part of probe - it kind of 
creates all kind of races which I would really like to avoid.


[1] 
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/mach-omap2/opp4xxx_data.c#n134
[2] 
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/mach-omap2/id.c#n290
-- 
Regards,
Nishanth Menon
